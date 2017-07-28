//
//  UMFunction_print.m
//  umscript
//
//  Created by Andreas Fink on 23/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_print.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_print

+ (NSString *)functionName
{
    return @"print";
}

- (NSString *)functionName
{
    return [UMFunction_print functionName];
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
    NSInteger start;
    NSInteger end = params.count;
    
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
    }
    else
    {
        start = 0;
    }
    
    for(NSInteger i=start;i<end;i++)
    {
        @try
        {
            UMTerm *entry = params[i];
            UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
            NSString *s = d.stringValue;
            fprintf(stdout,"%s",s.UTF8String);
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.position = i;
            e.name = [self functionName];
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    return [UMDiscreteValue discreteNull];
}

@end
