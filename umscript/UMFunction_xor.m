//
//  UMFunction_xor.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_xor.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_xor

+ (NSString *)functionName
{
    return @"__xor";
}

- (NSString *)functionName
{
    return [UMFunction_xor functionName];
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
    NSInteger start;
    UMDiscreteValue *result = NULL;
    
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        result = entry.temporaryResult;
    }
    else
    {
        start = 0;
        result = NULL;
    }
    
    NSInteger n = params.count;
    for(NSInteger i=start;i<n;i++)
    {
        UMTerm *entry = params[i];
        @try
        {
            if(result == NULL)
            {
                result = [entry evaluateWithEnvironment:env  continueFrom:interruptedAt];
            }
            else
            {
                result = [result logicXor:[entry evaluateWithEnvironment:env  continueFrom:interruptedAt]];
            }
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = i;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    return result;
}

@end
