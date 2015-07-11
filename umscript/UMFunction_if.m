//
//  UMFunction_if.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_if.h"

@implementation UMFunction_if

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_if"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"if";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)p environment:(id)env
{
    if(p.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *condition = p[0];
    UMTerm *ifBlock = p[1];
    UMTerm *elseBlock = nil;
    if(p.count == 3)
    {
        elseBlock = p[2];
    }
    UMDiscreteValue *result = [condition evaluateWithEnvironment:env];
    if(result.boolValue)
    {
        result = [ifBlock evaluateWithEnvironment:env];
    }
    else
    {
        result = [elseBlock evaluateWithEnvironment:env];

    }
    return result;
}

@end
