//
//  UMScriptDocument.h
//  umscript
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
    NSString *sourceCode;
    UMTerm *compiledCode;
    BOOL isCompiled;
}

@property (readwrite,strong)    NSString *sourceCode;
@property (readwrite, strong)   UMTerm   *compiledCode;

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env;
- (NSString *)compileSource;
- (id)initWithFilename:(NSString *)filename;
@end
