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
    return [self initWithEnvironment:env magic:@"UMFunction_break"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];
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
