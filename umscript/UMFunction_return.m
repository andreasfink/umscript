//
//  UMFunction_return.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_return.h"
#import "UMEnvironment.h"
@implementation UMFunction_return

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"return";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMDiscreteValue *returnValue =[params[0] evaluateWithEnvironment:env];
    env.returnValue =  returnValue;
    return returnValue;
}
@end
