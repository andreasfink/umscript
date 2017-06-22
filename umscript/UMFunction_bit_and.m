//
//  UMFunction_bit_and.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_bit_and.h"

@implementation UMFunction_bit_and

+ (NSString *)functionName
{
    return @"bit_and";
}

- (NSString *)functionName
{
    return @"bit_and";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"bit_and";
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
    UMTerm *entry2 = params[1];
    UMDiscreteValue *d1 = [entry1 evaluateWithEnvironment:env];
    UMDiscreteValue *d2 = [entry2 evaluateWithEnvironment:env];
    return [d1 bitAnd:d2];
}

@end
