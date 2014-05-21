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
    bb->cenv = CFBridgingRetain(cenv);
}

UMScriptCompilerEnvironment *bisonbridge_getcenv(bisonbridge *bb)
{
    return (__bridge CFTypeRef)(bb->cenv);
}

void bisonbridge_free(bisonbridge *bb)
{
    if(bb->cenv != NULL)
    {
        CFBridgingRelease(bb->cenv);
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

