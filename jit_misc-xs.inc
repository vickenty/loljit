MODULE = LOLJIT  PACKAGE = LOLJIT  PREFIX = loljit_misc_

jit_label_t
loljit_misc_jit_label_undefined()
CODE:
	RETVAL = jit_label_undefined;
OUTPUT:
	RETVAL

MODULE = LOLJIT  PACKAGE = LOLJIT

SV*
loljit_function_apply(func, ret, ...)
	jit_function_t	func
PREINIT:
	jit_type_t signature;
	jit_type_t ret_type;
	jit_type_t ptype;
	unsigned int idx, num_params, data_size, ret_size;
	void **params;
	char *data, *pdata;
CODE:
	signature = jit_function_get_signature(func);
	num_params = jit_type_num_params(signature);

	ret_type = jit_type_get_return(signature);
	ret_size = jit_type_get_size(ret_type);

	for (idx = 0; idx < num_params; idx++) {
		ptype = jit_type_get_param(signature, idx);
		if (ptype == jit_type_int || ptype == jit_type_uint || ptype == jit_type_nint || ptype == jit_type_nuint) {
			data_size += jit_type_get_size(ptype);
		} else {
			Perl_croak(aTHX_ "loljit_function_apply: unsupported parameter type %p", ptype);
		}
	}

	params = malloc(sizeof(void*) * num_params);
	data = malloc(data_size + jit_type_get_size(ret_type));
	pdata = data + ret_size;

	for (idx = 0; idx < num_params; idx++) {
		ptype = jit_type_get_param(signature, idx);
		if (ptype == jit_type_int || ptype == jit_type_nint) {
			*((int *) pdata) = SvIV(ST(idx + 1));
			params[idx] = pdata;
			pdata += sizeof(int);
		}
		else if (ptype == jit_type_uint || ptype == jit_type_nuint) {
			*((unsigned int *) pdata) = SvUV(ST(idx + 1));
			params[idx] = pdata;
			pdata += sizeof(unsigned int);
		} else {
			Perl_croak(aTHX_ "loljit_function_apply: unsupported parameter type %p", ptype);
		}
	}

	jit_function_apply(func, (void*) params, (void*) data);

	if (ret_type == jit_type_int || ret_type == jit_type_nint) {
		RETVAL = newSViv(*(int *) data);
	} else if (ret_type == jit_type_uint || ret_type == jit_type_nuint) {
		RETVAL = newSVuv(*(unsigned int *) data);
	} else {
		Perl_croak(aTHX_ "loljit_function_apply: unsupported return type %p", ptype);
	}
OUTPUT:
	RETVAL
CLEANUP:
	free(params);
	free(data);
