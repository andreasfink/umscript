//
//  UMFunction_and.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_and.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_and

+ (NSString *)functionName
{
    return @"__and";
}

- (NSString *)functionName
{
    return [UMFunction_and functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(params.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMDiscreteValue *result = NULL;
    NSInteger start;
    NSInteger end = params.count;
    
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        result = entry.temporaryResult;
        start = entry.position;
    }
    else
    {
        result = NULL;
        start = 0;
    }
    
    for(NSInteger i=start;i<end;i++)
    {
        UMDiscreteValue *d;
        UMTerm *entry = params[i];
        @try
        {
            d = [entry evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.temporaryResult = result;
            e.position = i;
            e.name = [self functionName];
            [interrupt recordEntry:e];
            @throw(interrupt);
        }

        if(result == nil)
        {
            result = d;
        }
        else
        {
            result = [result logicAnd:d];
        }
    }
    return result;
}
@end
