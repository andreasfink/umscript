//
//  UMFunction_for.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_for.h"

@implementation UMFunction_for


- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"FOR";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *initTerm = params[0];
    UMTerm *conditionTerm = params[1];
    UMTerm *everyTerm = params[2];
    UMTerm *thenDoTerm = params[3];
    
    [initTerm evaluateWithEnvironment:env];

    UMDiscreteValue *condition = [conditionTerm evaluateWithEnvironment:env];
    while (condition.boolValue==YES)
    {
        [thenDoTerm evaluateWithEnvironment:env];
        condition = [conditionTerm evaluateWithEnvironment:env];
        [everyTerm evaluateWithEnvironment:env];
    };
    return condition;
}


@end
