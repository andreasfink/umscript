//
//  UMFunction_dowhile.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_dowhile.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_dowhile

+ (NSString *)functionName
{
    return @"dowhile";
}

- (NSString *)functionName
{
    return @"dowhile";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"dowhile";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
    }
    else
    {
        start = 0;
    }

    UMTerm *thenDoTerm = params[0];
    UMTerm *conditionTerm = params[1];

    UMDiscreteValue *condition;
    UMDiscreteValue *doValue;
    
    env.breakCalled=NO;
    do
    {
        if(start==0)
        {
            @try
            {
                doValue = [thenDoTerm evaluateWithEnvironment:env  continueFrom:interruptedAt];
            }
            @catch(UMTerm_Interrupt *interrupt)
            {
                UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
                e.name = [self functionName];
                e.position = 0;
                [interrupt recordEntry:e];
                @throw(interrupt);
            }
            if(env.breakCalled==YES)
            {
                break;
            }
        }
        @try
        {
            condition = [conditionTerm evaluateWithEnvironment:env  continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 1;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
        start = 0;
    } while(condition.boolValue);
    return condition;
}

@end
