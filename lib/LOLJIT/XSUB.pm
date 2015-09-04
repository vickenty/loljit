package LOLJIT::XSUB;

use strict;
use warnings;

use LOLJIT qw/:all/;
use Exporter;

our @ISA = qw/Exporter/;
our @EXPORT_OK = qw/
    lolxsub_stack_state_init
    lolxsub_stack_xpush_sv
    lolxsub_stack_xpush_nint
    lolxsub_stack_xpush_nuint
    lolxsub_stack_xpush_double
    lolxsub_stack_prepare_return
    lolxsub_stack_putback
    lolxsub_stack_fetch
    lolxsub_sv_iv
    lolxsub_call_sv
    lolxsub_create
    lolxsub_params
/;
our %EXPORT_TAGS = (
    all => \@EXPORT_OK,
);

my $perl_stack_t = jit_type_create_struct [
    jit_type_void_ptr,
    jit_type_void_ptr,
    jit_type_nint,
    jit_type_nint,
], 1;

sub shim {
    my ($rtype, $name, @params) = @_;

    my $ptr = do {
        no strict "refs";
        &{ "lolxsub_" . $name . "_ptr" }();
    };

    my $sig = jit_type_create_signature jit_abi_cdecl, $rtype, [
        jit_type_void_ptr,      # my_perl
        @params
    ], 1;

    my $insn = sub {
        my ($fun, @args) = @_;
        local $" = " ";
        #cluck "$name(@_)";
        return jit_insn_call_native $fun, $name, $ptr, $sig, [ @args ], 0;
    };

    do {
        no strict "refs";
        *{ "lolxsub_$name" } = $insn;
    };
}

shim jit_type_void, stack_state_init => jit_type_void_ptr;
shim jit_type_void, stack_xpush_sv => jit_type_void_ptr, jit_type_void_ptr;
shim jit_type_void, stack_xpush_nint => jit_type_void_ptr, jit_type_nint;
shim jit_type_void, stack_xpush_nuint => jit_type_void_ptr, jit_type_nuint;
shim jit_type_void, stack_xpush_double => jit_type_void_ptr, jit_type_float64;
shim jit_type_void, stack_prepare_return => jit_type_void_ptr;
shim jit_type_void, stack_putback => jit_type_void_ptr;
shim jit_type_void_ptr, stack_fetch => jit_type_void_ptr, jit_type_nint;
shim jit_type_nint, sv_iv => jit_type_void_ptr;
shim jit_type_void, call_sv => jit_type_void_ptr, jit_type_nint;

sub lolxsub_create {
    my $ctx = shift;
    my $sig = jit_type_create_signature jit_abi_cdecl, jit_type_void, [ jit_type_void_ptr, jit_type_void_ptr ], 1;
    my $fun = jit_function_create $ctx, $sig;
    my $perl_stack_val = jit_value_create $fun, $perl_stack_t;
    my $perl_stack_ptr = jit_insn_address_of $fun, $perl_stack_val;
    return $fun, $perl_stack_ptr;
}

sub lolxsub_sv_sv {
    my ($fun, $perl, $sv) = @_;
    return $sv;
}

my %typemap = (
    iv => \&lolxsub_sv_iv,
    sv => \&lolxsub_sv_sv,
);

sub lolxsub_params {
    my ($fun, $stack, @params) = @_;

    my $perl = jit_value_get_param($fun, 0);
    lolxsub_stack_state_init($fun, $perl, $stack);

    my @args;
    foreach my $idx (0 .. $#params) {
        my $jit_idx = jit_value_create_nint_constant $fun, jit_type_nint, $idx;
        my $sv = lolxsub_stack_fetch($fun, $perl, $stack, $jit_idx);

        my $type = $params[$idx];
        my $conv = $typemap{$type} // die "invalid type name $type";
        push @args, $conv->($fun, $perl, $sv);
    }

    return ($perl, @args);
}

1;
