use strict;
use warnings;

use Test::More;
use Carp;

$SIG{__DIE__} = sub {
    confess @_;
};

BEGIN {
    use_ok("LOLJIT", ":all");
    use_ok("LOLJIT::XSUB", ":all");
    use_ok("LOLJIT::Lang", ":all");
}

sub build_gcd {
    my ($fun, $u, $v) = @_;

    return $u;
}

sub make_gcd_xsub {
    my $ctx = shift;

    fun { $ctx, qw/iv iv/ } doen {
        my ($u, $v) = @_;
        my $t = val create => jit_type_nint;
        my $z = val create_nint_constant => jit_type_nint, 0;

        zolang { i ne => $v, $z } doen {
            i store => $t, $u;
            i store => $u, $v;

            my $rem = i rem => $t, $v;
            i store => $v, $rem;
        };

        als { i lt => $u, $z } doen {
            retour { i neg => $u };
        } anders {
            retour { $u };
        };
    };
}

my $ctx = jit_context_create;
jit_context_build_start $ctx;
my $fun = make_gcd_xsub($ctx);
jit_context_build_end $ctx;

my $ptr = jit_function_to_closure($fun);
DynaLoader::dl_install_xsub("main::gcd_xsub", $ptr);

is gcd_xsub(12, 8), 4;

done_testing;
