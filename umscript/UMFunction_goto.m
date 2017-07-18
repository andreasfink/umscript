//
//  UMFunction_goto.m
//  umscript
//
//  Created by Andreas Fink on 23.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_goto.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_goto

+ (NSString *)functionName
{
    return @"goto";
}

- (NSString *)functionName
{
    return @"goto";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"goto";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    
    UMTerm *label = params[0];
    env.jumpTo = label.labelValue;
    return NULL;
}

@end
