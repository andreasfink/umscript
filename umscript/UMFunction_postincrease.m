//
//  UMFunction_postincrease.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_postincrease.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_postincrease

+ (NSString *)functionName
{
    return @"__postincrease";
}

- (NSString *)functionName
{
    return [UMFunction_postincrease functionName];
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        [env log:self.functionName];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
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
        newValue = [currentValue increase];
        [env setVariable:newValue forKey:currentTerm.varname];
    }
    else if(currentValue.type == UMTermType_field)
    {
        currentValue = [env fieldForKey:currentTerm.fieldname];
        newValue = [currentValue increase];
        [env setField:newValue forKey:currentTerm.fieldname];
    }
    else if(currentValue.type == UMTermType_discrete)
    {
        currentValue = currentTerm.discrete;
        [currentValue increase];
        /* we cant write back to a const */
    }
    return currentValue;
}
@end
