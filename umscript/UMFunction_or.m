//
//  UMFunction_or.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_or.h"

@implementation UMFunction_or

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"LOGICOR";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
   UMDiscreteValue *result = nil;
    for(UMTerm *entry in params)
    {
        UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
        if(result == nil)
        {
            result = d;
        }
        else
        {
            result = [result logicOr:d];
        }
    }
    return result;
}
@end