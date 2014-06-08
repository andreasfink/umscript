//
//  UMScriptCompierEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMEnvironment.h"

extern size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead);

@class UMScriptCompilerEnvironment;
@class UMTerm;

extern int yycompile(UMScriptCompilerEnvironment *cenv, int fdes_input, int fdes_output);

@interface UMScriptCompilerEnvironment : UMEnvironment
{
    NSString *stdErr;
    NSString *stdOut;
    NSString *currentSource;
    BOOL outputDataComplete;
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
    CFTypeRef root;
    int column;
    
    int stdin_pipe[2];
    int stdout_pipe[2];
    UMHistoryLog *parserLog;
    UMHistoryLog *lexerLog;
}

@property (readwrite,assign) int column;
@property (readwrite,assign)    CFTypeRef root;
@property (readwrite,strong)    NSString *currentSource;
@property (readwrite,strong)    UMHistoryLog *parserLog;
@property (readwrite,strong)    UMHistoryLog *lexerLog;


- (UMTerm *)compile:(NSString *)code stdOut:(NSString **)sout  stdErr:(NSString **)serr;

- (void)zapOutput;
- (void)addStdOut:(NSString *)s;
- (void)addStdErr:(NSString *)s;
- (NSString *)stdErr;
- (NSString *)stdOut;

@end

