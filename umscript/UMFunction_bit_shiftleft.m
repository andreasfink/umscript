//
//  UMFunction_bit_shiftleft.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_bit_shiftleft.h"

@implementation UMFunction_bit_shiftleft

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"BITSHIFTLEFT";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry1 = params[0];
    UMTerm *entry2 = params[2];
    UMDiscreteValue *d1 = [entry1 evaluateWithEnvironment:env];
    UMDiscreteValue *d2 = [entry2 evaluateWithEnvironment:env];
    return [d1 bitShiftLeft:d2];
}

@end
