//
//  UMFunction_xor.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_xor.h"

@implementation UMFunction_xor

+ (NSString *)functionName
{
    return @"xor";
}

- (NSString *)functionName
{
    return @"xor";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"xor";
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
            result = [result logicXor:d];
        }
    }
    return result;
}

@end
