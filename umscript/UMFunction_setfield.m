//
//  UMFunction_setfield.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_setfield.h"

@implementation UMFunction_setfield

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"SETFIELD";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if([params count] != 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *leftTerm  = params[0];
    UMTerm *rightTerm = params[1];
    UMDiscreteValue *leftValue  = [leftTerm evaluateWithEnvironment:env];
    UMDiscreteValue *rightValue = [rightTerm evaluateWithEnvironment:env];
    NSString *variableName = [leftValue stringValue];

    [env setVariable:rightValue forKey:variableName];
    return rightValue;
}

@end
