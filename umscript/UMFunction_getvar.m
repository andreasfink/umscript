//
//  UMFunction_getvar.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_getvar.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_getvar

+ (NSString *)functionName
{
    return @"getvar";
}

- (NSString *)functionName
{
    return @"getvar";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"getvar";
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

    if([params count] != 1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *variableNameTerm = params[0];
    UMDiscreteValue *variableNameValue  = [variableNameTerm evaluateWithEnvironment:env];
    NSString *variableName = [variableNameValue stringValue];
    
    return [env variableForKey:variableName ];

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
        UMTerm *varNameTerm = params[0];
        UMDiscreteValue *varNameValue;
        
        
        @try
        {
            varNameValue = [varNameTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = 0;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
        
        NSString *varName = [varNameValue stringValue];
        return [env variableForKey:varName ];
    }
}


- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"$"];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return param.discrete.stringValue;
    return param.varname;
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,[env identPrefix]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @"";
}

@end
