//
//  UMFunction_break.m
//  umscript
//
//  Created by Andreas Fink on 24.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_break.h"

@implementation UMFunction_break

+ (NSString *)functionName
{
    return @"bit_break";
}


- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"break";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    env.breakCalled = YES;
    return [UMDiscreteValue discreteNull];
}

@end
