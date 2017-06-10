//
//  UMFunction_math_add.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_add.h"

@implementation UMFunction_add

+ (NSString *)functionName
{
    return @"add";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_add"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];
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
