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
} UMTermType;

@interface UMTerm : UMObject
{
    UMTermType      type;
    UMDiscreteValue *discrete;
    UMFunction      *function;
    NSString        *fieldname;
    NSString        *varname;
    NSArray         *param;
}

@property (readwrite,assign) UMTermType      type;
@property (readwrite,strong) UMDiscreteValue *discrete;
@property (readwrite,strong) NSString        *fieldname;
@property (readwrite,strong) NSString        *varname;
@property (readwrite,strong) UMFunction      *function;
@property (readwrite,strong) NSArray         *param;


- (id)initWithDiscreteValue:(UMDiscreteValue *)d;
- (id)initWithFieldName:(NSString *)fieldName;
- (id)initWithVariableName:(NSString *)variableName;
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


@end
