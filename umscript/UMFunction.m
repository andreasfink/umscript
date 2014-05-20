//
//  UMFunction
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMFunction.h"
#import "UMEnvironment.h"
#import "UMTerm.h"
#import "NSNumber+UMScript.h"

@implementation UMFunction

@synthesize comment;
@synthesize name;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"Undefined";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    return [UMDiscreteValue discreteNull];
}

- (NSString *)debugDescription
{
    return self.name;
}

- (NSString *)description
{
    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
    NSString *s = [writer stringWithObject:[self descriptionDictVal]];
    return s;
}

- (id)descriptionDictVal
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(name)
    {
        dict[@"function"] = name;
    }
    return dict;
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@(",name];
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@",pstring];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@",%@",pstring];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@",%@",pstring];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end

