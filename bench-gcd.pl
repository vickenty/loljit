use strict;
use warnings;

use lib "blib/arch", "blib/lib";

use LOLJIT ":all";
use LOLJIT::XSUB ":all";
use Benchmark qw/timethese/;
use DynaLoader;

my $ctx = jit_context_create;

# converted from code at http://eli.thegreenplace.net/2013/10/17/getting-started-with-libjit-part-1/ 

sub build_gcd {
    my ($fun, $u, $v) = @_;
    my $t = jit_value_create $fun, jit_type_nint;
    my $z = jit_value_create_nint_constant $fun, jit_type_nint, 0;

    my $l_while = jit_label_undefined;
    my $l_end = jit_label_undefined;

    jit_insn_label $fun, $l_while;
    my $vz = jit_insn_eq $fun, $v, $z;
    jit_insn_branch_if $fun, $vz, $l_end;

    jit_insn_store $fun, $t, $u;
    jit_insn_store $fun, $u, $v;

    my $rem = jit_insn_rem $fun, $t, $v;
    jit_insn_store $fun, $v, $rem;

    jit_insn_branch $fun, $l_while;
    jit_insn_label $fun, $l_end;

    my $l_pos = jit_label_undefined;
    my $uz = jit_insn_ge $fun, $u, $z;
    jit_insn_branch_if $fun, $uz, $l_pos;

    my $nu = jit_insn_neg $fun, $u;
    jit_insn_return $fun, $nu;

    jit_insn_label $fun, $l_pos;

    return $u;
}

sub make_gcd {
    my $params = [ jit_type_int, jit_type_int ];
    my $sig = jit_type_create_signature jit_abi_cdecl, jit_type_nint, $params, 1;
    my $fun = jit_function_create $ctx, $sig;

    my ($u, $v) = map jit_value_get_param($fun, $_), 0 .. 1;

    my $ret = build_gcd($fun, $u, $v);

    jit_insn_return $fun, $ret;
    jit_function_compile $fun;
    return $fun;
}

sub make_gcd_xsub {
    my ($fun, $stack) = lolxsub_create $ctx;
    my ($perl, $u, $v) = lolxsub_params $fun, $stack, qw/iv iv/;

    my $ret = build_gcd($fun, $u, $v);

    lolxsub_stack_prepare_return $fun, $perl, $stack;
    lolxsub_stack_xpush_nint $fun, $perl, $stack, $ret;
    lolxsub_stack_putback($fun, $perl, $stack);

    jit_function_compile $fun;
    return $fun;
}

jit_context_build_start $ctx;

my $fun = make_gcd($ctx);
my $xsub = make_gcd_xsub($ctx);
my $ptr = jit_function_to_closure $xsub;
DynaLoader::dl_install_xsub("main::gcd_xsub", $ptr);

jit_context_build_end $ctx;

sub gcd_jit {
    my $u = pack "q", shift;
    my $v = pack "q", shift;
    my $r;
    jit_function_apply $fun, [ $u, $v ], $r;
    return unpack "q", $r;
}

sub gcd_lol {
    loljit_function_apply $fun, @_;
}

sub gcd_perl {
    my ($u, $v) = @_;
    my $t;
    while ($v) {
        $t = $u;
        $u = $v;
        $v = $t % $v;
    }

    return $u < 0 ? -$u : $u;
}

my $u = shift // int rand(1_000_000_000) + 1_000_000_000;
my $v = shift // int rand(1_000_000_000) + 1_000_000_000;

print "gcd_lol($u, $v) = ", gcd_lol($u, $v), "\n";
print "gcd_jit($u, $v) = ", gcd_jit($u, $v), "\n";
print "gcd_perl($u, $v) = ", gcd_perl($u, $v), "\n";
print "gcd_xsub($u, $v) = ", gcd_xsub($u, $v), "\n";

timethese(2000000, {
    perl => sub { gcd_perl($u, $v) },
    jit => sub { gcd_jit($u, $v) },
    lol => sub { gcd_lol($u, $v) },
    lxs => sub { gcd_xsub($u, $v) },
});

