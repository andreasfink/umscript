//
//  UMDiscreteValue.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMDiscreteValue.h"
#import "UMEnvironment.h"

@implementation UMDiscreteValue

@synthesize type;
@synthesize value;

- (UMDiscreteValueType)outputType:(UMDiscreteValueType)btype
{
    if(type == btype)
    {
       return type;
    }
    if  (   ( (type == UMVALUE_INT)       && (btype==UMVALUE_LONGLONG) )
         || ( (type == UMVALUE_LONGLONG)  && (btype==UMVALUE_INT)      ) )
    {
       return UMVALUE_LONGLONG;
    }
    if  (   ( (type == UMVALUE_INT)       && (btype==UMVALUE_DOUBLE) )
         || ( (type == UMVALUE_DOUBLE)  && (btype==UMVALUE_INT)      ) )
    {
        return UMVALUE_DOUBLE;
    }
    if  (   ( (type == UMVALUE_LONGLONG)       && (btype==UMVALUE_DOUBLE) )
         || ( (type == UMVALUE_DOUBLE)  && (btype==UMVALUE_LONGLONG)      ) )
    {
        return UMVALUE_DOUBLE;
    }
    return type;
}

- (UMDiscreteValue *)init
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_NULL;
    }
    return self;
}

- (UMDiscreteValue *)initWithBool:(BOOL)b
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_BOOL;
        value = @(b);
    }
    return self;
}

- (UMDiscreteValue *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_INT;
        value = @(i);
    }
    return self;

}

- (UMDiscreteValue *)initWithLongLong:(long long)ll
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_LONGLONG;
        value = @(ll);
    }
    return self;
 
}
- (UMDiscreteValue *)initWithDouble:(double)d
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_DOUBLE;
        value = @(d);
    }
    return self;

}

- (UMDiscreteValue *)initWithString:(NSString *)s;
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_STRING;
        value = s;
    }
    return self;
}

- (UMDiscreteValue *)initWithNumberString:(NSString *)numberString
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_INT;
        int i = atoi(numberString.UTF8String);
        /* FIXME: we must return other types if the string indicates its a long long or a double */
        value = @(i);
    }
    return self;
}



- (UMDiscreteValue *)initWithData:(NSString *)d;
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_DATA;
        value = d;
    }
    return self;
}


+ (UMDiscreteValue *)discreteYES
{
    return [[UMDiscreteValue alloc]initWithBool:YES];
}

+ (UMDiscreteValue *)discreteNO
{
    return [[UMDiscreteValue alloc]initWithBool:NO];
}


+ (UMDiscreteValue *)discreteBool:(BOOL)b
{
    return [[UMDiscreteValue alloc]initWithBool:b];
}

+ (UMDiscreteValue *)discreteInt:(int)i;
{
    return [[UMDiscreteValue alloc]initWithInt:i];
}

+ (UMDiscreteValue *)discreteLongLong:(long long)ll;
{
    return [[UMDiscreteValue alloc]initWithLongLong:ll];
}
+ (UMDiscreteValue *)discreteDouble:(double)d;
{
    return [[UMDiscreteValue alloc]initWithDouble:d];
}
+ (UMDiscreteValue *)discreteString:(NSString *)s;
{
    return [[UMDiscreteValue alloc]initWithString:s];
}

+ (UMDiscreteValue *)discreteQuotedString:(NSString *)s;
{
    NSUInteger start = 1;
    NSUInteger len = s.length - 2;
    /* TODO: we should not only remove quotes at beginning and end, we should also take care of escape sequences */
    
    return [[UMDiscreteValue alloc]initWithString:[s substringWithRange:NSMakeRange(start,len)]];
}

+ (UMDiscreteValue *)discreteData:(NSData *)data;
{
    return [[UMDiscreteValue alloc]initWithData:data];
}
+ (UMDiscreteValue *)discreteNull;
{
    return [[UMDiscreteValue alloc]init];
}

+ (UMDiscreteValue *)discreteNumberString:(NSString *)numberString;
{
    return [[UMDiscreteValue alloc]initWithNumberString:numberString];
}


- (BOOL)isNull
{
    if(type==UMVALUE_NULL)
        return YES;
    return NO;
}

- (int)intValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return 0;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)value) intValue];
        case UMVALUE_STRING:
        {
            int i;
            sscanf([((NSString *)value)  UTF8String],"%d",&i);
            return i;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (int)c[0];
        }
        default:
            return 0;
    }
}

- (NSString *)stringValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return @"NULL";
        case UMVALUE_BOOL:
            if([self boolValue])
            {
                return @"YES";
            }
            else
            {
                return @"NO";
            }
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)value) stringValue];
        case UMVALUE_STRING:
            return value;
        case UMVALUE_DATA:
            return [[NSString alloc] initWithData:(NSData *)value encoding:NSUTF8StringEncoding];
        default:
            return @"";
    }
}

- (NSData *)dataValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return [NSData data];
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
        {
            NSNumber *n = value;
            unsigned char c = [n unsignedCharValue];
            return [NSData dataWithBytes:&c length:1];
        }
        case UMVALUE_STRING:
        {
            NSString *s = value;
            const char *c = [s UTF8String];
            size_t len = strlen(c);
            return [NSData dataWithBytes:c length:len];
        }
        case UMVALUE_DATA:
            return value;
        default:
            return [NSData data];
    }
  
}

- (BOOL) boolValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return NO;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)value) boolValue];
        case UMVALUE_STRING:
        {
            if (([value isEqualToString:@"YES"]) ||  ([value isEqualToString:@"true"]))
            {
                return YES;
            }
            if (([value isEqualToString:@"NO"]) ||  ([value isEqualToString:@"false"]))
            {
                return NO;
            }
            int i;
            sscanf([((NSString *)value)  UTF8String],"%d",&i);
            return i ? YES : NO;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)value;
            unsigned char *c = (unsigned char *)[d bytes];
            return c[0] ? YES : NO;
        }
        default:
            return NO;
    }
}

- (UMDiscreteValue *) notValue
{
    return [UMDiscreteValue discreteBool:![self boolValue]];
}

- (double) doubleValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return 0.0;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)value) doubleValue];
        case UMVALUE_STRING:
        {
            double d;
            sscanf([((NSString *)value)  UTF8String],"%lf",&d);
            return d;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (double)c[0];
        }
        default:
            return 0.0;
    }
}

- (long long)longLongValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return 0LL;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)value) longLongValue];
        case UMVALUE_STRING:
        {
            long long i;
            sscanf([((NSString *)value)  UTF8String],"%lld",&i);
            return i;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (long long)c[0];
        }
        default:
            return 0LL;
    }
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    return self;
}

-(BOOL) isNumberType
{
    if((type==UMVALUE_BOOL) || (type==UMVALUE_INT) || (type==UMVALUE_LONGLONG) || (type==UMVALUE_DOUBLE))
    {
        return YES;
    }
    return NO;

}

- (UMDiscreteValue *)discreteIsEqualTo:(UMDiscreteValue *)bval
{
    BOOL r;
    if((type==UMVALUE_NULL) || (bval.type==UMVALUE_NULL))
    {
        r = (type == bval.type);
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        r = [value isEqualToValue:bval.value];
    }
    else if((type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        r = [value isEqualToString:bval.value];
    }
    else if((type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        r = [value isEqualToData:bval.value];
    }
    else
    {
        NSString *a = [self stringValue];
        NSString *b = [bval stringValue];
        r = [a isEqualToString:b];
    }
    UMDiscreteValue *result = [UMDiscreteValue discreteBool:r];
    return result;
}

- (UMDiscreteValue *)discreteIsNotEqualTo:(UMDiscreteValue *)bval
{
    UMDiscreteValue *result = [self discreteIsEqualTo:(UMDiscreteValue *)bval];
    return [result notValue];
}

- (UMDiscreteValue *)discreteIsGreaterThan:(UMDiscreteValue *)bval
{
    if((type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
    else if((type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
    else if((type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        NSData *a = self.value;
        NSData *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
    else
    {
        NSString *a = [self stringValue];
        NSString *b = [bval stringValue];
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
}

- (UMDiscreteValue *)discreteIsGreaterThanOrEqualTo:(UMDiscreteValue *)bval
{
    if((type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
    else if((type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
    else if((type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        NSData *a = self.value;
        NSData *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
    else
    {
        NSString *a = [self stringValue];
        NSString *b = [bval stringValue];
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
}

- (UMDiscreteValue *)discreteIsLessThan:(UMDiscreteValue *)bval
{
    if((type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
    else if((type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
    else if((type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        NSData *a = self.value;
        NSData *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
    else
    {
        NSString *a = [self stringValue];
        NSString *b = [bval stringValue];
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
}

- (UMDiscreteValue *)discreteIsLessThanOrEqualTo:(UMDiscreteValue *)bval
{
    if((type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
    else if((type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
    else if((type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        NSData *a = self.value;
        NSData *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
    else
    {
        NSString *a = [self stringValue];
        NSString *b = [bval stringValue];
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
}

- (NSString *)description
{
    switch(type)
    {
        case UMVALUE_NULL:
            return @"(null)";
        case UMVALUE_BOOL:
            return [NSString stringWithFormat:@"(BOOL)%@",self.boolValue ? @"YES" : @"NO"];
        case UMVALUE_INT:
            return [NSString stringWithFormat:@"(int)%d",self.intValue];
        case UMVALUE_LONGLONG:
            return [NSString stringWithFormat:@"(long long)%lld",self.longLongValue];
        case UMVALUE_DOUBLE:
            return [NSString stringWithFormat:@"(double)%lf",self.doubleValue];
        case UMVALUE_STRING:
            return [NSString stringWithFormat:@"(string)%@",self.stringValue];
        case UMVALUE_DATA:
            return [NSString stringWithFormat:@"(data)%@",self.dataValue];
        default:
            return @"(unknown)";
    }
}

- (id)descriptionDictVal
{
    switch(type)
    {
        case UMVALUE_NULL:
            return [NSNull null];
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return (NSNumber *)value;
        case UMVALUE_STRING:
            return (NSString *)value;
        case UMVALUE_DATA:
            return (NSData *)value;
        default:
            return [NSNull null];
    }
}

- (NSString *)labelValue
{
    switch(type)
    {
        case UMVALUE_NULL:
            return @"(null)";
        case UMVALUE_BOOL:
            return [NSString stringWithFormat:@"(bool)%@",self.boolValue ? @"YES" : @"NO"];
        case UMVALUE_INT:
            return [NSString stringWithFormat:@"(number)%d",self.intValue];
        case UMVALUE_LONGLONG:
            return [NSString stringWithFormat:@"(number)%lld",self.longLongValue];
        case UMVALUE_DOUBLE:
            return [NSString stringWithFormat:@"(number)%lf",self.doubleValue];
        case UMVALUE_STRING:
            return [NSString stringWithFormat:@"(string)%@",self.stringValue];
        case UMVALUE_DATA:
            return [NSString stringWithFormat:@"(data)%@",self.dataValue.hexString];
        default:
            return @"(unknown)";
    }
}

- (UMDiscreteValue *)addValue:(UMDiscreteValue *)bval
{
    UMDiscreteValueType t = [self outputType:bval.type];

    if(t==UMVALUE_BOOL)
    {
       NSNumber *a = self.value;
       NSNumber *b = bval.value;
       BOOL c = a.boolValue + b.boolValue;
       return [UMDiscreteValue discreteBool:c];
    }
    
    else if(type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        int c = a.intValue + b.intValue;
       return [UMDiscreteValue discreteInt:c];
    }
    else if(type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        long long c = a.longLongValue + b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(type==UMVALUE_DOUBLE)
    {
         NSNumber *a = self.value;
         NSNumber *b = bval.value;
         double c = a.doubleValue + b.doubleValue;
         return [UMDiscreteValue discreteDouble:c];
    }
    else if(type==UMVALUE_STRING)
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        NSString *c = [a stringByAppendingString:b];
        return [UMDiscreteValue discreteString:c];
    }
    else if(type==UMVALUE_DATA)
    {
        NSData *a = self.value;
        NSData *b = bval.value;
        NSMutableData *c = [a mutableCopy];
        [c appendData:b];
        return [UMDiscreteValue discreteData:c];
    }

    else
    {
        return [UMDiscreteValue discreteNull];
    }
}


- (UMDiscreteValue *)subtractValue:(UMDiscreteValue *)bval
{
    UMDiscreteValueType t = [self outputType:bval.type];

    if(t==UMVALUE_BOOL)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        BOOL c = a.boolValue - b.boolValue;
        return [UMDiscreteValue discreteBool:c];
    }

    else if(type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        int c = a.intValue - b.intValue;
        return [UMDiscreteValue discreteInt:c];
    }
    else if(type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        long long c = a.longLongValue - b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(type==UMVALUE_DOUBLE)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        double c = a.doubleValue - b.doubleValue;
        return [UMDiscreteValue discreteDouble:c];
    }
    else
    {
        return [UMDiscreteValue discreteNull];
    }
}


- (UMDiscreteValue *)multiplyValue:(UMDiscreteValue *)bval
{
    if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        if(type==UMVALUE_BOOL)
        {
            BOOL c = a.boolValue * b.boolValue;
            return [UMDiscreteValue discreteBool:c];
        }
        if(type==UMVALUE_INT)
        {
            int c = a.intValue * b.intValue;
            return [UMDiscreteValue discreteInt:c];
        }
        if(type==UMVALUE_LONGLONG)
        {
            long long c = a.longLongValue * b.longLongValue;
            return [UMDiscreteValue discreteLongLong:c];
        }
        else
        {
            double c = a.doubleValue * b.doubleValue;
            return [UMDiscreteValue discreteDouble:c];
        }
    }
    else
    {
        /* no idea how to multiply data and strings */
        return [UMDiscreteValue discreteNull];
    }
}

- (UMDiscreteValue *)divideValue:(UMDiscreteValue *)bval
{
    if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;

        if(type==UMVALUE_BOOL)
        {
            if(b.boolValue == NO)
            {
                return [UMDiscreteValue discreteNull];
            }
            else
            {
                return [UMDiscreteValue discreteBool:a.boolValue];
            }
        }
        if(type==UMVALUE_INT)
        {
            int c = a.intValue / b.intValue;
            return [UMDiscreteValue discreteInt:c];
        }
        if(type==UMVALUE_LONGLONG)
        {
            long long c = a.longLongValue / b.longLongValue;
            return [UMDiscreteValue discreteLongLong:c];
        }
        else
        {
            double c = a.doubleValue / b.doubleValue;
            return [UMDiscreteValue discreteDouble:c];
        }
    }
    else
    {
        /* no idea how to divide strings */
        return [UMDiscreteValue discreteNull];
    }
}


- (UMDiscreteValue *)dotValue:(UMDiscreteValue *)bval
{
    if((self.type==UMVALUE_STRING) && (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        NSString *c = [a stringByAppendingString:b];
        
        return [UMDiscreteValue discreteString:c];
    }
    else if((self.type==UMVALUE_DATA) && (bval.type==UMVALUE_DATA))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        NSString *c = [a stringByAppendingString:b];
        
        return [UMDiscreteValue discreteString:c];
    }
    else
    {
        /* no idea how to divide strings */
        return [UMDiscreteValue discreteNull];
    }
}

- (UMDiscreteValue *)percentValue:(UMDiscreteValue *)bval
{
    if(type==UMVALUE_BOOL)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToBool].value;
        BOOL c = a.boolValue % b.boolValue;
        return [UMDiscreteValue discreteBool:c];
    }
    else if(type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToInt].value;
        int c = a.intValue % b.intValue;
        return [UMDiscreteValue discreteInt:c];
    }
    else if(type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToLongLong].value;
        long long  c = a.longLongValue % b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(type==UMVALUE_DOUBLE)
    {
        NSNumber *a = [self convertToLongLong].value;
        NSNumber *b = [bval convertToLongLong].value;
        long long  c = a.longLongValue % b.longLongValue;
        return [UMDiscreteValue discreteLongLong:(double)c];
    }
    else
    {
        /* no idea how to divide strings */
        return [UMDiscreteValue discreteNull];
    }
}

- (UMDiscreteValue *)convertToBool
{
    if(type ==UMVALUE_BOOL)
    {
        return self;
    }
    return [UMDiscreteValue discreteBool:[self boolValue]];
}

- (UMDiscreteValue *)convertToInt
{
    if(type ==UMVALUE_INT)
    {
        return self;
    }
    return [UMDiscreteValue discreteInt:[self intValue]];
}

- (UMDiscreteValue *)convertToLongLong
{
    if(type == UMVALUE_LONGLONG)
    {
        return self;
    }
    return [UMDiscreteValue discreteLongLong:[self longLongValue]];
}

- (UMDiscreteValue *)convertToDouble
{
    if(type == UMVALUE_DOUBLE)
    {
        return self;
    }
    return [UMDiscreteValue discreteDouble:[self doubleValue]];
}

- (UMDiscreteValue *)convertToString
{
    if(type == UMVALUE_STRING)
    {
        return self;
    }
    return [UMDiscreteValue discreteString:[self stringValue]];
}

- (UMDiscreteValue *)convertToData
{
    if(type == UMVALUE_DATA)
    {
        return self;
    }
    return [UMDiscreteValue discreteData:[self dataValue]];
}

- (UMDiscreteValue *)logicAnd:(UMDiscreteValue *)bval
{
    NSNumber *anum = [self convertToBool].value;
    NSNumber *bnum = [bval convertToBool].value;
    BOOL a = [anum boolValue];
    BOOL b = [bnum boolValue];
    BOOL c = a && b;
    return [UMDiscreteValue discreteBool:c];

}
- (UMDiscreteValue *)logicOr:(UMDiscreteValue *)bval
{
    NSNumber *anum = [self convertToBool].value;
    NSNumber *bnum = [bval convertToBool].value;
    BOOL a = [anum boolValue];
    BOOL b = [bnum boolValue];
    BOOL c = a || b;
    return [UMDiscreteValue discreteBool:c];
}

- (UMDiscreteValue *)logicXor:(UMDiscreteValue *)bval
{
    NSNumber *anum = [self convertToBool].value;
    NSNumber *bnum = [bval convertToBool].value;
    BOOL a = [anum boolValue];
    BOOL b = [bnum boolValue];
    BOOL c = b ? !a : a;
    return [UMDiscreteValue discreteBool:c];
}

- (UMDiscreteValue *)logicNot
{
    NSNumber *anum = [self convertToBool].value;
    BOOL a = [anum boolValue];
    BOOL c = !a;
    return [UMDiscreteValue discreteBool:c];

}

- (UMDiscreteValue *)bitAnd:(UMDiscreteValue *)bval
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        NSNumber *bnum = [bval convertToLongLong].value;
        long long a = [anum longLongValue];
        long long b = [bnum longLongValue];
        long long c = a & b;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        NSNumber *bnum = [bval convertToInt].value;
        int a = [anum intValue];
        int b = [bnum intValue];
        int c = a & b;
        return [UMDiscreteValue discreteInt:c];
    }
}
- (UMDiscreteValue *)bitOr:(UMDiscreteValue *)bval
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        NSNumber *bnum = [bval convertToLongLong].value;
        long long a = [anum longLongValue];
        long long b = [bnum longLongValue];
        long long c = a | b;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        NSNumber *bnum = [bval convertToInt].value;
        int a = [anum intValue];
        int b = [bnum intValue];
        int c = a | b;
        return [UMDiscreteValue discreteInt:c];
    }
}

- (UMDiscreteValue *)bitXor:(UMDiscreteValue *)bval
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        NSNumber *bnum = [bval convertToLongLong].value;
        long long a = [anum longLongValue];
        long long b = [bnum longLongValue];
        long long c = a ^ b;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        NSNumber *bnum = [bval convertToInt].value;
        int a = [anum intValue];
        int b = [bnum intValue];
        int c = a ^ b;
        return [UMDiscreteValue discreteInt:c];
    }
}

- (UMDiscreteValue *)bitNot
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        long long a = [anum longLongValue];
        long long c = ~a;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        int a = [anum intValue];
        int c = ~a;
        return [UMDiscreteValue discreteInt:c];
    }
}

- (UMDiscreteValue *)bitShiftLeft:(UMDiscreteValue *)bval
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        NSNumber *bnum = [bval convertToLongLong].value;
        long long a = [anum longLongValue];
        long long b = [bnum longLongValue];
        long long c = a << b;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        NSNumber *bnum = [bval convertToInt].value;
        int a = [anum intValue];
        int b = [bnum intValue];
        int c = a << b;
        return [UMDiscreteValue discreteInt:c];
    }
  
}

- (UMDiscreteValue *)bitShiftRight:(UMDiscreteValue *)bval
{
    if(type == UMVALUE_LONGLONG)
    {
        NSNumber *anum = self.value;
        NSNumber *bnum = [bval convertToLongLong].value;
        long long a = [anum longLongValue];
        long long b = [bnum longLongValue];
        long long c = a >> b;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else
    {
        NSNumber *anum = [self convertToInt].value;
        NSNumber *bnum = [bval convertToInt].value;
        int a = [anum intValue];
        int b = [bnum intValue];
        int c = a >> b;
        return [UMDiscreteValue discreteInt:c];
    }
}

- (NSString *)codeWithEnvironment:(UMEnvironment *)env
{
    if(type==UMVALUE_NULL)
    {
        return @"NULL";
    }
    else if (type==UMVALUE_BOOL)
    {
        if([self boolValue])
        {
            return @"YES";
        }
        else
        {
            return @"NO";
        }
    }
    else if ((type==UMVALUE_INT) || (type==UMVALUE_LONGLONG) || (type==UMVALUE_DOUBLE))
    {
        return [self stringValue];
    }
    else if(type == UMVALUE_STRING)
    {
        return [NSString stringWithFormat:@"\"%@\"",[self stringValue]];
    }
    else if(type == UMVALUE_DATA)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [s appendString:@"["];
        NSData *d = value;
        const unsigned char *bytes = [d bytes];
        size_t len = [d length];
        size_t i;
        for(i=0;i<len;i++)
        {
            if(i==0)
            {
                [s appendFormat:@"0x%02X",bytes[i]];
            }
            else
            {
                [s appendFormat:@",0x%02X",bytes[i]];
                
            }
        }
        [s appendString:@"]"];
        return s;
    }
    return @"/* unknown discreete type */";
}

- (UMDiscreteValue *)increase
{
    if(self.isNumberType)
    {
        NSNumber *a = self.value;
        if(type==UMVALUE_BOOL)
        {
            BOOL c = a.boolValue + TRUE;
            return [UMDiscreteValue discreteBool:c];
        }
        if(type==UMVALUE_INT)
        {
            int c = a.intValue + 1;
            return [UMDiscreteValue discreteInt:c];
        }
        if(type==UMVALUE_LONGLONG)
        {
            long long c = a.longLongValue + 1;
            return [UMDiscreteValue discreteLongLong:c];
        }
        else
        {
            double c = a.doubleValue + 1.0;
            return [UMDiscreteValue discreteDouble:c];
        }
    }
    else
    {
        return [UMDiscreteValue discreteNull];
    }
}



- (UMDiscreteValue *)decrease
{
    if(self.isNumberType)
    {
        NSNumber *a = self.value;
        if(type==UMVALUE_BOOL)
        {
            BOOL c = a.boolValue - TRUE;
            return [UMDiscreteValue discreteBool:c];
        }
        if(type==UMVALUE_INT)
        {
            int c = a.intValue - 1;
            return [UMDiscreteValue discreteInt:c];
        }
        if(type==UMVALUE_LONGLONG)
        {
            long long c = a.longLongValue - 1;
            return [UMDiscreteValue discreteLongLong:c];
        }
        else
        {
            double c = a.doubleValue - 1.0;
            return [UMDiscreteValue discreteDouble:c];
        }
    }
    else
    {
        return [UMDiscreteValue discreteNull];
    }
}

@end
