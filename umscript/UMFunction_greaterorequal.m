//
//  UMFunction_greaterorequal.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_greaterorequal.h"

@implementation UMFunction_greaterorequal

+ (NSString *)functionName
{
    return @"greaterorequal";
}

- (NSString *)functionName
{
    return @"greaterorequal";
}


- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"greaterorequal";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count != 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *param0 = params[0];
    UMDiscreteValue *value0 = [param0 evaluateWithEnvironment:env];
    
    UMTerm *param1 = params[1];
    UMDiscreteValue *value1 = [param1 evaluateWithEnvironment:env];
    
    UMDiscreteValue *r = [value0 discreteIsGreaterThanOrEqualTo:value1];
    return r;
}

@end
