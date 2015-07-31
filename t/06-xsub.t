use strict;
use warnings;

use DynaLoader;
use Test::More;
use Carp qw/cluck/;

use constant MAGIC => 42;

BEGIN {
	use_ok("LOLJIT", ":all");
	use_ok("LOLJIT::XSUB", ":all");
}

my $ctx = jit_context_create;

sub make_simple {
    jit_context_build_start $ctx;

    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl, $i, $j) = lolxsub_params $fun, $stack, qw/iv iv/;

    my $k = jit_insn_mul $fun, $i, $j;

    lolxsub_stack_prepare_return($fun, $perl, $stack);
    lolxsub_stack_xpush_nint($fun, $perl, $stack, $k);
    lolxsub_stack_putback($fun, $perl, $stack);

    jit_function_compile $fun;
    jit_context_build_end $ctx;

    return $fun;
}

my $fun = make_simple;
my $ptr = jit_function_to_closure($fun);
DynaLoader::dl_install_xsub("main::lolxsub", $ptr);

is lolxsub(6, 7), MAGIC;

done_testing;
