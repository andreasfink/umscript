//
//  UMFunction_data.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_data.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_data

+ (NSString *)functionName
{
    return @"__data";
}

- (NSString *)functionName
{
    return @"__data";
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params
                            environment:(UMEnvironment *)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
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
    
    UMDiscreteValue *d;
    UMTerm *currentTerm = params[0];

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

    if(d.type == UMVALUE_DATA)
    {
        return d;
    }
    return [UMDiscreteValue discreteData:d.dataValue];
}

@end
