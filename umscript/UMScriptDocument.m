//
//  UMScriptDocument.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMScriptDocument.h"
#import "UMTerm.h"
#import "UMEnvironment.h"
#import "UMScriptCompilerEnvironment.h"
#include <stdio.h>
#include <unistd.h>

@implementation UMScriptDocument

@synthesize sourceCode;
@synthesize compiledCode;

- (id)initWithFilename:(NSString *)filename
{
    self = [super init];
    if(self)
    {
        NSError *err = NULL;
        sourceCode = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&err];
        if(err)
        {
            @throw err;
        }
    }
    return self;
}

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env
{
    if(isCompiled==NO)
    {
        [self compileSource];
    }
    UMDiscreteValue *result = [compiledCode evaluateWithEnvironment:env];
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

    UMScriptCompilerEnvironment *compilerEnvironment = [UMScriptCompilerEnvironment sharedInstance];

    NSString *out = @"";
    NSString *err = @"";
    
    self.compiledCode = [compilerEnvironment compile:sourceCode stdOut:&out stdErr:&err];

    return err;
}


@end
