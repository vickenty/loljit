struct lolxsub_stack_state {
  SV **sp;
  SV **mark;
  int ax;
  int items;
};

typedef struct lolxsub_stack_state *lolxsub_stack_state_t;

void lolxsub_stack_state_init(pTHX_ lolxsub_stack_state_t stack)
{
  dXSARGS;
  stack->sp = sp;
  stack->mark = mark;
  stack->ax = ax;
  stack->items = items;
}

#define sp (stack->sp)
#define mark (stack->mark)
#define ax (stack->ax)
#define items (stack->items)

SV* lolxsub_stack_fetch(pTHX_ lolxsub_stack_state_t stack, unsigned int item)
{
  return ST(item);
}

void lolxsub_stack_store(pTHX_ lolxsub_stack_state_t stack, unsigned int item, SV* value)
{
  ST(item) = value;
}

void lolxsub_stack_prepare_return(pTHX_ lolxsub_stack_state_t stack)
{
  XSprePUSH;
}

#define XWRAP(op, suffix, type)                                         \
  void lolxsub_stack_xpush_##suffix(pTHX_                               \
                                    lolxsub_stack_state_t stack,        \
                                    type value)                         \
  {                                                                     \
    op(value);                                                          \
  }

XWRAP(mXPUSHs, sv, SV*);
XWRAP(mXPUSHi, nint, IV);
XWRAP(mXPUSHu, nuint, UV);
XWRAP(mXPUSHn, double, NV);

void lolxsub_stack_putback(pTHX_ lolxsub_stack_state_t stack)
{
  PUTBACK;
}

IV lolxsub_sv_iv(pTHX_ SV *sv)
{
  if (!SvIOKp(sv))
    croak("argument is not an integer");
  return SvIV(sv);
}

UV lolxsub_sv_uv(pTHX_ SV *sv)
{
  if (!SvIOK(sv))
    croak("argument is not an integer");
  return SvUV(sv);
}

void lolxsub_call_sv(pTHX_ SV* sv, I32 flags) {
  if (flags == -1) {
    flags = GIMME_V;
  }

  call_sv(sv, flags);
}

#undef sp
#undef mark
#undef ax
#undef items
#undef XWRAP
