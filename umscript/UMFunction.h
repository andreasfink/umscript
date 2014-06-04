//
//  UMFunction.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMEnvironment.h"
#import "UMTerm.h"
#import "UMDiscreteValue.h"
#import "UMEnvironment.h"

@interface UMFunction : UMObject
{
    NSString                *name;
    NSString                *comment;
    UMEnvironment           *cenv;
}

#define LOG_TO_ENVBUILDUP(env,message)
#define LOG_TO_ENVTRACE(env,message)
@property(readwrite,strong) NSString *comment;
@property(readwrite,strong) NSString *name;
@property(readwrite,weak) UMEnvironment *cenv;

- (id)initWithEnvironment:(UMEnvironment *)cenv;

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env;
- (NSString *)description;
- (id)descriptionDictVal;

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env;

- (NSString *)debugDescription;

@end
