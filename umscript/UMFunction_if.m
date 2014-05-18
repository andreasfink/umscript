//
//  UMFunction_if.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_if.h"

@implementation UMFunction_if

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"IF";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *condition = params[0];
    UMTerm *ifBlock = params[1];
    UMTerm *elseBlock = nil;
    if(params.count == 3)
    {
        elseBlock = params[2];
    }
    UMDiscreteValue *result = [condition evaluateWithEnvironment:env];
    if(result.boolValue)
    {
        [ifBlock evaluateWithEnvironment:env];
    }
    else
    {
        [elseBlock evaluateWithEnvironment:env];

    }
    return result;
}

@end
