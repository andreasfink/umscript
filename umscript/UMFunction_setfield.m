//
//  UMFunction_setfield.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_setfield.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_setfield

+ (NSString *)functionName
{
    return @"setfield";
}

- (NSString *)functionName
{
    return @"setfield";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"setfield";
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

    [env setField:rightValue forKey:variableName];
    return rightValue;
}

@end
