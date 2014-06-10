//
//  UMFunction_switch.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_switch.h"

@implementation UMFunction_switch

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"switch";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *switchTerm = params[0];
    UMTerm *switchBlock = params[1];
    
    UMDiscreteValue *switchValue = [switchTerm evaluateWithEnvironment:env];
    env.jumpTo = switchValue.labelValue;
    [switchBlock evaluateWithEnvironment:env];
    env.breakCalled = NO;
    return [UMDiscreteValue discreteNull];
}

@end
