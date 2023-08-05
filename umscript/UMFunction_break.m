//
//  UMFunction_break.m
//  umscript
//
//  Created by Andreas Fink on 24.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_break.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_break

+ (NSString *)functionName
{
    return @"break";
}

- (NSString *)functionName
{
    return [UMFunction_break functionName];
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        [env log:self.functionName];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params
                            environment:(UMEnvironment *)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    env.breakCalled = YES;
    return [UMDiscreteValue discreteNull];
}

@end

