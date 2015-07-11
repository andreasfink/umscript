//
//  UMFunction_postdecrease.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_postdecrease.h"

@implementation UMFunction_postdecrease

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_postdecrease"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"postdecrease";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }

    UMTerm *currentTerm = params[0];
    UMDiscreteValue *currentValue;
    UMDiscreteValue *newValue;


    if(currentTerm.type == UMTermType_variable)
    {
        currentValue = [env variableForKey:currentTerm.varname];
        newValue = [currentValue decrease];
        [env setVariable:newValue forKey:currentTerm.varname];
    }
    else if(currentValue.type == UMTermType_field)
    {
        currentValue = [env fieldForKey:currentTerm.fieldname];
        newValue = [currentValue decrease];
        [env setField:newValue forKey:currentTerm.fieldname];
    }
    else if(currentValue.type == UMTermType_discrete)
    {
        currentValue = currentTerm.discrete;
        [currentValue decrease];
        /* we cant write back to a const */
    }
    return currentValue;
}
@end
