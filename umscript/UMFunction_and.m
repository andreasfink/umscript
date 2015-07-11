//
//  UMFunction_and.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_and.h"

@implementation UMFunction_and

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_and"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];
    if(self)
    {
        self.name=@"and";
        [env log:self.name];
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
            result = [result logicAnd:d];
        }
    }
    return result;
}
@end
