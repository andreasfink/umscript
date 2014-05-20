//
//  UMFunction_block.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_block.h"
#import "UMEnvironment.h"

@implementation UMFunction_block

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"BLOCK";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMDiscreteValue *previousReturnValue = env.returnValue;
    env.returnValue = nil;
    for(UMTerm *term in params)
    {
        [term evaluateWithEnvironment:env];
    }
    UMDiscreteValue *returnValue = env.returnValue;
    env.returnValue = previousReturnValue;
    return returnValue;
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"%@{\r%@    ",[env identPrefix],[env identPrefix]];
    [env identAdd];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,[env identPrefix]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,[env identPrefix]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r",pstring];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    [env identRemove];
    return [NSString stringWithFormat:@"%@}\r",[env identPrefix]];
}

@end
