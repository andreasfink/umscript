//
//  UMScriptCompierEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMEnvironment.h"

#ifdef LINUX
#ifndef LINUX_GLUE
#define LINUX_GLUE  1

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


#endif /* LINUX_GLUE */
#endif /* LINUX */


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
    UMTerm *root;
    int column;
    
    int stdin_pipe[2];
    int stdout_pipe[2];
    UMHistoryLog *parserLog;
    UMHistoryLog *lexerLog;
}

@property (readwrite,assign) int column;
@property (readwrite,strong)	UMTerm *root;
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

