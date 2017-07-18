//
//  UMFunction_longlong.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_longlong.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_longlong

+ (NSString *)functionName
{
    return @"longlong";
}

- (NSString *)functionName
{
    return @"longlong";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"longlong";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
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

    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d;
    @try
    {
        d = [currentTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 0;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    
    if(d.type == UMVALUE_LONGLONG)
    {
        return d;
    }
    return [UMDiscreteValue discreteLongLong:d.longLongValue];
}

@end
