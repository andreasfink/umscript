//
//  UMFunction_math_dot.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_math_dot.h"

@implementation UMFunction_math_dot


- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"MATHDOT";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    UMDiscreteValue *result = NULL;
    for(UMTerm *entry in params)
    {
        if(result == NULL)
        {
            result = [entry evaluateWithEnvironment:env];
        }
        else
        {
            result = [result dotValue:[entry evaluateWithEnvironment:env]];
        }
    }
    return result;
}
- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"("];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@".%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@".%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}


@end
