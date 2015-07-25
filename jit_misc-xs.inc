MODULE = LOLJIT  PACKAGE = LOLJIT  PREFIX = loljit_misc_

jit_label_t
loljit_misc_jit_label_undefined()
CODE:
	RETVAL = jit_label_undefined;
OUTPUT:
	RETVAL
