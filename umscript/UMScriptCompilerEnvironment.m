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
#include "umscript_globals.h"

extern int yyparse(void *);
extern FILE *yyin;

extern int yylex_init(void *scanner);
extern int yylex_destroy(void *scanner);


typedef struct BisonBridge
{
    void *scanner;
} BisonBridge;


@implementation UMScriptCompilerEnvironment

@synthesize currentSource;


-(id)init
{
    self = [super init];
    if(self)
    {        
        currentSource = @"DUMMY";
        currentSourceCString = currentSource.UTF8String;
        currentSourcePosition = 0;
        NSLog(@"init called");
    }
    return self;
}


@synthesize column;
@synthesize root;

+ (UMScriptCompilerEnvironment *)sharedInstance
{
    @synchronized(self)
    {
        if(hasBeenCreated==0)
        {
            global_UMScriptCompilerEnvironment = [[UMScriptCompilerEnvironment alloc]init];
            hasBeenCreated = YES;
            NSLog(@"INITIALIZING hasBeenCreated=%d, &hasBeenCreated=%p",hasBeenCreated,&hasBeenCreated);
        }
        return global_UMScriptCompilerEnvironment;
    }
}

- (void)zapOutput
{
    stdErr = [[NSString alloc]init];
    stdOut = [[NSString alloc]init];
}

#define RXPIPE 0
#define	TXPIPE 1

- (void)stdinFeeder:(NSData *)input
{
    const unsigned char  *bytes = [input bytes];
    size_t size = [input length];
    size_t write_size = size;
    size_t current_pos = 0;
    
    while(write_size > 0)
    {
        size_t written_size = write(stdin_pipe[TXPIPE], &bytes[current_pos], write_size);
        if(written_size>0)
        {
            write_size = size - written_size;
            current_pos = current_pos + written_size;
        }
        else
        {
            if(errno != EAGAIN)
            {
                NSLog(@"Writing to compiler failed with error %d",errno);
                return;
            }
        }
    }
}

- (UMTerm *)compile:(NSString *)code stdOut:(NSString **)sout  stdErr:(NSString **)serr
{
    @synchronized(self)
    {
        [self zapOutput];
        
        const char *c = code.UTF8String;
        NSData *data = [NSData dataWithBytes:c length:strlen(c)];
        self.currentSource = code;
        
        if (pipe(stdin_pipe) < 0)
        {
            switch(errno)
            {
                case EMFILE:
                    NSLog(@"Too many file descriptors are in use by the process ([GWThread initInThread])");
                    break;
                case ENFILE:
                    NSLog(@"The system file table is full. ([GWThread initInThread])");
                    break;
                default:
                    NSLog(@"cannot allocate wakeup pipe for new thread");
                    break;
            }
            return NULL;
        }
        [NSThread detachNewThreadSelector:@selector(stdinFeeder:) toTarget:self withObject:data];
        
        NSLog(@"\r***Compiling:\r%@\r***\r",currentSource);

        BisonBridge  bisonGlobals;

        yylex_init (&bisonGlobals.scanner);
        
 
        yyparse (&bisonGlobals);
        yylex_destroy (&bisonGlobals.scanner);
        
        yyparse((__bridge void *)(self));
        
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

size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead)
{
    
    UMScriptCompilerEnvironment *g=[UMScriptCompilerEnvironment sharedInstance];
    return [g readInputForLexer:buffer numBytesRead:numBytesRead maxBytesToRead:maxBytesToRead];
}


