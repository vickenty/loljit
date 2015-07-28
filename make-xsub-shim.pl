#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use File::Slurp;

my $prefix = "lolxsub_stack_";

my @shims = map "$prefix$_", qw/
    state_init
    fetch
    store
    prepare_return
    xpush_sv
    xpush_nint
    xpush_nuint
    xpush_double
    putback
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
