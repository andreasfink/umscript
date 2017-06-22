//
//  UMFunction_and.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_and.h"

@implementation UMFunction_and

+ (NSString *)functionName
{
    return @"and";
}

- (NSString *)functionName
{
    return @"and";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
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
