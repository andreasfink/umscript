//
//  UMDiscreteValue.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#import <ulibasn1/ulibasn1.h>

@class UMEnvironment;

typedef enum UMDiscreteValueType
{
    UMVALUE_NULL = 0,
    UMVALUE_BOOL = 1,
    UMVALUE_INT = 2,
    UMVALUE_LONGLONG = 3,
    UMVALUE_DOUBLE = 4,
    UMVALUE_STRING = 5,
    UMVALUE_DATA = 6,
    UMVALUE_ARRAY = 7,
    UMVALUE_STRUCT = 8, /* also known as DICT */
    UMVALUE_POINTER = 9,
    UMVALUE_CUSTOM_TYPE = -1,
} UMDiscreteValueType;

@interface UMDiscreteValue : UMASN1Choice
{
    UMDiscreteValueType type;
    NSString *_customTypeName;
    id value;
}

@property (readonly)    UMDiscreteValueType type;
@property (readonly)    NSString *customTypeName;
@property (readonly)    id value;

- (UMDiscreteValueType)outputType:(UMDiscreteValueType)btype;

- (BOOL)isNull;
- (int)intValue;
- (NSString *)stringValue;
- (NSData *)dataValue;
- (BOOL) boolValue;
- (double) doubleValue;
- (long long)longLongValue;
- (UMDiscreteValue *) notValue;
- (NSString *)labelValue;

- (UMDiscreteValue *)initWithBool:(BOOL)b;
- (UMDiscreteValue *)initWithInt:(int)i;
- (UMDiscreteValue *)initWithInteger:(NSInteger)i;
- (UMDiscreteValue *)initWithLongLong:(long long)ll;
- (UMDiscreteValue *)initWithDouble:(double)d;
- (UMDiscreteValue *)initWithString:(NSString *)s;
- (UMDiscreteValue *)initWithPointer:(NSString *)s;
- (UMDiscreteValue *)initWithData:(NSData *)data;
- (UMDiscreteValue *)initWithNumberString:(NSString *)numberString;
- (UMDiscreteValue *)initWithArray:(NSArray *)array;
- (UMDiscreteValue *)initWithDictionary:(NSDictionary *)array;

+ (UMDiscreteValue *)discreteBool:(BOOL)b;
+ (UMDiscreteValue *)discreteInt:(int)i;
+ (UMDiscreteValue *)discreteInteger:(NSInteger)i;
+ (UMDiscreteValue *)discreteLongLong:(long long)ll;
+ (UMDiscreteValue *)discreteDouble:(double)d;
+ (UMDiscreteValue *)discreteString:(NSString *)s;
+ (UMDiscreteValue *)discretePointer:(NSString *)s;
+ (UMDiscreteValue *)discreteData:(NSData *)data;
+ (UMDiscreteValue *)discreteNumberString:(NSString *)string;
+ (UMDiscreteValue *)discreteYES;
+ (UMDiscreteValue *)discreteNO;
+ (UMDiscreteValue *)discreteQuotedString:(NSString *)s;
+ (UMDiscreteValue *)discreteArray:(NSArray *)array;
+ (UMDiscreteValue *)discreteDictionary:(NSDictionary *)array;


+ (UMDiscreteValue *)discreteNull;

/* typecast functions */
- (UMDiscreteValue *)convertToBool;
- (UMDiscreteValue *)convertToInt;
- (UMDiscreteValue *)convertToLongLong;
- (UMDiscreteValue *)convertToDouble;
- (UMDiscreteValue *)convertToString;
- (UMDiscreteValue *)convertToData;

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env;

- (NSString *)description;
- (id)descriptionDictVal;

- (UMDiscreteValue *)discreteIsEqualTo:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)discreteIsNotEqualTo:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)discreteIsGreaterThan:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)discreteIsGreaterThanOrEqualTo:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)discreteIsLessThan:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)discreteIsLessThanOrEqualTo:(UMDiscreteValue *)bval;

- (UMDiscreteValue *)addValue:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)subtractValue:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)multiplyValue:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)divideValue:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)dotValue:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)percentValue:(UMDiscreteValue *)bval;

- (UMDiscreteValue *)logicAnd:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)logicOr:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)logicXor:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)logicNot;

- (UMDiscreteValue *)bitAnd:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)bitOr:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)bitXor:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)bitNot;
- (UMDiscreteValue *)bitShiftLeft:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)bitShiftRight:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)arrayAccess:(UMDiscreteValue *)bval;
- (UMDiscreteValue *)structAccess:(UMDiscreteValue *)bval;

- (UMDiscreteValue *)increase;
- (UMDiscreteValue *)decrease;

- (BOOL)isNumberType;
- (NSString *)codeWithEnvironment:(UMEnvironment *)env;

@end
