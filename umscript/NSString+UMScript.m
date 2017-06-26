//
//  NSString+UMScript.m
//  umscript
//
//  Created by Andreas Fink on 26.06.17.
//

#import "NSString+UMScript.h"

#include <ctype.h>
#include <string.h>
#include <xlocale.h>

@implementation NSString(UMScript)

- (UMDiscreteValue *)discreteValue
{
    const unsigned char *digits = (const unsigned char *)self.UTF8String;
    size_t len = strlen((const char *)digits);
    if(len == 0)
    {
        return [UMDiscreteValue discreteNull];
    }

    BOOL onlyDigits = YES;
    BOOL onlyHex = YES;
    BOOL onlyOcto = YES;
    BOOL onlyDouble = YES;

    BOOL hasDot = NO;
    BOOL hasLeadingZero = NO;
    BOOL hasXatSecondPos = NO;
    BOOL startsWithDoubleQuote = NO;
    BOOL endsWithDoubleQuote = NO;
    BOOL startsWithSingleQuote = NO;
    BOOL endsWithSingleQuote = NO;
    BOOL endsWithLL = NO;

    if([self isEqualToString:@"YES"] || [self isEqualToString:@"true"])
    {
        return [UMDiscreteValue discreteYES];
    }
    if([self isEqualToString:@"NO"] || [self isEqualToString:@"false"])
    {
        return [UMDiscreteValue discreteNO];
    }

    for(size_t i=0;i<len;i++)
    {
        char c = digits[i];
        if((i==0) && (c=='0') && (len > 1))
        {
            hasLeadingZero = YES;
        }
        if((i==1) && ((c=='x') || (c=='X')))
        {
            hasXatSecondPos = YES;
        }
        if((i==0) && (c=='"'))
        {
            startsWithDoubleQuote = YES;
        }
        if((len > 1) && (i==(len-1)) && (c=='"'))
        {
            endsWithDoubleQuote = YES;
        }
        if((i==0) && (c=='\''))
        {
            startsWithSingleQuote = YES;
        }
        if((len > 1) && (i==(len-1)) && (c=='\''))
        {
            endsWithSingleQuote = YES;
        }
        if((i==(len-2)) && (c=='L') && (digits[len-1] == 'L'))
        {
            endsWithLL = YES;
            break; /* we dont want the LL to be processed */
        }
        if(!isdigit(c))
        {
            onlyDigits = NO;
            if(c!='.')
            {
                onlyDouble = NO;
            }
        }
        if((i>1) && (!isxdigit(c)))
        {
            onlyHex = NO;
        }
        if((i>0) && ((c<'0') || (c>'7')))
        {
            onlyOcto = NO;
        }
        if(c=='.')
        {
            hasDot = YES;
        }
    }

    if(startsWithDoubleQuote && endsWithDoubleQuote)
    {
        /* FIXME: we should probably parse things like \t or \n here ? what about \" ? */
        NSString *s = [self substringWithRange:NSMakeRange(1,len-2)];
        return [UMDiscreteValue discreteString:s];
    }
    if(startsWithSingleQuote && endsWithSingleQuote)
    {
        int value = 0;
        for(size_t i=1;i<(len-1);i++)
        {
            value = (value * 256) + (digits[i]);
        }
        return [UMDiscreteValue discreteInt:value];
    }
    if(endsWithLL)
    {
        NSString *s = [self substringWithRange:NSMakeRange(0,len-2)];
        digits = (const unsigned char *)s.UTF8String;
        len = len - 2;
    }

    if((onlyDigits==YES) && (hasLeadingZero==NO) && (endsWithLL==NO))
    {
        if(endsWithLL)
        {
            return [UMDiscreteValue discreteLongLong:atoll((const char *)digits)];
        }
        else
        {
            return [UMDiscreteValue discreteInt:atoi((const char *)digits)];
        }
    }
    if((onlyOcto==YES) && (hasLeadingZero == YES))
    {
        long long value = 0;
        for(size_t i=1;i<len;i++)
        {
            value = (value * 8) + (digits[i]-'0');
        }
        if(endsWithLL)
        {
            return [UMDiscreteValue discreteLongLong:value];
        }
        else
        {
            return [UMDiscreteValue discreteInt:(int)value];
        }
    }
    if((onlyHex) && (hasLeadingZero == YES) && (hasXatSecondPos==YES))
    {
        long long value = 0;
        for(int i=2;i<len;i++)
        {
            char c = digits[i];
            if((c >='0') && (c<='9'))
            {
                value = (value * 16) + (digits[i]-'0');
            }
            else if((c >='a') && (c<='f'))
            {
                value = (value * 16) + (digits[i]-'a'+10);
            }
            else if((c >='A') && (c<='F'))
            {
                value = (value * 16) + (digits[i]-'A'+10);
            }
        }
        if(endsWithLL)
        {
            return [UMDiscreteValue discreteLongLong:value];
        }
        else
        {
            return [UMDiscreteValue discreteInt:(int)value];
        }
    }
    return [UMDiscreteValue discreteNull];
}

@end
