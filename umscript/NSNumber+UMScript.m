//
//  NSNumber+UMScript.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "NSNumber+UMScript.h"

@implementation NSNumber(UMScript)


+(NSNumber *)numberWithString:(NSString *)s
{
    if(s==NULL)
    {
        return @0;
    }
    if([s isEqualToString:@"YES"])
    {
        return @YES;
    }
    if([s isEqualToString:@"NO"])
    {
        return @NO;
    }
    if([s isEqualToString:@""])
    {
        return @0;
    }
    const char *c = [s UTF8String];
    size_t i;
    size_t n = strlen(c);
    int digitSeen = 0;
    int dotSeen = 0;
    int hexDigitSeen = 0;
    int minusOrPlusSeen = 0;
    int commaSeen = 0;
    int quotesSeen = 0;
    int whitespaceSeen = 0;
    int alphaSeen = 0;
    for(i=0;i<n;i++)
    {
        switch(c[i])
        {
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                digitSeen++;
                break;
            case 'a':
            case 'A':
            case 'b':
            case 'B':
            case 'c':
            case 'C':
            case 'd':
            case 'D':
            case 'e':
            case 'E':
            case 'f':
            case 'F':
                hexDigitSeen++;
                break;

            case '.':
                dotSeen++;
                break;
            case ',':
                commaSeen++;
                break;
            case '+':
            case '-':
                minusOrPlusSeen++;
                break;
            case '"':
            case '\'':
                quotesSeen++;
                break;
                
            case ' ':
            case '\r':
            case '\n':
            case '\t':
                whitespaceSeen++;
                break;
            default:
                alphaSeen++;
                break;
                
        }
    }
    
    if(digitSeen && !dotSeen)
    {
        if(minusOrPlusSeen)
        {
            long long v;
            sscanf(c,"%lld",&v);
            if(v < 0x7F)
            {
                return @((char)v);
            }
            if(v < 0x7FFF)
            {
                return @((short)v);
            }
            if(v < 0x7FFFFFFF)
            {
                return @((int)v);
            }
            return @(v);
        }
        else
        {
            unsigned long long v;
            sscanf(c,"%llu",&v);
            if(v <= 0xFF)
            {
                return @((unsigned char)v);
            }
            if(v <= 0xFFFF)
            {
                return @((unsigned short)v);
            }
            if(v <= 0xFFFFFFFF)
            {
                return @((unsigned int)v);
            }
            return @(v);
        }
    }
    if(digitSeen && dotSeen)
    {
        double d;
        sscanf(c,"%lf",&d);
        return @(d);
    }
    int iv;
    sscanf(c,"%d",&iv);
    return @(iv);
}

@end
