//
//  UMFunction_math_add.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_add.h"

@implementation UMFunction_add

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"add";
        [env log:self.name];
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
            result = [result addValue:[entry evaluateWithEnvironment:env]];
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
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end
