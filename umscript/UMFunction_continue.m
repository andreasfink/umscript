//
//  UMFunction_continue.m
//  umscript
//
//  Created by Andreas Fink on 24.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_continue.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_continue

- (NSString *)functionName
{
    return @"continue";
}

+ (NSString *)functionName
{
    return @"continue";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"continue";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params
                            environment:(UMEnvironment *)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    return NULL;
}

@end
