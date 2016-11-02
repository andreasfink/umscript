//
//  UMDiscreteValue.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>

@class UMEnvironment;

typedef enum UMDiscreteValueType
{
    UMVALUE_NULL,
    UMVALUE_BOOL,
    UMVALUE_INT,
    UMVALUE_LONGLONG,
    UMVALUE_DOUBLE,
    UMVALUE_STRING,
    UMVALUE_DATA,
} UMDiscreteValueType;

@interface UMDiscreteValue : UMObject
{
    UMDiscreteValueType type;
    id value;
}

@property (readonly)    UMDiscreteValueType type;
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
- (UMDiscreteValue *)initWithData:(NSData *)data;
- (UMDiscreteValue *)initWithNumberString:(NSString *)numberString;

+ (UMDiscreteValue *)discreteBool:(BOOL)b;
+ (UMDiscreteValue *)discreteInt:(int)i;
+ (UMDiscreteValue *)discreteInteger:(NSInteger)i;
+ (UMDiscreteValue *)discreteLongLong:(long long)ll;
+ (UMDiscreteValue *)discreteDouble:(double)d;
+ (UMDiscreteValue *)discreteString:(NSString *)s;
+ (UMDiscreteValue *)discreteData:(NSData *)data;
+ (UMDiscreteValue *)discreteNumberString:(NSString *)string;
+ (UMDiscreteValue *)discreteYES;
+ (UMDiscreteValue *)discreteNO;
+ (UMDiscreteValue *)discreteQuotedString:(NSString *)s;


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

- (UMDiscreteValue *)increase;
- (UMDiscreteValue *)decrease;

- (BOOL)isNumberType;
- (NSString *)codeWithEnvironment:(UMEnvironment *)env;

@end
