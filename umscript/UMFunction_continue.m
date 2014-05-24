//
//  UMFunction_continue.m
//  umscript
//
//  Created by Andreas Fink on 24.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_continue.h"

@implementation UMFunction_continue


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
