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
    my ($perl, $i, $j) = lolxsub_params $fun, $stack, qw/iv/;

    my $k = LOLJIT::Compile::compile_code $fun, sub {
        $i + 1.5;
    };

    lolxsub_stack_prepare_return $fun, $perl, $stack;
    lolxsub_stack_xpush_double $fun, $perl, $stack, $k;
    lolxsub_stack_putback $fun, $perl, $stack;

    jit_function_compile $fun;

    return $fun;
}

DynaLoader::dl_install_xsub("main::compiled", jit_function_to_closure make_simple);

is compiled(1), 2.5;

done_testing;
