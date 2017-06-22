//
//  UMScriptDocument.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMScriptDocument.h"
#import "UMTerm.h"
#import "UMEnvironment.h"
#import "UMScriptCompilerEnvironment.h"
#import "UMFunction.h"
#include <stdio.h>
#include <unistd.h>

@implementation UMScriptDocument

@synthesize name;
@synthesize sourceCode;
@synthesize compiledCode;
@synthesize parserLog;
@synthesize lexerLog;

 
- (id)initWithFilename:(NSString *)filename
{
    self = [super init];
    if(self)
    {
        NSError *err = NULL;
        sourceCode = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
        if(err)
        {
            @throw([NSException exceptionWithName:@"UMScriptDocument init with file"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : @"init failed",
                                                    @"func": @(__func__),
                                                    @"obj":self,
                                                    }
                    ]);
        }
        isCompiled = NO;
    }
    return self;
}

- (id)initWithCode:(NSString *)code
{
    self = [super init];
    if(self)
    {
        sourceCode = code;
        isCompiled = NO;
    }
    return self;
}

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env
{
    if((isCompiled==NO) || (compiledCode==NULL))
    {
        [env trace:@"compilingSource"];
        NSString *e =[self compileSource];
        if(e.length > 0)
        {
            [env print:[NSString stringWithFormat:@"Error while compiling %@",e]];
        }
    }
    UMDiscreteValue *result = NULL;
    @try
    {
        UMFunction *mainFunction = [env functionByName:@"main"];
        result = [mainFunction evaluateWithParams:@[] environment:env];
    }
    @catch(NSException *nse)
    {
        [env print: [NSString stringWithFormat:@"Error: %@",nse]];
    }
    return result;
}

- (NSString *)sourceCode
{
    return sourceCode;
}

- (void)setSourceCode:(NSString *)s
{
    sourceCode = s;
    isCompiled = NO;
}

- (NSString *)compileSource
{
    UMScriptCompilerEnvironment *compilerEnvironment = [[UMScriptCompilerEnvironment alloc]init];

    NSString *out = @"";
    NSString *err = @"";
    NSLog(@"Compiling %@",name);
    self.compiledCode = [compilerEnvironment compile:sourceCode stdOut:&out stdErr:&err];
    if(self.compiledCode)
    {
        isCompiled = YES;
    }
    else
    {
        NSLog(@"compiling failed for '%@'\n\nSource:%@\n\nParserLog:\n%@\n\nLexerLog:\n%@\n",
              name,
              sourceCode,
              [compilerEnvironment.parserLog getLogForwardOrder],
              [compilerEnvironment.lexerLog getLogForwardOrder]);
        isCompiled = NO;
    }
    self.parserLog = [compilerEnvironment.parserLog getLogForwardOrder];
    self.lexerLog  = [compilerEnvironment.lexerLog getLogForwardOrder];
    return err;
}

@end
