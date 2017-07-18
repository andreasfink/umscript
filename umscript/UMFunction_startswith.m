//
//  UMFunction_startswith.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_startswith.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_startswith

+ (NSString *)functionName
{
    return @"startswith";
}

- (NSString *)functionName
{
    return @"startswith";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"startswith";
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
    
    NSString *leftString = leftValue.stringValue;
    NSString *rightString = rightValue.stringValue;
    if([leftString length] < [rightString length])
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    leftString = [leftString substringToIndex:[rightString length]];
    BOOL result = [leftString isEqualToString:rightString];
    return [UMDiscreteValue discreteBool:result];
}
@end
