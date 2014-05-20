//
//  UMFunction_dowhile.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_dowhile.h"

@implementation UMFunction_dowhile

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"DOWHILE";
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
    do
    {
        [thenDoTerm evaluateWithEnvironment:env];
        condition = [conditionTerm evaluateWithEnvironment:env];
    } while(condition.boolValue);
    return condition;
}

@end
