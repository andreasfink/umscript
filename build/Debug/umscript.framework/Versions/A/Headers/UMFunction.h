//
//  UMRuleCondition.h
//  umruleengine
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
}
@property(readwrite,strong) NSString *comment;
@property(readwrite,strong) NSString *name;

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env;
- (NSString *)description;
- (id)descriptionDictVal;

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env;
- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env;

@end
