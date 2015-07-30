package LOLJIT::XSUB;

use strict;
use warnings;

use LOLJIT qw/:all/;
use Exporter;

our @ISA = qw/Exporter/;
our @EXPORT_OK = qw/
    lolxsub_stack_state_init
    lolxsub_stack_xpush_nint
    lolxsub_stack_prepare_return
    lolxsub_stack_putback
    lolxsub_stack_fetch
    lolxsub_sv_iv
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
        jit_type_void_ptr,      # stack
        @params
    ], 1;

    my $insn = sub {
        my ($fun, $my_perl, $stack, @args) = @_;
        local $" = " ";
        #cluck "$name(@_)";
        return jit_insn_call_native $fun, $name, $ptr, $sig, [ $my_perl, $stack, @args ], 0;
    };

    do {
        no strict "refs";
        *{ "lolxsub_$name" } = $insn;
    };
}

shim jit_type_void, stack_state_init => ();
shim jit_type_void, stack_xpush_nint => jit_type_nint;
shim jit_type_void, stack_prepare_return => ();
shim jit_type_void, stack_putback => ();
shim jit_type_void_ptr, stack_fetch => (jit_type_nint);
shim jit_type_nint, sv_iv => (jit_type_void_ptr);

sub lolxsub_create {
    my $ctx = shift;
    my $sig = jit_type_create_signature jit_abi_cdecl, jit_type_void, [ jit_type_void_ptr ], 1;
    my $fun = jit_function_create $ctx, $sig;
    my $perl_stack_val = jit_value_create $fun, $perl_stack_t;
    my $perl_stack_ptr = jit_insn_address_of $fun, $perl_stack_val;
    return $fun, $perl_stack_ptr;
}

sub lolxsub_params {
    my ($fun, $stack, $params) = @_;

    my $perl = jit_value_get_param($fun, 0);
    lolxsub_stack_state_init($fun, $perl, $stack);

    # fixme

    return ($perl);
}

1;
