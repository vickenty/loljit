package LOLJIT::Tree;

use strict;
use warnings;

use B;

sub codevars {
    my $obj = shift;
    my ($names, $values) = $obj->PADLIST->ARRAY;
    my @names = $names->ARRAY;
    my @values = $values->ARRAY;
    
    my @res;
    foreach my $idx (0 .. $#names) {
        my $name_sv = $names[$idx];
        my $is_special = $name_sv->isa("B::SPECIAL");

        my $name = $is_special ? "<special>" : $name_sv->PV;
        my $value_ref = $values[$idx]->object_2svref;
    
        push @res, {
            name => $name,
            value => $value_ref,
            outer => !$is_special && $name_sv->FLAGS & B::SVf_FAKE ? 1 : 0,
        };
    }

    return \@res;
}

my %ops;
sub expr {
    my ($scope, $op, %args) = @_;

    local @$scope{keys %args} = values %args;

    my $name = $op->name;
    my $type = ref $op;
    my $impl = $ops{$name} // $ops{$type} // die "unsupported op $name of type $type";

    return $impl->($scope, $op);
}

$ops{"B::COP"} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
    };
};

$ops{"B::UNOP"} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
        expr => expr($scope, $op->first),
    };
};

$ops{"B::BINOP"} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
        args => [ map expr($scope, $_), $op->first, $op->last ],
    };
};

$ops{"B::LISTOP"} = sub {
    my ($scope, $op) = @_;

    my @list;
    my $child = $op->first;
    while (!UNIVERSAL::isa($child, "B::NULL")) {
        push @list, expr($scope, $child);
        $child = $child->sibling;
    }

    return {
        op => $op->name,
        list => \@list,
    };
};


$ops{const} =
$ops{padsv} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
        pad => $scope->{vars}->[$op->targ],
    };
};

$ops{cond_expr} = sub {
    my ($scope, $op) = @_;
    return {
        op => "cond_expr",
        pred => expr($scope, $op->first),
        then => expr($scope, $op->first->sibling),
        else => expr($scope, $op->first->sibling->sibling),
    };
};

sub build {
    my ($code) = @_;

    my $obj = B::svref_2object $code;
    my $scope = {
        vars => codevars($obj),
    };

    my $tree = expr $scope, $obj->ROOT;
    return {
        vars => $scope->{vars},
        root => $tree,
    };
}

1;
