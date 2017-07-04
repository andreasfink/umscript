//
//  UMFunction_CGlue.h
//  umscript
//
//  Created by Andreas Fink on 03.07.17.
//
//

/* this is some glue code provided that C functions can deal with ObjectiveC objects used by umscript */
#include <CoreFoundation/CoreFoundation.h>

/* for C, these are just some opaque pointers */
typedef void *CFEnvironmentRef;
typedef void *CFDiscreteValueRef;
typedef void *CFTermRef;

/* a discrete value can have one of these types */
typedef enum CFDiscreteValueType
{
    DVALUE_NULL = 0,
    DVALUE_BOOL = 1,
    DVALUE_INT = 2,
    DVALUE_LONGLONG = 3,
    DVALUE_DOUBLE = 4,
    DVALUE_STRING = 5,
    DVALUE_DATA = 6,
} CFDiscreteValueType;

/* allocationg DiscreteValue object and initialize it with a value */
CFDiscreteValueRef discrete_value_with_null(void);
CFDiscreteValueRef discrete_value_with_bool(int b);
CFDiscreteValueRef discrete_value_with_int(int a);
CFDiscreteValueRef discrete_value_with_longlong(long long a);
CFDiscreteValueRef discrete_value_with_cstring(const char *s);

/* figuring out which type it is */
CFDiscreteValueType discrete_get_type(CFDiscreteValueRef d);

/* get a specific type. Note: it does automatically typeconvert for you */
int discrete_value_get_integer(CFDiscreteValueRef d);
BOOL discrete_value_get_bool(CFDiscreteValueRef d);
long long discrete_value_get_longlong(CFDiscreteValueRef d);
void discrete_value_get_string(CFDiscreteValueRef d, char *s, size_t maxlen);

/* release a discrete value object from memory */
void discrete_value_release(CFDiscreteValueRef discreteVal);

CFTermRef term_get(CFArrayRef params,int pos);
void term_release(CFTermRef t);
CFDiscreteValueRef term_evaluate_with_environment(CFTermRef xterm, CFEnvironmentRef xenv);
