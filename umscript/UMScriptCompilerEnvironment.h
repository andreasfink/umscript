//
//  UMScriptCompierEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMEnvironment.h"
#import "umscript.yl.h"

extern size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead);

@class UMScriptCompilerEnvironment;
@class UMTerm;

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
    int column;
    
    int stdin_pipe[2];
}

@property (readwrite,assign) int column;
@property (readwrite,strong)    UMTerm *root;
@property (readwrite,strong)    NSString *currentSource;

+ (UMScriptCompilerEnvironment *)sharedInstance;

- (UMTerm *)compile:(NSString *)code stdOut:(NSString **)sout  stdErr:(NSString **)serr;

- (void)zapOutput;
- (void)addStdOut:(NSString *)s;
- (void)addStdErr:(NSString *)s;
- (NSString *)stdErr;
- (NSString *)stdOut;

- (size_t)readInputForLexer:(char *)buffer numBytesRead:(size_t *)numBytesRead maxBytesToRead:(size_t)maxBytesToRead;

@end

extern UMScriptCompilerEnvironment *global_UMScriptCompilerEnvironment;

