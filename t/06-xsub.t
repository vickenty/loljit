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
    my ($perl) = lolxsub_params $fun, $stack, [];

    # this goes into fixme above
    my $iidx = jit_value_create_nint_constant $fun, jit_type_nint, 0;
    my $isv = lolxsub_stack_fetch($fun, $perl, $stack, $iidx);
    my $i = lolxsub_sv_iv($fun, $perl, $isv);

    my $jidx = jit_value_create_nint_constant $fun, jit_type_nint, 1;
    my $jsv = lolxsub_stack_fetch($fun, $perl, $stack, $jidx);
    my $j = lolxsub_sv_iv($fun, $perl, $jsv);

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
