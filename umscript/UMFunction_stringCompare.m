//
//  UMFunction_stringCompare.m
//  umscript
//
//  Created by Andreas Fink on 26.07.17.
//
//

#import "UMFunction_stringCompare.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_stringCompare


+ (NSString *)functionName
{
    return @"stringcompare";
}

- (NSString *)functionName
{
    return @"stringcompare";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"stringcompare";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(params.count <2)
    {
        return [UMDiscreteValue discreteNull];
    }

    UMTerm *param3 = NULL;
    if(params.count == 3)
    {
        param3 = params[3];
    }

    UMTerm *param0 = params[0];
    UMTerm *param1 = params[1];
    UMDiscreteValue *value0;
    UMDiscreteValue *value1;
    int value3;

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        value0 = entry.temporaryResult;
    }
    else
    {
        start = 0;
    }

    if(start==0)
    {
        @try
        {
            value0 = [param0 evaluateWithEnvironment:env  continueFrom:interruptedAt];
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
        value1 = [param1 evaluateWithEnvironment:env  continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.temporaryResult = value0;
        e.position = 1;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }

    if(param3)
    {
        @try
        {
            UMDiscreteValue *dvalue3 = [param1 evaluateWithEnvironment:env  continueFrom:interruptedAt];
            value3 = [dvalue3 intValue];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = value0;
            e.position = 2;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    else
    {
        value3 = 0;
    }
    UMDiscreteValue *r;
    NSString *s0 = [value0 stringValue];
    NSString *s1 = [value1 stringValue];
    NSStringCompareOptions opt = value3 ? NSCaseInsensitiveSearch : 0;

    NSComparisonResult re = [s0 compare:s1 options:opt];
    switch(re)
    {
        case    NSOrderedAscending:
            r = [[UMDiscreteValue alloc]initWithInt:-1];
            break;
        case    NSOrderedSame:
            r = [[UMDiscreteValue alloc]initWithInt:0];
            break;
        case    NSOrderedDescending:
            r = [[UMDiscreteValue alloc]initWithInt:1];
            break;
    }
    return r;
}

@end
