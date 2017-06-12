//
//  UMFunction_bit_shiftright.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_bit_shiftright.h"

@implementation UMFunction_bit_shiftright

+ (NSString *)functionName
{
    return @"bit_shiftright";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"bit_shiftright";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry1 = params[0];
    UMTerm *entry2 = params[2];
    UMDiscreteValue *d1 = [entry1 evaluateWithEnvironment:env];
    UMDiscreteValue *d2 = [entry2 evaluateWithEnvironment:env];
    return [d1 bitShiftRight:d2];
}

@end
