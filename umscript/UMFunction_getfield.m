//
//  UMFunction_getfield.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_getfield.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_getfield

+ (NSString *)functionName
{
    return @"getfield";
}

- (NSString *)functionName
{
    return @"getfield";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"getfield";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt
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

    if([params count] != 1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *fieldNameTerm = params[0];
    UMDiscreteValue *fieldNameValue;
    
    
    @try
    {
        fieldNameValue = [fieldNameTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        e.position = 0;
        [interrupt recordEntry:e];
        @throw(interrupt);
    }

    NSString *fieldName = [fieldNameValue stringValue];
    return [env fieldForKey:fieldName ];
}

@end
