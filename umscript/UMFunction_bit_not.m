//
//  UMFunction_bit_not.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_bit_not.h"

@implementation UMFunction_bit_not

+ (NSString *)functionName
{
    return @"bit_not";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_bit_not"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];
    if(self)
    {
        self.name = @"bit_not";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry = params[0];
    UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
    return [d bitNot];
 }

@end
