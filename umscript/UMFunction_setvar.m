//
//  UMFunction_setvar.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_setvar.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_setvar

+ (NSString *)functionName
{
    return @"setvar";
}

- (NSString *)functionName
{
    return @"setvar";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"setvar";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if([params count] != 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *leftTerm  = params[0];
    UMTerm *rightTerm = params[1];
    UMDiscreteValue *leftValue;
    UMDiscreteValue *rightValue;
    
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        leftValue = entry.temporaryResult;
    }
    else
    {
        start = 0;
    }
    
    if(start==0)
    {
        @try
        {
            leftValue = [leftTerm evaluateWithEnvironment:env  continueFrom:interruptedAt];
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
    
    @try
    {
        rightValue = [rightTerm evaluateWithEnvironment:env  continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 1;
        e.temporaryResult = leftValue;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    
    NSString *variableName = [leftValue stringValue];
    
    [env setVariable:rightValue forKey:variableName];
    return rightValue;
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"$"];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@=",param.discrete.stringValue];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [param codeWithEnvironment:env];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [param codeWithEnvironment:env];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @"";
}

@end
