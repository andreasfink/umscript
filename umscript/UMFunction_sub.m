//
//  UMFunction_math_substract.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_sub.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_sub

+ (NSString *)functionName
{
    return @"__sub";
}

- (NSString *)functionName
{
    return [UMFunction_sub functionName];
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
                result = [result subtractValue:[entry evaluateWithEnvironment:env  continueFrom:interruptedAt]];
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
- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"("];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"-%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"-%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end
