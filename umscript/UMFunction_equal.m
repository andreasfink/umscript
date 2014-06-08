//
//  UMFunction_equal.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_equal.h"

@implementation UMFunction_equal

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"equal";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }

    UMDiscreteValue *lastValue = nil;

    for(UMTerm *entry in params)
    {
        UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
        if(lastValue == nil)
        {
            lastValue = d;
        }
        else
        {
            if([d isNotEqualTo:lastValue])
            {
                return [UMDiscreteValue discreteBool:NO];
            }
        }
    }
    return [UMDiscreteValue discreteBool:YES];
}

@end
