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

    size_t len = [self length]; /* this might be a UTF8 string with foreign characters. So strlen wont work */

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
    NSString *digits;

    if([self isEqualToString:@"YES"] || [self isEqualToString:@"true"])
    {
        return [UMDiscreteValue discreteYES];
    }
    if([self isEqualToString:@"NO"] || [self isEqualToString:@"false"])
    {
        return [UMDiscreteValue discreteNO];
    }
    if([self isEqualToString:@"nil"] || [self isEqualToString:@"NULL"])
    {
        return [UMDiscreteValue discreteNull];
    }
    unichar previous='\0';
    unichar c='\0';
    /*unichar last='\0';
    unichar preLast='\0';
    unichar first='\0';
    unichar second='\0';*/
    /*
    if(len >= 1)
    {
        //last = [self characterAtIndex:len-1];
        //first = [self characterAtIndex:0];
    }
    if(len >= 2)
    {
        //preLast = [self characterAtIndex:len-2];
        //second = [self characterAtIndex:1];
    }
*/
    for(size_t i=0;i<len;i++)
    {
        previous = c;
        c = [self characterAtIndex:i];
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
        if((i==(len-2)) && (c=='L') && (previous == 'L'))
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

    if((startsWithDoubleQuote && endsWithDoubleQuote) && (len>=2))
    {
        NSString *s = [self substringWithRange:NSMakeRange(1,len-2)];
        return [UMDiscreteValue discreteString:s];
    }
    if(startsWithSingleQuote && endsWithSingleQuote)
    {
        NSString *s = [self substringWithRange:NSMakeRange(1,len-2)];
        return [UMDiscreteValue discreteString:s];
/* what was this ?!
        int value = 0;
        for(size_t i=1;i<(len-1);i++)
        {
            unichar c = [self characterAtIndex:i];
            value = (value * 256) + c;
        }
        return [UMDiscreteValue discreteInt:value];
 */
    }
    if(endsWithLL)
    {
        digits = [self substringWithRange:NSMakeRange(0,len-2)];
        len = len - 2;
    }
    else
    {
        digits = [self copy];
    }

    if((onlyDigits==YES) && (hasLeadingZero==NO) && (hasDot == NO))
    {
        if(endsWithLL)
        {
            return [UMDiscreteValue discreteLongLong:atoll((const char *)digits.UTF8String)];
        }
        else
        {
            return [UMDiscreteValue discreteInt:atoi((const char *)digits.UTF8String)];
        }
    }
    if((onlyOcto==YES) && (hasLeadingZero == YES) && (hasDot == NO))
    {
        long long value = 0;
        for(size_t i=1;i<len;i++)
        {
            unichar c = [self characterAtIndex:i];
            value = (value * 8) + (c-'0');
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
            unichar c = [self characterAtIndex:i];
            if((c >='0') && (c<='9'))
            {
                value = (value * 16) + (c-'0');
            }
            else if((c >='a') && (c<='f'))
            {
                value = (value * 16) + (c-'a'+10);
            }
            else if((c >='A') && (c<='F'))
            {
                value = (value * 16) + (c-'A'+10);
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
    if(onlyDouble && hasDot)
    {
        double d = atof((const char *)digits.UTF8String);
        return [UMDiscreteValue discreteDouble:d];

    }
    return NULL;
}

@end
