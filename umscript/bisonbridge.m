//
//  bisonbridge.m
//  umscript
//
//  Created by Andreas Fink on 21.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#include "bisonbridge.h"
#include <stdlib.h>
#include "UMScriptCompilerEnvironment.h"
#include "umscript.yl.h"

#include "_generated_umscript.y.h"


#ifndef CFTypeRef
typedef void *CFTypeRef;
#endif

#define CF_RETURNS_RETAINED __attribute__((cf_returns_retained))

#if !defined(NS_INLINE)
#if defined(__GNUC__)
#define NS_INLINE static __inline__ __attribute__((always_inline))
#elif defined(__MWERKS__) || defined(__cplusplus)
#define NS_INLINE static inline
#elif defined(_MSC_VER)
#define NS_INLINE static __inline
#elif TARGET_OS_WIN32
#define NS_INLINE static __inline__
#endif
#endif

#ifndef CF_CONSUMED
#if __has_feature(attribute_cf_consumed)
#define CF_CONSUMED __attribute__((cf_consumed))
#else
#define CF_CONSUMED
#endif
#endif

NS_INLINE CF_RETURNS_RETAINED CFTypeRef CFBridgingRetain(id X) {
    return (__bridge_retained CFTypeRef)X;
}

NS_INLINE id CFBridgingRelease(CFTypeRef CF_CONSUMED X)
{
    return (__bridge_transfer id)X;
}





@class UMScriptCompilerEnvironment;


bisonbridge *bisonbridge_alloc(void)
{
    bisonbridge *bb;
    bb = malloc(sizeof(bisonbridge));
    if(bb)
    {
        memset(bb,0x00,sizeof(bisonbridge));
    }
    return bb;
}

void bisonbridge_setcenv(bisonbridge *bb, UMScriptCompilerEnvironment *cenv)
{
    bb->cenv = cenv; //(__bridge retained void *) (cenv);
}

UMScriptCompilerEnvironment *bisonbridge_getcenv(bisonbridge *bb)
{
    return bb->cenv;
}

void bisonbridge_free(bisonbridge *bb)
{
    if(bb->cenv != NULL)
    {
        bb->cenv=NULL;
    }
    memset(bb,0x00,sizeof(bisonbridge));
}

void bisonbridge_set_input_data(bisonbridge *bb, const char *ptr, size_t len)
{
    if(bb->input_data)
    {
        free(bb->input_data);
    }
    unsigned char *input_data = malloc(len);
    if(input_data)
    {
        memset(input_data,0x00,len);
        bb->input_data = input_data;
        bb->input_size = len;
        bb->input_position = 0;
    }
}

