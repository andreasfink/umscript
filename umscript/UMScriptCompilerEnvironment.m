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
    stdErr = @"";
    stdOut = @"";
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

        int result = yyparse(NULL);
        
        UMTerm *resultingCode = root;
        root = NULL;
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
    NSLog(@"OUT: %@",s);
    stdOut = [stdOut stringByAppendingString:s];
}

- (void)addStdErr:(NSString *)s
{
    NSLog(@"ERR: %@",s);
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

- (int)readInputForLexer:(char *)buffer numBytesRead:(int *)numBytesRead maxBytesToRead:(int)maxBytesToRead
{
    
    int numBytesToRead = maxBytesToRead;
    int bytesRemaining = strlen(currentSourceCString)-currentSourcePosition;
    int i;
    
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


int readInputForLexer(char *buffer, int *numBytesRead, int maxBytesToRead)
{
    UMScriptCompilerEnvironment *g = [UMScriptCompilerEnvironment sharedInstance];
    return [g readInputForLexer:buffer numBytesRead:numBytesRead maxBytesToRead:maxBytesToRead];
}

