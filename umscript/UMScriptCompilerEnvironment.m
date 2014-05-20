//
//  UMScriptCompierEnvironment.m
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMScriptCompilerEnvironment.h"
#import "UMTerm.h"
#include <string.h>


UMScriptCompilerEnvironment *global_UMScriptCompilerEnvironment = NULL;

extern int yyparse(void *);
extern FILE *yyin;

@implementation UMScriptCompilerEnvironment

@synthesize column;
@synthesize root;

- (id)init
{
    if(global_UMScriptCompilerEnvironment!=NULL)
    {
        return global_UMScriptCompilerEnvironment;
    }
    global_UMScriptCompilerEnvironment = [super init];
    return global_UMScriptCompilerEnvironment;
}

+ (UMScriptCompilerEnvironment *)sharedInstance
{
    if(global_UMScriptCompilerEnvironment)
    {
        return global_UMScriptCompilerEnvironment;
    }
    global_UMScriptCompilerEnvironment = [[UMScriptCompilerEnvironment alloc]init];
    return global_UMScriptCompilerEnvironment;
}

- (void)zapOutput
{
    stdErr = [[NSString alloc]init];
    stdOut = [[NSString alloc]init];
}

#define RXPIPE 0
#define	TXPIPE 1

- (UMTerm *)compile:(NSString *)code stdOut:(NSString **)sout  stdErr:(NSString **)serr
{
    @synchronized(self)
    {
        [self zapOutput];
        
        currentSource = code;
        currentSourceCString = currentSource.UTF8String;
        currentSourcePosition = 0;

        yyparse(NULL);
        
        UMTerm *resultingCode = root;
        root = NULL;
        printf("\r***STDOUT:\r");
        NSLog(@"**STDOUT: \r%@",stdOut);
        NSLog(@"**STDERR: \r%@",stdErr);
        return resultingCode;
    }
}


- (NSString *)compilerOutput
{
    if(stdOut)
    {
        return stdOut;
        
    }
    return @"no output";
}

- (void)addStdOut:(NSString *)s
{
    stdOut = [stdOut stringByAppendingString:s];
}

- (void)addStdErr:(NSString *)s
{
    stdErr = [stdErr stringByAppendingString:s];
    
}

- (NSString *)stdErr
{
    return stdErr;
}

- (NSString *)stdOut
{
    return stdOut;
}

- (size_t)readInputForLexer:(char *)buffer numBytesRead:(size_t *)numBytesRead maxBytesToRead:(size_t)maxBytesToRead
{
    
    size_t numBytesToRead = maxBytesToRead;
    size_t bytesRemaining = strlen(currentSourceCString)-currentSourcePosition;
    size_t i;
    
    if (numBytesToRead > bytesRemaining)
    {
        numBytesToRead = bytesRemaining;
    }
    for ( i = 0; i < numBytesToRead; i++ )
    {
        buffer[i] = currentSourceCString[currentSourcePosition+i];
    }
    *numBytesRead = numBytesToRead;
    currentSourcePosition += numBytesToRead;
    return 0;
}

@end



