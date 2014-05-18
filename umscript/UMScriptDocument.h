//
//  UMScript.h
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@class UMTerm;
@class UMEnvironment;
@class UMDiscreteValue;

@interface UMScriptDocument : UMObject
{
    NSString *scriptName;
    NSString *sourceCode;
    UMTerm   *execCode;
    BOOL isCompiled;
}

@property (readwrite,strong)    NSString *sourceCode;
@property (readonly, strong)    UMTerm   *execCode;

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env;
- (NSString *)compileSource;
- (NSString *)sourceWithoutComment;

@end
