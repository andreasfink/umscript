//
//  UMDiscreteValue.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMDiscreteValue.h"
#import "UMEnvironment.h"
#import "UMTerm_Interrupt.h"

@implementation UMDiscreteValue

- (void) processBeforeEncode
{
    [super processBeforeEncode];

    _asn1_tag.tagClass = UMASN1Class_ContextSpecific;
    _asn1_tag.isConstructed=NO;

    switch(_type)
    {
        case UMVALUE_NULL:
        {
            _asn1_tag.tagNumber = UMVALUE_NULL;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            [_asn1_list addObject:[[UMASN1Null alloc]init]];
            break;
        }
        case UMVALUE_BOOL:
        {
            _asn1_tag.tagNumber = UMVALUE_BOOL;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1Boolean *b = [[UMASN1Boolean alloc]initWithValue:[_value boolValue]];
            [_asn1_list addObject:b];
            break;
        }
        case UMVALUE_INT:
        {
            _asn1_tag.tagNumber = UMVALUE_INT;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1Integer *i = [[UMASN1Integer alloc]initWithValue:[_value integerValue]];
            [_asn1_list addObject:i];
            break;
        }
        case UMVALUE_LONGLONG:
        {
            _asn1_tag.tagNumber = UMVALUE_LONGLONG;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1Integer *i = [[UMASN1Integer alloc]initWithValue:[_value longLongValue]];
            [_asn1_list addObject:i];
            break;
        }
        case UMVALUE_DOUBLE:
        {
            _asn1_tag.tagNumber = UMVALUE_DOUBLE;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *i = [[UMASN1UTF8String alloc]initWithValue:[_value stringValue]];
            [_asn1_list addObject:i];
            break;
        }
        case UMVALUE_STRING:
        {
            _asn1_tag.tagNumber = UMVALUE_STRING;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *s = [[UMASN1UTF8String alloc]initWithValue:[_value stringValue]];
            [_asn1_list addObject:s];
            break;
        }
        case UMVALUE_ARRAY:
        {
            _asn1_tag.tagNumber = UMVALUE_ARRAY;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            NSArray *a = (NSArray *)_value;
            NSInteger n = [a count];
            for(NSInteger i=0;i<n;i++)
            {
                UMDiscreteValue *x = a[i];
                [_asn1_list addObject:x];
            }
            break;
        }
        case UMVALUE_STRUCT:
        {
            _asn1_tag.tagNumber = UMVALUE_STRUCT;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            NSDictionary *dict = (NSDictionary *)_value;
            NSArray *allKeys = [dict allKeys];
            NSInteger n = [allKeys count];
            for(NSInteger i=0;i<n;i++)
            {
                NSString        *key   = allKeys[i];
                UMDiscreteValue *xvalue = dict[key];
                UMASN1UTF8String *uKey = [[UMASN1UTF8String alloc]initWithValue:[xvalue stringValue]];
                UMASN1Sequence *seq = [[UMASN1Sequence alloc]init];
                [seq setValues:@[uKey,xvalue]];
                [_asn1_list addObject:seq];
            }
            break;
        }
        case UMVALUE_DATA:
        {
            _asn1_tag.tagNumber = UMVALUE_DATA;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1OctetString *d = [[UMASN1OctetString alloc]initWithValue:(NSData *)_value];
            [_asn1_list addObject:d];
            break;
        }
        case UMVALUE_ASN1_OBJECT:
        {
            _asn1_tag.tagNumber = UMVALUE_ASN1_OBJECT;
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1Object *asn1 = (UMASN1Object *)_value;
            NSData *d = [asn1 berEncoded];
            UMASN1OctetString *o = [[UMASN1OctetString alloc]initWithValue:d];
            [_asn1_list addObject:o];
            break;
        }
        default:
        {
            if(_type==UMVALUE_ASN1_OBJECT)
            {
                _asn1_tag.tagNumber = UMVALUE_ASN1_OBJECT; /* An ANS1 object is simply transported as BER encoded */
            }
            else
            {
                _asn1_tag.tagNumber = UMVALUE_DATA;
            }
            _asn1_tag.isConstructed=YES;
            _asn1_list = [[NSMutableArray alloc]init];
            UMASN1OctetString *d = [[UMASN1OctetString alloc]initWithValue:(NSData *)_value];
            [_asn1_list addObject:d];
            break;
        }
    }
}


- (UMDiscreteValue *) processAfterDecodeWithContext:(id)context
{
    int p=0;
    UMASN1Object *o = NULL;
    if(_asn1_tag.tagClass == UMASN1Class_ContextSpecific)
    {
        o = [self getObjectAtPosition:p++];
        if(o)
        {
            switch(o.asn1_tag.tagNumber)
            {
                case UMVALUE_NULL:
                {
                    _type = UMVALUE_NULL;
                    _value = NULL;
                    return self;
                }
                case UMVALUE_BOOL:
                {
                    _type = UMVALUE_BOOL;
                    UMASN1Boolean *b = [[UMASN1Boolean alloc]initWithASN1Object:o context:context];
                    if(b.isTrue)
                    {
                        _value = @(YES);
                    }
                    else
                    {
                        _value = @(NO);
                    }
                    return self;
                }
                case UMVALUE_INT:
                {
                    _type = UMVALUE_INT;
                    UMASN1Integer *i = [[UMASN1Integer alloc]initWithASN1Object:o context:context];
                    _value = @( (int)i.value);
                    return self;
                }
                case UMVALUE_LONGLONG:
                {
                    _type = UMVALUE_LONGLONG;
                    UMASN1Integer *i = [[UMASN1Integer alloc]initWithASN1Object:o context:context];
                    _value = @( (long long)i.value);
                    return self;
                }
                case UMVALUE_DOUBLE:
                {
                    _type = UMVALUE_DOUBLE;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    NSString *s = utf8.stringValue;
                    _value = @(s.doubleValue);
                    return self;
                }
                case UMVALUE_STRING:
                {
                    _type = UMVALUE_STRING;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    _value = utf8.stringValue;
                    return self;
                }
                case UMVALUE_DATA:
                {
                    _type = UMVALUE_DATA;
                    UMASN1OctetString *os = [[UMASN1OctetString alloc]initWithASN1Object:o context:context];
                    _value = os.value;
                    return self;
                }
                case UMVALUE_ARRAY:
                {
                    _type = UMVALUE_ARRAY;
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
                    _value = marr;
                    return self;
                }
                case UMVALUE_STRUCT:
                {
                    _type = UMVALUE_STRUCT;
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
                    _value = mdict;
                    return self;
                }
                case UMVALUE_ASN1_OBJECT:
                {
                    _type = UMVALUE_ASN1_OBJECT;
                    UMASN1OctetString *os = [[UMASN1OctetString alloc]initWithASN1Object:o context:context];
                    NSData *d = os.value;
                    UMASN1Object *asn1 = [[UMASN1Object alloc]initWithBerData:d];
                    _value = asn1;
                    return self;
                }
            }
        }
    }
    @throw([NSException exceptionWithName:@"INVALID_ASN1" reason:@"while decoding UMDiscreteValue, the _type could not be decoded" userInfo:NULL]);
}

- (NSString *) objectName
{
    return @"UMDiscreteValue";
}


- (id) objectValue
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];

    switch(_type)
    {
        case UMVALUE_NULL:
            dict[@"null"] = [NSNull null];
            break;
        case UMVALUE_BOOL:
            dict[@"bool"] = @([_value boolValue]);
            break;
        case UMVALUE_INT:
            dict[@"int"] = @([_value intValue]);
            break;
        case UMVALUE_LONGLONG:
            dict[@"longlong"] = @([_value longLongValue]);
            break;
        case UMVALUE_DOUBLE:
            dict[@"double"] = @([_value doubleValue]);
            break;
        case UMVALUE_STRING:
            dict[@"string"] = [_value stringValue];
            break;
        case UMVALUE_ARRAY:
            dict[@"array"] = [(NSArray *)_value copy];
            break;
        case UMVALUE_STRUCT:
            dict[@"struct"] = [(NSDictionary *)_value copy];
            break;
        case UMVALUE_DATA:
            dict[@"data"] = [_value dataValue];
            break;
        case UMVALUE_POINTER:
            dict[@"pointer"] = [_value stringValue];
            break;
        case UMVALUE_ASN1_OBJECT:
            dict[@"asn1"] = [_value objectValue];
            break;

        case UMVALUE_CUSTOM_TYPE:
            /* FIXME */
            break;
    }
    return dict;
}


- (UMDiscreteValueType)outputType:(UMDiscreteValueType)btype
{
    if(_type == btype)
    {
       return _type;
    }
    if  (   ( (_type == UMVALUE_INT)       && (btype==UMVALUE_LONGLONG) )
         || ( (_type == UMVALUE_LONGLONG)  && (btype==UMVALUE_INT)      ) )
    {
       return UMVALUE_LONGLONG;
    }
    if  (   ( (_type == UMVALUE_INT)        && (btype==UMVALUE_DOUBLE) )
         || ( (_type == UMVALUE_DOUBLE)     && (btype==UMVALUE_INT)      ) )
    {
        return UMVALUE_DOUBLE;
    }
    if  (   ( (_type == UMVALUE_LONGLONG)    && (btype==UMVALUE_DOUBLE) )
         || ( (_type == UMVALUE_DOUBLE)      && (btype==UMVALUE_LONGLONG)      ) )
    {
        return UMVALUE_DOUBLE;
    }
    return _type;
}

- (UMDiscreteValue *)init
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_NULL;
    }
    return self;
}

- (UMDiscreteValue *)initWithBool:(BOOL)b
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_BOOL;
        _value = @(b);
    }
    return self;
}

- (UMDiscreteValue *)initWithInt:(int)i
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_INT;
        _value = @(i);
    }
    return self;

}

- (UMDiscreteValue *)initWithInteger:(NSInteger)i
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_INT;
        _value = @(i);
    }
    return self;

}

- (UMDiscreteValue *)initWithLongLong:(long long)ll
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_LONGLONG;
        _value = @(ll);
    }
    return self;
 
}
- (UMDiscreteValue *)initWithDouble:(double)d
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_DOUBLE;
        _value = @(d);
    }
    return self;

}

- (UMDiscreteValue *)initWithString:(NSString *)s;
{
    self = [super init];
    if(self)
    {
        if(s==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type = UMVALUE_STRING;
            _value = s;
        }
    }
    return self;
}

- (UMDiscreteValue *)initWithPointer:(NSString *)s;
{
    self = [super init];
    if(self)
    {
        if(s==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type = UMVALUE_POINTER;
            _value = s;
        }
    }
    return self;
}

- (UMDiscreteValue *)initWithNumberString:(NSString *)numberString
{
    self = [super init];
    if(self)
    {
        _type = UMVALUE_INT;
        int i = atoi(numberString.UTF8String);
        /* FIXME: we must return other types if the string indicates its a long long or a double */
        _value = @(i);
    }
    return self;
}


- (UMDiscreteValue *)initWithArray:(NSArray *)array
{
    self = [super init];
    if(self)
    {
        if(array==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type    = UMVALUE_ARRAY;
            _value   = [array mutableCopy];
        }
    }
    return self;
}

- (UMDiscreteValue *)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        if(dict==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type    = UMVALUE_STRUCT;
            _value   = [dict mutableCopy];
        }
    }
    return self;
}

- (UMDiscreteValue *)initWithData:(NSString *)d;
{
    self = [super init];
    if(self)
    {
        if(d==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type = UMVALUE_DATA;
            _value = d;
        }
    }
    return self;
}

- (UMDiscreteValue *)initWithASN1Object:(UMASN1Object *)asn1;
{
	self = [super init];
	if(self)
	{
        if(asn1==NULL)
        {
            _type = UMVALUE_NULL;
            _value = NULL;
        }
        else
        {
            _type = UMVALUE_ASN1_OBJECT;
            _value = asn1;
        }
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
    NSUInteger n = [s length];
    NSUInteger i;
    BOOL inEscape = NO;
    BOOL inOctalEscape = NO;
    BOOL inHexEscape = NO;
    NSMutableString *s2 = [[NSMutableString alloc]init];
    long value = 0;
    unichar c;
    for(i=1;i<(n-1);i++) /* we skip the starting and ending quote */
    {
        c = [s characterAtIndex:i];

        if(inEscape)
        {
            if(inOctalEscape)
            {
                if((c >= '0') && (c<='7'))
                {
                    value = value * 8 + c-'0';
                    continue;
                }
                else
                {
                    c = value;
                    NSString *s3 = [NSString stringWithCharacters:&c length:1];
                    [s2 appendString:s3];
                    inOctalEscape = NO;
                    inEscape = NO;
                    i--; /* we need to process the characer which is not 0...7, so lets reloop */
                    continue;
                }
            }
            else if(inHexEscape)
            {
                if((c >= '0') && (c<='9'))
                {
                    value = value * 16 + c-'0';
                    continue;
                }
                else if((c >= 'a') && (c<='f'))
                {
                    value = value * 16 + c-'a' + 10;
                    continue;
                }
                else if((c >= 'A') && (c<='F'))
                {
                    value = value * 16 + c-'A' + 10;
                    continue;
                }
                else
                {
                    c = value;
                    NSString *s3 = [NSString stringWithCharacters:&c length:1];
                    [s2 appendString:s3];
                    inHexEscape = NO;
                    inEscape = NO;
                    i--; /* we need to process the characer which is not 0...F, so lets reloop */
                    continue;
                }
            }
            else
            {
                switch(c)
                {
                    case 'a':
                        [s2 appendString:@"\a"];
                        break;
                    case 'b':
                        [s2 appendString:@"\b"];
                        break;
                    case 'f':
                        [s2 appendString:@"\f"];
                        break;
                    case 'n':
                        [s2 appendString:@"\n"];
                        break;
                    case 'r':
                        [s2 appendString:@"\r"];
                        break;
                    case 't':
                        [s2 appendString:@"\t"];
                        break;
                    case 'v':
                        [s2 appendString:@"\v"];
                        break;
                    case '\\':
                        [s2 appendString:@"\\"];
                        break;
                    case '\'':
                        [s2 appendString:@"'"];
                        break;
                    case '"':
                        [s2 appendString:@"\""];
                        break;
                    case '?':
                        [s2 appendString:@"?"];
                        break;
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
                        inOctalEscape = YES;
                        break;
                    case 'x':
                        inHexEscape = YES;
                        break;
                    default:
                    {
                        NSString *s3 = [NSString stringWithCharacters:&c length:1];
                        [s2 appendString:s3];
                        break;
                    }
                }
            }
        }
        else
        {
            if(c=='\\')
            {
                inEscape=YES;
                inOctalEscape = NO;
                inHexEscape = NO;
            }
            else
            {
                inEscape=NO;
                inOctalEscape = NO;
                inHexEscape = NO;
                NSString *s3 = [NSString stringWithCharacters:&c length:1];
                [s2 appendString:s3];
            }
        }
    }
    /* we have an escape at the end of the string which we have not yet appended */
    if((inHexEscape) || (inOctalEscape))
    {
        c = value;
        NSString *s3 = [NSString stringWithCharacters:&c length:1];
        [s2 appendString:s3];
    }
    return [[UMDiscreteValue alloc]initWithString:s2];
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

+ (UMDiscreteValue *)discreteASN1Object:(UMASN1Object *)asn1
{
	return [[UMDiscreteValue alloc]initWithASN1Object:asn1];
}



- (BOOL)isNull
{
    if(_type==UMVALUE_NULL)
	{
        return YES;
	}
    return NO;
}

- (int)intValue
{
    switch(_type)
    {
        case UMVALUE_NULL:
            return 0;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)_value) intValue];
        case UMVALUE_POINTER:
        case UMVALUE_STRING:
        {
            int i;
            sscanf([((NSString *)_value)  UTF8String],"%d",&i);
            return i;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)_value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (int)c[0];
        }
		case UMVALUE_ASN1_OBJECT:
		{
			UMASN1Object *asn1 = (UMASN1Object *)_value;
			if([asn1 isKindOfClass:[UMASN1Integer class]])
			{
				return (int) [((UMASN1Integer *)asn1) value];
			}
			else if([asn1 isKindOfClass:[UMASN1OctetString class]])
			{
				NSData *data = [((UMASN1OctetString *)asn1) value];
				if(data==NULL)
				{
					return 0;
				}
				const char *bytes = data.bytes;
				return (int) bytes[0];
			}
			else if([asn1 isKindOfClass:[UMASN1UTF8String class]])
			{
				NSString  *str = [((UMASN1UTF8String *)asn1) value];
				if(str==NULL)
				{
					return 0;
				}
				return atoi(str.UTF8String);
			}
			return 0;
		}
        default:
            return 0;
    }
}

- (NSString *)stringValue
{
    switch(_type)
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
            return [((NSNumber *)_value) stringValue];
        case UMVALUE_STRING:
        case UMVALUE_POINTER:
            return _value;
        case UMVALUE_DATA:
            return [[NSString alloc] initWithData:(NSData *)_value encoding:NSUTF8StringEncoding];
		case UMVALUE_ASN1_OBJECT:
		{
			UMASN1Object *asn1 = (UMASN1Object *)_value;
			if([asn1 isKindOfClass:[UMASN1Integer class]])
			{
				return [NSString stringWithFormat:@"%lld",(long long) [((UMASN1Integer *)asn1) value]];
			}
			else if([asn1 isKindOfClass:[UMASN1OctetString class]])
			{
				NSData *data = [((UMASN1OctetString *)asn1) value];
				if(data==NULL)
				{
					return @"";
				}
				return [data hexString];
			}
			else if([asn1 isKindOfClass:[UMASN1UTF8String class]])
			{
				NSString  *str = [((UMASN1UTF8String *)asn1) value];
				if(str==NULL)
				{
					return @"";
				}
				return str;
			}
			return @"";
		}

        default:
            return @"";
    }
}

- (NSArray *)stringArrayValue
{
    switch(_type)
    {
        case UMVALUE_ARRAY:
        {
            NSMutableArray *a = [[NSMutableArray alloc]init];
            for (id i in (NSArray *)_value)
            {
                [a addObject: [i stringValue]];
            }
            return a;
        }
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
        case UMVALUE_STRING:
        case UMVALUE_DATA:
            return @[[self stringValue]];
        default:
            return @[];
    }
}

- (NSData *)dataValue
{
    switch(_type)
    {
        case UMVALUE_NULL:
            return [NSData data];
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
        {
            NSNumber *n = _value;
            unsigned char c = [n unsignedCharValue];
            return [NSData dataWithBytes:&c length:1];
        }
        case UMVALUE_POINTER:
        case UMVALUE_STRING:
        {
            NSString *s = _value;
            return [s dataUsingEncoding:NSUTF8StringEncoding];
        }
        case UMVALUE_DATA:
            return _value;
		case UMVALUE_ASN1_OBJECT:
		{
			UMASN1Object *asn1 = (UMASN1Object *)_value;
			return [asn1 berEncoded];
		}
        default:
            return [NSData data];
    }
  
}

- (BOOL) boolValue
{
    switch(_type)
    {
        case UMVALUE_NULL:
            return NO;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)_value) boolValue];
        case UMVALUE_STRING:
        {
            if (([_value isEqualToString:@"YES"]) ||  ([_value isEqualToString:@"true"]))
            {
                return YES;
            }
            if (([_value isEqualToString:@"NO"]) ||  ([_value isEqualToString:@"false"]))
            {
                return NO;
            }
            int i;
            sscanf([((NSString *)_value)  UTF8String],"%d",&i);
            return i ? YES : NO;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)_value;
            unsigned char *c = (unsigned char *)[d bytes];
            return c[0] ? YES : NO;
        }
        case UMVALUE_POINTER:
        {
            NSString *s = _value;
            if (s.length > 0)
            {
                return YES;
            }
            return NO;
        }
		case UMVALUE_ASN1_OBJECT:
		{
			UMASN1Object *asn1 = (UMASN1Object *)_value;
			if([asn1 isKindOfClass:[UMASN1Integer class]])
			{
				int64_t i = [((UMASN1Integer *)asn1) value];
				if(i)
				{
					return YES;
				}
				return NO;
			}
			else if([asn1 isKindOfClass:[UMASN1OctetString class]])
			{
				NSData *data = [((UMASN1OctetString *)asn1) value];
				if(data==NULL)
				{
					return 0;
				}
				const uint8_t *bytes = data.bytes;
				if(bytes[0])
				{
					return YES;
				}
				return NO;			}
			else if([asn1 isKindOfClass:[UMASN1UTF8String class]])
			{
				NSString  *str = [((UMASN1UTF8String *)asn1) value];
				if(str==NULL)
				{
					return NO;
				}
				if([str caseInsensitiveCompare:@"YES"]==NSOrderedSame)
				{
					return YES;
				}
				if([str caseInsensitiveCompare:@"NO"]==NSOrderedSame)
				{
					return NO;
				}
				if([str caseInsensitiveCompare:@"true"]==NSOrderedSame)
				{
					return YES;
				}
				if([str caseInsensitiveCompare:@"false"]==NSOrderedSame)
				{
					return NO;
				}

				if([str caseInsensitiveCompare:@"1"]==NSOrderedSame)
				{
					return YES;
				}
				if([str caseInsensitiveCompare:@"0"]==NSOrderedSame)
				{
					return NO;
				}
				return NO;
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
    switch(_type)
    {
        case UMVALUE_NULL:
            return 0.0;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)_value) doubleValue];
        case UMVALUE_STRING:
        case UMVALUE_POINTER:
        {
            double d;
            sscanf([((NSString *)_value)  UTF8String],"%lf",&d);
            return d;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)_value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (double)c[0];
        }
		case UMVALUE_ASN1_OBJECT:
		{
			UMASN1Object *asn1 = (UMASN1Object *)_value;
			if([asn1 isKindOfClass:[UMASN1Integer class]])
			{
				return (double) [((UMASN1Integer *)asn1) value];
			}
			else if([asn1 isKindOfClass:[UMASN1OctetString class]])
			{
				UMASN1OctetString *o = (UMASN1OctetString *)asn1;
				NSData *data = o.value;
				NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
				double d;
				sscanf(string.UTF8String,"%lf",&d);
				return d;

			}
			else if([asn1 isKindOfClass:[UMASN1UTF8String class]])
			{
				UMASN1UTF8String *utf8 = (UMASN1UTF8String *)asn1;
				NSString *string = utf8.value;
				double d;
				sscanf(string.UTF8String,"%lf",&d);
				return d;
			}
			return 0.0;
		}
        default:
            return 0.0;
    }
}

- (long long)longLongValue
{
    switch(_type)
    {
        case UMVALUE_NULL:
            return 0LL;
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return [((NSNumber *)_value) longLongValue];
        case UMVALUE_STRING:
        {
            long long i;
            sscanf([((NSString *)_value)  UTF8String],"%lld",&i);
            return i;
        }
        case UMVALUE_DATA:
        {
            NSData *d = (NSData *)_value;
            unsigned char *c = (unsigned char *)[d bytes];
            return (long long)c[0];
        }
		case UMVALUE_ASN1_OBJECT:
		{
			NSData *d = (NSData *)_value;
			unsigned char *c = (unsigned char *)[d bytes];
			return (long long)c[0];
		}

        default:
            return 0LL;
    }
}

- (UMASN1Object *)asn1Value
{
	switch(_type)
	{
		case UMVALUE_NULL:
			return [[UMASN1Null alloc]init];
		case UMVALUE_BOOL:
			if( [((NSNumber *)_value) boolValue])
			{
				return [[UMASN1Boolean alloc]initAsYes];
			}
			else
			{
				return [[UMASN1Boolean alloc]initAsNo];
			}

		case UMVALUE_INT:
		case UMVALUE_LONGLONG:
		{
			int64_t i = [(NSNumber *)_value longLongValue];
			return [[UMASN1Integer alloc]initWithValue:i];
			break;
		}
		case UMVALUE_DOUBLE:
		{
			double d = [(NSNumber *)_value doubleValue];
			return [[UMASN1Real alloc]initWithValue:d];
		}
			break;
		case UMVALUE_STRING:
		{
			NSString *str = (NSString *)_value;
			return [[UMASN1UTF8String alloc]initWithValue:str];
		}
		case UMVALUE_DATA:
		{
			NSData *d = (NSData *)_value;
			return [[UMASN1OctetString alloc]initWithValue:d];
		}
		case UMVALUE_ASN1_OBJECT:
		{
			return (UMASN1Object *)_value;
		}
		default:
			return 0LL;
	}
}


- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    return self;
}

-(BOOL) isNumberType
{
    if((_type==UMVALUE_BOOL) || (_type==UMVALUE_INT) || (_type==UMVALUE_LONGLONG) || (_type==UMVALUE_DOUBLE))
    {
        return YES;
    }
    return NO;

}

- (UMDiscreteValue *)discreteIsCaseInsensitiveEqualTo:(UMDiscreteValue *)bval
{
    BOOL r;
    if((_type==UMVALUE_NULL) || (bval.type==UMVALUE_NULL))
    {
        r = (_type == bval.type);
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        r = [_value isEqualToValue:bval.value];
    }
    else if((_type==UMVALUE_STRING) && (bval.type==UMVALUE_STRING))
    {
        r = [[_value lowercaseString] isEqualToString:[bval.value lowercaseString]];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        r = [_value isEqualToData:bval.value];
    }
    else
    {
        NSString *a = [[self stringValue] lowercaseString];
        NSString *b = [[bval stringValue] lowercaseString];
        r = [a isEqualToString:b];
    }
    UMDiscreteValue *result = [UMDiscreteValue discreteBool:r];
    return result;
}

- (UMDiscreteValue *)discreteIsEqualTo:(UMDiscreteValue *)bval
{
    BOOL r;
    if((_type==UMVALUE_NULL) || (bval.type==UMVALUE_NULL))
    {
        r = (_type == bval.type);
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        r = [_value isEqualToValue:bval.value];
    }
    else if((_type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        r = [_value isEqualToString:bval.value];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
    {
        r = [_value isEqualToData:bval.value];
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
    if((_type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((_type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((_type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
    else if((_type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThan:b]];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
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
    if((_type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((_type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((_type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
    else if((_type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isGreaterThanOrEqualTo:b]];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
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
    if((_type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    if((_type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((_type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
    else if((_type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThan:b]];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
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
    if((_type==UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((_type==UMVALUE_NULL) && (bval.type!=UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:YES];
    }
    if((_type!=UMVALUE_NULL) && (bval.type==UMVALUE_NULL))
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    else if((self.isNumberType) && (bval.isNumberType))
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
    else if((_type==UMVALUE_STRING) || (bval.type==UMVALUE_STRING))
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        return [UMDiscreteValue discreteBool:[a isLessThanOrEqualTo:b]];
    }
    else if((_type==UMVALUE_DATA) || (bval.type==UMVALUE_DATA))
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
    switch(_type)
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
    switch(_type)
    {
        case UMVALUE_NULL:
            return [NSNull null];
        case UMVALUE_BOOL:
        case UMVALUE_INT:
        case UMVALUE_LONGLONG:
        case UMVALUE_DOUBLE:
            return (NSNumber *)_value;
        case UMVALUE_STRING:
            return (NSString *)_value;
        case UMVALUE_DATA:
            return (NSData *)_value;
        default:
            return [NSNull null];
    }
}

- (NSString *)labelValue
{
    return [self stringValue];
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
    
    else if(_type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        int c = a.intValue + b.intValue;
       return [UMDiscreteValue discreteInt:c];
    }
    else if(_type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        long long c = a.longLongValue + b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(_type==UMVALUE_DOUBLE)
    {
         NSNumber *a = self.value;
         NSNumber *b = bval.value;
         double c = a.doubleValue + b.doubleValue;
         return [UMDiscreteValue discreteDouble:c];
    }
    else if(_type==UMVALUE_STRING)
    {
        NSString *a = self.value;
        NSString *b = bval.value;
        NSString *c = [a stringByAppendingString:b];
        return [UMDiscreteValue discreteString:c];
    }
    else if(_type==UMVALUE_DATA)
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

    else if(_type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        int c = a.intValue - b.intValue;
        return [UMDiscreteValue discreteInt:c];
    }
    else if(_type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = bval.value;
        long long c = a.longLongValue - b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(_type==UMVALUE_DOUBLE)
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
        if(_type==UMVALUE_BOOL)
        {
            BOOL c = a.boolValue * b.boolValue;
            return [UMDiscreteValue discreteBool:c];
        }
        if(_type==UMVALUE_INT)
        {
            int c = a.intValue * b.intValue;
            return [UMDiscreteValue discreteInt:c];
        }
        if(_type==UMVALUE_LONGLONG)
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
    else if ((_type==UMVALUE_STRING) && (bval.isNumberType))
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

        if(_type==UMVALUE_BOOL)
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
        if(_type==UMVALUE_INT)
        {
            int c = a.intValue / b.intValue;
            return [UMDiscreteValue discreteInt:c];
        }
        if(_type==UMVALUE_LONGLONG)
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
    if(_type==UMVALUE_BOOL)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToBool].value;
        BOOL c = a.boolValue % b.boolValue;
        return [UMDiscreteValue discreteBool:c];
    }
    else if(_type==UMVALUE_INT)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToInt].value;
        int c = a.intValue % b.intValue;
        return [UMDiscreteValue discreteInt:c];
    }
    else if(_type==UMVALUE_LONGLONG)
    {
        NSNumber *a = self.value;
        NSNumber *b = [bval convertToLongLong].value;
        long long  c = a.longLongValue % b.longLongValue;
        return [UMDiscreteValue discreteLongLong:c];
    }
    else if(_type==UMVALUE_DOUBLE)
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
    if(_type ==UMVALUE_BOOL)
    {
        return self;
    }
    return [UMDiscreteValue discreteBool:[self boolValue]];
}

- (UMDiscreteValue *)convertToInt
{
    if(_type ==UMVALUE_INT)
    {
        return self;
    }
    return [UMDiscreteValue discreteInt:[self intValue]];
}

- (UMDiscreteValue *)convertToLongLong
{
    if(_type == UMVALUE_LONGLONG)
    {
        return self;
    }
    return [UMDiscreteValue discreteLongLong:[self longLongValue]];
}

- (UMDiscreteValue *)convertToDouble
{
    if(_type == UMVALUE_DOUBLE)
    {
        return self;
    }
    return [UMDiscreteValue discreteDouble:[self doubleValue]];
}

- (UMDiscreteValue *)convertToString
{
    if(_type == UMVALUE_STRING)
    {
        return self;
    }
    return [UMDiscreteValue discreteString:[self stringValue]];
}

- (UMDiscreteValue *)convertToData
{
    if(_type == UMVALUE_DATA)
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
    if(_type == UMVALUE_LONGLONG)
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
    if(_type == UMVALUE_LONGLONG)
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
    if(_type == UMVALUE_LONGLONG)
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
    if(_type == UMVALUE_LONGLONG)
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
    if(_type == UMVALUE_LONGLONG)
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
    if(_type == UMVALUE_LONGLONG)
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
    NSMutableArray *arr = (NSMutableArray *)_value;
    return  arr[bnum.intValue];
}
                           
- (UMDiscreteValue *)structAccess:(UMDiscreteValue *)bval
{
    NSString *key = [bval convertToString].value;
    NSMutableDictionary *dict = (NSMutableDictionary *)_value;
    return  dict[key];
}

- (NSString *)codeWithEnvironment:(UMEnvironment *)env
{
    if(_type==UMVALUE_NULL)
    {
        return @"NULL";
    }
    else if (_type==UMVALUE_BOOL)
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
    else if ((_type==UMVALUE_INT) || (_type==UMVALUE_LONGLONG) || (_type==UMVALUE_DOUBLE))
    {
        return [self stringValue];
    }
    else if(_type == UMVALUE_STRING)
    {
        return [NSString stringWithFormat:@"\"%@\"",[self stringValue]];
    }
    else if(_type == UMVALUE_DATA)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [s appendString:@"["];
        NSData *d = _value;
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
    return @"/* unknown discreete _type */";
}

- (UMDiscreteValue *)increase
{
    if(self.isNumberType)
    {
        NSNumber *a = self.value;
        if(_type==UMVALUE_BOOL)
        {
            BOOL c =  YES;
            return [UMDiscreteValue discreteBool:c];
        }
        if(_type==UMVALUE_INT)
        {
            int c = a.intValue + 1;
            return [UMDiscreteValue discreteInt:c];
        }
        if(_type==UMVALUE_LONGLONG)
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
        if(_type==UMVALUE_BOOL)
        {
            BOOL c = NO;
            return [UMDiscreteValue discreteBool:c];
        }
        if(_type==UMVALUE_INT)
        {
            int c = a.intValue - 1;
            return [UMDiscreteValue discreteInt:c];
        }
        if(_type==UMVALUE_LONGLONG)
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


- (UMDiscreteValue *)hashWithOptions:(UMDiscreteValue *)hashOptions
{
    int hashMethod = 1; // SHA1
    int outputFormat = 1; // 1 = data, 2 = hex string

    if ([hashOptions isNull])
    {
        hashMethod = 1;
        outputFormat = 1;
    }
    NSString *optionString = [hashOptions stringValue];
    NSArray *options = [optionString componentsSeparatedByCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];
    
    for(NSString *option in options)
    {
        if([option isEqualToString:@"SHA1"])
        {
            hashMethod = 1;
        }
        else if([option isEqualToString:@"SHA224"])
        {
            hashMethod = 224;
        }
        else if([option isEqualToString:@"SHA256"])
        {
            hashMethod = 256;
        }
        else if([option isEqualToString:@"SHA384"])
        {
            hashMethod = 384;
        }
        else if([option isEqualToString:@"SHA512"])
        {
            hashMethod = 512;
        }
        else if([option isEqualToString:@"string"])
        {
            outputFormat = 1;
        }
        else if([option isEqualToString:@"data"])
        {
            outputFormat = 2;
        }
    }
    NSData *input = [self dataValue];
    NSData *output;
    switch(hashMethod)
    {
        case 224:
            output = [input sha224];
            break;
        case 256:
            output = [input sha256];
            break;
        case 384:
            output = [input sha384];
            break;
        case 512:
            output = [input sha512];
            break;
        case 1:
        default:
            output = [input sha1];
            break;
    }
    if(outputFormat==2)
    {
        return [UMDiscreteValue discreteData:output];
    }
    return [UMDiscreteValue discreteString:[output hexString]];
}


@end
