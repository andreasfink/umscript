//
//  UMFunction_bit_not.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_bit_not.h"

@implementation UMFunction_bit_not

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"BITNOT";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry = params[0];
    UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
    return [d bitNot];
 }

@end
