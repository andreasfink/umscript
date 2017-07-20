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
#import "UMTerm_Interrupt.h"

@implementation UMScriptDocument

- (id)initWithFilename:(NSString *)filename
{
    self = [super init];
    if(self)
    {
        NSError *err = NULL;
        _name = filename;
        _sourceCode = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
        if(err)
        {
            @throw([NSException exceptionWithName:@"UMScriptDocument init with file"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : @"init failed",
                                                    @"func": @(__func__),
                                                    @"obj":self,
                                                    @"err" : err
                                                    }
                    ]);
        }
        _isCompiled = NO;
    }
    return self;
}

- (id)initWithCode:(NSString *)code
{
    self = [super init];
    if(self)
    {
        _name = @"Untitled";
        _sourceCode = code;
        _isCompiled = NO;
    }
    return self;
}

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env
{
    return [self runScriptWithEnvironment:env continueFrom:NULL];
}

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedFrom
{
    if((_isCompiled==NO) || (_compiledCode==NULL))
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
        env.functionDictionary = _compiledFunctions;
        result = [_compiledCode evaluateWithEnvironment:env continueFrom:interruptedFrom];

    }
    @catch(NSException *nse)
    {
        [env print: [NSString stringWithFormat:@"Error: %@",nse]];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        interrupt.currentScript = self;
        @throw(interrupt);
    }
    return result;
}

- (NSString *)_sourceCode
{
    return _sourceCode;
}

- (void)set_sourceCode:(NSString *)s
{
    _sourceCode = s;
    _isCompiled = NO;
}

- (NSString *)compileSource
{
    UMScriptCompilerEnvironment *compilerEnvironment = [[UMScriptCompilerEnvironment alloc]init];

    NSString *out = @"";
    NSString *err = @"";
    //NSLog(@"Compiling %@",_name);
    _compiledCode = [compilerEnvironment compile:_sourceCode stdOut:&out stdErr:&err];
    if(_compiledCode)
    {
        _isCompiled = YES;
        _compiledFunctions = compilerEnvironment.functionDictionary;
    }
    else
    {
        NSLog(@"compiling failed for '%@'\n\nSource:%@\n\nParserLog:\n%@\n\nLexerLog:\n%@\n",
              _name,
              _sourceCode,
              [compilerEnvironment.parserLog getLogForwardOrder],
              [compilerEnvironment.lexerLog getLogForwardOrder]);
        _isCompiled = NO;
    }
    _parserLog = [compilerEnvironment.parserLog getLogForwardOrder];
    _lexerLog  = [compilerEnvironment.lexerLog getLogForwardOrder];
    return err;
}

@end
