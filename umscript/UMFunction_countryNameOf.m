//
//  UMFunction_countryNameOf.m
//  umscript
//
//  Created by Andreas Fink on 15.02.18.
//

#import "UMFunction_countryNameOf.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_countryNameOf

+ (NSString *)functionName
{
    return @"countryNameOf";
}

- (NSString *)functionName
{
    return [UMFunction_countryNameOf functionName];
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
                            environment:(id)env
                           continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMTerm *param0 = params[0] ? params[0] : NULL;

    UMDiscreteValue *inputValue;

    if(params.count < 1)
    {
        return [UMDiscreteValue discreteNull];
    }

    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
        if(start>0)
        {
            inputValue = entry.temporaryResult;
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
            inputValue = [param0 evaluateWithEnvironment:env  continueFrom:interruptedAt];
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

    NSString *in = [inputValue stringValue];
    NSString *out = [self countryNameFromDigits:in];
    UMDiscreteValue *r = [UMDiscreteValue discreteString:out];
    return r;
}

-(NSString *)countryNameFromDigits:(NSString *)digits
{
    if(digits==NULL)
    {
        return @"";
    }
    const char *digit = [digits UTF8String];
    if(digit==NULL)
    {
        return @"";
    }
    if(digit[0]!='+')
    {
        return @"national";
    }
    digit = &digit[1];

    switch(digit[0])
    {
        case '0':
        {
            return @"";
            break;
        }
        case '1':
        {
            switch(digit[1])
            {
                case '0':
                {
                    return @"";
                    break;
                }
                case '1':
                {
                    return @"";
                    break;
                }
                case '2':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"Bahamas";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Barbados";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Anguilla";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"Antigua/Barbuda";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"British Virgin Islands";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Canada";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"Cayman Islands";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"Bermuda";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"Grenada";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Canada";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Turks & Caicos Islands";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Montserrat";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Canada";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"Sint Maarten";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"St. Lucia";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Dominica";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"St. Vincent & Grenadines";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Puerto Rico";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Dominican Republic";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Canada";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Dominican Republic";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Dominican Republic";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '8':
                                {
                                    return @"Trinidad and Tobago";
                                    break;
                                }
                                case '9':
                                {
                                    return @"St. Kitts & Nevis";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"Jamaica";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"Canada";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Puerto Rico";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '2':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '3':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"USA";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"USA";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '2':
        {
            switch(digit[1])
            {
                case '0':
                {
                    return @"Egypt";
                    break;
                }
                case '1':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Spare";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    switch(digit[6])
                                                    {
                                                        case '0':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '1':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '2':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '3':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '4':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '5':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '6':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '7':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '8':
                                                        {
                                                            return @"Western Sahara";
                                                            break;
                                                        }
                                                        case '9':
                                                        {
                                                            return @"Western Sahara";
                                                            break;
                                                        }
                                                        default:
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            return @"Algeria";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Tunisia";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Libya";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '2':
                {
                    switch(digit[2])
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
                            return @"Côte d'Ivoire";
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
                            return @"Togolese Republic";
                            break;
                        }
                        case '9':
                        {
                            return @"Benin";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '3':
                {
                    switch(digit[2])
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
                            return @"Sao Tome and Principe";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    switch(digit[2])
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
                            return @"Congo";
                            break;
                        }
                        case '3':
                        {
                            return @"Congo DRC";
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
                            return @"Ascension";
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
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '5':
                {
                    switch(digit[2])
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
                            return @"Somali Democratic Republic";
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
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"Zanzibar";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
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
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    switch(digit[2])
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
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"Mayotte";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"Mayotte";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
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
                        default:
                        {
                            return @"";
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
                case '8':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Spare";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Saint Helena";
                            break;
                        }
                        case '1':
                        {
                            return @"Eritrea";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
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
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '3':
        {
            switch(digit[1])
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
                    switch(digit[2])
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
                        case '4':
                        {
                            return @"Iceland";
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
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"Åland Islands";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"Bulgaria";
                            break;
                        }
                        default:
                        {
                            return @"";
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
                    switch(digit[2])
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
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"Transnistria";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"Transnistria";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"Nagorno-Karabakh";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"Nagorno-Karabakh";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
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
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            return @"San Marino";
                            break;
                        }
                        case '9':
                        {
                            return @"Vatican City State";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Ukraine";
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '3':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            return @"Montenegro";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Croatia";
                            break;
                        }
                        case '6':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"Kosovo";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '7':
                        {
                            return @"Bosnia and Herzegovina";
                            break;
                        }
                        case '8':
                        {
                            return @"Group of countries, shared code";
                            break;
                        }
                        case '9':
                        {
                            return @"Macedonia";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    switch(digit[6])
                                                    {
                                                        case '0':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '1':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '2':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '3':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '4':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '5':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '6':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '7':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '8':
                                                        {
                                                            return @"Vatican City";
                                                            break;
                                                        }
                                                        case '9':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        default:
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            return @"";
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '4':
        {
            switch(digit[1])
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
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Czech Republic";
                            break;
                        }
                        case '1':
                        {
                            return @"Slovak Republic";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Liechtenstein";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
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
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"Guernsey";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '5':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"Jersey";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '6':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"Isle of Man";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            return @"";
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
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
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            return @"";
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Svalbard";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
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
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '5':
        {
            switch(digit[1])
            {
                case '0':
                {
                    switch(digit[2])
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
                            return @"Saint Pierre and Miquelon";
                            break;
                        }
                        case '9':
                        {
                            return @"Haiti";
                            break;
                        }
                        default:
                        {
                            return @"";
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
                    switch(digit[2])
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
                            return @"Suriname";
                            break;
                        }
                        case '8':
                        {
                            return @"Uruguay";
                            break;
                        }
                        case '9':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"Sint Eustatius";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Saba";
                                    break;
                                }
                                case '5':
                                {
                                    return @"formerly Sint Maarten";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"Bonaire";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"Curaçao";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '6':
        {
            switch(digit[1])
            {
                case '0':
                {
                    return @"Malaysia";
                    break;
                }
                case '1':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            return @"";
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            switch(digit[5])
                                            {
                                                case '0':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '1':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '2':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '3':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '4':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '5':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '6':
                                                {
                                                    switch(digit[6])
                                                    {
                                                        case '0':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '1':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '2':
                                                        {
                                                            return @"Cocos Islands";
                                                            break;
                                                        }
                                                        case '3':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '4':
                                                        {
                                                            return @"Christmas Island";
                                                            break;
                                                        }
                                                        case '5':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '6':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '7':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '8':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        case '9':
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                        default:
                                                        {
                                                            return @"";
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                                case '7':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '8':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                case '9':
                                                {
                                                    return @"";
                                                    break;
                                                }
                                                default:
                                                {
                                                    return @"";
                                                    break;
                                                }
                                            }
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
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
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Timor-Leste";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"Australian Antarctic Territory";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"Norfolk Island";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            return @"Brunei Darussalam";
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
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(digit[2])
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
                        case '4':
                        {
                            return @"Spare";
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
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
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
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '7':
        {
            switch(digit[1])
            {
                case '0':
                {
                    return @"";
                    break;
                }
                case '1':
                {
                    return @"";
                    break;
                }
                case '2':
                {
                    return @"";
                    break;
                }
                case '3':
                {
                    return @"";
                    break;
                }
                case '4':
                {
                    return @"";
                    break;
                }
                case '5':
                {
                    return @"";
                    break;
                }
                case '6':
                {
                    return @"Kazakhstan";
                    break;
                }
                case '7':
                {
                    return @"Kazakhstan";
                    break;
                }
                case '8':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Abkhazia";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            return @"";
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"Abkhazia";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '8':
        {
            switch(digit[1])
            {
                case '0':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"International Freephone Service";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"International Shared Cost Service";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '1':
                {
                    return @"Japan";
                    break;
                }
                case '2':
                {
                    return @"Korea (South)";
                    break;
                }
                case '3':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Spare";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '4':
                {
                    return @"Viet Nam";
                    break;
                }
                case '5':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Korea (North)";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            return @"Hong Kong";
                            break;
                        }
                        case '3':
                        {
                            return @"Macao";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Cambodia";
                            break;
                        }
                        case '6':
                        {
                            return @"Lao";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '6':
                {
                    return @"China";
                    break;
                }
                case '7':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Inmarsat SNAC";
                            break;
                        }
                        case '1':
                        {
                            return @"Inmarsat Atlantic Ocean-East";
                            break;
                        }
                        case '2':
                        {
                            return @"Inmarsat Pacific Ocean)";
                            break;
                        }
                        case '3':
                        {
                            return @"Inmarsat Indian Ocean)";
                            break;
                        }
                        case '4':
                        {
                            return @"Inmarsat Atlantic Ocean-West";
                            break;
                        }
                        case '5':
                        {
                            return @"Reserved - Maritime Mobile Service Applications";
                            break;
                        }
                        case '6':
                        {
                            return @"Reserved - Maritime Mobile Service Applications";
                            break;
                        }
                        case '7':
                        {
                            return @"Reserved - Maritime Mobile Service Applications";
                            break;
                        }
                        case '8':
                        {
                            return @"Universal Personal Telecommunication Service";
                            break;
                        }
                        case '9':
                        {
                            return @"Reserved for national non-commercial purposes";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '8':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Bangladesh";
                            break;
                        }
                        case '1':
                        {
                            return @"Global Mobile Satellite System";
                            break;
                        }
                        case '2':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"Global Networks Antarctica";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Taiwan";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Reserved for future global service";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '9':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Spare";
                            break;
                        }
                        case '1':
                        {
                            return @"Spare";
                            break;
                        }
                        case '2':
                        {
                            return @"Spare";
                            break;
                        }
                        case '3':
                        {
                            return @"Spare";
                            break;
                        }
                        case '4':
                        {
                            return @"Spare";
                            break;
                        }
                        case '5':
                        {
                            return @"Spare";
                            break;
                        }
                        case '6':
                        {
                            return @"Spare";
                            break;
                        }
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"Spare";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        case '9':
        {
            switch(digit[1])
            {
                case '0':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"";
                            break;
                        }
                        case '1':
                        {
                            return @"";
                            break;
                        }
                        case '2':
                        {
                            return @"";
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    switch(digit[4])
                                    {
                                        case '0':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '1':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '2':
                                        {
                                            return @"Northern Cyprus";
                                            break;
                                        }
                                        case '3':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '4':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '5':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '6':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '7':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '8':
                                        {
                                            return @"";
                                            break;
                                        }
                                        case '9':
                                        {
                                            return @"";
                                            break;
                                        }
                                        default:
                                        {
                                            return @"";
                                            break;
                                        }
                                    }
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            return @"";
                            break;
                        }
                        case '5':
                        {
                            return @"";
                            break;
                        }
                        case '6':
                        {
                            return @"";
                            break;
                        }
                        case '7':
                        {
                            return @"";
                            break;
                        }
                        case '8':
                        {
                            return @"";
                            break;
                        }
                        case '9':
                        {
                            return @"";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
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
                    return @"Myanmar";
                    break;
                }
                case '6':
                {
                    switch(digit[2])
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
                            return @"Syrian Arab Republic";
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
                        case '9':
                        {
                            return @"Reserved";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                case '7':
                {
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Reserved";
                            break;
                        }
                        case '1':
                        {
                            return @"UAE";
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
                        case '8':
                        {
                            return @"Spare";
                            break;
                        }
                        case '9':
                        {
                            return @"International Premium Rate Service";
                            break;
                        }
                        default:
                        {
                            return @"";
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
                    switch(digit[2])
                    {
                        case '0':
                        {
                            return @"Spare";
                            break;
                        }
                        case '1':
                        {
                            return @"ITU Trials";
                            break;
                        }
                        case '2':
                        {
                            return @"Tajikistan";
                            break;
                        }
                        case '3':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"South Ossetia";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
                            break;
                        }
                        case '4':
                        {
                            switch(digit[3])
                            {
                                case '0':
                                {
                                    return @"";
                                    break;
                                }
                                case '1':
                                {
                                    return @"";
                                    break;
                                }
                                case '2':
                                {
                                    return @"";
                                    break;
                                }
                                case '3':
                                {
                                    return @"";
                                    break;
                                }
                                case '4':
                                {
                                    return @"Abkhazia";
                                    break;
                                }
                                case '5':
                                {
                                    return @"";
                                    break;
                                }
                                case '6':
                                {
                                    return @"";
                                    break;
                                }
                                case '7':
                                {
                                    return @"";
                                    break;
                                }
                                case '8':
                                {
                                    return @"";
                                    break;
                                }
                                case '9':
                                {
                                    return @"";
                                    break;
                                }
                                default:
                                {
                                    return @"";
                                    break;
                                }
                            }
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
                        case '7':
                        {
                            return @"Spare";
                            break;
                        }
                        case '8':
                        {
                            return @"Uzbekistan";
                            break;
                        }
                        case '9':
                        {
                            return @"Reserved Disaster Relief";
                            break;
                        }
                        default:
                        {
                            return @"";
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    return @"";
                    break;
                }
            }
            break;
        }
        default:
        {
            return @"";
            break;
        }
    }
    return @"";
}

@end
