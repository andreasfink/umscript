//
//  UMFunction_namedlist_contains.m
//  umscript
//
//  Created by Andreas Fink on 12.09.17.
//
//

#import "UMFunction_namedlist_contains.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_namedlist_contains


+ (NSString *)functionName
{
    return @"namedlist_contains";
}

- (NSString *)functionName
{
    return [UMFunction_namedlist_contains functionName];
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
    if(params.count != 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *param0 = params[0];
    UMTerm *param1 = params[1];
    
    UMDiscreteValue *value0;
    UMDiscreteValue *value1;
    
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
            value0 = [param0 evaluateWithEnvironment:env continueFrom:interruptedAt];
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
        value1 = [param1 evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 1;
        e.temporaryResult = value0;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    NSString *list_name = [value0 stringValue];
    NSString *entry_string = [value1 stringValue];
    if([env namedlist_contains:list_name value:entry_string])
    {
        return [UMDiscreteValue discreteYES];
    }
    return [UMDiscreteValue discreteNO];
}

@end
