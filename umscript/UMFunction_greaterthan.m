//
//  UMFunction_greaterthan.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_greaterthan.h"

@implementation UMFunction_greaterthan

+ (NSString *)functionName
{
    return @"greaterthan";
}

- (NSString *)functionName
{
    return @"greaterthan";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"greaterthan";
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
    
    UMDiscreteValue *r = [value0 discreteIsGreaterThan:value1];
    return r;
}

@end
