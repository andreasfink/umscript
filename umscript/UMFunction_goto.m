//
//  UMFunction_goto.m
//  umscript
//
//  Created by Andreas Fink on 23.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_goto.h"

@implementation UMFunction_goto


- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"goto";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *label = params[0];
    env.jumpTo = label.labelValue;
    return NULL;
}

@end
