package LOLJIT;

use 5.020002;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use LOLJIT ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.

our @TYPES = qw(
    jit_type_void
    jit_type_sbyte
    jit_type_ubyte
    jit_type_short
    jit_type_ushort
    jit_type_int
    jit_type_uint
    jit_type_nint
    jit_type_nuint
    jit_type_long
    jit_type_ulong
    jit_type_float32
    jit_type_float64
    jit_type_nfloat
    jit_type_void_ptr
    jit_type_sys_bool
    jit_type_sys_char
    jit_type_sys_schar
    jit_type_sys_uchar
    jit_type_sys_short
    jit_type_sys_ushort
    jit_type_sys_int
    jit_type_sys_uint
    jit_type_sys_long
    jit_type_sys_ulong
    jit_type_sys_longlong
    jit_type_sys_ulonglong
    jit_type_sys_float
    jit_type_sys_double
    jit_type_sys_long_double
);

our %EXPORT_TAGS = ( 'all' => [ qw(
	JIT_PROT_EXEC_READ
	JIT_PROT_EXEC_READ_WRITE
	JIT_PROT_NONE
	JIT_PROT_READ
	JIT_PROT_READ_WRITE
	jit_abi_cdecl
	jit_abi_fastcall
	jit_abi_stdcall
	jit_abi_vararg
	_jit_get_frame_address
	_jit_get_next_frame_address
	_jit_get_return_address
	jit_apply
	jit_apply_raw
	jit_block_current_is_dead
	jit_block_ends_in_dead
	jit_block_free_meta
	jit_block_from_label
	jit_block_get_context
	jit_block_get_function
	jit_block_get_label
	jit_block_get_meta
	jit_block_get_next_label
	jit_block_is_reachable
	jit_block_next
	jit_block_previous
	jit_block_set_meta
	jit_calloc
	jit_closure_create
	jit_closure_va_get_float32
	jit_closure_va_get_float64
	jit_closure_va_get_long
	jit_closure_va_get_nfloat
	jit_closure_va_get_nint
	jit_closure_va_get_nuint
	jit_closure_va_get_ptr
	jit_closure_va_get_struct
	jit_closure_va_get_ulong
	jit_constant_convert
	jit_context_build_end
	jit_context_build_start
	jit_context_create
	jit_context_destroy
	jit_context_free_meta
	jit_context_get_meta
	jit_context_get_meta_numeric
	jit_context_set_memory_manager
	jit_context_set_meta
	jit_context_set_meta_numeric
	jit_context_set_on_demand_driver
	jit_debugger_add_breakpoint
	jit_debugger_attach_self
	jit_debugger_break
	jit_debugger_create
	jit_debugger_destroy
	jit_debugger_detach_self
	jit_debugger_finish
	jit_debugger_from_context
	jit_debugger_get_context
	jit_debugger_get_native_thread
	jit_debugger_get_self
	jit_debugger_get_thread
	jit_debugger_is_alive
	jit_debugger_is_running
	jit_debugger_next
	jit_debugger_quit
	jit_debugger_remove_all_breakpoints
	jit_debugger_remove_breakpoint
	jit_debugger_run
	jit_debugger_set_breakable
	jit_debugger_set_hook
	jit_debugger_step
	jit_debugger_wait_event
	jit_debugging_possible
	jit_default_memory_manager
	jit_exception_builtin
	jit_exception_clear_last
	jit_exception_get_handler
	jit_exception_get_last
	jit_exception_get_last_and_clear
	jit_exception_get_stack_trace
	jit_exception_set_handler
	jit_exception_set_last
	jit_exception_throw
	jit_float32_abs
	jit_float32_acos
	jit_float32_add
	jit_float32_asin
	jit_float32_atan
	jit_float32_atan2
	jit_float32_ceil
	jit_float32_cmpg
	jit_float32_cmpl
	jit_float32_cos
	jit_float32_cosh
	jit_float32_div
	jit_float32_eq
	jit_float32_exp
	jit_float32_floor
	jit_float32_ge
	jit_float32_gt
	jit_float32_ieee_rem
	jit_float32_is_finite
	jit_float32_is_inf
	jit_float32_is_nan
	jit_float32_le
	jit_float32_log
	jit_float32_log10
	jit_float32_lt
	jit_float32_max
	jit_float32_min
	jit_float32_mul
	jit_float32_ne
	jit_float32_neg
	jit_float32_pow
	jit_float32_rem
	jit_float32_rint
	jit_float32_round
	jit_float32_sign
	jit_float32_sin
	jit_float32_sinh
	jit_float32_sqrt
	jit_float32_sub
	jit_float32_tan
	jit_float32_tanh
	jit_float32_to_float64
	jit_float32_to_int
	jit_float32_to_int_ovf
	jit_float32_to_long
	jit_float32_to_long_ovf
	jit_float32_to_nfloat
	jit_float32_to_uint
	jit_float32_to_uint_ovf
	jit_float32_to_ulong
	jit_float32_to_ulong_ovf
	jit_float32_trunc
	jit_float64_abs
	jit_float64_acos
	jit_float64_add
	jit_float64_asin
	jit_float64_atan
	jit_float64_atan2
	jit_float64_ceil
	jit_float64_cmpg
	jit_float64_cmpl
	jit_float64_cos
	jit_float64_cosh
	jit_float64_div
	jit_float64_eq
	jit_float64_exp
	jit_float64_floor
	jit_float64_ge
	jit_float64_gt
	jit_float64_ieee_rem
	jit_float64_is_finite
	jit_float64_is_inf
	jit_float64_is_nan
	jit_float64_le
	jit_float64_log
	jit_float64_log10
	jit_float64_lt
	jit_float64_max
	jit_float64_min
	jit_float64_mul
	jit_float64_ne
	jit_float64_neg
	jit_float64_pow
	jit_float64_rem
	jit_float64_rint
	jit_float64_round
	jit_float64_sign
	jit_float64_sin
	jit_float64_sinh
	jit_float64_sqrt
	jit_float64_sub
	jit_float64_tan
	jit_float64_tanh
	jit_float64_to_float32
	jit_float64_to_int
	jit_float64_to_int_ovf
	jit_float64_to_long
	jit_float64_to_long_ovf
	jit_float64_to_nfloat
	jit_float64_to_uint
	jit_float64_to_uint_ovf
	jit_float64_to_ulong
	jit_float64_to_ulong_ovf
	jit_float64_trunc
	jit_frame_contains_crawl_mark
	jit_free
	jit_function_abandon
	jit_function_apply
	jit_function_apply_vararg
	jit_function_clear_recompilable
	jit_function_compile
	jit_function_compile_entry
	jit_function_create
	jit_function_create_nested
	jit_function_free_meta
	jit_function_from_closure
	jit_function_from_pc
	jit_function_from_vtable_pointer
	jit_function_get_context
	jit_function_get_current
	jit_function_get_entry
	jit_function_get_max_optimization_level
	jit_function_get_meta
	jit_function_get_nested_parent
	jit_function_get_on_demand_compiler
	jit_function_get_optimization_level
	jit_function_get_signature
	jit_function_is_compiled
	jit_function_is_recompilable
	jit_function_labels_equal
	jit_function_next
	jit_function_previous
	jit_function_reserve_label
	jit_function_set_meta
	jit_function_set_on_demand_compiler
	jit_function_set_optimization_level
	jit_function_set_recompilable
	jit_function_setup_entry
	jit_function_to_closure
	jit_function_to_vtable_pointer
	jit_get_closure_alignment
	jit_get_closure_size
	jit_get_trampoline_alignment
	jit_get_trampoline_size
	jit_init
	jit_insn_abs
	jit_insn_acos
	jit_insn_add
	jit_insn_add_ovf
	jit_insn_add_relative
	jit_insn_address_of
	jit_insn_address_of_label
	jit_insn_alloca
	jit_insn_and
	jit_insn_asin
	jit_insn_atan
	jit_insn_atan2
	jit_insn_branch
	jit_insn_branch_if
	jit_insn_branch_if_not
	jit_insn_branch_if_pc_not_in_range
	jit_insn_call
	jit_insn_call_filter
	jit_insn_call_finally
	jit_insn_call_indirect
	jit_insn_call_indirect_vtable
	jit_insn_call_intrinsic
	jit_insn_call_native
	jit_insn_ceil
	jit_insn_check_null
	jit_insn_cmpg
	jit_insn_cmpl
	jit_insn_convert
	jit_insn_cos
	jit_insn_cosh
	jit_insn_default_return
	jit_insn_defer_pop_stack
	jit_insn_dest_is_value
	jit_insn_div
	jit_insn_dup
	jit_insn_eq
	jit_insn_exp
	jit_insn_floor
	jit_insn_flush_defer_pop
	jit_insn_flush_struct
	jit_insn_ge
	jit_insn_get_call_stack
	jit_insn_get_dest
	jit_insn_get_function
	jit_insn_get_label
	jit_insn_get_name
	jit_insn_get_native
	jit_insn_get_opcode
	jit_insn_get_signature
	jit_insn_get_value1
	jit_insn_get_value2
	jit_insn_gt
	jit_insn_import
	jit_insn_incoming_frame_posn
	jit_insn_incoming_reg
	jit_insn_is_finite
	jit_insn_is_inf
	jit_insn_is_nan
	jit_insn_iter_init
	jit_insn_iter_init_last
	jit_insn_iter_next
	jit_insn_iter_previous
	jit_insn_jump_table
	jit_insn_label
	jit_insn_le
	jit_insn_load
	jit_insn_load_elem
	jit_insn_load_elem_address
	jit_insn_load_relative
	jit_insn_load_small
	jit_insn_log
	jit_insn_log10
	jit_insn_lt
	jit_insn_mark_breakpoint
	jit_insn_mark_breakpoint_variable
	jit_insn_mark_offset
	jit_insn_max
	jit_insn_memcpy
	jit_insn_memmove
	jit_insn_memset
	jit_insn_min
	jit_insn_move_blocks_to_end
	jit_insn_move_blocks_to_start
	jit_insn_mul
	jit_insn_mul_ovf
	jit_insn_ne
	jit_insn_neg
	jit_insn_new_block
	jit_insn_not
	jit_insn_or
	jit_insn_outgoing_frame_posn
	jit_insn_outgoing_reg
	jit_insn_pop_stack
	jit_insn_pow
	jit_insn_push
	jit_insn_push_ptr
	jit_insn_push_return_area_ptr
	jit_insn_rem
	jit_insn_rem_ieee
	jit_insn_rethrow_unhandled
	jit_insn_return
	jit_insn_return_from_filter
	jit_insn_return_from_finally
	jit_insn_return_ptr
	jit_insn_return_reg
	jit_insn_rint
	jit_insn_round
	jit_insn_set_param
	jit_insn_set_param_ptr
	jit_insn_setup_for_nested
	jit_insn_shl
	jit_insn_shr
	jit_insn_sign
	jit_insn_sin
	jit_insn_sinh
	jit_insn_sqrt
	jit_insn_sshr
	jit_insn_start_catcher
	jit_insn_start_filter
	jit_insn_start_finally
	jit_insn_store
	jit_insn_store_elem
	jit_insn_store_relative
	jit_insn_sub
	jit_insn_sub_ovf
	jit_insn_tan
	jit_insn_tanh
	jit_insn_throw
	jit_insn_thrown_exception
	jit_insn_to_bool
	jit_insn_to_not_bool
	jit_insn_trunc
	jit_insn_uses_catcher
	jit_insn_ushr
	jit_insn_xor
	jit_int_abs
	jit_int_add
	jit_int_add_ovf
	jit_int_and
	jit_int_cmp
	jit_int_div
	jit_int_eq
	jit_int_ge
	jit_int_gt
	jit_int_le
	jit_int_lt
	jit_int_max
	jit_int_min
	jit_int_mul
	jit_int_mul_ovf
	jit_int_ne
	jit_int_neg
	jit_int_not
	jit_int_or
	jit_int_rem
	jit_int_shl
	jit_int_shr
	jit_int_sign
	jit_int_sub
	jit_int_sub_ovf
	jit_int_to_float32
	jit_int_to_float64
	jit_int_to_int
	jit_int_to_int_ovf
	jit_int_to_long
	jit_int_to_long_ovf
	jit_int_to_nfloat
	jit_int_to_sbyte
	jit_int_to_sbyte_ovf
	jit_int_to_short
	jit_int_to_short_ovf
	jit_int_to_ubyte
	jit_int_to_ubyte_ovf
	jit_int_to_uint
	jit_int_to_uint_ovf
	jit_int_to_ulong
	jit_int_to_ulong_ovf
	jit_int_to_ushort
	jit_int_to_ushort_ovf
	jit_int_xor
	jit_long_abs
	jit_long_add
	jit_long_add_ovf
	jit_long_and
	jit_long_cmp
	jit_long_div
	jit_long_eq
	jit_long_ge
	jit_long_gt
	jit_long_le
	jit_long_lt
	jit_long_max
	jit_long_min
	jit_long_mul
	jit_long_mul_ovf
	jit_long_ne
	jit_long_neg
	jit_long_not
	jit_long_or
	jit_long_rem
	jit_long_shl
	jit_long_shr
	jit_long_sign
	jit_long_sub
	jit_long_sub_ovf
	jit_long_to_float32
	jit_long_to_float64
	jit_long_to_int
	jit_long_to_int_ovf
	jit_long_to_long
	jit_long_to_long_ovf
	jit_long_to_nfloat
	jit_long_to_uint
	jit_long_to_uint_ovf
	jit_long_to_ulong
	jit_long_to_ulong_ovf
	jit_long_xor
	jit_malloc
	jit_memchr
	jit_memcmp
	jit_memcpy
	jit_memmove
	jit_memset
	jit_meta_destroy
	jit_meta_free
	jit_meta_get
	jit_meta_set
	jit_nfloat_abs
	jit_nfloat_acos
	jit_nfloat_add
	jit_nfloat_asin
	jit_nfloat_atan
	jit_nfloat_atan2
	jit_nfloat_ceil
	jit_nfloat_cmpg
	jit_nfloat_cmpl
	jit_nfloat_cos
	jit_nfloat_cosh
	jit_nfloat_div
	jit_nfloat_eq
	jit_nfloat_exp
	jit_nfloat_floor
	jit_nfloat_ge
	jit_nfloat_gt
	jit_nfloat_ieee_rem
	jit_nfloat_is_finite
	jit_nfloat_is_inf
	jit_nfloat_is_nan
	jit_nfloat_le
	jit_nfloat_log
	jit_nfloat_log10
	jit_nfloat_lt
	jit_nfloat_max
	jit_nfloat_min
	jit_nfloat_mul
	jit_nfloat_ne
	jit_nfloat_neg
	jit_nfloat_pow
	jit_nfloat_rem
	jit_nfloat_rint
	jit_nfloat_round
	jit_nfloat_sign
	jit_nfloat_sin
	jit_nfloat_sinh
	jit_nfloat_sqrt
	jit_nfloat_sub
	jit_nfloat_tan
	jit_nfloat_tanh
	jit_nfloat_to_float32
	jit_nfloat_to_float64
	jit_nfloat_to_int
	jit_nfloat_to_int_ovf
	jit_nfloat_to_long
	jit_nfloat_to_long_ovf
	jit_nfloat_to_uint
	jit_nfloat_to_uint_ovf
	jit_nfloat_to_ulong
	jit_nfloat_to_ulong_ovf
	jit_nfloat_trunc
	jit_raw_supported
	jit_readelf_add_to_context
	jit_readelf_close
	jit_readelf_get_name
	jit_readelf_get_needed
	jit_readelf_get_section
	jit_readelf_get_section_by_type
	jit_readelf_get_symbol
	jit_readelf_map_vaddr
	jit_readelf_num_needed
	jit_readelf_open
	jit_readelf_register_symbol
	jit_readelf_resolve_all
	jit_realloc
	jit_snprintf
	jit_sprintf
	jit_stack_trace_free
	jit_stack_trace_get_function
	jit_stack_trace_get_offset
	jit_stack_trace_get_pc
	jit_stack_trace_get_size
	jit_strcat
	jit_strchr
	jit_strcmp
	jit_strcpy
	jit_strdup
	jit_stricmp
	jit_strlen
	jit_strncmp
	jit_strncpy
	jit_strndup
	jit_strnicmp
	jit_strrchr
	jit_supports_closures
	jit_supports_threads
	jit_supports_virtual_memory
	jit_type_best_alignment
	jit_type_copy
	jit_type_create_pointer
	jit_type_create_signature
	jit_type_create_struct
	jit_type_create_tagged
	jit_type_create_union
	jit_type_find_name
	jit_type_free
	jit_type_get_abi
	jit_type_get_alignment
	jit_type_get_field
	jit_type_get_kind
	jit_type_get_name
	jit_type_get_offset
	jit_type_get_param
	jit_type_get_ref
	jit_type_get_return
	jit_type_get_size
	jit_type_get_tagged_data
	jit_type_get_tagged_kind
	jit_type_get_tagged_type
	jit_type_has_tag
	jit_type_is_pointer
	jit_type_is_primitive
	jit_type_is_signature
	jit_type_is_struct
	jit_type_is_tagged
	jit_type_is_union
	jit_type_normalize
	jit_type_num_fields
	jit_type_num_params
	jit_type_promote_int
	jit_type_remove_tags
	jit_type_return_via_pointer
	jit_type_set_names
	jit_type_set_offset
	jit_type_set_size_and_alignment
	jit_type_set_tagged_data
	jit_type_set_tagged_type
	jit_uint_add
	jit_uint_add_ovf
	jit_uint_and
	jit_uint_cmp
	jit_uint_div
	jit_uint_eq
	jit_uint_ge
	jit_uint_gt
	jit_uint_le
	jit_uint_lt
	jit_uint_max
	jit_uint_min
	jit_uint_mul
	jit_uint_mul_ovf
	jit_uint_ne
	jit_uint_neg
	jit_uint_not
	jit_uint_or
	jit_uint_rem
	jit_uint_shl
	jit_uint_shr
	jit_uint_sub
	jit_uint_sub_ovf
	jit_uint_to_float32
	jit_uint_to_float64
	jit_uint_to_int
	jit_uint_to_int_ovf
	jit_uint_to_long
	jit_uint_to_long_ovf
	jit_uint_to_nfloat
	jit_uint_to_uint
	jit_uint_to_uint_ovf
	jit_uint_to_ulong
	jit_uint_to_ulong_ovf
	jit_uint_xor
	jit_ulong_add
	jit_ulong_add_ovf
	jit_ulong_and
	jit_ulong_cmp
	jit_ulong_div
	jit_ulong_eq
	jit_ulong_ge
	jit_ulong_gt
	jit_ulong_le
	jit_ulong_lt
	jit_ulong_max
	jit_ulong_min
	jit_ulong_mul
	jit_ulong_mul_ovf
	jit_ulong_ne
	jit_ulong_neg
	jit_ulong_not
	jit_ulong_or
	jit_ulong_rem
	jit_ulong_shl
	jit_ulong_shr
	jit_ulong_sub
	jit_ulong_sub_ovf
	jit_ulong_to_float32
	jit_ulong_to_float64
	jit_ulong_to_int
	jit_ulong_to_int_ovf
	jit_ulong_to_long
	jit_ulong_to_long_ovf
	jit_ulong_to_nfloat
	jit_ulong_to_uint
	jit_ulong_to_uint_ovf
	jit_ulong_to_ulong
	jit_ulong_to_ulong_ovf
	jit_ulong_xor
	jit_unwind_free
	jit_unwind_get_function
	jit_unwind_get_offset
	jit_unwind_get_pc
	jit_unwind_init
	jit_unwind_jump
	jit_unwind_next
	jit_unwind_next_pc
	jit_uses_interpreter
	jit_value_create
	jit_value_create_constant
	jit_value_create_float32_constant
	jit_value_create_float64_constant
	jit_value_create_long_constant
	jit_value_create_nfloat_constant
	jit_value_create_nint_constant
	jit_value_get_block
	jit_value_get_constant
	jit_value_get_context
	jit_value_get_float32_constant
	jit_value_get_float64_constant
	jit_value_get_function
	jit_value_get_long_constant
	jit_value_get_nfloat_constant
	jit_value_get_nint_constant
	jit_value_get_param
	jit_value_get_struct_pointer
	jit_value_get_type
	jit_value_is_addressable
	jit_value_is_constant
	jit_value_is_local
	jit_value_is_parameter
	jit_value_is_temporary
	jit_value_is_true
	jit_value_is_volatile
	jit_value_ref
	jit_value_set_addressable
	jit_value_set_volatile
	jit_vmem_commit
	jit_vmem_decommit
	jit_vmem_init
	jit_vmem_page_size
	jit_vmem_protect
	jit_vmem_release
	jit_vmem_reserve
	jit_vmem_reserve_committed
	jit_vmem_round_down
	jit_vmem_round_up
	jit_writeelf_add_function
	jit_writeelf_add_needed
	jit_writeelf_create
	jit_writeelf_destroy
	jit_writeelf_write
	jit_writeelf_write_section
	jitom_class_add_ref
	jitom_class_delete
	jitom_class_get_all_supers
	jitom_class_get_fields
	jitom_class_get_interfaces
	jitom_class_get_methods
	jitom_class_get_modifiers
	jitom_class_get_name
	jitom_class_get_primary_super
	jitom_class_get_type
	jitom_class_get_value_type
	jitom_class_new
	jitom_class_new_value
	jitom_destroy_model
	jitom_field_get_modifiers
	jitom_field_get_name
	jitom_field_get_type
	jitom_field_load
	jitom_field_load_address
	jitom_field_store
	jitom_get_class_by_name
	jitom_method_get_modifiers
	jitom_method_get_name
	jitom_method_get_type
	jitom_method_invoke
	jitom_method_invoke_virtual
	jitom_type_get_class
	jitom_type_get_model
	jitom_type_is_class
	jitom_type_is_value
	jitom_type_tag_as_class
	jitom_type_tag_as_value
), @TYPES ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	JIT_PROT_EXEC_READ
	JIT_PROT_EXEC_READ_WRITE
	JIT_PROT_NONE
	JIT_PROT_READ
	JIT_PROT_READ_WRITE
	jit_abi_cdecl
	jit_abi_fastcall
	jit_abi_stdcall
	jit_abi_vararg
);

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&LOLJIT::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('LOLJIT', $VERSION);

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

LOLJIT - Perl extension for blah blah blah

=head1 SYNOPSIS

  use LOLJIT;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for LOLJIT, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.

=head2 Exportable constants

  JIT_PROT_EXEC_READ
  JIT_PROT_EXEC_READ_WRITE
  JIT_PROT_NONE
  JIT_PROT_READ
  JIT_PROT_READ_WRITE
  jit_abi_cdecl
  jit_abi_fastcall
  jit_abi_stdcall
  jit_abi_vararg

=head2 Exportable functions

  void *_jit_get_frame_address(void *start, unsigned int n)
  void *_jit_get_next_frame_address(void *frame)
  void *_jit_get_return_address(void *frame, void *frame0, void *return0)
  void jit_apply(jit_type_t signature, void *func,
               void **args, unsigned int num_fixed_args,
               void *return_value)
  void jit_apply_raw(jit_type_t signature, void *func,
                   void *args, void *return_value)
  int jit_block_current_is_dead(jit_function_t func) 
  int jit_block_ends_in_dead(jit_block_t block) 
  void jit_block_free_meta(jit_block_t block, int type) 
  jit_block_t jit_block_from_label(jit_function_t func,
     jit_label_t label) 
  jit_context_t jit_block_get_context(jit_block_t block) 
  jit_function_t jit_block_get_function(jit_block_t block) 
  jit_label_t jit_block_get_label(jit_block_t block) 
  void *jit_block_get_meta(jit_block_t block, int type) 
  jit_label_t jit_block_get_next_label(jit_block_t block,
         jit_label_t label) 
  int jit_block_is_reachable(jit_block_t block) 
  jit_block_t jit_block_next(jit_function_t func,
      jit_block_t previous) 
  jit_block_t jit_block_previous(jit_function_t func,
          jit_block_t previous) 
  int jit_block_set_meta(jit_block_t block, int type, void *data,
         jit_meta_free_func free_data) 
  void *jit_calloc(unsigned int num, unsigned int size) 
  void *jit_closure_create(jit_context_t context, jit_type_t signature,
    jit_closure_func func, void *user_data)
  jit_float32 jit_closure_va_get_float32(jit_closure_va_list_t va)
  jit_float64 jit_closure_va_get_float64(jit_closure_va_list_t va)
  jit_long jit_closure_va_get_long(jit_closure_va_list_t va)
  jit_nfloat jit_closure_va_get_nfloat(jit_closure_va_list_t va)
  jit_nint jit_closure_va_get_nint(jit_closure_va_list_t va)
  jit_nuint jit_closure_va_get_nuint(jit_closure_va_list_t va)
  void *jit_closure_va_get_ptr(jit_closure_va_list_t va)
  void jit_closure_va_get_struct(jit_closure_va_list_t va, void *buf, jit_type_t type)
  jit_ulong jit_closure_va_get_ulong(jit_closure_va_list_t va)
  int jit_constant_convert
 (jit_constant_t *result, jit_constant_t *value,
  jit_type_t type, int overflow_check) 
  void jit_context_build_end(jit_context_t context) 
  void jit_context_build_start(jit_context_t context) 
  jit_context_t jit_context_create(void) 
  void jit_context_destroy(jit_context_t context) 
  void jit_context_free_meta(jit_context_t context, int type) 
  void *jit_context_get_meta(jit_context_t context, int type) 
  jit_nuint jit_context_get_meta_numeric
 (jit_context_t context, int type) 
  void jit_context_set_memory_manager(
 jit_context_t context,
 jit_memory_manager_t manager) 
  int jit_context_set_meta
 (jit_context_t context, int type, void *data,
  jit_meta_free_func free_data) 
  int jit_context_set_meta_numeric
 (jit_context_t context, int type, jit_nuint data) 
  void jit_context_set_on_demand_driver(
 jit_context_t context,
 jit_on_demand_driver_func driver) 
  jit_debugger_breakpoint_id_t jit_debugger_add_breakpoint
  (jit_debugger_t dbg, jit_debugger_breakpoint_info_t info) 
  void jit_debugger_attach_self
  (jit_debugger_t dbg, int stop_immediately) 
  void jit_debugger_break(jit_debugger_t dbg) 
  jit_debugger_t jit_debugger_create(jit_context_t context) 
  void jit_debugger_destroy(jit_debugger_t dbg) 
  void jit_debugger_detach_self(jit_debugger_t dbg) 
  void jit_debugger_finish
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  jit_debugger_t jit_debugger_from_context(jit_context_t context) 
  jit_context_t jit_debugger_get_context(jit_debugger_t dbg) 
  int jit_debugger_get_native_thread
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread,
   void *native_thread) 
  jit_debugger_thread_id_t jit_debugger_get_self(jit_debugger_t dbg) 
  jit_debugger_thread_id_t jit_debugger_get_thread
  (jit_debugger_t dbg, void *native_thread) 
  int jit_debugger_is_alive
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  int jit_debugger_is_running
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  void jit_debugger_next
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  void jit_debugger_quit(jit_debugger_t dbg) 
  void jit_debugger_remove_all_breakpoints(jit_debugger_t dbg) 
  void jit_debugger_remove_breakpoint
  (jit_debugger_t dbg, jit_debugger_breakpoint_id_t id) 
  void jit_debugger_run
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  void jit_debugger_set_breakable
  (jit_debugger_t dbg, void *native_thread, int flag) 
  jit_debugger_hook_func jit_debugger_set_hook
  (jit_context_t context, jit_debugger_hook_func hook)
  void jit_debugger_step
  (jit_debugger_t dbg, jit_debugger_thread_id_t thread) 
  int jit_debugger_wait_event
  (jit_debugger_t dbg, jit_debugger_event_t *event,
   jit_int timeout) 
  int jit_debugging_possible(void) 
  jit_memory_manager_t jit_default_memory_manager(void) 
  void jit_exception_builtin(int exception_type)
  void jit_exception_clear_last(void)
  jit_exception_func jit_exception_get_handler(void)
  void *jit_exception_get_last(void)
  void *jit_exception_get_last_and_clear(void)
  jit_stack_trace_t jit_exception_get_stack_trace(void)
  jit_exception_func jit_exception_set_handler(jit_exception_func handler)
  void jit_exception_set_last(void *object)
  void jit_exception_throw(void *object)
  jit_float32 jit_float32_abs(jit_float32 value1) 
  jit_float32 jit_float32_acos(jit_float32 value1) 
  jit_float32 jit_float32_add
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_asin(jit_float32 value1) 
  jit_float32 jit_float32_atan(jit_float32 value1) 
  jit_float32 jit_float32_atan2
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_ceil(jit_float32 value1) 
  jit_int jit_float32_cmpg(jit_float32 value1, jit_float32 value2) 
  jit_int jit_float32_cmpl(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_cos(jit_float32 value1) 
  jit_float32 jit_float32_cosh(jit_float32 value1) 
  jit_float32 jit_float32_div
 (jit_float32 value1, jit_float32 value2) 
  jit_int jit_float32_eq(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_exp(jit_float32 value1) 
  jit_float32 jit_float32_floor(jit_float32 value1) 
  jit_int jit_float32_ge(jit_float32 value1, jit_float32 value2) 
  jit_int jit_float32_gt(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_ieee_rem
 (jit_float32 value1, jit_float32 value2) 
  jit_int jit_float32_is_finite(jit_float32 value) 
  jit_int jit_float32_is_inf(jit_float32 value) 
  jit_int jit_float32_is_nan(jit_float32 value) 
  jit_int jit_float32_le(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_log(jit_float32 value1) 
  jit_float32 jit_float32_log10(jit_float32 value1) 
  jit_int jit_float32_lt(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_max
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_min
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_mul
 (jit_float32 value1, jit_float32 value2) 
  jit_int jit_float32_ne(jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_neg(jit_float32 value1) 
  jit_float32 jit_float32_pow
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_rem
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_rint(jit_float32 value1) 
  jit_float32 jit_float32_round(jit_float32 value1) 
  jit_int jit_float32_sign(jit_float32 value1) 
  jit_float32 jit_float32_sin(jit_float32 value1) 
  jit_float32 jit_float32_sinh(jit_float32 value1) 
  jit_float32 jit_float32_sqrt(jit_float32 value1) 
  jit_float32 jit_float32_sub
 (jit_float32 value1, jit_float32 value2) 
  jit_float32 jit_float32_tan(jit_float32 value1) 
  jit_float32 jit_float32_tanh(jit_float32 value1) 
  jit_float64 jit_float32_to_float64(jit_float32 value) 
  jit_int jit_float32_to_int(jit_float32 value) 
  jit_int jit_float32_to_int_ovf(jit_int *result, jit_float32 value) 
  jit_long jit_float32_to_long(jit_float32 value) 
  jit_int jit_float32_to_long_ovf(jit_long *result, jit_float32 value) 
  jit_nfloat jit_float32_to_nfloat(jit_float32 value) 
  jit_uint jit_float32_to_uint(jit_float32 value) 
  jit_int jit_float32_to_uint_ovf(jit_uint *result, jit_float32 value) 
  jit_ulong jit_float32_to_ulong(jit_float32 value) 
  jit_int jit_float32_to_ulong_ovf
 (jit_ulong *result, jit_float32 value) 
  jit_float32 jit_float32_trunc(jit_float32 value1) 
  jit_float64 jit_float64_abs(jit_float64 value1) 
  jit_float64 jit_float64_acos(jit_float64 value1) 
  jit_float64 jit_float64_add
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_asin(jit_float64 value1) 
  jit_float64 jit_float64_atan(jit_float64 value1) 
  jit_float64 jit_float64_atan2
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_ceil(jit_float64 value1) 
  jit_int jit_float64_cmpg(jit_float64 value1, jit_float64 value2) 
  jit_int jit_float64_cmpl(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_cos(jit_float64 value1) 
  jit_float64 jit_float64_cosh(jit_float64 value1) 
  jit_float64 jit_float64_div
 (jit_float64 value1, jit_float64 value2) 
  jit_int jit_float64_eq(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_exp(jit_float64 value1) 
  jit_float64 jit_float64_floor(jit_float64 value1) 
  jit_int jit_float64_ge(jit_float64 value1, jit_float64 value2) 
  jit_int jit_float64_gt(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_ieee_rem
 (jit_float64 value1, jit_float64 value2) 
  jit_int jit_float64_is_finite(jit_float64 value) 
  jit_int jit_float64_is_inf(jit_float64 value) 
  jit_int jit_float64_is_nan(jit_float64 value) 
  jit_int jit_float64_le(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_log(jit_float64 value1) 
  jit_float64 jit_float64_log10(jit_float64 value1) 
  jit_int jit_float64_lt(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_max
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_min
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_mul
 (jit_float64 value1, jit_float64 value2) 
  jit_int jit_float64_ne(jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_neg(jit_float64 value1) 
  jit_float64 jit_float64_pow
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_rem
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_rint(jit_float64 value1) 
  jit_float64 jit_float64_round(jit_float64 value1) 
  jit_int jit_float64_sign(jit_float64 value1) 
  jit_float64 jit_float64_sin(jit_float64 value1) 
  jit_float64 jit_float64_sinh(jit_float64 value1) 
  jit_float64 jit_float64_sqrt(jit_float64 value1) 
  jit_float64 jit_float64_sub
 (jit_float64 value1, jit_float64 value2) 
  jit_float64 jit_float64_tan(jit_float64 value1) 
  jit_float64 jit_float64_tanh(jit_float64 value1) 
  jit_float32 jit_float64_to_float32(jit_float64 value) 
  jit_int jit_float64_to_int(jit_float64 value) 
  jit_int jit_float64_to_int_ovf(jit_int *result, jit_float64 value) 
  jit_long jit_float64_to_long(jit_float64 value) 
  jit_int jit_float64_to_long_ovf(jit_long *result, jit_float64 value) 
  jit_nfloat jit_float64_to_nfloat(jit_float64 value) 
  jit_uint jit_float64_to_uint(jit_float64 value) 
  jit_int jit_float64_to_uint_ovf(jit_uint *result, jit_float64 value) 
  jit_ulong jit_float64_to_ulong(jit_float64 value) 
  jit_int jit_float64_to_ulong_ovf
 (jit_ulong *result, jit_float64 value) 
  jit_float64 jit_float64_trunc(jit_float64 value1) 
  int jit_frame_contains_crawl_mark(void *frame, jit_crawl_mark_t *mark)
  void jit_free(void *ptr) 
  void jit_function_abandon(jit_function_t func) 
  int jit_function_apply
 (jit_function_t func, void **args, void *return_area)
  int jit_function_apply_vararg
 (jit_function_t func, jit_type_t signature, void **args, void *return_area)
  void jit_function_clear_recompilable(jit_function_t func) 
  int jit_function_compile(jit_function_t func) 
  int jit_function_compile_entry(jit_function_t func, void **entry_point) 
  jit_function_t jit_function_create
 (jit_context_t context, jit_type_t signature) 
  jit_function_t jit_function_create_nested
 (jit_context_t context, jit_type_t signature,
  jit_function_t parent) 
  void jit_function_free_meta(jit_function_t func, int type) 
  jit_function_t jit_function_from_closure
 (jit_context_t context, void *closure) 
  jit_function_t jit_function_from_pc
 (jit_context_t context, void *pc, void **handler) 
  jit_function_t jit_function_from_vtable_pointer
 (jit_context_t context, void *vtable_pointer) 
  jit_context_t jit_function_get_context(jit_function_t func) 
  jit_block_t jit_function_get_current(jit_function_t func) 
  jit_block_t jit_function_get_entry(jit_function_t func) 
  unsigned int jit_function_get_max_optimization_level(void) 
  void *jit_function_get_meta(jit_function_t func, int type) 
  jit_function_t jit_function_get_nested_parent(jit_function_t func) 
  jit_on_demand_func jit_function_get_on_demand_compiler(jit_function_t func) 
  unsigned int jit_function_get_optimization_level
 (jit_function_t func) 
  jit_type_t jit_function_get_signature(jit_function_t func) 
  int jit_function_is_compiled(jit_function_t func) 
  int jit_function_is_recompilable(jit_function_t func) 
  int jit_function_labels_equal(jit_function_t func, jit_label_t label, jit_label_t label2)
  jit_function_t jit_function_next
 (jit_context_t context, jit_function_t prev) 
  jit_function_t jit_function_previous
 (jit_context_t context, jit_function_t prev) 
  jit_label_t jit_function_reserve_label(jit_function_t func) 
  int jit_function_set_meta
 (jit_function_t func, int type, void *data,
  jit_meta_free_func free_data, int build_only) 
  void jit_function_set_on_demand_compiler
 (jit_function_t func, jit_on_demand_func on_demand) 
  void jit_function_set_optimization_level
 (jit_function_t func, unsigned int level) 
  void jit_function_set_recompilable(jit_function_t func) 
  void jit_function_setup_entry(jit_function_t func, void *entry_point) 
  void *jit_function_to_closure(jit_function_t func) 
  void *jit_function_to_vtable_pointer(jit_function_t func) 
  unsigned int jit_get_closure_alignment(void)
  unsigned int jit_get_closure_size(void)
  unsigned int jit_get_trampoline_alignment(void)
  unsigned int jit_get_trampoline_size(void)
  void jit_init(void) 
  jit_value_t jit_insn_abs
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_acos
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_add
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_add_ovf
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_add_relative
 (jit_function_t func, jit_value_t value, jit_nint offset) 
  jit_value_t jit_insn_address_of
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_address_of_label
 (jit_function_t func, jit_label_t *label) 
  jit_value_t jit_insn_alloca
 (jit_function_t func, jit_value_t size) 
  jit_value_t jit_insn_and
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_asin
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_atan
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_atan2
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_branch
 (jit_function_t func, jit_label_t *label) 
  int jit_insn_branch_if
 (jit_function_t func, jit_value_t value, jit_label_t *label) 
  int jit_insn_branch_if_not
 (jit_function_t func, jit_value_t value, jit_label_t *label) 
  int jit_insn_branch_if_pc_not_in_range
 (jit_function_t func, jit_label_t start_label,
  jit_label_t end_label, jit_label_t *label) 
  jit_value_t jit_insn_call
 (jit_function_t func, char *name,
  jit_function_t jit_func, jit_type_t signature,
  jit_value_t *args, unsigned int num_args, int flags) 
  jit_value_t jit_insn_call_filter
 (jit_function_t func, jit_label_t *label,
  jit_value_t value, jit_type_t type) 
  int jit_insn_call_finally
 (jit_function_t func, jit_label_t *finally_label) 
  jit_value_t jit_insn_call_indirect
 (jit_function_t func, jit_value_t value, jit_type_t signature,
  jit_value_t *args, unsigned int num_args, int flags) 
  jit_value_t jit_insn_call_indirect_vtable
 (jit_function_t func, jit_value_t value, jit_type_t signature,
  jit_value_t *args, unsigned int num_args, int flags) 
  jit_value_t jit_insn_call_intrinsic
 (jit_function_t func, char *name, void *intrinsic_func,
   jit_intrinsic_descr_t *descriptor,
  jit_value_t arg1, jit_value_t arg2) 
  jit_value_t jit_insn_call_native
 (jit_function_t func, char *name,
  void *native_func, jit_type_t signature,
  jit_value_t *args, unsigned int num_args, int flags) 
  jit_value_t jit_insn_ceil
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_check_null(jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_cmpg
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_cmpl
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_convert
 (jit_function_t func, jit_value_t value,
  jit_type_t type, int overflow_check) 
  jit_value_t jit_insn_cos
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_cosh
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_default_return(jit_function_t func) 
  int jit_insn_defer_pop_stack
 (jit_function_t func, jit_nint num_items) 
  int jit_insn_dest_is_value(jit_insn_t insn) 
  jit_value_t jit_insn_div
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_dup(jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_eq
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_exp
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_floor
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_flush_defer_pop
 (jit_function_t func, jit_nint num_items) 
  int jit_insn_flush_struct(jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_ge
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_get_call_stack(jit_function_t func) 
  jit_value_t jit_insn_get_dest(jit_insn_t insn) 
  jit_function_t jit_insn_get_function(jit_insn_t insn) 
  jit_label_t jit_insn_get_label(jit_insn_t insn) 
  char *jit_insn_get_name(jit_insn_t insn) 
  void *jit_insn_get_native(jit_insn_t insn) 
  int jit_insn_get_opcode(jit_insn_t insn) 
  jit_type_t jit_insn_get_signature(jit_insn_t insn) 
  jit_value_t jit_insn_get_value1(jit_insn_t insn) 
  jit_value_t jit_insn_get_value2(jit_insn_t insn) 
  jit_value_t jit_insn_gt
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_import
 (jit_function_t func, jit_value_t value) 
  int jit_insn_incoming_frame_posn
 (jit_function_t func, jit_value_t value, jit_nint frame_offset) 
  int jit_insn_incoming_reg
 (jit_function_t func, jit_value_t value, int reg) 
  jit_value_t jit_insn_is_finite
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_is_inf
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_is_nan
 (jit_function_t func, jit_value_t value1) 
  void jit_insn_iter_init(jit_insn_iter_t *iter, jit_block_t block) 
  void jit_insn_iter_init_last
 (jit_insn_iter_t *iter, jit_block_t block) 
  jit_insn_t jit_insn_iter_next(jit_insn_iter_t *iter) 
  jit_insn_t jit_insn_iter_previous(jit_insn_iter_t *iter) 
  int jit_insn_jump_table
 (jit_function_t func, jit_value_t value,
  jit_label_t *labels, unsigned int num_labels) 
  int jit_insn_label(jit_function_t func, jit_label_t *label) 
  jit_value_t jit_insn_le
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_load(jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_load_elem
 (jit_function_t func, jit_value_t base_addr,
  jit_value_t index, jit_type_t elem_type) 
  jit_value_t jit_insn_load_elem_address
 (jit_function_t func, jit_value_t base_addr,
  jit_value_t index, jit_type_t elem_type) 
  jit_value_t jit_insn_load_relative
 (jit_function_t func, jit_value_t value,
  jit_nint offset, jit_type_t type) 
  jit_value_t jit_insn_load_small
 (jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_log
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_log10
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_lt
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_mark_breakpoint
 (jit_function_t func, jit_nint data1, jit_nint data2) 
  int jit_insn_mark_breakpoint_variable
 (jit_function_t func, jit_value_t data1, jit_value_t data2) 
  int jit_insn_mark_offset
 (jit_function_t func, jit_int offset) 
  jit_value_t jit_insn_max
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_memcpy
 (jit_function_t func, jit_value_t dest,
  jit_value_t src, jit_value_t size) 
  int jit_insn_memmove
 (jit_function_t func, jit_value_t dest,
  jit_value_t src, jit_value_t size) 
  int jit_insn_memset
 (jit_function_t func, jit_value_t dest,
  jit_value_t value, jit_value_t size) 
  jit_value_t jit_insn_min
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_move_blocks_to_end
 (jit_function_t func, jit_label_t from_label, jit_label_t to_label)
  
  int jit_insn_move_blocks_to_start
 (jit_function_t func, jit_label_t from_label, jit_label_t to_label)
  
  jit_value_t jit_insn_mul
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_mul_ovf
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_ne
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_neg
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_new_block(jit_function_t func) 
  jit_value_t jit_insn_not
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_or
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_outgoing_frame_posn
 (jit_function_t func, jit_value_t value, jit_nint frame_offset) 
  int jit_insn_outgoing_reg
 (jit_function_t func, jit_value_t value, int reg) 
  int jit_insn_pop_stack(jit_function_t func, jit_nint num_items) 
  jit_value_t jit_insn_pow
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_push(jit_function_t func, jit_value_t value) 
  int jit_insn_push_ptr
 (jit_function_t func, jit_value_t value, jit_type_t type) 
  int jit_insn_push_return_area_ptr(jit_function_t func) 
  jit_value_t jit_insn_rem
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_rem_ieee
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  int jit_insn_rethrow_unhandled(jit_function_t func) 
  int jit_insn_return(jit_function_t func, jit_value_t value) 
  int jit_insn_return_from_filter
 (jit_function_t func, jit_value_t value) 
  int jit_insn_return_from_finally(jit_function_t func) 
  int jit_insn_return_ptr
 (jit_function_t func, jit_value_t value, jit_type_t type) 
  int jit_insn_return_reg
 (jit_function_t func, jit_value_t value, int reg) 
  jit_value_t jit_insn_rint
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_round
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_set_param
 (jit_function_t func, jit_value_t value, jit_nint offset) 
  int jit_insn_set_param_ptr
 (jit_function_t func, jit_value_t value, jit_type_t type,
  jit_nint offset) 
  int jit_insn_setup_for_nested
 (jit_function_t func, int nested_level, int reg) 
  jit_value_t jit_insn_shl
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_shr
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_sign
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_sin
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_sinh
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_sqrt
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_sshr
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_start_catcher(jit_function_t func) 
  jit_value_t jit_insn_start_filter
 (jit_function_t func, jit_label_t *label, jit_type_t type) 
  int jit_insn_start_finally
 (jit_function_t func, jit_label_t *finally_label) 
  int jit_insn_store
 (jit_function_t func, jit_value_t dest, jit_value_t value) 
  int jit_insn_store_elem
 (jit_function_t func, jit_value_t base_addr,
  jit_value_t index, jit_value_t value) 
  int jit_insn_store_relative
 (jit_function_t func, jit_value_t dest,
  jit_nint offset, jit_value_t value) 
  jit_value_t jit_insn_sub
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_sub_ovf
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_tan
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_tanh
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_throw(jit_function_t func, jit_value_t value) 
  jit_value_t jit_insn_thrown_exception(jit_function_t func) 
  jit_value_t jit_insn_to_bool
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_to_not_bool
 (jit_function_t func, jit_value_t value1) 
  jit_value_t jit_insn_trunc
 (jit_function_t func, jit_value_t value1) 
  int jit_insn_uses_catcher(jit_function_t func) 
  jit_value_t jit_insn_ushr
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_value_t jit_insn_xor
 (jit_function_t func, jit_value_t value1, jit_value_t value2) 
  jit_int jit_int_abs(jit_int value1) 
  jit_int jit_int_add(jit_int value1, jit_int value2) 
  jit_int jit_int_add_ovf
 (jit_int *result, jit_int value1, jit_int value2) 
  jit_int jit_int_and(jit_int value1, jit_int value2) 
  jit_int jit_int_cmp(jit_int value1, jit_int value2) 
  jit_int jit_int_div
 (jit_int *result, jit_int value1, jit_int value2) 
  jit_int jit_int_eq(jit_int value1, jit_int value2) 
  jit_int jit_int_ge(jit_int value1, jit_int value2) 
  jit_int jit_int_gt(jit_int value1, jit_int value2) 
  jit_int jit_int_le(jit_int value1, jit_int value2) 
  jit_int jit_int_lt(jit_int value1, jit_int value2) 
  jit_int jit_int_max(jit_int value1, jit_int value2) 
  jit_int jit_int_min(jit_int value1, jit_int value2) 
  jit_int jit_int_mul(jit_int value1, jit_int value2) 
  jit_int jit_int_mul_ovf
 (jit_int *result, jit_int value1, jit_int value2) 
  jit_int jit_int_ne(jit_int value1, jit_int value2) 
  jit_int jit_int_neg(jit_int value1) 
  jit_int jit_int_not(jit_int value1) 
  jit_int jit_int_or(jit_int value1, jit_int value2) 
  jit_int jit_int_rem
 (jit_int *result, jit_int value1, jit_int value2) 
  jit_int jit_int_shl(jit_int value1, jit_uint value2) 
  jit_int jit_int_shr(jit_int value1, jit_uint value2) 
  jit_int jit_int_sign(jit_int value1) 
  jit_int jit_int_sub(jit_int value1, jit_int value2) 
  jit_int jit_int_sub_ovf
 (jit_int *result, jit_int value1, jit_int value2) 
  jit_float32 jit_int_to_float32(jit_int value) 
  jit_float64 jit_int_to_float64(jit_int value) 
  jit_int jit_int_to_int(jit_int value) 
  jit_int jit_int_to_int_ovf(jit_int *result, jit_int value) 
  jit_long jit_int_to_long(jit_int value) 
  jit_int jit_int_to_long_ovf(jit_long *result, jit_int value) 
  jit_nfloat jit_int_to_nfloat(jit_int value) 
  jit_int jit_int_to_sbyte(jit_int value) 
  jit_int jit_int_to_sbyte_ovf(jit_int *result, jit_int value) 
  jit_int jit_int_to_short(jit_int value) 
  jit_int jit_int_to_short_ovf(jit_int *result, jit_int value) 
  jit_int jit_int_to_ubyte(jit_int value) 
  jit_int jit_int_to_ubyte_ovf(jit_int *result, jit_int value) 
  jit_uint jit_int_to_uint(jit_int value) 
  jit_int jit_int_to_uint_ovf(jit_uint *result, jit_int value) 
  jit_ulong jit_int_to_ulong(jit_int value) 
  jit_int jit_int_to_ulong_ovf(jit_ulong *result, jit_int value) 
  jit_int jit_int_to_ushort(jit_int value) 
  jit_int jit_int_to_ushort_ovf(jit_int *result, jit_int value) 
  jit_int jit_int_xor(jit_int value1, jit_int value2) 
  jit_long jit_long_abs(jit_long value1) 
  jit_long jit_long_add(jit_long value1, jit_long value2) 
  jit_int jit_long_add_ovf
 (jit_long *result, jit_long value1, jit_long value2) 
  jit_long jit_long_and(jit_long value1, jit_long value2) 
  jit_int jit_long_cmp(jit_long value1, jit_long value2) 
  jit_int jit_long_div
 (jit_long *result, jit_long value1, jit_long value2) 
  jit_int jit_long_eq(jit_long value1, jit_long value2) 
  jit_int jit_long_ge(jit_long value1, jit_long value2) 
  jit_int jit_long_gt(jit_long value1, jit_long value2) 
  jit_int jit_long_le(jit_long value1, jit_long value2) 
  jit_int jit_long_lt(jit_long value1, jit_long value2) 
  jit_long jit_long_max(jit_long value1, jit_long value2) 
  jit_long jit_long_min(jit_long value1, jit_long value2) 
  jit_long jit_long_mul(jit_long value1, jit_long value2) 
  jit_int jit_long_mul_ovf
 (jit_long *result, jit_long value1, jit_long value2) 
  jit_int jit_long_ne(jit_long value1, jit_long value2) 
  jit_long jit_long_neg(jit_long value1) 
  jit_long jit_long_not(jit_long value1) 
  jit_long jit_long_or(jit_long value1, jit_long value2) 
  jit_int jit_long_rem
 (jit_long *result, jit_long value1, jit_long value2) 
  jit_long jit_long_shl(jit_long value1, jit_uint value2) 
  jit_long jit_long_shr(jit_long value1, jit_uint value2) 
  jit_int jit_long_sign(jit_long value1) 
  jit_long jit_long_sub(jit_long value1, jit_long value2) 
  jit_int jit_long_sub_ovf
 (jit_long *result, jit_long value1, jit_long value2) 
  jit_float32 jit_long_to_float32(jit_long value) 
  jit_float64 jit_long_to_float64(jit_long value) 
  jit_int jit_long_to_int(jit_long value) 
  jit_int jit_long_to_int_ovf(jit_int *result, jit_long value) 
  jit_long jit_long_to_long(jit_long value) 
  jit_int jit_long_to_long_ovf(jit_long *result, jit_long value) 
  jit_nfloat jit_long_to_nfloat(jit_long value) 
  jit_uint jit_long_to_uint(jit_long value) 
  jit_int jit_long_to_uint_ovf(jit_uint *result, jit_long value) 
  jit_ulong jit_long_to_ulong(jit_long value) 
  jit_int jit_long_to_ulong_ovf(jit_ulong *result, jit_long value) 
  jit_long jit_long_xor(jit_long value1, jit_long value2) 
  void *jit_malloc(unsigned int size) 
  void *jit_memchr( void *str, int ch, unsigned int len) 
  int jit_memcmp( void *s1, void *s2, unsigned int len) 
  void *jit_memcpy(void *dest, void *src, unsigned int len) 
  void *jit_memmove(void *dest, void *src, unsigned int len) 
  void *jit_memset(void *dest, int ch, unsigned int len) 
  void jit_meta_destroy(jit_meta_t *list) 
  void jit_meta_free(jit_meta_t *list, int type) 
  void *jit_meta_get(jit_meta_t list, int type) 
  int jit_meta_set
 (jit_meta_t *list, int type, void *data,
  jit_meta_free_func free_data, jit_function_t pool_owner) 
  jit_nfloat jit_nfloat_abs(jit_nfloat value1) 
  jit_nfloat jit_nfloat_acos(jit_nfloat value1) 
  jit_nfloat jit_nfloat_add(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_asin(jit_nfloat value1) 
  jit_nfloat jit_nfloat_atan(jit_nfloat value1) 
  jit_nfloat jit_nfloat_atan2(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_ceil(jit_nfloat value1) 
  jit_int jit_nfloat_cmpg(jit_nfloat value1, jit_nfloat value2) 
  jit_int jit_nfloat_cmpl(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_cos(jit_nfloat value1) 
  jit_nfloat jit_nfloat_cosh(jit_nfloat value1) 
  jit_nfloat jit_nfloat_div(jit_nfloat value1, jit_nfloat value2) 
  jit_int jit_nfloat_eq(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_exp(jit_nfloat value1) 
  jit_nfloat jit_nfloat_floor(jit_nfloat value1) 
  jit_int jit_nfloat_ge(jit_nfloat value1, jit_nfloat value2) 
  jit_int jit_nfloat_gt(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_ieee_rem
 (jit_nfloat value1, jit_nfloat value2) 
  jit_int jit_nfloat_is_finite(jit_nfloat value) 
  jit_int jit_nfloat_is_inf(jit_nfloat value) 
  jit_int jit_nfloat_is_nan(jit_nfloat value) 
  jit_int jit_nfloat_le(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_log(jit_nfloat value1) 
  jit_nfloat jit_nfloat_log10(jit_nfloat value1) 
  jit_int jit_nfloat_lt(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_max(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_min(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_mul(jit_nfloat value1, jit_nfloat value2) 
  jit_int jit_nfloat_ne(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_neg(jit_nfloat value1) 
  jit_nfloat jit_nfloat_pow(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_rem(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_rint(jit_nfloat value1) 
  jit_nfloat jit_nfloat_round(jit_nfloat value1) 
  jit_int jit_nfloat_sign(jit_nfloat value1) 
  jit_nfloat jit_nfloat_sin(jit_nfloat value1) 
  jit_nfloat jit_nfloat_sinh(jit_nfloat value1) 
  jit_nfloat jit_nfloat_sqrt(jit_nfloat value1) 
  jit_nfloat jit_nfloat_sub(jit_nfloat value1, jit_nfloat value2) 
  jit_nfloat jit_nfloat_tan(jit_nfloat value1) 
  jit_nfloat jit_nfloat_tanh(jit_nfloat value1) 
  jit_float32 jit_nfloat_to_float32(jit_nfloat value) 
  jit_float64 jit_nfloat_to_float64(jit_nfloat value) 
  jit_int jit_nfloat_to_int(jit_nfloat value) 
  jit_int jit_nfloat_to_int_ovf(jit_int *result, jit_nfloat value) 
  jit_long jit_nfloat_to_long(jit_nfloat value) 
  jit_int jit_nfloat_to_long_ovf(jit_long *result, jit_nfloat value) 
  jit_uint jit_nfloat_to_uint(jit_nfloat value) 
  jit_int jit_nfloat_to_uint_ovf(jit_uint *result, jit_nfloat value) 
  jit_ulong jit_nfloat_to_ulong(jit_nfloat value) 
  jit_int jit_nfloat_to_ulong_ovf
 (jit_ulong *result, jit_nfloat value) 
  jit_nfloat jit_nfloat_trunc(jit_nfloat value1) 
  int jit_raw_supported(jit_type_t signature)
  void jit_readelf_add_to_context
 (jit_readelf_t readelf, jit_context_t context) 
  void jit_readelf_close(jit_readelf_t readelf) 
  char *jit_readelf_get_name(jit_readelf_t readelf) 
  char *jit_readelf_get_needed
 (jit_readelf_t readelf, unsigned int index) 
  void *jit_readelf_get_section
 (jit_readelf_t readelf, char *name, jit_nuint *size) 
  void *jit_readelf_get_section_by_type
 (jit_readelf_t readelf, jit_int type, jit_nuint *size) 
  void *jit_readelf_get_symbol
 (jit_readelf_t readelf, char *name) 
  void *jit_readelf_map_vaddr
 (jit_readelf_t readelf, jit_nuint vaddr) 
  unsigned int jit_readelf_num_needed(jit_readelf_t readelf) 
  int jit_readelf_open
 (jit_readelf_t *readelf, char *filename, int flags) 
  int jit_readelf_register_symbol
 (jit_context_t context, char *name,
  void *value, int after) 
  int jit_readelf_resolve_all
 (jit_context_t context, int print_failures) 
  void *jit_realloc(void *ptr, unsigned int size) 
  int jit_snprintf
 (char *str, unsigned int len, char *format, ...) 
  int jit_sprintf(char *str, char *format, ...) 
  void jit_stack_trace_free(jit_stack_trace_t trace)
  jit_function_t jit_stack_trace_get_function(jit_context_t context,
         jit_stack_trace_t trace,
         unsigned int posn)
  unsigned int jit_stack_trace_get_offset(jit_context_t context,
     jit_stack_trace_t trace,
     unsigned int posn)
  void *jit_stack_trace_get_pc(jit_stack_trace_t trace, unsigned int posn)
  unsigned int jit_stack_trace_get_size(jit_stack_trace_t trace)
  char *jit_strcat(char *dest, char *src) 
  char *jit_strchr( char *str, int ch) 
  int jit_strcmp( char *str1, char *str2) 
  char *jit_strcpy(char *dest, char *src) 
  char *jit_strdup( char *str) 
  int jit_stricmp( char *str1, char *str2) 
  unsigned int jit_strlen( char *str) 
  int jit_strncmp
 ( char *str1, char *str2, unsigned int len) 
  char *jit_strncpy(char *dest, char *src, unsigned int len) 
  char *jit_strndup( char *str, unsigned int len) 
  int jit_strnicmp
 ( char *str1, char *str2, unsigned int len) 
  char *jit_strrchr( char *str, int ch) 
  int jit_supports_closures(void)
  int jit_supports_threads(void) 
  int jit_supports_virtual_memory(void) 
  jit_nuint jit_type_best_alignment(void) 
  jit_type_t jit_type_copy(jit_type_t type) 
  jit_type_t jit_type_create_pointer(jit_type_t type, int incref) 
  jit_type_t jit_type_create_signature
 (jit_abi_t abi, jit_type_t return_type, jit_type_t *params,
  unsigned int num_params, int incref) 
  jit_type_t jit_type_create_struct
 (jit_type_t *fields, unsigned int num_fields, int incref) 
  jit_type_t jit_type_create_tagged
 (jit_type_t type, int kind, void *data,
  jit_meta_free_func free_func, int incref) 
  jit_type_t jit_type_create_union
 (jit_type_t *fields, unsigned int num_fields, int incref) 
  unsigned int jit_type_find_name(jit_type_t type, char *name) 
  void jit_type_free(jit_type_t type) 
  jit_abi_t jit_type_get_abi(jit_type_t type) 
  jit_nuint jit_type_get_alignment(jit_type_t type) 
  jit_type_t jit_type_get_field
 (jit_type_t type, unsigned int field_index) 
  int jit_type_get_kind(jit_type_t type) 
  char *jit_type_get_name(jit_type_t type, unsigned int index) 
  jit_nuint jit_type_get_offset
 (jit_type_t type, unsigned int field_index) 
  jit_type_t jit_type_get_param
 (jit_type_t type, unsigned int param_index) 
  jit_type_t jit_type_get_ref(jit_type_t type) 
  jit_type_t jit_type_get_return(jit_type_t type) 
  jit_nuint jit_type_get_size(jit_type_t type) 
  void *jit_type_get_tagged_data(jit_type_t type) 
  int jit_type_get_tagged_kind(jit_type_t type) 
  jit_type_t jit_type_get_tagged_type(jit_type_t type) 
  int jit_type_has_tag(jit_type_t type, int kind) 
  int jit_type_is_pointer(jit_type_t type) 
  int jit_type_is_primitive(jit_type_t type) 
  int jit_type_is_signature(jit_type_t type) 
  int jit_type_is_struct(jit_type_t type) 
  int jit_type_is_tagged(jit_type_t type) 
  int jit_type_is_union(jit_type_t type) 
  jit_type_t jit_type_normalize(jit_type_t type) 
  unsigned int jit_type_num_fields(jit_type_t type) 
  unsigned int jit_type_num_params(jit_type_t type) 
  jit_type_t jit_type_promote_int(jit_type_t type) 
  jit_type_t jit_type_remove_tags(jit_type_t type) 
  int jit_type_return_via_pointer(jit_type_t type) 
  int jit_type_set_names
 (jit_type_t type, char **names, unsigned int num_names) 
  void jit_type_set_offset
 (jit_type_t type, unsigned int field_index, jit_nuint offset) 
  void jit_type_set_size_and_alignment
 (jit_type_t type, jit_nint size, jit_nint alignment) 
  void jit_type_set_tagged_data
 (jit_type_t type, void *data, jit_meta_free_func free_func) 
  void jit_type_set_tagged_type
 (jit_type_t type, jit_type_t underlying, int incref) 
  jit_uint jit_uint_add(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_add_ovf
 (jit_uint *result, jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_and(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_cmp(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_div
 (jit_uint *result, jit_uint value1, jit_uint value2) 
  jit_int jit_uint_eq(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_ge(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_gt(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_le(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_lt(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_max(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_min(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_mul(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_mul_ovf
 (jit_uint *result, jit_uint value1, jit_uint value2) 
  jit_int jit_uint_ne(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_neg(jit_uint value1) 
  jit_uint jit_uint_not(jit_uint value1) 
  jit_uint jit_uint_or(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_rem
 (jit_uint *result, jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_shl(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_shr(jit_uint value1, jit_uint value2) 
  jit_uint jit_uint_sub(jit_uint value1, jit_uint value2) 
  jit_int jit_uint_sub_ovf
 (jit_uint *result, jit_uint value1, jit_uint value2) 
  jit_float32 jit_uint_to_float32(jit_uint value) 
  jit_float64 jit_uint_to_float64(jit_uint value) 
  jit_int jit_uint_to_int(jit_uint value) 
  jit_int jit_uint_to_int_ovf(jit_int *result, jit_uint value) 
  jit_long jit_uint_to_long(jit_uint value) 
  jit_int jit_uint_to_long_ovf(jit_long *result, jit_uint value) 
  jit_nfloat jit_uint_to_nfloat(jit_uint value) 
  jit_uint jit_uint_to_uint(jit_uint value) 
  jit_int jit_uint_to_uint_ovf(jit_uint *result, jit_uint value) 
  jit_ulong jit_uint_to_ulong(jit_uint value) 
  jit_int jit_uint_to_ulong_ovf(jit_ulong *result, jit_uint value) 
  jit_uint jit_uint_xor(jit_uint value1, jit_uint value2) 
  jit_ulong jit_ulong_add(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_add_ovf
 (jit_ulong *result, jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_and(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_cmp(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_div
 (jit_ulong *result, jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_eq(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_ge(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_gt(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_le(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_lt(jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_max(jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_min(jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_mul(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_mul_ovf
 (jit_ulong *result, jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_ne(jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_neg(jit_ulong value1) 
  jit_ulong jit_ulong_not(jit_ulong value1) 
  jit_ulong jit_ulong_or(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_rem
 (jit_ulong *result, jit_ulong value1, jit_ulong value2) 
  jit_ulong jit_ulong_shl(jit_ulong value1, jit_uint value2) 
  jit_ulong jit_ulong_shr(jit_ulong value1, jit_uint value2) 
  jit_ulong jit_ulong_sub(jit_ulong value1, jit_ulong value2) 
  jit_int jit_ulong_sub_ovf
 (jit_ulong *result, jit_ulong value1, jit_ulong value2) 
  jit_float32 jit_ulong_to_float32(jit_ulong value) 
  jit_float64 jit_ulong_to_float64(jit_ulong value) 
  jit_int jit_ulong_to_int(jit_ulong value) 
  jit_int jit_ulong_to_int_ovf(jit_int *result, jit_ulong value) 
  jit_long jit_ulong_to_long(jit_ulong value) 
  jit_int jit_ulong_to_long_ovf(jit_long *result, jit_ulong value) 
  jit_nfloat jit_ulong_to_nfloat(jit_ulong value) 
  jit_uint jit_ulong_to_uint(jit_ulong value) 
  jit_int jit_ulong_to_uint_ovf(jit_uint *result, jit_ulong value) 
  jit_ulong jit_ulong_to_ulong(jit_ulong value) 
  jit_int jit_ulong_to_ulong_ovf(jit_ulong *result, jit_ulong value) 
  jit_ulong jit_ulong_xor(jit_ulong value1, jit_ulong value2) 
  void jit_unwind_free(jit_unwind_context_t *unwind)
  jit_function_t jit_unwind_get_function(jit_unwind_context_t *unwind)
  unsigned int jit_unwind_get_offset(jit_unwind_context_t *unwind)
  void *jit_unwind_get_pc(jit_unwind_context_t *unwind)
  int jit_unwind_init(jit_unwind_context_t *unwind, jit_context_t context)
  int jit_unwind_jump(jit_unwind_context_t *unwind, void *pc)
  int jit_unwind_next(jit_unwind_context_t *unwind)
  int jit_unwind_next_pc(jit_unwind_context_t *unwind)
  int jit_uses_interpreter(void) 
  jit_value_t jit_value_create(jit_function_t func, jit_type_t type) 
  jit_value_t jit_value_create_constant
 (jit_function_t func, jit_constant_t *const_value) 
  jit_value_t jit_value_create_float32_constant
 (jit_function_t func, jit_type_t type,
  jit_float32 const_value) 
  jit_value_t jit_value_create_float64_constant
 (jit_function_t func, jit_type_t type,
  jit_float64 const_value) 
  jit_value_t jit_value_create_long_constant
 (jit_function_t func, jit_type_t type, jit_long const_value) 
  jit_value_t jit_value_create_nfloat_constant
 (jit_function_t func, jit_type_t type,
  jit_nfloat const_value) 
  jit_value_t jit_value_create_nint_constant
 (jit_function_t func, jit_type_t type, jit_nint const_value) 
  jit_block_t jit_value_get_block(jit_value_t value) 
  jit_constant_t jit_value_get_constant(jit_value_t value) 
  jit_context_t jit_value_get_context(jit_value_t value) 
  jit_float32 jit_value_get_float32_constant(jit_value_t value) 
  jit_float64 jit_value_get_float64_constant(jit_value_t value) 
  jit_function_t jit_value_get_function(jit_value_t value) 
  jit_long jit_value_get_long_constant(jit_value_t value) 
  jit_nfloat jit_value_get_nfloat_constant(jit_value_t value) 
  jit_nint jit_value_get_nint_constant(jit_value_t value) 
  jit_value_t jit_value_get_param
 (jit_function_t func, unsigned int param) 
  jit_value_t jit_value_get_struct_pointer(jit_function_t func) 
  jit_type_t jit_value_get_type(jit_value_t value) 
  int jit_value_is_addressable(jit_value_t value) 
  int jit_value_is_constant(jit_value_t value) 
  int jit_value_is_local(jit_value_t value) 
  int jit_value_is_parameter(jit_value_t value) 
  int jit_value_is_temporary(jit_value_t value) 
  int jit_value_is_true(jit_value_t value) 
  int jit_value_is_volatile(jit_value_t value) 
  void jit_value_ref(jit_function_t func, jit_value_t value) 
  void jit_value_set_addressable(jit_value_t value) 
  void jit_value_set_volatile(jit_value_t value) 
  int jit_vmem_commit(void *addr, jit_uint size, jit_prot_t prot)
  int jit_vmem_decommit(void *addr, jit_uint size)
  void jit_vmem_init(void)
  jit_uint jit_vmem_page_size(void)
  int jit_vmem_protect(void *addr, jit_uint size, jit_prot_t prot)
  int jit_vmem_release(void *addr, jit_uint size)
  void *jit_vmem_reserve(jit_uint size)
  void *jit_vmem_reserve_committed(jit_uint size, jit_prot_t prot)
  jit_nuint jit_vmem_round_down(jit_nuint value)
  jit_nuint jit_vmem_round_up(jit_nuint value)
  int jit_writeelf_add_function
 (jit_writeelf_t writeelf, jit_function_t func,
   char *name) 
  int jit_writeelf_add_needed
 (jit_writeelf_t writeelf, char *library_name) 
  jit_writeelf_t jit_writeelf_create( char *library_name) 
  void jit_writeelf_destroy(jit_writeelf_t writeelf) 
  int jit_writeelf_write
 (jit_writeelf_t writeelf, char *filename) 
  int jit_writeelf_write_section
 (jit_writeelf_t writeelf, char *name, jit_int type,
   void *buf, unsigned int len, int discardable) 
  int jitom_class_add_ref
 (jit_objmodel_t model, jitom_class_t klass,
  jit_value_t obj_value) 
  int jitom_class_delete
 (jit_objmodel_t model, jitom_class_t klass,
  jit_value_t obj_value) 
  jitom_class_t *jitom_class_get_all_supers
 (jit_objmodel_t model, jitom_class_t klass, unsigned int *num) 
  jitom_field_t *jitom_class_get_fields
 (jit_objmodel_t model, jitom_class_t klass, unsigned int *num) 
  jitom_class_t *jitom_class_get_interfaces
 (jit_objmodel_t model, jitom_class_t klass, unsigned int *num) 
  jitom_method_t *jitom_class_get_methods
 (jit_objmodel_t model, jitom_class_t klass, unsigned int *num) 
  int jitom_class_get_modifiers
 (jit_objmodel_t model, jitom_class_t klass) 
  char *jitom_class_get_name
 (jit_objmodel_t model, jitom_class_t klass) 
  jitom_class_t jitom_class_get_primary_super
 (jit_objmodel_t model, jitom_class_t klass) 
  jit_type_t jitom_class_get_type
 (jit_objmodel_t model, jitom_class_t klass) 
  jit_type_t jitom_class_get_value_type
 (jit_objmodel_t model, jitom_class_t klass) 
  jit_value_t jitom_class_new
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_method_t ctor, jit_function_t func,
  jit_value_t *args, unsigned int num_args, int flags) 
  jit_value_t jitom_class_new_value
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_method_t ctor, jit_function_t func,
  jit_value_t *args, unsigned int num_args, int flags) 
  void jitom_destroy_model(jit_objmodel_t model) 
  int jitom_field_get_modifiers
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_field_t field) 
  char *jitom_field_get_name
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_field_t field) 
  jit_type_t jitom_field_get_type
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_field_t field) 
  jit_value_t jitom_field_load
 (jit_objmodel_t model, jitom_class_t klass, jitom_field_t field,
  jit_function_t func, jit_value_t obj_value) 
  jit_value_t jitom_field_load_address
 (jit_objmodel_t model, jitom_class_t klass, jitom_field_t field,
  jit_function_t func, jit_value_t obj_value) 
  int jitom_field_store
 (jit_objmodel_t model, jitom_class_t klass, jitom_field_t field,
  jit_function_t func, jit_value_t obj_value, jit_value_t value) 
  jitom_class_t jitom_get_class_by_name
 (jit_objmodel_t model, char *name) 
  int jitom_method_get_modifiers
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_method_t method) 
  char *jitom_method_get_name
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_method_t method) 
  jit_type_t jitom_method_get_type
 (jit_objmodel_t model, jitom_class_t klass,
  jitom_method_t method) 
  jit_value_t jitom_method_invoke
 (jit_objmodel_t model, jitom_class_t klass, jitom_method_t method,
  jit_function_t func, jit_value_t *args,
  unsigned int num_args, int flags) 
  jit_value_t jitom_method_invoke_virtual
 (jit_objmodel_t model, jitom_class_t klass, jitom_method_t method,
  jit_function_t func, jit_value_t *args,
  unsigned int num_args, int flags) 
  jitom_class_t jitom_type_get_class(jit_type_t type) 
  jit_objmodel_t jitom_type_get_model(jit_type_t type) 
  int jitom_type_is_class(jit_type_t type) 
  int jitom_type_is_value(jit_type_t type) 
  jit_type_t jitom_type_tag_as_class
 (jit_type_t type, jit_objmodel_t model,
  jitom_class_t klass, int incref) 
  jit_type_t jitom_type_tag_as_value
 (jit_type_t type, jit_objmodel_t model,
  jitom_class_t klass, int incref) 



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Vickenty Fesunov, E<lt>cpan+loljit@setattr.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Vickenty Fesunov.

The library is distributed under the terms of the GNU Lesser General
Public License.  See the LICENSE file for details.

=cut
