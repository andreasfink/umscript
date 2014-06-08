//
//  UMFunction_lessorequal.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_lessorequal.h"

@implementation UMFunction_lessorequal

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"lessorequal";
        [env log:self.name];
    }
    return self;
}


- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    UMDiscreteValue *lastValue = nil;
    int i = 0;
    
    for(UMTerm *entry in params)
    {
        UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
        
        if(i++ ==0)
        {
            lastValue = d;
        }
        else
        {
            if(![d isLessThanOrEqualTo:lastValue])
            {
                return [UMDiscreteValue discreteBool:NO];
            }
        }
    }
    return [UMDiscreteValue discreteBool:YES];
}

@end
