//
//  UMTerm.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
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
@synthesize label;
@synthesize env;

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)xenv;
{
    switch(type)
    {
        case UMTermType_identifier:
        {
            return [UMDiscreteValue discreteString:identifier];
        }
        case UMTermType_discrete:
        {
            return discrete;
        }
        case UMTermType_variable:
        {
            return [xenv variableForKey:varname];
        }
        case UMTermType_field:
        {
            return [xenv fieldForKey:fieldname];
        }
        case UMTermType_function:
        {
            return [function evaluateWithParams:param environment:xenv];
        }
        case UMTermType_nullterm:
        {
            return [UMDiscreteValue discreteNull];
        }
        case UMTermType_token:
        {
            return [UMDiscreteValue discreteString:identifier];
        }
    }
    return [UMDiscreteValue discreteNull];
}

- (id)initWithNullWithEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(null)"];
    if(self)
    {
        self.type = UMTermType_nullterm;
        self.env = e;
    }
    return self;
}

- (id)initWithDiscreteValue:(UMDiscreteValue *)d withEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(discrete)"];
    if(self)
    {
        self.type = UMTermType_discrete;
        self.discrete = d;
        self.env = e;
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)ident withEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(identifier)"];
    if(self)
    {
        self.type = UMTermType_identifier;
        self.identifier = ident;
        self.env = e;
    }
    return self;
}

- (id)initWithFieldName:(NSString *)fieldName withEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(field)"];
    if(self)
    {
        self.type = UMTermType_field;
        self.fieldname = fieldName;
        self.env = e;
    }
    return self;
}

- (id)initWithVariableName:(NSString *)variableName  withEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(variable)"];
    if(self)
    {
        self.type = UMTermType_variable;
        self.varname = variableName;
        self.env = e;
    }
    return self;
}

- (id)initWithFunction:(UMFunction *)func andParams:(NSArray *)params  withEnvironment:(UMEnvironment *)e
{
    self = [super initWithMagic:@"UMTerm(function)"];
    if(self)
    {
        self.type = UMTermType_function;
        self.function = func;
        self.param = params;
        self.env = e;
    }
    return self;
}

- (id)initWithString:(NSString *)s  withEnvironment:(UMEnvironment *)e
{
    return [self initWithDiscreteValue:[UMDiscreteValue discreteString:s] withEnvironment:e];
}

- (id)initWithInt:(int)i  withEnvironment:(UMEnvironment *)e
{
    return [self initWithDiscreteValue:[UMDiscreteValue discreteInt:i] withEnvironment:e];
}


- (BOOL)boolValue:(UMEnvironment *)e
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:e];
    return [d boolValue];
}

- (NSString *)stringValue:(UMEnvironment *)e
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:e];
    return [d stringValue];
}

- (NSData *)dataValue:(UMEnvironment *)e
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:e];
    return [d dataValue];
}

- (int)intValue:(UMEnvironment *)e
{
    UMDiscreteValue *d = [self evaluateWithEnvironment:e];
    return [d intValue];
}


- (NSString *)descriptionJson
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
        case UMTermType_token:
            return @{@"TOKEN" : [NSString stringWithFormat:@"%d",token], @"IDENTIFIER" : identifier};
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

- (NSString *)codeWithEnvironment:(UMEnvironment *)e
{

    if(type==UMTermType_discrete)
    {
        return [discrete codeWithEnvironment:e];
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
        [s appendString:[function codeWithEnvironmentStart:e]];
        NSUInteger i=0;
        NSUInteger n = param.count;
        for(UMTerm *p in param)
        {
            i++;
            if(i==1)
            {
                [s appendString:[function codeWithEnvironmentFirstParam:p env:e]];
            }
            else if(i==n)
            {
                [s appendString:[function codeWithEnvironmentLastParam:p env:e]];
            }
            else 
            {
                [s appendString:[function codeWithEnvironmentNextParam:p env:e]];
            }
        }
        [s appendString:[function codeWithEnvironmentStop:env]];
        return s;
    }
    return @"/*unknown UMTerm */";
}

+ (id)termWithNullWithEnvironment:(UMEnvironment *)e
{
    UMTerm *term = [[UMTerm alloc]initWithNullWithEnvironment:e];
    return term;
}

+ (id)termWithIdentifierFromTag:(UMTerm *)identifier  withEnvironment:(UMEnvironment *)e
{
    UMTerm *term = [[UMTerm alloc]initWithIdentifier:identifier.identifier  withEnvironment:e];
    return term;
}


+ (id)termWithVariableFromTag:(UMTerm *)varNameTerm  withEnvironment:(UMEnvironment *)e
{
    UMTerm *term = [[UMTerm alloc]initWithVariableName:varNameTerm.identifier  withEnvironment:e];
    return term;
}

+ (id)termWithFieldFromTag:(UMTerm *)fieldNameTerm  withEnvironment:(UMEnvironment *)e
{
    /* the term being passed here is a token term */
    UMTerm *term = [[UMTerm alloc]initWithFieldName:fieldNameTerm.identifier withEnvironment:e];
    return term;
}

+ (id)termWithStringFromTag:(UMTerm *)stringTagTerm  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteQuotedString:stringTagTerm.identifier];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithIntegerFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    int i = atoi(tagTerm.identifier.UTF8String);
    UMDiscreteValue *d = [UMDiscreteValue discreteInt:i];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d  withEnvironment:e];
    return term;
}

+ (id)termWithLongLongFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    long long ll = atoll(tagTerm.identifier.UTF8String);
    UMDiscreteValue *d = [UMDiscreteValue discreteLongLong:ll];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithDoubleFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    double dd = atof(tagTerm.identifier.UTF8String);
    UMDiscreteValue *d = [UMDiscreteValue discreteDouble:dd];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithBooleanFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteBool:[tagTerm.identifier isEqualToString:@"YES"]];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithHexFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    /* TODO: parse the string in hex way to create an integer */
    UMDiscreteValue *d = [UMDiscreteValue discreteString:tagTerm.identifier];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithOctalFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    /* TODO: parse the string in octal way to create an integer */
    UMDiscreteValue *d = [UMDiscreteValue discreteString:tagTerm.identifier];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
}

+ (id)termWithBinaryFromTag:(UMTerm *)tagTerm  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteString:tagTerm.identifier];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d  withEnvironment:e];
    return term;
}


+ (id)termWithDirectInteger:(int)i  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteInt:i];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
   
}

+ (id)termWithDirectString:(NSString *)s  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteString:s];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
    
}

+ (id)termWithDirectCString:(char *)s  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [UMDiscreteValue discreteString:@(s)];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
    return term;
    
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

- (NSString * )description
{
    
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString: [super description]];
    switch(type)
    {
        case UMTermType_discrete:
            [s appendFormat:@"discrete: %@\r",[discrete description]];
            break;
        case UMTermType_field:
            [s appendFormat:@"field: %@\r",fieldname];
            break;
        case UMTermType_variable:
            [s appendFormat:@"variable: %@\r",varname];
            break;
        case UMTermType_function:
            [s appendFormat:@"function: %@\r",[function name]];
            [s appendFormat:@" parameter.count=%d\r", (int)param.count ];
            break;
        case UMTermType_identifier:
            [s appendFormat:@"identifier: %@\r",identifier];
            break;
        case UMTermType_token:
            [s appendFormat:@"token: %d\r",token];
            [s appendFormat:@"value: %@\r",identifier];
            break;
        default:
            [s appendString:@"unknown UMTerm type\r"];
            break;
    }
    return s;
}

- (UMTerm *)add:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_add alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]  withEnvironment:self.env];
    return result;
}

- (UMTerm *)sub:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_sub alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)mul:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_mul alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)div:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)modulo:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)dot:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_dot alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_not
{
    UMFunction *func = [[UMFunction_not alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:self.env];
    return result;
}

- (UMTerm *)equal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_equal alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)notequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_notequal alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)greaterthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterthan alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)lessthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessthan alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)greaterorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterorequal alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)lessorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessorequal alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)assign:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_assign alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_and alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)logical_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_or alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_xor alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)bit_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_and alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_or alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_xor alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_not
{
    UMFunction *func = [[UMFunction_bit_not alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:self.env];
    return result;

}

- (UMTerm *)leftshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftleft alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)rightshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftright alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

+ (UMTerm *)returnValue:(UMTerm *)val withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_return alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[val] withEnvironment:cenv];
    return result;
}

+ (UMTerm *)whileCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_while alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thendo] withEnvironment:cenv];
    return result;
}

+ (UMTerm *)ifCondition:(UMTerm *)condition thenDo:(UMTerm *)thendo elseDo:(UMTerm *)elsedo withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_if alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thendo,(elsedo ? elsedo : [NSNull null])] withEnvironment:cenv];
    return result;
}

+ (UMTerm *)thenDo:(UMTerm *)thendo whileCondition:(UMTerm *)condition withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_dowhile alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[thendo,condition]  withEnvironment:cenv];
    return result;

}

+ (UMTerm *)forInitializer:(UMTerm *)initializer endCondition:(UMTerm *)condition every:(UMTerm *)every thenDo:(UMTerm *)thenDo withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_for alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:
                       @[ (initializer ? initializer: [NSNull null]),
                          (condition ? condition : [NSNull null]),
                           (every ? every : [NSNull null]),
                          thenDo]  withEnvironment:cenv];
    return result;
}

- (UMTerm *)preincrease
{
    UMFunction *func = [[UMFunction_preincrease alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:cenv];
    return result;
}

- (UMTerm *)postincrease
{
    UMFunction *func = [[UMFunction_postincrease alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:cenv];
    return result;
}
- (UMTerm *)predecrease
{
    UMFunction *func = [[UMFunction_predecrease alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:cenv];
    return result;

}

- (UMTerm *)postdecrease
{
    UMFunction *func = [[UMFunction_postdecrease alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]  withEnvironment:cenv];
    return result;
}

+ (UMTerm *)blockWithStatement:(UMTerm *)statement withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_block alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[statement] withEnvironment:cenv];
    return result;
}

- (UMTerm *)blockAppendStatement:(UMTerm *)term
{
    if((type == UMTermType_function) && ([function isKindOfClass:[UMFunction_block class]]))
    {
        param = [param arrayByAddingObject:term];
        return self;
    }
    else
    {
        UMTerm *block = [UMTerm blockWithStatement:self withEnvironment:self.env];
        block.param = [block.param arrayByAddingObject:term];
        return block;
    }
}



+ (UMTerm *)listWithStatement:(UMTerm *)statement withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_list alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[statement] withEnvironment:cenv];
    return result;
}

- (UMTerm *)listAppendStatement:(UMTerm *)term
{
    if((type == UMTermType_function) && ([function isKindOfClass:[UMFunction_list class]]))
    {
        param = [param arrayByAddingObject:term];
        return self;
    }
    else
    {
        UMTerm *block = [UMTerm listWithStatement:self withEnvironment:self.env];
        block.param = [block.param arrayByAddingObject:term];
        return block;
    }
}


+ (UMTerm *)switchCondition:(UMTerm *)condition thenDo:(UMTerm *)thenDo withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_switch alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[condition,thenDo]  withEnvironment:cenv];
    return result;
}

+ (UMTerm *)token:(int)tok text:(const char *)text withEnvironment:(UMEnvironment *)cenv
{
    UMTerm *result = [[UMTerm alloc] init];
    result.env = cenv;
    result.type =UMTermType_token;
    result.identifier = @(text);
    return result;
}

+ (UMTerm *)letsGoto:(UMTerm *)labelTerm withEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_goto alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[labelTerm] withEnvironment:cenv];
    return result;
}

+ (UMTerm *)letsContinueWithEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_goto alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[] withEnvironment:cenv];
    return result;
}

+ (UMTerm *)letsBreakWithEnvironment:(UMEnvironment *)cenv
{
    UMFunction *func = [[UMFunction_break alloc]initWithEnvironment:cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[] withEnvironment:cenv];
    return result;
}

- (UMTerm *)functionCallWithArguments:(UMTerm *)list environment:(UMEnvironment *)env1;
{
    if(type != UMTermType_identifier)
    {
        return [UMTerm termWithNullWithEnvironment:env1];
    }
    NSArray *params;
    if(list == NULL)
    {
        params = @[];
    }
     else if((list.type == UMTermType_function) && ([list.function isKindOfClass:[UMFunction_list class]]))
    {
        /* this is a list with multiple items */
        params = list.param;
    }
    else
    {
        /* this is not yet a list but a single item */
        params = @[list];
    }

    NSString *name=identifier;
    UMFunction *f = [env functionByName:name];
    if(f == NULL)
    {
        return [UMTerm termWithNullWithEnvironment:env1];
    }
    f.cenv = env1;
    
    UMTerm *result =  [[UMTerm alloc] initWithFunction:f andParams:params withEnvironment:cenv];
    return result;
}

- (UMTerm *)dotIdentifier:(UMTerm *)list /* object.access */
{
    /*TODO: missing implemementation */
    return self;
}

- (NSString *)constantStringValue
{
    switch(type)
    {
        case UMTermType_discrete:
            return [discrete stringValue];
            break;
        case UMTermType_field:
            return fieldname;
            break;
        case UMTermType_variable:
            return varname;
            break;
        case UMTermType_function:
            return [function name];
            break;
        case UMTermType_identifier:
            return identifier;
            break;
        case UMTermType_token:
            return identifier;
            break;
        default:
            return @"";
            break;
    }
}

- (NSString *)labelValue
{
    switch(type)
    {
        case UMTermType_discrete:
            return [discrete labelValue];
            break;
        case UMTermType_field:
            @throw [NSError errorWithDomain:@"umscript" code:2 userInfo:@{@"sysmsg":[NSString stringWithFormat:@"Nonstatic label %@",fieldname]}];
            break;
        case UMTermType_variable:
            @throw [NSError errorWithDomain:@"umscript" code:2 userInfo:@{@"sysmsg":[NSString stringWithFormat:@"Nonstatic label %@",varname]}];
            break;
        case UMTermType_function:
            @throw [NSError errorWithDomain:@"umscript" code:2 userInfo:@{@"sysmsg":[NSString stringWithFormat:@"Unknown label %@",[function name]]}];
            break;
        case UMTermType_identifier:
            return identifier;
            break;
        case UMTermType_token:
            return identifier;
            break;
        default:
            return @"";
            break;
    }
}

@end
