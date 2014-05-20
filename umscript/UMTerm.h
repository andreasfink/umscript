//
//  UMRuleFieldOrValue.h
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@class UMFunction;
@class UMDiscreteValue;
@class UMEnvironment;
@class UMDiscreteValue;

typedef enum UMTermType
{
    UMTermType_discrete,
    UMTermType_field,
    UMTermType_variable,
    UMTermType_function,
    UMTermType_identifier,
} UMTermType;

@interface UMTerm : UMObject
{
    UMTermType      type;
    UMDiscreteValue *discrete;
    UMFunction      *function;
    NSString        *fieldname;
    NSString        *varname;
    NSString        *identifier;
    NSArray         *param;
    int             token;
}

@property (readwrite,assign) UMTermType      type;
@property (readwrite,strong) UMDiscreteValue *discrete;
@property (readwrite,strong) NSString        *fieldname;
@property (readwrite,strong) NSString        *varname;
@property (readwrite,strong) NSString        *identifier;
@property (readwrite,strong) UMFunction      *function;
@property (readwrite,strong) NSArray         *param;
@property (readwrite,assign) int             token;


- (id)initWithDiscreteValue:(UMDiscreteValue *)d;
- (id)initWithFieldName:(NSString *)fieldName;
- (id)initWithVariableName:(NSString *)variableName;
- (id)initWithIdentifier:(NSString *)identifierName;
- (id)initWithFunction:(UMFunction *)func andParams:(NSArray *)params;

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)env;
- (BOOL)boolValue:(UMEnvironment *)env;
- (NSString *)stringValue:(UMEnvironment *)env;
- (NSData *)dataValue:(UMEnvironment *)env;
- (int)intValue:(UMEnvironment *)env;

- (NSString *)description;
- (id)descriptionDictVal;

- (id)initFunction:(UMFunction *)name parm1:(UMTerm *)parm1;
- (id)initFunction:(UMFunction *)name parm1:(UMTerm *)parm1 parm2:(UMTerm *)parm2;
- (id)initFunction:(UMFunction *)name parm1:(UMTerm *)parm1 parm2:(UMTerm *)parm2 parm3:(UMTerm *)parm3;
- (id)initFunction:(UMFunction *)name params:(NSArray *)parm;
- (NSString *)codeWithEnvironment:(UMEnvironment *)env;

+ (id)termWithIdentifier:(UMTerm *)identifierName;
+ (id)termWithVariable:(UMTerm *)varNameTerm;
+ (id)termWithField:(UMTerm *)fieldNameTerm;
+ (id)termWithConstant:(UMTerm *)constantTerm;
+ (id)termWithString:(UMTerm *)stringTerm;

- (void) setDiscreteString:(NSString *)s;
- (NSString * )debugDescription;

- (UMTerm *)add:(UMTerm *)b;
- (UMTerm *)sub:(UMTerm *)b;
- (UMTerm *)mul:(UMTerm *)b;
- (UMTerm *)div:(UMTerm *)b;
- (UMTerm *)modulo:(UMTerm *)b;
- (UMTerm *)dot:(UMTerm *)b;
- (UMTerm *)not;
- (UMTerm *)equal:(UMTerm *)b;
- (UMTerm *)notequal:(UMTerm *)b;
- (UMTerm *)greaterthan:(UMTerm *)b;
- (UMTerm *)lessthan:(UMTerm *)b;
- (UMTerm *)greatorequal:(UMTerm *)b;
- (UMTerm *)lessorequal:(UMTerm *)b;
- (UMTerm *)assign:(UMTerm *)b;
- (UMTerm *)and:(UMTerm *)b;
- (UMTerm *)or:(UMTerm *)b;
- (UMTerm *)xor:(UMTerm *)b;
- (UMTerm *)leftshift:(UMTerm *)b;
- (UMTerm *)rightshift:(UMTerm *)b;

@end
