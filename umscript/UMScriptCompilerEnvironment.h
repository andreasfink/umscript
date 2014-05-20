//
//  UMScriptCompierEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMEnvironment.h"

@class UMScriptCompilerEnvironment;
@class UMTerm;
extern UMScriptCompilerEnvironment *global_UMScriptCompilerEnvironment;

@interface UMScriptCompilerEnvironment : UMEnvironment
{
    NSString *stdErr;
    NSString *stdOut;
    NSString *currentSource;
    const char *currentSourceCString;
    size_t  currentSourcePosition;
    
    int linenum;
    NSString *input_name;
    int num_errors;
    int num_warnings;
    int num_extern_functions;
    int num_local_functions;
    int errors;
    int last_syntax_error_line;
    UMTerm *root;
}


+ (UMScriptCompilerEnvironment *)sharedInstance;

- (UMTerm *)compile:(NSString *)code stdOut:(NSString **)sout  stdErr:(NSString **)serr;

- (void)zapOutput;
- (void)addStdOut:(NSString *)s;
- (void)addStdErr:(NSString *)s;
- (NSString *)stdErr;
- (NSString *)stdOut;

- (int)readInputForLexer:(char *)buffer numBytesRead:(int *)numBytesRead maxBytesToRead:(int)maxBytesToRead;

@end

extern int readInputForLexer(char *buffer, int *numBytesRead, int maxBytesToRead);