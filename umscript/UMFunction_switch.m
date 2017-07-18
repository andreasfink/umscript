//
//  UMFunction_switch.m
//  umscript
//
//  Created by Andreas Fink on 20.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_switch.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_switch

+ (NSString *)functionName
{
    return @"switch";
}

- (NSString *)functionName
{
    return @"switch";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"switch";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMDiscreteValue *switchValue;
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        switchValue = entry.temporaryResult;
    }
    else
    {
        start = 0;
    }

    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *switchTerm = params[0];
    UMTerm *switchBlock = params[1];
    if(start==0)
    {
        @try
        {
            switchValue = [switchTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
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

    env.jumpTo = switchValue.stringValue;
    @try
    {
        [switchBlock evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 1;
        e.temporaryResult = switchValue;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    env.breakCalled = NO;
    return [UMDiscreteValue discreteNull];
}

@end
