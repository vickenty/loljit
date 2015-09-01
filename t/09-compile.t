use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok("LOLJIT", ":all");
    use_ok("LOLJIT::XSUB", ":all");
    require_ok("LOLJIT::Compile");
}

my $ctx = jit_context_create;
jit_context_build_start $ctx;

sub make_simple {
    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl, $i, $j) = lolxsub_params $fun, $stack, qw/iv iv/;

    my $k = LOLJIT::Compile::compile_code $fun, sub {
        my $z = $i + $j;
        $z < 0 ? -$z : $z;
    };

    lolxsub_stack_prepare_return $fun, $perl, $stack;
    lolxsub_stack_xpush_nint $fun, $perl, $stack, $k;
    lolxsub_stack_putback $fun, $perl, $stack;

    jit_function_compile $fun;

    return $fun;
}

DynaLoader::dl_install_xsub("main::compiled", jit_function_to_closure make_simple);

is compiled(-5, 8), 3;
is compiled(-5, -1), 6;
is compiled(2, 3), 5;

done_testing;
