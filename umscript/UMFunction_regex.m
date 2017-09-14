//
//  UMFunction_regex.m
//  umscript
//
//  Created by Andreas Fink on 14.09.17.
//
//

#import "UMFunction_regex.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_regex

+ (NSString *)functionName
{
    return @"regex";
}

- (NSString *)functionName
{
    return [UMFunction_regex functionName];
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
    NSString *regex = [value0 stringValue];
    NSString *mystring = [value1 stringValue];
    
    
    NSPredicate *regextest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([regextest evaluateWithObject:mystring] == YES)
    {
        return [UMDiscreteValue discreteYES];
    }
    return [UMDiscreteValue discreteNO];    
}

@end
