//
//  UMScriptDocument.h
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>

@class UMTerm;
@class UMEnvironment;
@class UMDiscreteValue;
@class UMTerm_Interrupt;
@interface UMScriptDocument : UMObject
{
    NSString *_name;
    NSString *_sourceCode;
    UMTerm *_compiledCode;
    BOOL _isCompiled;
    NSString *_parserLog;
    NSString *_lexerLog;
    UMSynchronizedSortedDictionary *_compiledFunctions;
}

@property (readwrite,strong)    NSString    *name;
@property (readwrite,strong)    NSString    *sourceCode;
@property (readwrite, strong)   UMTerm      *compiledCode;
@property (readwrite,strong)    NSString    *parserLog;
@property (readwrite,strong)    NSString    *lexerLog;
@property (readonly, assign,atomic) BOOL    isCompiled;

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env;
- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedFrom;
- (NSString *)compileSource;
- (id)initWithFilename:(NSString *)filename;
- (id)initWithCode:(NSString *)code;


@end
