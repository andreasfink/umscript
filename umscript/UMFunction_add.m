//
//  UMFunction_math_add.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_add.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_add

+ (NSString *)functionName
{
    return @"__add";
}

- (NSString *)functionName
{
    return [UMFunction_add functionName];
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
        @try
        {
            UMTerm *entry = params[i];
            if(result == NULL)
            {
                result = [entry evaluateWithEnvironment:env continueFrom:interruptedAt];
            }
            else
            {
                result = [result addValue:[entry evaluateWithEnvironment:env continueFrom:interruptedAt]];
            }
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
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end
