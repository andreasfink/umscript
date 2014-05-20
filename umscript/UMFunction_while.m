//
//  UMFunction_while.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_while.h"

@implementation UMFunction_while

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"WHILE";
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
    while(condition.boolValue)
    {
        [thenDoTerm evaluateWithEnvironment:env];
        condition = [conditionTerm evaluateWithEnvironment:env];
    }
    return condition;
}

@end
