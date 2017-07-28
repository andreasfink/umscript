//
//  UMFunction_if.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_if.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_if

+ (NSString *)functionName
{
    return @"if";
}

- (NSString *)functionName
{
    return [UMFunction_if functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)p environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(p.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *condition = p[0];
    UMTerm *ifBlock = p[1];
    UMTerm *elseBlock = nil;
    UMDiscreteValue *conditionValue;
    UMDiscreteValue *result;
    if(p.count == 3)
    {
        elseBlock = p[2];
    }

    
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        conditionValue = entry.temporaryResult;
    }
    else
    {
        start = 0;
    }

    if(start==0)
    {
        @try
        {
            conditionValue = [condition evaluateWithEnvironment:env continueFrom:interruptedAt];
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

    
    if(conditionValue.boolValue)
    {
        @try
        {
            result = [ifBlock evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 1;
            e.temporaryResult = conditionValue;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    else
    {
        @try
        {
            result = [elseBlock evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 1;
            e.temporaryResult = conditionValue;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }

    }
    return result;
}

@end
