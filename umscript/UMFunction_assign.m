//
//  UMFunction_assign.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_assign.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_assign

+ (NSString *)functionName
{
    return @"assign";
}

- (NSString *)functionName
{
    return @"assign";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"assign";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    if(params.count !=2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    
    UMTerm *entry1 = params[0];
    UMTerm *entry2 = params[1];

    UMDiscreteValue *d2;
    @try
    {
        d2 = [entry2 evaluateWithEnvironment:env continueFrom:interruptedAt];
    }
    @catch(UMTerm_Interrupt *interrupt)
    {
        UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
        e.name = [self functionName];
        [interrupt recordEntry:e];
        @throw(interrupt);
    }
    
    if(entry1.type == UMTermType_variable)
    {
        [env setVariable:d2 forKey:entry1.varname];
    }
    else if(entry1.type == UMTermType_field)
    {
        [env setField:d2 forKey:entry1.fieldname];
    }
    else
    {
        /* we try to assign a value to a const or a string or something like that which might not be a so good idea */
    }
    return d2;
}


@end
