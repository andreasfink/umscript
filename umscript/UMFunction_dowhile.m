//
//  UMFunction_dowhile.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_dowhile.h"

@implementation UMFunction_dowhile

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_dowhile"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"dowhile";
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
    UMTerm *thenDoTerm = params[0];
    UMTerm *conditionTerm = params[1];
    
    UMDiscreteValue *condition;
    env.breakCalled=NO;
    do
    {
        [thenDoTerm evaluateWithEnvironment:env];
        if(    env.breakCalled==YES)
        {
            break;
        }
        condition = [conditionTerm evaluateWithEnvironment:env];
    } while(condition.boolValue);
    env.breakCalled=NO;
    return condition;
}

@end
