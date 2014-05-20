//
//  UMRuleFieldOrValue.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMTerm.h"
#import "UMFunction.h"
#import "NSNumber+UMRule.h"
#import "UMEnvironment.h"

@implementation UMTerm

@synthesize type;
@synthesize param;
@synthesize fieldname;
@synthesize varname;
@synthesize discrete;
@synthesize function;
@synthesize token;

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)env;
{
    switch(type)
    {
        case UMTermType_discrete:
        {
            return discrete;
        }
        case UMTermType_variable:
        {
            return [env variableForKey:varname];
        }
        case UMTermType_field:
        {
            return [env fieldForKey:fieldname];
        }
        case UMTermType_function:
        {
            return [function evaluateWithParams:param environment:env];
        }
    }
    return [UMDiscreteValue discreteNull];
}
    

- (id)initWithDiscreteValue:(UMDiscreteValue *)d
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_discrete;
        self.discrete = d;
    }
    return self;
}

- (id)initWithFieldName:(NSString *)fieldName
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_field;
        self.fieldname = fieldName;
    }
    return self;
}

- (id)initWithVariableName:(NSString *)variableName
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_field;
        self.varname = varname;
    }
    return self;
}

- (id)initWithFunction:(UMFunction *)func andParams:(NSArray *)params
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_function;
        self.function = func;
        self.param = params;
    }
    return self;
}

- (id)initWithString:(NSString *)s
{
    return [self initWithDiscreteValue:[UMDiscreteValue discreteString:s]];
}

- (id)initWithInt:(int)i
{
    return [self initWithDiscreteValue:[UMDiscreteValue discreteInt:i]];
}


- (BOOL)boolValue:(UMEnvironment *)env
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:env];
    return [d boolValue];
}

- (NSString *)stringValue:(UMEnvironment *)env
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:env];
    return [d stringValue];
}

- (NSData *)dataValue:(UMEnvironment *)env
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:env];
    return [d dataValue];
}

- (int)intValue:(UMEnvironment *)env
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:env];
    return [d intValue];
}


- (NSString *)description
{
    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
    NSString *s = [writer stringWithObject:[self descriptionDictVal]];
    return s;
}

- (id)descriptionDictVal
{
    switch(type)
    {
        case UMTermType_discrete:
            return [discrete descriptionDictVal];
        case UMTermType_variable:
            return @{@"VAR" : varname}; //[env variableForKey:varname];
        case UMTermType_field:
            return @{@"FIELD" : fieldname};
        case UMTermType_function:
        {
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            dict[@"function"] = [function descriptionDictVal];
            NSMutableArray *pdesc =[[NSMutableArray alloc]init];
            for (UMTerm *p in param)
            {
                [pdesc addObject:[p descriptionDictVal]];
            }
            dict[@"params"] = pdesc;
            return dict;
        }
    }
    return [UMDiscreteValue discreteNull];

}


#if 0
- (id)descriptionDictVal
{
    if(isField)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict[@"field"] = val;
        return dict;
    }
    else if(isCondition)
    {
        return [val descriptionDict];
    }
    return val;
}
#endif


- (id)initFunction:(UMFunction *)func parm1:(UMTerm *)parm1
{
    return [self initFunction:func params: @[parm1]];
}

- (id)initFunction:(UMFunction *)func parm1:(UMTerm *)parm1 parm2:(UMTerm *)parm2
{
    return [self initFunction:func params: @[parm1,parm2]];
    
}
- (id)initFunction:(UMFunction *)func parm1:(UMTerm *)parm1 parm2:(UMTerm *)parm2 parm3:(UMTerm *)parm3
{
    return [self initFunction:func params: @[parm1,parm2,parm3]];
}

- (id)initFunction:(UMFunction *)func params:(NSArray *)p;
{
    self = [super init];
    if(self)
    {
        type = UMTermType_function;
        function = func;
        param = p;
    }
    return self;
}

- (NSString *)codeWithEnvironment:(UMEnvironment *)env
{

    if(type==UMTermType_discrete)
    {
        return [discrete codeWithEnvironment:env];
    }
    if(type==UMTermType_field)
    {
        return [NSString stringWithFormat:@"%%%@",fieldname];
    }
    if(type==UMTermType_variable)
    {
        return [NSString stringWithFormat:@"%%%@",varname];
    }
    if(type==UMTermType_function)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [s appendString:[function codeWithEnvironmentStart:env]];
        NSUInteger i=0;
        NSUInteger n = param.count;
        for(UMTerm *p in param)
        {
            i++;
            if(i==1)
            {
                [s appendString:[function codeWithEnvironmentFirstParam:p env:env]];
            }
            else if(i==n)
            {
                [s appendString:[function codeWithEnvironmentLastParam:p env:env]];
            }
            else 
            {
                [s appendString:[function codeWithEnvironmentNextParam:p env:env]];
            }
        }
        [s appendString:[function codeWithEnvironmentStop:env]];
        return s;
    }
    return @"/*unknown UMTerm */";
}

+ (id)termWithVariable:(UMTerm *)varNameTerm
{
    UMDiscreteValue *d = varNameTerm.discrete;
    UMTerm *term = [[UMTerm alloc]initWithVariableName:d.stringValue];
    return term;
}

+ (id)termWithField:(UMTerm *)fieldNameTerm
{
    UMDiscreteValue *d = fieldNameTerm.discrete;
    UMTerm *term = [[UMTerm alloc]initWithFieldName:d.stringValue];
    return term;
}

+ (id)termWithConstant:(UMTerm *)constantTerm
{
    return constantTerm;
}

+ (id)termWithString:(UMTerm *)stringTerm
{
    return stringTerm;
}

- (void) setDiscreteString:(NSString *)s
{
    UMDiscreteValue *d = [UMDiscreteValue discreteString:s];
    self.discrete = d;
}


- (NSString * )debugDescription
{
    
NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString: [super description]];
    switch(type)
    {
        case UMTermType_discrete:
            [s appendString:@"\r type=discrete\r"];
            break;
        case UMTermType_field:
            [s appendString:@"\r type=field\r"];
            break;
        case UMTermType_variable:
            [s appendString:@"\r type=variable\r"];
            break;
        case UMTermType_function:
            [s appendString:@"\r type=function\r"];
            break;
        default:
            [s appendString:@"\r type=unknown\r"];
            break;
    }
    [s appendFormat:@" discrete=%@\r", discrete ? [discrete debugDescription] : @"nil"];
    [s appendFormat:@" function=%@\r", function ? [function debugDescription] : @"nil"];
    [s appendFormat:@" fieldname=%@\r", fieldname ? fieldname : @"nil"];
    [s appendFormat:@" varname=%@\r", varname ? varname : @"nil"];
    [s appendFormat:@" paramcount=%d\r", (int)param.count ];
    [s appendFormat:@" token=%d\r", token];
    return s;
}

@end
