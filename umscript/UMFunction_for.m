//
//  UMFunction_for.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_for.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_for

- (NSString *)functionName
{
    return @"for";
}

+ (NSString *)functionName
{
    return @"for";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"for";
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
    UMTerm *initTerm = params[0];
    UMTerm *conditionTerm = params[1];
    UMTerm *everyTerm = params[2];
    UMTerm *thenDoTerm = params[3];
    UMDiscreteValue *condition;
    
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

    /*  start=0: nothing has been done
     ** start=1: the init part has been done
     ** start=2: the condition check has been done
     ** start=3: the block has been done
     ** start=4: the increment has been done -> start1
    */
    if(start==0)
    {
        @try
        {
            [initTerm evaluateWithEnvironment:env  continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 0;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
        env.breakCalled=NO;
    }
    
    
    while(1)
    {
        /* check if the condition is still true */
        if(start <=1)
        {
            @try
            {
                condition = [conditionTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
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
        }
        if((env.breakCalled==YES) || (condition.boolValue==NO))
        {
            break;
        }

        /* execute the block */
        if(start <=2)
        {
            @try
            {
                [thenDoTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
            }
            @catch(UMTerm_Interrupt *interrupt)
            {
                UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
                e.name = [self functionName];
                e.temporaryResult = condition;
                e.position = 2;
                [interrupt recordEntry:e];
                @throw(interrupt);
            }
        }

        /* do the increment the block */
        if(start <=3)
        {
            @try
            {
                [everyTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
            }
            @catch(UMTerm_Interrupt *interrupt)
            {
                UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
                e.name = [self functionName];
                e.temporaryResult = condition;
                e.position = 2;
                [interrupt recordEntry:e];
                @throw(interrupt);
            }
        }
    }

    env.breakCalled=NO;
    return condition;
}


@end
