//
//  UMTerm.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMTerm.h"
#import "UMFunction.h"
#import "UMFunctionMacros.h"
#import "NSNumber+UMScript.h"
#import "UMEnvironment.h"

@implementation UMTerm

@synthesize type;
@synthesize param;
@synthesize fieldname;
@synthesize varname;
@synthesize discrete;
@synthesize function;
@synthesize token;
@synthesize identifier;

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)env;
{
    switch(type)
    {
        case UMTermType_identifier:
        {
            return discrete;
        }
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
        case UMTermType_nullterm:
        {
            return [UMDiscreteValue discreteNull];
        }
    }
    return [UMDiscreteValue discreteNull];
}

- (id)initWithNull
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_nullterm;
    }
    return self;
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

- (id)initWithIdentifier:(NSString *)ident
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_identifier;
        self.identifier = ident;
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
        case UMTermType_nullterm:
            return @{@"NULLTERM" :@"NULL"};
        case UMTermType_identifier:
            return @{@"IDENTIFIER" : identifier };
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

+ (id)termWithNull
{
    UMTerm *term = [[UMTerm alloc]initWithNull];
    return term;
}

+ (id)termWithIdentifier:(UMTerm *)identifier
{
    UMDiscreteValue *d = identifier.discrete;
    UMTerm *term = [[UMTerm alloc]initWithIdentifier:d.stringValue];
    return term;
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

+ (id)termWithDirectInteger:(int)i
{
    UMDiscreteValue *d = [UMDiscreteValue discreteInt:i];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d];
    return term;
   
}

+ (id)termWithDirectString:(NSString *)s
{
    UMDiscreteValue *d = [UMDiscreteValue discreteString:s];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d];
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

- (UMTerm *)add:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_add alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)sub:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_sub alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)mul:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_mul alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)div:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)modulo:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)dot:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_dot alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)logical_not
{
    UMFunction *func = [[UMFunction_not alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;
}

- (UMTerm *)equal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_equal alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)notequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_notequal alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)greaterthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterthan alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)lessthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessthan alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)greaterorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterorequal alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)lessorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessorequal alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)assign:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_assign alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)logical_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_and alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;

}

- (UMTerm *)logical_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_or alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)logical_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_xor alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)bit_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_and alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;

}

- (UMTerm *)bit_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_or alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;

}

- (UMTerm *)bit_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_xor alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;

}

- (UMTerm *)bit_not
{
    UMFunction *func = [[UMFunction_bit_not alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;

}

- (UMTerm *)leftshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftleft alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

- (UMTerm *)rightshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftright alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]];
    return result;
}

+ (UMTerm *)whileCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo
{
    UMFunction *func = [[UMFunction_while alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thendo]];
    return result;
}

+ (UMTerm *)ifCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo elseDo:(UMTerm *)elsedo
{
    UMFunction *func = [[UMFunction_if alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thendo,(elsedo ? elsedo : [NSNull null])]];
    return result;
}

+ (UMTerm *)thenDo:(UMTerm *)thendo whileCondition:(UMTerm *)condition
{
    UMFunction *func = [[UMFunction_dowhile alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[thendo,condition]];
    return result;

}

+ (UMTerm *)forInitializer:(UMTerm *)initializer endCondition:(UMTerm *)condition every:(UMTerm *)every thenDo:(UMTerm *)thenDo
{
    UMFunction *func = [[UMFunction_for alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:
                       @[ (initializer ? initializer: [NSNull null]),
                          (condition ? condition : [NSNull null]),
                           (every ? every : [NSNull null]),
                          thenDo]];
    return result;
}

- (UMTerm *)preincrease
{
    UMFunction *func = [[UMFunction_preincrease alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;
}

- (UMTerm *)postincrease
{
    UMFunction *func = [[UMFunction_postincrease alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;
}
- (UMTerm *)predecrease
{
    UMFunction *func = [[UMFunction_predecrease alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;

}
- (UMTerm *)postdecrease
{
    UMFunction *func = [[UMFunction_postdecrease alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]];
    return result;
}

+ (UMTerm *)switchCondition:(UMTerm *)condition thenDo:(UMTerm *)thenDo
{
    UMFunction *func = [[UMFunction_switch alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thenDo]];
    return result;
}

@end
