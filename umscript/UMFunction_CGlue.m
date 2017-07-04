//
//  UMFunction_CGlue.m
//  umscript
//
//  Created by Andreas Fink on 03.07.17.
//
//

#import "UMFunction_CGlue.h"
#import "UMDiscreteValue.h"
#import "UMTerm.h"
#import "UMEnvironment.h"
#include <string.h>

CFDiscreteValueRef discrete_value_null(void)
{
    return (__bridge_retained CFDiscreteValueRef)[UMDiscreteValue discreteNull];
}

CFDiscreteValueRef discrete_value_bool(int b)
{
    return (__bridge_retained CFDiscreteValueRef)[UMDiscreteValue discreteBool:b];
}

CFDiscreteValueRef discrete_value_int(int i)
{
    return (__bridge_retained CFDiscreteValueRef)[UMDiscreteValue discreteInt:i];
}


CFDiscreteValueRef discrete_value_longlong(long long ll)
{
    return (__bridge_retained CFDiscreteValueRef)[UMDiscreteValue discreteLongLong:ll];
}

CFDiscreteValueRef discrete_value_cstring(const char *s)
{
    return (__bridge_retained CFDiscreteValueRef)[UMDiscreteValue discreteString:@(s)];
}

void discrete_value_release(CFDiscreteValueRef discreteVal)
{
    UMDiscreteValue *d = (__bridge_transfer UMDiscreteValue *)discreteVal;
#pragma unused(d)
}

CFDiscreteValueRef term_evaluate_with_environment(CFTermRef xterm, CFEnvironmentRef xenv)
{
    UMTerm *term = (__bridge UMTerm *)xterm;
    UMEnvironment *env = (__bridge UMEnvironment *)xenv;
    UMDiscreteValue *d = [term evaluateWithEnvironment:env];
    return (__bridge_retained CFDiscreteValueRef)d;
}

CFTermRef term_get(CFArrayRef params,int pos)
{
    NSArray *a = (__bridge NSArray *)params;
    if((pos <0) || (pos >= a.count))
    {
        return NULL;
    }
    UMTerm *t = a[pos];
    return (__bridge_retained CFTermRef)t;
}

void term_release(CFTermRef t)
{
    UMTerm *t2 = (__bridge_transfer UMTerm *)t;
#pragma unused(t2)
}


CFDiscreteValueType discrete_value_type(CFDiscreteValueRef d)
{
    UMDiscreteValue *dv = (__bridge UMDiscreteValue *)d;
    switch(dv.type)
    {
        case UMVALUE_BOOL:
            return DVALUE_BOOL;
        case UMVALUE_INT:
            return DVALUE_INT;
        case UMVALUE_LONGLONG:
            return DVALUE_LONGLONG;
        case UMVALUE_DOUBLE:
            return DVALUE_DOUBLE;
        case UMVALUE_STRING:
            return DVALUE_STRING;
        case UMVALUE_DATA:
            return DVALUE_DATA;
        default:
            return DVALUE_NULL;
    }
}


int discrete_get_integer(CFDiscreteValueRef d)
{
    UMDiscreteValue *dv = (__bridge UMDiscreteValue *)d;
    return dv.intValue;
}

BOOL discrete_get_bool(CFDiscreteValueRef d)
{
    UMDiscreteValue *dv = (__bridge UMDiscreteValue *)d;
    return dv.boolValue;
}

long long discrete_get_longlong(CFDiscreteValueRef d)
{
    UMDiscreteValue *dv = (__bridge UMDiscreteValue *)d;
    return dv.longLongValue;
}

void discrete_get_string(CFDiscreteValueRef d, char *s, size_t maxlen)
{
    UMDiscreteValue *dv = (__bridge UMDiscreteValue *)d;
    const char *cstr = dv.stringValue.UTF8String;
    if(cstr)
    {
        strncpy(s,cstr,maxlen);
    }

}

