//
//  uscript.yl.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

/* functions which are used by the lexer and the parser jointly */

#include "uscript.yl.h"


#import "UMScriptCompilerEnvironment.h"

int redirected_fprintf(FILE *f,char *format,...)
{
    char buffer[1024];
    memset(buffer,0x00,sizeof(buffer));
    va_list args;
    
    
    va_start(args, format);
    vsnprintf(buffer,sizeof(buffer)-1, format,args);
    va_end(args);
    
    NSString *errStr = [NSString stringWithUTF8String:buffer];
    
    [global_UMScriptCompilerEnvironment addStdOut:errStr];
    fprintf(f,"<*%s*>\n",buffer);
    return (int)strlen(buffer);
}

size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead)
{
    UMScriptCompilerEnvironment *g = [UMScriptCompilerEnvironment sharedInstance];
    return [g readInputForLexer:buffer numBytesRead:numBytesRead maxBytesToRead:maxBytesToRead];
}



extern int colum;

void yyerror(char *s)
{
    fflush(stdout);
    char buffer [1024];
    UMScriptCompilerEnvironment *g = global_UMScriptCompilerEnvironment;
    snprintf(buffer,sizeof(buffer),"\n%*s\n%*s\n", [g column], "^", [g column], s);
    NSString *err = [NSString stringWithUTF8String:buffer];
    [global_UMScriptCompilerEnvironment addStdErr:err];
}

