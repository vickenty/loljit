#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use File::Slurp;

my $prefix = "lolxsub_";

my @shims = map "$prefix$_", qw/
    stack_state_init
    stack_fetch
    stack_store
    stack_prepare_return
    stack_xpush_sv
    stack_xpush_nint
    stack_xpush_nuint
    stack_xpush_double
    stack_putback
    sv_iv
    sv_uv
/;

open my $xs, ">", "jit_xsub-xs.inc";

my @names;
foreach my $shim (@shims) {
    push @names, my $name = $shim . "_ptr";
    $xs->print("void*\n$name()\n");
    $xs->print("CODE:\n\tRETVAL = $shim;\nOUTPUT:\n\tRETVAL\n\n");
}

my $pm = read_file("lib/LOLJIT.pm");
my $shims = join "", map "    $_\n", @names;
$pm =~ s/(our\s+\@SHIMS\s*=\s*qw\()[^\)]*(\);)/$1\n$shims$2/m;
write_file("lib/LOLJIT.pm", $pm);
