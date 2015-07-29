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
XWRAP(mXPUSHi, nint, int);
XWRAP(mXPUSHu, nuint, unsigned int);
XWRAP(mXPUSHu, double, double);

void lolxsub_stack_putback(pTHX_ lolxsub_stack_state_t stack)
{
  PUTBACK;
}

int lolxsub_sv_iv(pTHX_ SV *sv)
{
  return SvIV(sv);
}

int lolxsub_sv_uv(pTHX_ SV *sv)
{
  return SvUV(sv);
}

#undef sp
#undef mark
#undef ax
#undef items
#undef XWRAP
