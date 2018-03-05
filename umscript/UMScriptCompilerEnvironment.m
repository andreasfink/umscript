//
//  UMScriptCompierEnvironment.m
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#include <unistd.h>
#import "UMScriptCompilerEnvironment.h"
#import "UMTerm.h"
#import <string.h>

#import "_generated_umscript.y.h"
#import "flex_definitions.h"
#import "bison_definitions.h"


@implementation UMScriptCompilerEnvironment

@synthesize currentSource;
@synthesize parserLog;
@synthesize lexerLog;
@synthesize column;

- (id)init
{
    self = [super init];
    if(self)
    {        
        currentSource = @"DUMMY";
        currentSourceCString = currentSource.UTF8String;
        currentSourcePosition = 0;
        parserLog = [[UMHistoryLog alloc]initWithMaxLines:10240];
        lexerLog  = [[UMHistoryLog alloc]initWithMaxLines:10240];
        _compileLock = [[UMMutex alloc]initWithName:@"umscript-compile-lock"];
    }
    return self;
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
    ulib_set_thread_name([NSString stringWithFormat:@"[UMScriptCompilerEnvironment stdinFeeder] %@",currentSource]);
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
    if(stdin_pipe[TXPIPE]>=0)
    {
        close(stdin_pipe[TXPIPE]);
    }
    stdin_pipe[TXPIPE] = -1;
}

- (void)stdoutListener
{
    
    ulib_set_thread_name([NSString stringWithFormat:@"[UMScriptCompilerEnvironment stdoutListener] %@",currentSource]);

    NSMutableData *outputData = [[NSMutableData alloc]init];
    outputDataComplete = NO;
    char buf[1025];
    
    memset(buf,0x00,sizeof(buf));
    
    ssize_t read_bytes = 0;
    do
    {
        read_bytes = read(stdout_pipe[RXPIPE],buf,sizeof(buf)-1);
        if(read_bytes > 0)
        {
            @synchronized(outputData)
            {
                [outputData appendBytes:buf length:read_bytes];
            }
            memset(buf,0x00,sizeof(buf));
        }
        if((read_bytes < 0) && (errno=EAGAIN))
        {
            read_bytes = 99;
        }
    }
    while (read_bytes > 0);

    NSString *out = [[NSString alloc]initWithBytes:[outputData bytes] length:[outputData length] encoding:NSUTF8StringEncoding];
    [self addStdOut:out];
    outputDataComplete=YES;
    if(stdout_pipe[RXPIPE]>=0)
    {
        close(stdout_pipe[RXPIPE]);
    }
    stdout_pipe[RXPIPE] = -1;
}

- (UMTerm *)compile:(NSString *)code
             stdOut:(NSString **)sout
             stdErr:(NSString **)serr
{
    [_compileLock lock];
    @try
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
                    NSLog(@"Too many file descriptors are in use by the process");
                    break;
                case ENFILE:
                    NSLog(@"The system file table is full.");
                    break;
                default:
                    NSLog(@"cannot allocate wakeup pipe for new thread");
                    break;
            }
            return NULL;
        }
        if (pipe(stdout_pipe) < 0)
        {
            switch(errno)
            {
                case EMFILE:
                    NSLog(@"Too many file descriptors are in use by the process");
                    break;
                case ENFILE:
                    NSLog(@"The system file table is full.");
                    break;
                default:
                    NSLog(@"cannot allocate wakeup pipe for new thread");
                    break;
            }
            return NULL;
        }
        /* we have now 2 threads ready to stuff data into the compiler and to read its output */
        [NSThread detachNewThreadSelector:@selector(stdinFeeder:) toTarget:self withObject:data];
        [NSThread detachNewThreadSelector:@selector(stdoutListener) toTarget:self withObject:nil];
    
        yycompile(self, stdin_pipe[RXPIPE], stdout_pipe[TXPIPE]);
        /* close the pipes from the yycompile side. this should terminate the helper threads if they are not already gone */
        if(stdout_pipe[TXPIPE] >=0)
        {
            close(stdout_pipe[TXPIPE]);
        }
        stdout_pipe[TXPIPE] = -1;
        if(close(stdin_pipe[RXPIPE])>=0)
        {
            close(stdin_pipe[RXPIPE]);
        }
        stdin_pipe[RXPIPE] = -1;
        while(outputDataComplete==NO)
        {
            sleep(1);
        }
        if(stdout_pipe[TXPIPE] >=0)
        {
            close(stdout_pipe[RXPIPE]);
        }
        UMTerm *resultingCode = _root;
        _root = NULL;
        if(stdOut.length > 0)
        {
            NSLog(@"**STDOUT: \r%@",stdOut);
        }
        if(stdErr.length> 0)
        {
            NSLog(@"**STDERR: \r%@",stdErr);
        }
        *serr = stdErr;
        *sout = stdOut;
        return resultingCode;
    }
    @finally
    {
        [_compileLock unlock];
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

- (size_t)readInputForLexer:(char *)buffer
               numBytesRead:(size_t *)numBytesRead
             maxBytesToRead:(size_t)maxBytesToRead
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

- (void)addFunctionDefinition:(UMTerm *)fdef
{
    UMFunction *f = fdef.function;
    _functionDictionary[f.name] = f;
    if([f.name isEqualToString:@"main"])
    {
        _root = f.statements;
    }
}

@end

