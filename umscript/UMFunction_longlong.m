//
//  UMFunction_longlong.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_longlong.h"

@implementation UMFunction_longlong

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_longlong"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"longlong";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_LONGLONG)
    {
        return d;
    }
    return [UMDiscreteValue discreteLongLong:d.longLongValue];
}

@end
