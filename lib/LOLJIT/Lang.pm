package LOLJIT::Lang;

use strict;
use warnings;

use LOLJIT qw/:all/;
use LOLJIT::XSUB qw/:all/;
use List::Util qw/any/;
use Exporter;

our @ISA = qw/Exporter/;
our @EXPORT_OK = qw/
    fun
    doen
    retour
    i
    val
    zolang
    als
    anders
/;
our %EXPORT_TAGS = (
    all => \@EXPORT_OK,
);

our $scope;

sub fun(&;@) {
    my ($init, $block) = @_;

    my ($ctx, @sig) = $init->();

    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl, @args) = lolxsub_params $fun, $stack, @sig;

    local $scope = {
        ctx => $ctx,
        fun => $fun,
        stack => $stack,
        perl => $perl,
    };

    my $val = $block->(@args);

    jit_function_compile $fun;

    return $fun;
}

sub doen (&;@) { @_ }

sub type_eq {
    my $a = shift;
    return any { $$a == $$_ } @_;
}

sub typename {
    my $type = shift;
    foreach my $name (@LOLJIT::TYPES) {
        no strict "refs";
        return $name if type_eq $type, &{$name}();
    }
    return "???";
}

sub push_any {
    my ($fun, $perl, $stack, $val) = @_;

    my $type = jit_value_get_type $val;

    if (type_eq $type, jit_type_nint, jit_type_long) {
        lolxsub_stack_xpush_nint @_;
    }
    elsif (type_eq $type, jit_type_nuint, jit_type_ulong) {
        lolxsub_stack_xpush_nuint @_;
    }
    elsif (type_eq $type, jit_type_float64) {
        lolxsub_stack_xpush_double @_;
    }
    else {
        die "unsupported type " . typename($type);
    }
}

sub retour(&) {
    my $code = shift;

    my (@vals) = $code->();

    my @args = @$scope{qw/fun perl stack/};

    lolxsub_stack_prepare_return @args;
    push_any(@args, $_) foreach (@vals);
    lolxsub_stack_putback @args;
}

sub make_proxy {
    my $prefix = shift;
    return sub {
        my $name = shift;
        no strict "refs";
        # it is important to use @_ here so any C code can chage caller's
        # variables.
        &{$prefix . $name}($scope->{fun}, @_);
    }
}

BEGIN {
    *i = make_proxy "LOLJIT::jit_insn_";
    *val = make_proxy "LOLJIT::jit_value_";
}

sub zolang(&;@) {
    my ($cond, $body) = @_;

    my $while = jit_label_undefined;
    my $end = jit_label_undefined;

    i label => $while;

    my $val = $cond->();

    i branch_if_not => $val, $end;

    $body->();

    i branch => $while;
    i label => $end;
}

sub als(&;@) {
    my ($cond, $then, $else) = @_;

    my $l = jit_label_undefined;
    my $l2 = jit_label_undefined;

    my $val = $cond->();
    i branch_if_not => $val, $l;

    $then->();

    if (defined $else) {
        i branch => $l2;
    }

    i label => $l;

    if (defined $else) {
        $else->();

        i label => $l2;
    }
}

*anders = \&doen;

1;
