//
//  UMRuleFieldOrValue.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#import <ulibasn1/ulibasn1.h>

@class UMFunction;
@class UMDiscreteValue;
@class UMEnvironment;
@class UMDiscreteValue;
@class UMTerm_Interrupt;

typedef enum UMTermType
{
    UMTermType_discrete,
    UMTermType_field,
    UMTermType_variable,
    UMTermType_functionCall,
    UMTermType_functionDefinition,
    UMTermType_identifier,
    UMTermType_nullterm,
    UMTermType_token,
} UMTermType;

@interface UMTerm : UMASN1Choice
{
    UMEnvironment   *_cenv;    /* compilation environment */
    UMEnvironment   *_env;     /* runtime environment */
    UMTermType      _type;
    UMDiscreteValue *_discrete;
    UMFunction      *_function;
    NSString        *_fieldname;
    NSString        *_varname;
    NSString        *_identifier;
    NSString        *_label;
    int             _token;
    NSArray         *_param;
}

@property (readwrite,assign) UMTermType      type;
@property (readwrite,strong) UMDiscreteValue *discrete;
@property (readwrite,strong) NSString        *fieldname;
@property (readwrite,strong) NSString        *varname;
@property (readwrite,strong) NSString        *identifier;
@property (readwrite,strong) UMFunction      *function;
@property (readwrite,assign) int             token;
@property (readwrite,strong) NSString        *label;
//@property (readwrite,strong) NSMutableArray  *array;
@property (readwrite,strong) NSArray          *param;
@property (readwrite,strong)   UMEnvironment   *env;
@property (readwrite,strong)   UMEnvironment   *cenv;

- (id)initWithNullWithEnvironment:(UMEnvironment *)cenv;
- (id)initWithDiscreteValue:(UMDiscreteValue *)d withEnvironment:(UMEnvironment *)cenv;
- (id)initWithFieldName:(NSString *)fieldName withEnvironment:(UMEnvironment *)cenv;
- (id)initWithVariableName:(NSString *)variableName withEnvironment:(UMEnvironment *)cenv;
- (id)initWithIdentifier:(NSString *)identifierName withEnvironment:(UMEnvironment *)cenv;
- (id)initWithFunction:(UMFunction *)func andParams:(NSArray *)params withEnvironment:(UMEnvironment *)cenv;

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)env;
- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)xenv continueFrom:(UMTerm_Interrupt *)interruptedFrom;
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
- (UMTerm *)initWithfunctionDefinitionName:(UMTerm *)name
                                statements:(UMTerm *)statements
                               environment:(UMEnvironment *)env1;

- (NSString *)codeWithEnvironment:(UMEnvironment *)env;

+ (id)termWithIdentifierFromTag:(UMTerm *)identifierName withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithConstantFromTag:(UMTerm *)identifierName withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithVariableFromTag:(UMTerm *)varNameTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithFieldFromTag:(UMTerm *)fieldNameTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithStringFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithIntegerFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithLongLongFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithDoubleFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithBooleanFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithHexFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithBinaryFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithOctalFromTag:(UMTerm *)stringTerm withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithNullWithEnvironment:(UMEnvironment *)cenv;

+ (id)termWithDirectInteger:(int)i withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithDirectString:(NSString *)s withEnvironment:(UMEnvironment *)cenv;
+ (id)termWithDirectCString:(char *)s withEnvironment:(UMEnvironment *)cenv;

- (void) setDiscreteString:(NSString *)s;
- (NSString * )descriptionJson;

- (UMTerm *)invertSign;
- (UMTerm *)add:(UMTerm *)b;
- (UMTerm *)sub:(UMTerm *)b;
- (UMTerm *)mul:(UMTerm *)b;
- (UMTerm *)div:(UMTerm *)b;
- (UMTerm *)modulo:(UMTerm *)b;
- (UMTerm *)dot:(UMTerm *)b;
- (UMTerm *)equal:(UMTerm *)b;
- (UMTerm *)notequal:(UMTerm *)b;
- (UMTerm *)greaterthan:(UMTerm *)b;
- (UMTerm *)lessthan:(UMTerm *)b;
- (UMTerm *)greaterorequal:(UMTerm *)b;
- (UMTerm *)lessorequal:(UMTerm *)b;
- (UMTerm *)assign:(UMTerm *)b;
- (UMTerm *)logical_not;
- (UMTerm *)logical_and:(UMTerm *)b;
- (UMTerm *)logical_or:(UMTerm *)b;
- (UMTerm *)logical_xor:(UMTerm *)b;
- (UMTerm *)bit_and:(UMTerm *)b;
- (UMTerm *)bit_or:(UMTerm *)b;
- (UMTerm *)bit_xor:(UMTerm *)b;
- (UMTerm *)bit_not;
- (UMTerm *)leftshift:(UMTerm *)b;
- (UMTerm *)rightshift:(UMTerm *)b;
+ (UMTerm *)returnValue:(UMTerm *)val withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)whileCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)ifCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo elseDo:(UMTerm *)elsedo withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)thenDo:(UMTerm *)thendo whileCondition:(UMTerm *)condition withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)forInitializer:(UMTerm *)initializer endCondition:(UMTerm *)condition every:(UMTerm *)every thenDo:(UMTerm *)thenDo withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)switchCondition:(UMTerm *)condition thenDo:(UMTerm *)thenDo withEnvironment:(UMEnvironment *)cenv;
- (UMTerm *)blockAppendStatement:(UMTerm *)term;
+ (UMTerm *)blockWithStatement:(UMTerm *)term withEnvironment:(UMEnvironment *)cenv;
- (UMTerm *)listAppendStatement:(UMTerm *)term;
+ (UMTerm *)listWithStatement:(UMTerm *)term withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)token:(int)tok text:(const char *)text withEnvironment:(UMEnvironment *)cenv;

- (UMTerm *)preincrease;
- (UMTerm *)postincrease;
- (UMTerm *)predecrease;
- (UMTerm *)postdecrease;

+ (UMTerm *)functionDefinitionWithName:(UMTerm *)list
                            statements:(UMTerm *)statements
                           environment:(UMEnvironment *)env1;
- (UMTerm *)functionCallWithArguments:(UMTerm *)list environment:(UMEnvironment *)cenv;
- (UMTerm *)arrayAccess:(UMTerm *)index environment:(UMEnvironment *)cenv;
- (UMTerm *)dotIdentifier:(UMTerm *)list environment:(UMEnvironment *)cenv; /* object.access */
- (UMTerm *)arrowIdentifier:(UMTerm *)list environment:(UMEnvironment *)cenv; /* object->access */
- (UMTerm *)starIdentifierWithEnvironment:(UMEnvironment *)cenv; /* *object */
- (UMTerm *)sizeofTypeWithEnvironment:(UMEnvironment *)cenv; /* sizeof(object) */
- (UMTerm *)sizeofVarWithEnvironment:(UMEnvironment *)cenv; /* sizeof(object) */
- (UMTerm *)addressOfIdentifierWithEnvironment:(UMEnvironment *)cenv; /* sizeof(object) */
- (UMTerm *)castTo:(UMTerm *)newType environment:(UMEnvironment *)cenv;/* (newtype)object */



- (NSString *)constantStringValue;
- (NSString *)labelValue;

+ (UMTerm *)letsGoto:(UMTerm *)labelTerm withEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)letsBreakWithEnvironment:(UMEnvironment *)cenv;
+ (UMTerm *)letsContinueWithEnvironment:(UMEnvironment *)cenv;

- (NSString *)logDescription;

@end
