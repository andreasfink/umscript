//
//  UMFunction_while.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_while.h"

@implementation UMFunction_while

+ (NSString *)functionName
{
    return @"while";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_while"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"while";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *conditionTerm = params[0];
    UMTerm *thenDoTerm = params[1];
    
    UMDiscreteValue *condition = [conditionTerm evaluateWithEnvironment:env];
    env.breakCalled=NO;
    while(condition.boolValue)
    {
        [thenDoTerm evaluateWithEnvironment:env];
        if(env.breakCalled==YES)
        {
            break;
        }
        condition = [conditionTerm evaluateWithEnvironment:env];
    }
    env.breakCalled=NO;
    return condition;
}

@end
