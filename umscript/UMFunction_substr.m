//
//  UMFunction_substr.m
//  umscript
//
//  Created by Andreas Fink on 10.06.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_substr.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_substr

+ (NSString *)functionName
{
    return @"substr";
}

- (NSString *)functionName
{
    return @"substr";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"substr";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    NSUInteger c = params.count;
    if((c<2) || (c>3))
    {
        return [UMDiscreteValue discreteNull];
    }

    UMTerm *stringTerm = params[0];
    UMTerm *startTerm = params[1];
    UMTerm *lenTerm;
    if(c>2)
    {
        lenTerm = params[2];
    }
    UMDiscreteValue *lenValue = NULL;
    UMDiscreteValue *stringValue;
    UMDiscreteValue *startValue;

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        stringValue = entry.temporaryResult;
        lenValue = entry.temporaryResult2;
    }
    else
    {
        start = 0;
    }

    if(start==0)
    {
        @try
        {
            stringValue = [stringTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
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
    
    if(start <=1)
    {
        @try
        {
            startValue = [startTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = stringValue;
            e.position = 1;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    if(c>2)
    {
        @try
        {
            lenValue = [lenTerm evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = stringValue;
            e.temporaryResult2 = startValue;
            e.position = 2;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    
    NSString *string = stringValue.stringValue;
    NSInteger stringStart = startValue.intValue;
    NSInteger len = lenValue.intValue;
    
    if(stringStart >= string.length)
    {
        return [UMDiscreteValue discreteString:@""];
    }

    if(c>2)
    {
        lenTerm = params[2];
        lenValue = [lenTerm evaluateWithEnvironment:env];
        len = lenValue.intValue;
        NSString *result = [string substringWithRange:NSMakeRange(stringStart,len)];
        return [UMDiscreteValue discreteString:result];
    }
    NSString *result = [string substringFromIndex:stringStart];
    return [UMDiscreteValue discreteString:result];
}

@end
