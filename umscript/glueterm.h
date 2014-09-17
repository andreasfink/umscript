//
//  glueterm.h
//  umscript
//
//  Created by Andreas Fink on 22.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef LINUX
#ifndef LINUX_GLUE
#define LINUX_GLUE  1

typedef void *CFTypeRef;
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


#endif /* LINUX_GLUE */
#endif /* LINUX */


typedef struct glueterm
{
    int         token;
    CFTypeRef   value;
} glueterm;
