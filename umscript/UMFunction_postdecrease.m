//
//  UMFunction_postdecrease.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_postdecrease.h"

@implementation UMFunction_postdecrease

+ (NSString *)functionName
{
    return @"postdecrease";
}

- (NSString *)functionName
{
    return @"postdecrease";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
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
