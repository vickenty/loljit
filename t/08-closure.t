use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok("LOLJIT", ":all");
    use_ok("LOLJIT::XSUB", ":all");
}

my $ctx = jit_context_create;

sub make_adder {
    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl, $i, $j) = lolxsub_params $fun, $stack, qw/iv iv/;

    my $k = jit_insn_add $fun, $i, $j;

    lolxsub_stack_prepare_return $fun, $perl, $stack;
    lolxsub_stack_xpush_nint $fun, $perl, $stack, $k;
    lolxsub_stack_putback $fun, $perl, $stack;

    jit_function_compile $fun;

    return $fun;
}

=for Notes

For simplicity, append @values after other arguments.

Equivalent perl code (sans ref-counting):

    sub partial {
        my ($target, @values) = @_;
        return sub {
            $target->(@_, @values);
        }
    }

=cut

my @keepalive;
sub partial {
    my ($target, @values) = @_;
    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl) = lolxsub_params $fun, $stack;

    my $nvalues = jit_value_create_nint_constant $fun, jit_type_nint, scalar @values;

    foreach my $value (@values) {
        push @keepalive, \$value; # poor man's incref
        my $ptr = jit_value_create_nint_constant $fun, jit_type_void_ptr, int \$value;
        lolxsub_stack_xpush_sv($fun, $perl, $stack, $ptr);
    }

    lolxsub_stack_putback $fun, $perl, $stack;

    my $cv_ptr = jit_value_create_nint_constant $fun, jit_type_void_ptr, 0;

    if (ref $target eq "jit_function_t") {
        jit_insn_call $fun, "", $target, jit_function_get_signature($target), [ $perl, $cv_ptr ], 0;
    } else {
        push @keepalive, \$target;
        my $ptr = jit_value_create_nint_constant $fun, jit_type_void_ptr, int \$target;
        my $flags = jit_value_create_nint_constant $fun, jit_type_nint, -1;
        lolxsub_call_sv $fun, $perl, $ptr, $flags;
    }

    jit_function_compile $fun;

    do {
        no warnings "uninitialized", "redefine";
        return DynaLoader::dl_install_xsub(undef, jit_function_to_closure $fun);
    };
}

jit_context_build_start $ctx;

DynaLoader::dl_install_xsub("main::adder", jit_function_to_closure make_adder);

my $add_1 = partial(\&adder, 1);
my $add_5 = partial(\&adder, 5);

jit_context_build_end $ctx;

is $add_1->(5), 6;
is $add_5->(4), 9;

done_testing;
