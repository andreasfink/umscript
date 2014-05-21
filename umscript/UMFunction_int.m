//
//  UMFunction_int.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_int.h"

@implementation UMFunction_int

- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"(int)";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_INT)
    {
        return d;
    }
    return [UMDiscreteValue discreteLongLong:d.intValue];
}

@end
