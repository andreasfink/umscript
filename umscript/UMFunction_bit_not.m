//
//  UMFunction_bit_not.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_bit_not.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_bit_not


+ (NSString *)functionName
{
    return @"__bit_not";
}

- (NSString *)functionName
{
    return [UMFunction_bit_not functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(interruptedAt)
    {
        [interruptedAt pullEntry];
    }
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry = params[0];
    
    UMDiscreteValue *d;
    @try
    {
        d = [entry evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.temporaryResult = NULL;
        e.position = 0;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    return [d bitNot];
 }

@end
