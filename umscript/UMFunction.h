//
//  UMFunction.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#import <ulibasn1/ulibasn1.h>
#import "UMEnvironment.h"
#import "UMTerm.h"
#import "UMDiscreteValue.h"
#import "UMEnvironment.h"

@interface UMFunction : UMObject
{
    NSString                *_name;
    NSString                *_comment;
    UMEnvironment           *_cenv;
    UMTerm                  *_statements;
}

#define LOG_TO_ENVBUILDUP(env,message)
#define LOG_TO_ENVTRACE(env,message)
@property(readwrite,strong) NSString *comment;
@property(readwrite,strong) NSString *name;
@property(readwrite,strong) UMEnvironment *cenv;
@property(readwrite,strong) UMTerm  *statements;

+ (NSString *)functionName;
- (NSString *)functionName;

- (id)initWithEnvironment:(UMEnvironment *)cenv;
- (UMFunction *)initWithName:(NSString *)name statements:(UMTerm *)statements;

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt;
- (NSString *)description;
- (id)descriptionDictVal;

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env;

- (NSString *)debugDescription;

@end
