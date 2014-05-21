//
//  bisonbridge.h
//  umscript
//
//  Created by Andreas Fink on 21.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UMScriptCompilerEnvironment;

typedef struct bisonbridge
{
    struct yyguts_t *lexer_globals;
    unsigned char *input_data;
    size_t input_position;
    size_t input_size;
    UMScriptCompilerEnvironment *cenv;
} bisonbridge;

bisonbridge *bisonbridge_allocate(void);
void bisonbridge_free(bisonbridge *ptr);

bisonbridge *bisonbridge_alloc(void);
void bisonbridge_setcenv(bisonbridge *bb, UMScriptCompilerEnvironment *cenv);
UMScriptCompilerEnvironment *bisonbridge_getcenv(bisonbridge *bb);

void bisonbridge_set_input_data(bisonbridge *bb, const char *ptr, size_t len);
void bisonbridge_free(bisonbridge *bb);

bisonbridge_set_input_file_descriptor(bisonbridge *bb,int fd);
