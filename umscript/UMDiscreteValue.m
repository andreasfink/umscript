//
//  UMDiscreteValue.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMDiscreteValue.h"
#import "UMEnvironment.h"

@implementation UMDiscreteValue

@synthesize type;
@synthesize value;

- (void) processBeforeEncode
{
    [super processBeforeEncode];

    asn1_tag.tagClass = UMASN1Class_ContextSpecific;
    asn1_tag.isConstructed=NO;

    switch(type)
    {
        case UMVALUE_NULL:
        {
            self.asn1_tag.tagNumber = 0;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            [asn1_list addObject:[[UMASN1Null alloc]init]];
            break;
        }
        case UMVALUE_BOOL:
        {
            self.asn1_tag.tagNumber = 1;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1Boolean *b = [[UMASN1Boolean alloc]initWithValue:[value booleanValue]];
            [asn1_list addObject:b];
            break;
        }
        case UMVALUE_INT:
        {
            self.asn1_tag.tagNumber = 2;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1Integer *i = [[UMASN1Integer alloc]initWithValue:[value integerValue]];
            [asn1_list addObject:i];
            break;
        }
        case UMVALUE_LONGLONG:
        {
            self.asn1_tag.tagNumber = 3;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1Integer *i = [[UMASN1Integer alloc]initWithValue:[value longLongValue]];
            [asn1_list addObject:i];
            break;
        }
        case UMVALUE_DOUBLE:
        {
            self.asn1_tag.tagNumber = 4;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *i = [[UMASN1UTF8String alloc]initWithValue:[value stringValue]];
            [asn1_list addObject:i];
            break;
        }
        case UMVALUE_STRING:
        {
            self.asn1_tag.tagNumber = 5;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *s = [[UMASN1UTF8String alloc]initWithValue:[value stringValue]];
            [asn1_list addObject:s];
            break;
        }
        case UMVALUE_ARRAY:
        {
            self.asn1_tag.tagNumber = 6;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            NSArray *a = (NSArray *)value;
            NSInteger n = [a count];
            for(NSInteger i=0;i<n;i++)
            {
                UMDiscreteValue *x = a[i];
                [asn1_list addObject:x];
            }
            break;
        }
        case UMVALUE_STRUCT:
        {
            self.asn1_tag.tagNumber = 6;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            NSDictionary *dict = (NSDictionary *)value;
            NSArray *allKeys = [dict allKeys];
            NSInteger n = [allKeys count];
            for(NSInteger i=0;i<n;i++)
            {
                NSString        *key   = allKeys[i];
                UMDiscreteValue *xvalue = dict[key];
                UMASN1UTF8String *uKey = [[UMASN1UTF8String alloc]initWithValue:[xvalue stringValue]];
                UMASN1Sequence *seq = [[UMASN1Sequence alloc]init];
                [seq setValues:@[uKey,xvalue]];
                [asn1_list addObject:seq];
            }
            break;
        }
        case UMVALUE_DATA:
        default:
        {
            self.asn1_tag.tagNumber = 6;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1OctetString *d = [[UMASN1OctetString alloc]initWithValue:(NSData *)value];
            [asn1_list addObject:d];
            break;
        }
    }
}


- (UMDiscreteValue *) processAfterDecodeWithContext:(id)context
{
    int p=0;
    UMASN1Object *o = NULL;
    if(self.asn1_tag.tagClass == UMASN1Class_ContextSpecific)
    {
        o = [self getObjectAtPosition:p++];
        if(o)
        {
            switch(o.asn1_tag.tagNumber)
            {
                case 0:
                {
                    type = UMVALUE_NULL;
                    value = NULL;
                    return self;
                }
                case 1:
                {
                    type = UMVALUE_BOOL;
                    UMASN1Boolean *b = [[UMASN1Boolean alloc]initWithASN1Object:o context:context];
                    if(b.isTrue)
                    {
                        value = @(YES);
                    }
                    else
                    {
                        value = @(NO);
                    }
                    return self;
                }
                case 2:
                {
                    type = UMVALUE_INT;
                    UMASN1Integer *i = [[UMASN1Integer alloc]initWithASN1Object:o context:context];
                    value = @( (int)i.value);
                    return self;
                }
                case 3:
                {
                    type = UMVALUE_LONGLONG;
                    type = UMVALUE_INT;
                    UMASN1Integer *i = [[UMASN1Integer alloc]initWithASN1Object:o context:context];
                    value = @( (long long)i.value);
                    return self;
                }
                case 4:
                {
                    type = UMVALUE_DOUBLE;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    NSString *s = utf8.stringValue;
                    value = @(s.doubleValue);
                    return self;
                }
                case 5:
                {
                    type = UMVALUE_STRING;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    value = utf8.stringValue;
                    return self;
                }
                case 6:
                {
                    type = UMVALUE_DATA;
                    UMASN1OctetString *os = [[UMASN1OctetString alloc]initWithASN1Object:o context:context];
                    value = os.value;
                    return self;
                }
                case 7:
                {
                    type = UMVALUE_ARRAY;
                    UMASN1Sequence *os = [[UMASN1Sequence alloc]initWithASN1Object:o context:context];
                    NSArray *arr = os.values;
                    NSMutableArray *marr = [[NSMutableArray alloc]init];
                    NSUInteger n = [arr count];
                    for(NSUInteger i =0;i<n;i++)
                    {
                        UMASN1Object *o = arr[i];
                        UMDiscreteValue *ds = [[UMDiscreteValue alloc]initWithASN1Object:o context:context];
                        if(ds)
                        {
                            [marr addObject:ds];
                        }
                    }
                    value = marr;
                    return self;
                }
                case 8:
                {
                    type = UMVALUE_STRUCT;
                    UMASN1Sequence *os = [[UMASN1Sequence alloc]initWithASN1Object:o context:context];
                    NSArray *arr = os.values;
                    NSMutableDictionary *mdict = [[NSMutableDictionary alloc]init];
                    NSUInteger n = [arr count];
                    for(NSUInteger i =0;i<n;i++)
                    {
                        UMASN1Sequence *o = arr[i];
                        NSArray *a2 = o.values;
                        if(a2.count <2)
                        {
                            continue;
                        }
                        UMASN1UTF8String *asn1_key = [[UMASN1UTF8String alloc]initWithASN1Object:a2[0] context:context];
                        NSString *key = asn1_key.stringValue;
                        UMDiscreteValue *xvalue = [[UMDiscreteValue alloc]initWithASN1Object:a2[1] context:context];
                        if((xvalue) && (key.length > 0))
                        {
                            mdict[key] = xvalue;
                        }
                    }
                    value = mdict;
                    return self;
                }
            }
        }
    }
    @throw([NSException exceptionWithName:@"INVALID_ASN1" reason:@"while decoding UMDiscreteValue, the type could not be decoded" userInfo:NULL]);
}

- (NSString *) objectName
{
    return @"UMDiscreteValue";
}


- (id) objectValue
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];

    switch(type)
    {
        case UMVALUE_NULL:
            dict[@"null"] = [NSNull null];
            break;
        case UMVALUE_BOOL:
            dict[@"bool"] = @([value boolValue]);
            break;
        case UMVALUE_INT:
            dict[@"int"] = @([value intValue]);
            break;
        case UMVALUE_LONGLONG:
            dict[@"longlong"] = @([value longLongValue]);
            break;
        case UMVALUE_DOUBLE:
            dict[@"double"] = @([value doubleValue]);
            break;
        case UMVALUE_STRING:
            dict[@"string"] = [value stringValue];
            break;
        case UMVALUE_ARRAY:
            dict[@"array"] = [(NSArray *)value copy];
            break;
        case UMVALUE_STRUCT:
            dict[@"struct"] = [(NSDictionary *)value copy];
            break;
        case UMVALUE_DATA:
            dict[@"data"] = [value dataValue];
            break;
        case UMVALUE_POINTER:
            dict[@"pointer"] = [value stringValue];
            break;
            
        case UMVALUE_CUSTOM_TYPE:
            /* FIXME */
            break;
    }
    return dict;
}


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
    if  (   ( (type == UMVALUE_INT)        && (btype==UMVALUE_DOUBLE) )
         || ( (type == UMVALUE_DOUBLE)     && (btype==UMVALUE_INT)      ) )
    {
        return UMVALUE_DOUBLE;
    }
    if  (   ( (type == UMVALUE_LONGLONG)    && (btype==UMVALUE_DOUBLE) )
         || ( (type == UMVALUE_DOUBLE)      && (btype==UMVALUE_LONGLONG)      ) )
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

- (UMDiscreteValue *)initWithInteger:(NSInteger)i
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

- (UMDiscreteValue *)initWithPointer:(NSString *)s;
{
    self = [super init];
    if(self)
    {
        type = UMVALUE_POINTER;
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


- (UMDiscreteValue *)initWithArray:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        type    = UMVALUE_ARRAY;
        value   = [array mutableCopy];
    }
    return self;
}

- (UMDiscreteValue *)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        type    = UMVALUE_STRUCT;
        value   = [dict mutableCopy];
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

+ (UMDiscreteValue *)discreteInteger:(NSInteger)ll;
{
    return [[UMDiscreteValue alloc]initWithInteger:ll];
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

+ (UMDiscreteValue *)discretePointer:(NSString *)s;
{
    return [[UMDiscreteValue alloc]initWithPointer:s];
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

+ (UMDiscreteValue *)discreteArray:(NSArray *)array
{
    return [[UMDiscreteValue alloc]initWithArray:array];
}

+ (UMDiscreteValue *)discreteDictionary:(NSDictionary *)dict
{
    return [[UMDiscreteValue alloc]initWithDictionary:dict];
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
        case UMVALUE_POINTER:
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
            return @"(null)";
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
        case UMVALUE_POINTER:
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
        case UMVALUE_POINTER:
        case UMVALUE_STRING:
        {
            NSString *s = value;
            return [s dataUsingEncoding:NSUTF8StringEncoding];
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
        case UMVALUE_POINTER:
        {
            NSString *s = value;
            if (s.length > 0)
            {
                return YES;
            }
            return NO;
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
        case UMVALUE_POINTER:
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
    else if ((type==UMVALUE_STRING) && (bval.isNumberType))
    {
        /* string multiplied by integer */
        int count = bval.intValue;
        UMDiscreteValue *result = [UMDiscreteValue discreteString:@""];
        for(int i=0;i<count;i++)
        {
            [result addValue:self.value];
        }
        return result;
    }
    /* no idea how to multiply data and strings */
    return [UMDiscreteValue discreteNull];
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

- (UMDiscreteValue *)arrayAccess:(UMDiscreteValue *)bval
{
    NSNumber *bnum = [bval convertToInt].value;
    NSMutableArray *arr = (NSMutableArray *)value;
    return  arr[bnum.intValue];
}
                           
- (UMDiscreteValue *)structAccess:(UMDiscreteValue *)bval
{
    NSString *key = [bval convertToString].value;
    NSMutableDictionary *dict = (NSMutableDictionary *)value;
    return  dict[key];
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
            BOOL c =  YES;
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
            BOOL c = NO;
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
