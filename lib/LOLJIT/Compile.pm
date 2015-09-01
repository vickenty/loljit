package LOLJIT::Compile;

use strict;
use warnings;

use LOLJIT qw/:all/;
use LOLJIT::XSUB qw/:all/;
use LOLJIT::Tree;
use Data::Dumper;
use Carp qw/confess/;

my %ops;

sub compile_expr {
    my ($ctx, $op, %args) = @_;

    local @$ctx{keys %args} = values %args;
    
    my $name = $op->{op} // confess "invalid op " . Dumper($op);
    my $impl = $ops{$name} // confess "unsupported op $name";

    return $impl->($ctx, $op);
}

sub compile_code {
    my ($fun, $code) = @_;

    my $tree = LOLJIT::Tree::build $code;

    my $ctx = {
        fun => $fun,
        mode => "",
    };

    compile_expr $ctx, $tree->{root};
}

$ops{null} =
$ops{leavesub} = sub {
    my ($ctx, $op) = @_;
    return compile_expr $ctx, $op->{expr};
};

$ops{lineseq} = sub {
    my ($ctx, $op) = @_;
    my $ret;
    $ret = compile_expr $ctx, $_ foreach (@{$op->{list}});
    return $ret;
};

$ops{nextstate} = sub {};

$ops{assign} = sub {
    my ($ctx, $op) = @_;

    my $value = compile_expr $ctx, $op->{value};
    my $target = compile_expr $ctx, $op->{target}, mode => "lvalue", type => jit_value_get_type $value;

    jit_insn_store $ctx->{fun}, $target, $value;
};

$ops{add} = sub {
    my ($ctx, $op) = @_;

    my @args = map compile_expr($ctx, $_), @{$op->{args}};
    return jit_insn_add $ctx->{fun}, @args;
};

$ops{padsv} = sub {
    my ($ctx, $op) = @_;

    my $pad = $op->{pad};
    my $val = $pad->{stash} // ${$pad->{value}};

    if ($ctx->{mode} eq "lvalue" && !defined $val) {
        return $pad->{stash} = jit_value_create $ctx->{fun}, $ctx->{type};
    }

    if (ref $val eq "jit_value_t") {
        return $val;
    }
    # FIXME: create constants from values.
    else {
        confess "unsupported value in expression: " . Dumper($val);
    }
};

$ops{const} = sub {
    my ($ctx, $op) = @_;
    
    # FIXME: don't assume integer type here.
    return jit_value_create_nint_constant $ctx->{fun}, jit_type_nint, ${$op->{pad}{value}};
};

$ops{cond_expr} = sub {
    my ($ctx, $op) = @_;

    my $else = jit_label_undefined;
    my $skip = jit_label_undefined;

    my $cond = compile_expr $ctx, $op->{pred};
    jit_insn_branch_if_not $ctx->{fun}, $cond, $else;
    
    my $then_val = compile_expr $ctx, $op->{then};
    jit_insn_branch $ctx->{fun}, $skip;

    jit_insn_label $ctx->{fun}, $else;
    my $else_val = compile_expr $ctx, $op->{else};
    jit_insn_store $ctx->{fun}, $then_val, $else_val;
    jit_insn_label $ctx->{fun}, $skip;
    
    return $then_val;
};

$ops{lt} = sub {
    my ($ctx, $op) = @_;

    my @args = map compile_expr($ctx, $_), @{$op->{args}};
    return jit_insn_lt $ctx->{fun}, @args;
};

$ops{negate} = sub {
    my ($ctx, $op) = @_;

    my $v = compile_expr $ctx, $op->{expr};
    return jit_insn_neg $ctx->{fun}, $v;
};

1;
