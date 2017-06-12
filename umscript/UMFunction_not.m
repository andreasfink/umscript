//
//  UMFunction_logic_not.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_not.h"

@implementation UMFunction_not

+ (NSString *)functionName
{
    return @"not";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_not"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name=@"not";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count < 1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry = params[0];
    UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
    return [d notValue];
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"!"];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"/* unused %@*/",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"/* unused %@*/",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end
