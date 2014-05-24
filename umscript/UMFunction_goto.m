//
//  UMFunction_goto.m
//  umscript
//
//  Created by Andreas Fink on 23.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_goto.h"

@implementation UMFunction_goto


- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"GOTO";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    return NULL;
}

@end
