//
//  UMFunction_notequal.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_notequal.h"

@implementation UMFunction_notequal

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"NOTEQUAL";
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
            if([d isEqualTo:lastValue])
            {
                return [UMDiscreteValue discreteBool:NO];
            }
        }
    }
    return [UMDiscreteValue discreteBool:YES];
}



@end
