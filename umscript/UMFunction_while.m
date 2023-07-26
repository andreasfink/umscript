//
//  UMFunction_while.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_while.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_while

+ (NSString *)functionName
{
    return @"while";
}

- (NSString *)functionName
{
    return [UMFunction_while functionName];
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"while";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMTerm *conditionTerm = params[0];
    UMTerm *thenDoTerm = params[1];
    UMDiscreteValue *condition;

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        condition = entry.temporaryResult;
    }
    else
    {
        start = 0;
    }

    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    env._breakCalled=NO;
    if(start==0)
    {
        @try
        {
           condition = [conditionTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
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
    
    while(condition.boolValue)
    {
        @try
        {
            [thenDoTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 1;
            e.temporaryResult = condition;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }

        if(env._breakCalled==YES)
        {
            break;
        }

        @try
        {
            condition = [conditionTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
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
    env._breakCalled=NO;
    return condition;
}

@end
