//
//  UMFunction_country_of.m
//  umscript
//
//  Created by Andreas Fink on 21.09.17.
//

#import "UMFunction_country_of.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_country_of


+ (NSString *)functionName
{
    return @"country_of";
}

- (NSString *)functionName
{
    return [UMFunction_country_of functionName];
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
    if(params.count != 1)
    {
        return [UMDiscreteValue discreteNull];
    }

    UMTerm *param0 = params[0];

    UMDiscreteValue *value0;

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

    NSString *number = [value0 stringValue];
    NSString *country = [self countryFromMSISDN:number];
    return [UMDiscreteValue discreteString:country];
}

- (NSString *)countryFromMSISDN:(NSString *)number
{
    if(number==NULL)
    {
        return @"unknown";
    }
    static NSString *usa = @"United States";
    static NSString *canada = @"Canada";
    char msisdn[32];
    memset(msisdn,0x00,sizeof(msisdn));
    strncpy(msisdn,number.UTF8String,sizeof(msisdn)-1);
    switch(msisdn[0])
    {
        case '1':
        {
            switch(msisdn[1])
            {
                case '2':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                case '2':
                                case '3':
                                    return usa;
                                case '4':
                                    return canada;
                                case '5':
                                case '6':
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '2':
                                case '3':
                                case '4':
                                case '5':
                                case '6':
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '3':
                                case '4':
                                case '5':
                                    return usa;
                                case '6':
                                    return canada;
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '4':
                                    return usa;
                                case '6':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return @"Bahamas";
                                case '6':
                                    return @"Barbados";
                                case '8':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return canada;
                                case '1':
                                case '2':
                                case '3':
                                case '4':
                                case '6':
                                    return usa;
                                case '7':
                                    return canada;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '4':
                                    return @"Anguilla";
                                case '7':
                                    return usa;
                                case '8':
                                    return @"Antigua/Barbuda";
                                    break;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '4':
                                case '6':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                case '3':
                                    return usa;
                                case '4':
                                    return @"British Virgin Islands";
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                case '2':
                                case '3':
                                case '4':
                                case '5':
                                    return usa;
                                case '6':
                                    return canada;
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '2':
                                case '3':
                                case '4':
                                case '5':
                                case '6':
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '1':
                                case '3':
                                case '5':
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '1':
                                case '2':
                                case '4':
                                case '6':
                                case '7':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '3':
                                    return canada;
                                case '5':
                                {
                                    return @"Cayman Islands";
                                    break;
                                }
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                case '2':
                                case '3':
                                    return usa;
                                case '4':
                                    return canada;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '1':
                                case '4':
                                    return usa;
                                case '5':
                                case '7':
                                case '8':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return canada;
                                case '5':
                                case '6':
                                    return usa;
                                case '7':
                                    return canada;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '4':
                                case '5':
                                case '6':
                                case '7':
                                case '8':
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                case '2':
                                case '3':
                                case '4':
                                case '5':
                                    return usa;
                                case '6':
                                    return canada;
                                case '7':
                                    return usa;
                                case '8':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '8':
                                    return canada;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return canada;
                                case '2':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '7':
                                    return canada;
                                case '8':
                                    return canada;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return @"Bermuda";
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '5':
                                    return usa;
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return canada;
                                case '8':
                                    return usa;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return canada;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '8':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '3':
                                    return @"Grenada";
                                case '4':
                                    return canada;
                                case '5':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '4':
                                    return usa;
                                case '7':
                                    return canada;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return canada;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return canada;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '4':
                                    return usa;
                                case '7':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '8':
                                    return canada;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '7':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return canada;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return canada;
                                case '2':
                                    return usa;
                                case '4':
                                    return canada;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return canada;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return canada;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return canada;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return canada;
                                case '3':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '6':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return canada;
                                case '9':
                                    return @"Turks &Caicos Islands";
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return @"Jamaica";
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '4':
                                    return @"Montserrat";
                                case '7':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return canada;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '4':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return canada;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return @"Sint Maarten";
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '4':
                                    return usa;
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return canada;
                                case '3':
                                    return usa;
                                case '7':
                                    return usa;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '3':
                                    return canada;
                                case '4':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return @"St. Lucia";
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '7':
                                    return @"Dominica";
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '8':
                                    return canada;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return canada;
                                case '1':
                                    return usa;
                                case '2':
                                    return canada;
                                case '4':
                                    return @"St. Vincent & Grenadines";
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return @"Puerto Rico";
                            }
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return canada;
                                case '8':
                                    return usa;
                                case '9':
                                    return @"Dominican Republic";
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '5':
                                    return canada;
                                case '8':
                                    return usa;
                                case '9':
                                    return @"Dominican Republic";
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '5':
                                    return usa;
                                case '8':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '3':
                                    return usa;
                                case '5':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return @"Dominican Republic";
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return canada;
                                case '4':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '7':
                                    return canada;
                                case '8':
                                    return @"Trinidad & Tobago";
                                case '9':
                                    return @"St. Kitts & Nevis";
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return canada;
                                case '2':
                                    return usa;
                                case '3':
                                    return canada;
                                case '6':
                                    return @"Jamaica";
                                case '8':
                                    return usa;
                                case '9':
                                    return canada;
                            }
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return canada;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return canada;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '5':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '7':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return canada;
                                case '7':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(msisdn[3])
                            {
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '4':
                                    return usa;
                                case '6':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '1':
                                    return usa;
                                case '2':
                                    return usa;
                                case '3':
                                    return usa;
                                case '5':
                                    return usa;
                                case '8':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(msisdn[3])
                            {
                                case '0':
                                    return usa;
                                case '4':
                                    return usa;
                                case '5':
                                    return usa;
                                case '6':
                                    return usa;
                                case '9':
                                    return usa;
                            }
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '2':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    return @"Egypt";
                    break;
                }
                case '1':
                {
                    switch(msisdn[2])
                    {
                        case '1':
                        {
                            return @"South Sudan";
                            break;
                        }
                        case '2':
                        {
                            return @"Morocco";
                            break;
                        }
                        case '3':
                        {
                            return @"Algeria";
                            break;
                        }
                        case '6':
                        {
                            return @"Tunisia";
                            break;
                        }
                        case '8':
                        {
                            return @"Libya";
                            break;
                        }
                    }
                    break;
                }
                case '2':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Gambia";
                            break;
                        }
                        case '1':
                        {
                            return @"Senegal";
                            break;
                        }
                        case '2':
                        {
                            return @"Mauritania";
                            break;
                        }
                        case '3':
                        {
                            return @"Mali";
                            break;
                        }
                        case '4':
                        {
                            return @"Guinea";
                            break;
                        }
                        case '5':
                        {
                            return @"Ivory Coast";
                            break;
                        }
                        case '6':
                        {
                            return @"Burkina Faso";
                            break;
                        }
                        case '7':
                        {
                            return @"Niger";
                            break;
                        }
                        case '8':
                        {
                            return @"Togo";
                            break;
                        }
                        case '9':
                        {
                            return @"Benin";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Mauritius";
                            break;
                        }
                        case '1':
                        {
                            return @"Liberia";
                            break;
                        }
                        case '2':
                        {
                            return @"Sierra Leone";
                            break;
                        }
                        case '3':
                        {
                            return @"Ghana";
                            break;
                        }
                        case '4':
                        {
                            return @"Nigeria";
                            break;
                        }
                        case '5':
                        {
                            return @"Chad";
                            break;
                        }
                        case '6':
                        {
                            return @"Central African Republic";
                            break;
                        }
                        case '7':
                        {
                            return @"Cameroon";
                            break;
                        }
                        case '8':
                        {
                            return @"Cape Verde";
                            break;
                        }
                        case '9':
                        {
                            return @"São Tomé and Príncipe";
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Equatorial Guinea";
                            break;
                        }
                        case '1':
                        {
                            return @"Gabon";
                            break;
                        }
                        case '2':
                        {
                            return @"Dem. Republic of the Congo";
                            break;
                        }
                        case '3':
                        {
                            return @"République démocratique du Congo";
                            break;
                        }
                        case '4':
                        {
                            return @"Angola";
                            break;
                        }
                        case '5':
                        {
                            return @"Guinea-Bissau";
                            break;
                        }
                        case '6':
                        {
                            return @"Diego Garcia";
                            break;
                        }
                        case '7':
                        {
                            return @"Ascension Island";
                            break;
                        }
                        case '8':
                        {
                            return @"Seychelles";
                            break;
                        }
                        case '9':
                        {
                            return @"Sudan";
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Rwanda";
                            break;
                        }
                        case '1':
                        {
                            return @"Ethiopia";
                            break;
                        }
                        case '2':
                        {
                            return @"Somalia";
                            break;
                        }
                        case '3':
                        {
                            return @"Djibouti";
                            break;
                        }
                        case '4':
                        {
                            return @"Kenya";
                            break;
                        }
                        case '5':
                        {
                            return @"Tanzania";
                            break;
                        }
                        case '6':
                        {
                            return @"Uganda";
                            break;
                        }
                        case '7':
                        {
                            return @"Burundi";
                            break;
                        }
                        case '8':
                        {
                            return @"Mozambique";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Zambia";
                            break;
                        }
                        case '1':
                        {
                            return @"Madagascar";
                            break;
                        }
                        case '2':
                        {
                            return @"Réunion";
                            break;
                        }
                        case '3':
                        {
                            return @"Zimbabwe";
                            break;
                        }
                        case '4':
                        {
                            return @"Namibia";
                            break;
                        }
                        case '5':
                        {
                            return @"Malawi";
                            break;
                        }
                        case '6':
                        {
                            return @"Lesotho";
                            break;
                        }
                        case '7':
                        {
                            return @"Botswana";
                            break;
                        }
                        case '8':
                        {
                            return @"Swaziland";
                            break;
                        }
                        case '9':
                        {
                            return @"Comoros";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    return @"South Africa";
                    break;
                }
                case '9':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"St. Helena";
                            break;
                        }
                        case '1':
                        {
                            return @"Eritrea";
                            break;
                        }
                        case '7':
                        {
                            return @"Aruba";
                            break;
                        }
                        case '8':
                        {
                            return @"Faroe Islands";
                            break;
                        }
                        case '9':
                        {
                            return @"Greenland";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '3':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    return @"Greece";
                    break;
                }
                case '1':
                {
                    return @"Netherlands";
                    break;
                }
                case '2':
                {
                    return @"Belgium";
                    break;
                }
                case '3':
                {
                    return @"France";
                    break;
                }
                case '4':
                {
                    return @"Spain";
                    break;
                }
                case '5':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Gibraltar";
                            break;
                        }
                        case '1':
                        {
                            return @"Portugal";
                            break;
                        }
                        case '2':
                        {
                            return @"Luxembourg";
                            break;
                        }
                        case '3':
                        {
                            return @"Ireland";
                            break;
                        }
                        case '5':
                        {
                            return @"Albania";
                            break;
                        }
                        case '6':
                        {
                            return @"Malta";
                            break;
                        }
                        case '7':
                        {
                            return @"Cyprus";
                            break;
                        }
                        case '8':
                        {
                            return @"Finland";
                            break;
                        }
                        case '9':
                        {
                            return @"Bulgaria";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    return @"Hungary";
                    break;
                }
                case '7':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Lithuania";
                            break;
                        }
                        case '1':
                        {
                            return @"Latvia";
                            break;
                        }
                        case '2':
                        {
                            return @"Estonia";
                            break;
                        }
                        case '3':
                        {
                            return @"Moldova";
                            break;
                        }
                        case '4':
                        {
                            return @"Armenia";
                            break;
                        }
                        case '5':
                        {
                            return @"Belarus";
                            break;
                        }
                        case '6':
                        {
                            return @"Andorra";
                            break;
                        }
                        case '7':
                        {
                            return @"Monaco";
                            break;
                        }
                        case '8':
                        {
                            return @"San Marino";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Ukraine";
                            break;
                        }
                        case '1':
                        {
                            return @"Serbia";
                            break;
                        }
                        case '2':
                        {
                            return @"Montenegro";
                            break;
                        }
                        case '5':
                        {
                            return @"Croatia";
                            break;
                        }
                        case '6':
                        {
                            return @"Slovenia";
                            break;
                        }
                        case '7':
                        {
                            return @"Bosnia and Herzegovina";
                            break;
                        }
                        case '9':
                        {
                            return @"Republic of Macedonia";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    return @"Vatican City";
                    break;
                }
            }
            break;
        }
        case '4':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    return @"Romania";
                    break;
                }
                case '1':
                {
                    return @"Switzerland";
                    break;
                }
                case '2':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Czech Republic";
                            break;
                        }
                        case '1':
                        {
                            return @"Slovakia";
                            break;
                        }
                        case '3':
                        {
                            return @"Liechtenstein";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    return @"Austria";
                    break;
                }
                case '4':
                {
                    return @"Wales";
                    break;
                }
                case '5':
                {
                    return @"Denmark";
                    break;
                }
                case '6':
                {
                    return @"Sweden";
                    break;
                }
                case '7':
                {
                    return @"Norway";
                    break;
                }
                case '8':
                {
                    return @"Poland";
                    break;
                }
                case '9':
                {
                    return @"Germany";
                    break;
                }
            }
            break;
        }
        case '5':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Falkland Islands";
                            break;
                        }
                        case '1':
                        {
                            return @"Belize";
                            break;
                        }
                        case '2':
                        {
                            return @"Guatemala";
                            break;
                        }
                        case '3':
                        {
                            return @"El Salvador";
                            break;
                        }
                        case '4':
                        {
                            return @"Honduras";
                            break;
                        }
                        case '5':
                        {
                            return @"Nicaragua";
                            break;
                        }
                        case '6':
                        {
                            return @"Costa Rica";
                            break;
                        }
                        case '7':
                        {
                            return @"Panama";
                            break;
                        }
                        case '8':
                        {
                            return @"Saint-Pierre and Miquelon";
                            break;
                        }
                        case '9':
                        {
                            return @"Haiti";
                            break;
                        }
                    }
                    break;
                }
                case '1':
                {
                    return @"Peru";
                    break;
                }
                case '2':
                {
                    return @"Mexico";
                    break;
                }
                case '3':
                {
                    return @"Cuba";
                    break;
                }
                case '4':
                {
                    return @"Argentina";
                    break;
                }
                case '5':
                {
                    return @"Brazil";
                    break;
                }
                case '6':
                {
                    return @"Chile";
                    break;
                }
                case '7':
                {
                    return @"Colombia";
                    break;
                }
                case '8':
                {
                    return @"Venezuela";
                    break;
                }
                case '9':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Guadeloupe";
                            break;
                        }
                        case '1':
                        {
                            return @"Bolivia";
                            break;
                        }
                        case '2':
                        {
                            return @"Guyana";
                            break;
                        }
                        case '3':
                        {
                            return @"Ecuador";
                            break;
                        }
                        case '4':
                        {
                            return @"French Guiana";
                            break;
                        }
                        case '5':
                        {
                            return @"Paraguay";
                            break;
                        }
                        case '6':
                        {
                            return @"Martinique";
                            break;
                        }
                        case '7':
                        {
                            return @"Surinam";
                            break;
                        }
                        case '8':
                        {
                            return @"Uruguay";
                            break;
                        }
                        case '9':
                        {
                            return @"Netherlands Antilles";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '6':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    return @"Malaysia";
                    break;
                }
                case '1':
                {
                    return @"Christmas Island";
                    break;
                }
                case '2':
                {
                    return @"Indonesia";
                    break;
                }
                case '3':
                {
                    return @"Philippines";
                    break;
                }
                case '4':
                {
                    return @"New Zealand";
                    break;
                }
                case '5':
                {
                    return @"Singapore";
                    break;
                }
                case '6':
                {
                    return @"Thailand";
                    break;
                }
                case '7':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"East Timor";
                            break;
                        }
                        case '3':
                        {
                            return @"Brunei";
                            break;
                        }
                        case '4':
                        {
                            return @"Nauru";
                            break;
                        }
                        case '5':
                        {
                            return @"Papua New Guinea";
                            break;
                        }
                        case '6':
                        {
                            return @"Tonga";
                            break;
                        }
                        case '7':
                        {
                            return @"Solomon Islands";
                            break;
                        }
                        case '8':
                        {
                            return @"Vanuatu";
                            break;
                        }
                        case '9':
                        {
                            return @"Fiji";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Palau";
                            break;
                        }
                        case '1':
                        {
                            return @"Wallis and Futuna";
                            break;
                        }
                        case '2':
                        {
                            return @"Cook Islands";
                            break;
                        }
                        case '3':
                        {
                            return @"Niue";
                            break;
                        }
                        case '5':
                        {
                            return @"Samoa";
                            break;
                        }
                        case '6':
                        {
                            return @"Kiribati";
                            break;
                        }
                        case '7':
                        {
                            return @"New Caledonia";
                            break;
                        }
                        case '8':
                        {
                            return @"Tuvalu";
                            break;
                        }
                        case '9':
                        {
                            return @"French Polynesia";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Tokelau";
                            break;
                        }
                        case '1':
                        {
                            return @"Micronesia";
                            break;
                        }
                        case '2':
                        {
                            return @"Marshall Islands";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '7':
        {
            switch(msisdn[1])
            {
                case '7':
                {
                    switch(msisdn[2])
                    {
                        case '2':
                        {
                            return @"Kazakhstan";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '8':
        {
            switch(msisdn[1])
            {
                case '1':
                {
                    return @"Japan";
                    break;
                }
                case '2':
                {
                    return @"South Korea";
                    break;
                }
                case '4':
                {
                    return @"Vietnam";
                    break;
                }
                case '5':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"North Korea";
                            break;
                        }
                        case '2':
                        {
                            return @"Hong Kong";
                            break;
                        }
                        case '3':
                        {
                            return @"Macau";
                            break;
                        }
                        case '5':
                        {
                            return @"Cambodia";
                            break;
                        }
                        case '6':
                        {
                            return @"Laos";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    return @"Republic of China";
                    break;
                }
                case '8':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Bangladesh";
                            break;
                        }
                        case '6':
                        {
                            return @"Taiwan";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case '9':
        {
            switch(msisdn[1])
            {
                case '0':
                {
                    return @"Turkey";
                    break;
                }
                case '1':
                {
                    return @"India";
                    break;
                }
                case '2':
                {
                    return @"Pakistan";
                    break;
                }
                case '3':
                {
                    return @"Afghanistan";
                    break;
                }
                case '4':
                {
                    return @"Sri Lanka";
                    break;
                }
                case '5':
                {
                    return @"Burma";
                    break;
                }
                case '6':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Maldives";
                            break;
                        }
                        case '1':
                        {
                            return @"Lebanon";
                            break;
                        }
                        case '2':
                        {
                            return @"Jordan";
                            break;
                        }
                        case '3':
                        {
                            return @"Syria";
                            break;
                        }
                        case '4':
                        {
                            return @"Iraq";
                            break;
                        }
                        case '5':
                        {
                            return @"Kuwait";
                            break;
                        }
                        case '6':
                        {
                            return @"Saudi Arabia";
                            break;
                        }
                        case '7':
                        {
                            return @"Yemen";
                            break;
                        }
                        case '8':
                        {
                            return @"Oman";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    switch(msisdn[2])
                    {
                        case '0':
                        {
                            return @"Palestine";
                            break;
                        }
                        case '1':
                        {
                            return @"United Arab Emirates";
                            break;
                        }
                        case '2':
                        {
                            return @"Israel";
                            break;
                        }
                        case '3':
                        {
                            return @"Bahrain";
                            break;
                        }
                        case '4':
                        {
                            return @"Qatar";
                            break;
                        }
                        case '5':
                        {
                            return @"Bhutan";
                            break;
                        }
                        case '6':
                        {
                            return @"Mongolia";
                            break;
                        }
                        case '7':
                        {
                            return @"Nepal";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    return @"Iran";
                    break;
                }
                case '9':
                {
                    switch(msisdn[2])
                    {
                        case '2':
                        {
                            return @"Tajikistan";
                            break;
                        }
                        case '3':
                        {
                            return @"Turkmenistan";
                            break;
                        }
                        case '4':
                        {
                            return @"Azerbaijan";
                            break;
                        }
                        case '5':
                        {
                            return @"Georgia";
                            break;
                        }
                        case '6':
                        {
                            return @"Kyrgyzstan";
                            break;
                        }
                        case '8':
                        {
                            return @"Uzbekistan";
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    return @"unknown";
}

@end
