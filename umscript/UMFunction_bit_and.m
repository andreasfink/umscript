//
//  UMFunction_bit_and.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_bit_and.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_bit_and

+ (NSString *)functionName
{
    return @"__bit_and";
}

- (NSString *)functionName
{
    return [UMFunction_bit_and functionName];
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
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *entry1 = params[0];
    UMTerm *entry2 = params[1];
    
    UMDiscreteValue *d1;
    UMDiscreteValue *d2;

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        if(start == 1)
        {
            d1 = entry.temporaryResult;
        }
    }
    else
    {
        d1 = NULL;
        start = 0;
    }

    if(start == 0)
    {
        @try
        {
            d1 = [entry1 evaluateWithEnvironment:env continueFrom:interruptedAt];
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
    }

    @try
    {
        d2 = [entry2 evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 1;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    return [d1 bitAnd:d2];
}

@end
