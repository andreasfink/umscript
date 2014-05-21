//
//  UMFunction_double.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_double.h"

@implementation UMFunction_double


- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"(double)";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_DOUBLE)
    {
        return d;
    }
    return [UMDiscreteValue discreteDouble:d.doubleValue];
}

@end
