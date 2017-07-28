//
//  UMFunction_hash.m
//  umscript
//
//  Created by Andreas Fink on 28.07.17.
//
//

#import "UMFunction_hash.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_hash


+ (NSString *)functionName
{
    return @"hash";
}

- (NSString *)functionName
{
    return [UMFunction_hash functionName];
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
                            environment:(id)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMTerm *param0 = params[0] ? params[0] : NULL;
    UMTerm *param1 = params[1] ? params[1] : NULL;

    UMDiscreteValue *hashData;
    UMDiscreteValue *hashOptions;
    
    if((params.count < 1) || (params.count > 2))
    {
        return [UMDiscreteValue discreteNull];
    }
    
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        if(start>0)
        {
            hashData = entry.temporaryResult;
        }
        if(start>1)
        {
            hashOptions = entry.temporaryResult2;
        }
    }
    else
    {
        start = 0;
    }
    
    if(start==0)
    {
        @try
        {
            hashData = [param0 evaluateWithEnvironment:env  continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 0;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    if(start <= 1)
    {
        @try
        {
            if(param1)
            {
                hashOptions = [param1 evaluateWithEnvironment:env  continueFrom:interruptedAt];
            }
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = hashData;
            e.position = 1;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    
    UMDiscreteValue *r = [hashData hashWithOptions:hashOptions];
    return r;
}

@end
