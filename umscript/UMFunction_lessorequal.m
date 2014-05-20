//
//  UMFunction_lessorequal.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_lessorequal.h"

@implementation UMFunction_lessorequal

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"LESSOREQUAL";
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
