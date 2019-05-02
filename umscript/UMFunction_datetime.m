//
//  UMFunction_datetime.m
//  umscript
//
//  Created by Andreas Fink on 27.07.17.
//
//

#import "UMFunction_datetime.h"

#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_datetime


+ (NSString *)functionName
{
    return @"datetime";
}

- (NSString *)functionName
{
    return [UMFunction_datetime functionName];
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


//datetime(format,timezone=UTC,locale=US)

#define STANDARD_DATE_STRING_FORMAT     @"yyyy-MM-dd HH:mm:ss.SSSSSS"

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params
                            environment:(id)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMTerm *param0 = params[0] ? params[0] : NULL;
    UMTerm *param1 = params[1] ? params[1] : NULL;
    UMTerm *param2 = params[2] ? params[2] : NULL;
    NSString *dateFormatString = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
    NSString *timezoneString = @"UTC";
    NSString *localeString = @"en_US";
    
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        if(start>0)
        {
            dateFormatString = entry.temporaryResult.stringValue;
        }
        if(start>1)
        {
            timezoneString = entry.temporaryResult2.stringValue;
        }
    }
    else
    {
        start = 0;
    }
    
    if(start==0)
    {
        @try
        {
            if(param0)
            {
                UMDiscreteValue *value0 = [param0 evaluateWithEnvironment:env  continueFrom:interruptedAt];
                dateFormatString = [value0 stringValue];
            }
            else
            {
                dateFormatString = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
            }
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
    if(start <= 1)
    {
        @try
        {
            if(param1)
            {
                UMDiscreteValue *value1 = [param1 evaluateWithEnvironment:env  continueFrom:interruptedAt];
                timezoneString = [value1 stringValue];
            }
            else
            {
                timezoneString = @"UTC";

            }

        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = [UMDiscreteValue discreteString:dateFormatString];
            e.position = 1;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    if(start <= 2)
    {
        @try
        {
            if(param2)
            {
                UMDiscreteValue *value2 = [param1 evaluateWithEnvironment:env  continueFrom:interruptedAt];
                localeString = [value2 stringValue];
            }
            else
            {
                localeString = @"en_US";
            }
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.temporaryResult = [UMDiscreteValue discreteString:dateFormatString];
            e.temporaryResult2 = [UMDiscreteValue discreteString:timezoneString];
            e.position = 2;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
    }
    
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:timezoneString];
    NSLocale *theLocale = [[NSLocale alloc] initWithLocaleIdentifier:localeString];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setLocale:theLocale];
    [dateFormatter setDateFormat:dateFormatString];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return [UMDiscreteValue discreteString:dateString];
}

@end
