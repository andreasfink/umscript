//
//  UMFunction_typecast_int.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_typecast_int.h"

@implementation UMFunction_typecast_int

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if([params count] != 1)
    {
        return [UMDiscreteValue discreteNull];

    }
    UMTerm *p = params[0];
    UMDiscreteValue *v = [p evaluateWithEnvironment:env];
    return [UMDiscreteValue discreteInt:[v intValue]];
}
    

@end
