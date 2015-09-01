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
    my $impl = $ops{$name} // die "unsupported op $name";

    return $impl->($scope, $op);
}

$ops{lineseq} = sub {
    my ($scope, $op) = @_;

    my @list;
    my $child = $op->first;
    while (!UNIVERSAL::isa($child, "B::NULL")) {
        push @list, expr($scope, $child);
        $child = $child->sibling;
    }

    return {
        op => "lineseq",
        list => \@list,
    };
};

$ops{nextstate} = sub {
    return {
        op => "nextstate",
    };
};

$ops{sassign} = sub {
    my ($scope, $op) = @_;

    return {
        op => "assign",
        value => expr($scope, $op->first),
        target => expr($scope, $op->last),
    };
};

# BINOP
$ops{lt} = 
$ops{add} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
        args => [ map expr($scope, $_), $op->first, $op->last ],
    };
};

$ops{padsv} = sub {
    my ($scope, $op) = @_;
    return {
        op => "padsv",
        pad => $scope->{vars}->[$op->targ],
    };
};

$ops{const} = sub {
    my ($scope, $op) = @_;
    return {
        op => "const",
        pad => $scope->{vars}->[$op->targ],
    };
};

# UNOP
$ops{leavesub} =
$ops{negate} = 
$ops{null} = sub {
    my ($scope, $op) = @_;
    return {
        op => $op->name,
        expr => expr($scope, $op->first),
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
