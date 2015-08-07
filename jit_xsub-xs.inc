void*
lolxsub_stack_state_init_ptr()
CODE:
	RETVAL = lolxsub_stack_state_init;
OUTPUT:
	RETVAL

void*
lolxsub_stack_fetch_ptr()
CODE:
	RETVAL = lolxsub_stack_fetch;
OUTPUT:
	RETVAL

void*
lolxsub_stack_store_ptr()
CODE:
	RETVAL = lolxsub_stack_store;
OUTPUT:
	RETVAL

void*
lolxsub_stack_prepare_return_ptr()
CODE:
	RETVAL = lolxsub_stack_prepare_return;
OUTPUT:
	RETVAL

void*
lolxsub_stack_xpush_sv_ptr()
CODE:
	RETVAL = lolxsub_stack_xpush_sv;
OUTPUT:
	RETVAL

void*
lolxsub_stack_xpush_nint_ptr()
CODE:
	RETVAL = lolxsub_stack_xpush_nint;
OUTPUT:
	RETVAL

void*
lolxsub_stack_xpush_nuint_ptr()
CODE:
	RETVAL = lolxsub_stack_xpush_nuint;
OUTPUT:
	RETVAL

void*
lolxsub_stack_xpush_double_ptr()
CODE:
	RETVAL = lolxsub_stack_xpush_double;
OUTPUT:
	RETVAL

void*
lolxsub_stack_putback_ptr()
CODE:
	RETVAL = lolxsub_stack_putback;
OUTPUT:
	RETVAL

void*
lolxsub_sv_iv_ptr()
CODE:
	RETVAL = lolxsub_sv_iv;
OUTPUT:
	RETVAL

void*
lolxsub_sv_uv_ptr()
CODE:
	RETVAL = lolxsub_sv_uv;
OUTPUT:
	RETVAL

void*
lolxsub_call_sv_ptr()
CODE:
	RETVAL = lolxsub_call_sv;
OUTPUT:
	RETVAL

