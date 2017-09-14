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
#import "NSString+UMScript.h"
#import "UMTerm_Interrupt.h"

@implementation UMTerm

- (void) processBeforeEncode
{
    [super processBeforeEncode];

    asn1_tag.tagClass = UMASN1Class_ContextSpecific;
    asn1_tag.isConstructed=NO;

    switch(_type)
    {
        case UMTermType_discrete:
        {
            self.asn1_tag.tagNumber = 0;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            [asn1_list addObject:_discrete];
            break;
        }
        case UMTermType_field:
        {
            self.asn1_tag.tagNumber = 1;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *s = [[UMASN1UTF8String alloc]initWithValue:_fieldname];
            [asn1_list addObject:s];
            break;
        }
        case UMTermType_variable:
        {
            self.asn1_tag.tagNumber = 2;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *s = [[UMASN1UTF8String alloc]initWithValue:_varname];
            [asn1_list addObject:s];
            break;
        }
        case UMTermType_functionCall:
        {
            self.asn1_tag.tagNumber = 3;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            [asn1_list addObject:_function];
            break;
        }
        case UMTermType_functionDefinition:
        {
            /* CHECK THIS */
            self.asn1_tag.tagNumber = 4;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            [asn1_list addObject:_function];
            break;
        }
      case UMTermType_identifier:
        {
            self.asn1_tag.tagNumber = 5;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1UTF8String *s = [[UMASN1UTF8String alloc]initWithValue:_identifier];
            [asn1_list addObject:s];
            break;
        }
        case UMTermType_nullterm:
        {
            self.asn1_tag.tagNumber = 6;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1Null *s = [[UMASN1Null alloc]init];
            [asn1_list addObject:s];
            break;
        }
        case UMTermType_token:
        default:
        {
            self.asn1_tag.tagNumber = 7;
            asn1_tag.isConstructed=YES;
            asn1_list = [[NSMutableArray alloc]init];
            UMASN1Integer *s = [[UMASN1Integer alloc]initWithValue:_token];
            [asn1_list addObject:s];
            break;
        }

    }
}


- (UMTerm *) processAfterDecodeWithContext:(id)context
{
    int p=0;
    UMASN1Object *o = NULL;
    BOOL allFine = NO;
    if(self.asn1_tag.tagClass == UMASN1Class_ContextSpecific)
    {
        o = [self getObjectAtPosition:p++];
        if(o)
        {
            switch(o.asn1_tag.tagNumber)
            {
                case 0:
                {
                    _type = UMTermType_discrete;
                    _discrete = [[UMDiscreteValue alloc]initWithASN1Object:o context:context];
                    if(_discrete)
                    {
                        allFine = YES;
                    }
                    break;
                }
                case 1:
                {
                    _type = UMTermType_field;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    _fieldname = utf8.stringValue;
                    if(_fieldname.length > 0)
                    {
                        allFine = YES;
                    }
                    break;
                }
                case 2:
                {
                    _type = UMTermType_variable;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    _varname = utf8.stringValue;
                    if(_varname.length > 0)
                    {
                        allFine = YES;
                    }
                    break;
                }
                case 3:
                {
                    _type = UMTermType_functionCall;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    NSString *name = utf8.stringValue;
                    UMFunction *f;
                    if([name isEqualTo:[UMFunction_add functionName]])
                    {
                        f = [[UMFunction_add alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_sub functionName]])
                    {
                        f = [[UMFunction_sub alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_mul functionName]])
                    {
                        f = [[UMFunction_mul alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_div functionName]])
                    {
                        f = [[UMFunction_div alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_dot functionName]])
                    {
                        f = [[UMFunction_dot alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_modulo functionName]])
                    {
                        f = [[UMFunction_modulo alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_if functionName]])
                    {
                        f = [[UMFunction_if alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_not functionName]])
                    {
                        f = [[UMFunction_not alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_and functionName]])
                    {
                        f = [[UMFunction_and alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_or functionName]])
                    {
                        f = [[UMFunction_or alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_xor functionName]])
                    {
                        f = [[UMFunction_xor alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_not functionName]])
                    {
                        f = [[UMFunction_bit_not alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_and functionName]])
                    {
                        f = [[UMFunction_bit_and alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_or functionName]])
                    {
                        f = [[UMFunction_bit_or alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_xor functionName]])
                    {
                        f = [[UMFunction_bit_xor alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_shiftleft functionName]])
                    {
                        f = [[UMFunction_bit_shiftleft alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_bit_shiftright functionName]])
                    {
                        f = [[UMFunction_bit_shiftright alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_equal functionName]])
                    {
                        f = [[UMFunction_equal alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_notequal functionName]])
                    {
                        f = [[UMFunction_notequal alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_greaterthan functionName]])
                    {
                        f = [[UMFunction_greaterthan alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_greaterorequal functionName]])
                    {
                        f = [[UMFunction_greaterorequal alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_lessthan functionName]])
                    {
                        f = [[UMFunction_lessthan alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_lessorequal functionName]])
                    {
                        f = [[UMFunction_lessorequal alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_startswith functionName]])
                    {
                        f = [[UMFunction_startswith alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_endswith functionName]])
                    {
                        f = [[UMFunction_endswith alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_setvar functionName]])
                    {
                        f = [[UMFunction_setvar alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_setfield functionName]])
                    {
                        f = [[UMFunction_setfield alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_getvar functionName]])
                    {
                        f = [[UMFunction_getvar alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_getfield functionName]])
                    {
                        f = [[UMFunction_getfield alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_block functionName]])
                    {
                        f = [[UMFunction_block alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_return functionName]])
                    {
                        f = [[UMFunction_return alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_assign functionName]])
                    {
                        f = [[UMFunction_assign alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_while functionName]])
                    {
                        f = [[UMFunction_while alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_dowhile functionName]])
                    {
                        f = [[UMFunction_dowhile alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_for functionName]])
                    {
                        f = [[UMFunction_for alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_preincrease functionName]])
                    {
                        f = [[UMFunction_preincrease alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_predecrease functionName]])
                    {
                        f = [[UMFunction_predecrease alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_postincrease functionName]])
                    {
                        f = [[UMFunction_postincrease alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_postdecrease functionName]])
                    {
                        f = [[UMFunction_postdecrease alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_switch functionName]])
                    {
                        f = [[UMFunction_switch alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_print functionName]])
                    {
                        f = [[UMFunction_print alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_goto functionName]])
                    {
                        f = [[UMFunction_goto alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_continue functionName]])
                    {
                        f = [[UMFunction_continue alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_break functionName]])
                    {
                        f = [[UMFunction_break alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_substr functionName]])
                    {
                        f = [[UMFunction_substr alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_list functionName]])
                    {
                        f = [[UMFunction_list alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_equalCaseInsensitive functionName]])
                    {
                        f = [[UMFunction_equalCaseInsensitive alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_stringCompare functionName]])
                    {
                        f = [[UMFunction_stringCompare alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_datetime functionName]])
                    {
                        f = [[UMFunction_datetime alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_hash functionName]])
                    {
                        f = [[UMFunction_hash alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_namedlist_add functionName]])
                    {
                        f = [[UMFunction_namedlist_add alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_namedlist_remove functionName]])
                    {
                        f = [[UMFunction_namedlist_remove alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_namedlist_contains functionName]])
                    {
                        f = [[UMFunction_namedlist_contains alloc]initWithEnvironment:context];
                    }
                    else if([name isEqualTo:[UMFunction_regex functionName]])
                    {
                        f = [[UMFunction_regex alloc]initWithEnvironment:context];
                    }

                    _function = f;
                    if(_function)
                    {
                        allFine = YES;
                    }
                    break;
                }
                case 4:
                {
                    _type = UMTermType_functionDefinition;
                    /* FIXME: how to encode/decode a function definition ? */
                    break;
                }
                case 5:
                {
                    _type = UMTermType_identifier;
                    UMASN1UTF8String *utf8 = [[UMASN1UTF8String alloc]initWithASN1Object:o context:context];
                    _identifier  = utf8.stringValue;
                    if(_identifier.length > 0)
                    {
                        allFine = YES;
                    }
                    break;
                }
                case 6:
                {
                    _type = UMTermType_nullterm;
                    allFine = YES;
                    break;
                }
                case 7:
                {
                    _type = UMTermType_token;
                    UMASN1Integer *i = [[UMASN1Integer alloc]initWithASN1Object:o context:context];
                    _token = (int)[i value];
                    allFine = YES;
                    break;
                }
            }
        }
    }
    if(allFine == NO)
    {
        @throw([NSException exceptionWithName:@"INVALID_ASN1" reason:@"while decoding UMTerm, the type could not be decoded" userInfo:NULL]);
    }
    return self;
}

- (NSString *) objectName
{
    return @"UMTerm";
}


- (id) objectValue
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];

    switch(_type)
    {
        case UMTermType_discrete:
            dict[@"_discrete"] = _discrete.objectValue;
        case UMTermType_field:
            dict[@"field"] = _fieldname;
        case UMTermType_variable:
            dict[@"variable"] = _varname;
        case UMTermType_functionCall:
            dict[@"function-call"] = _function.name;
        case UMTermType_functionDefinition:
            dict[@"function-definition"] = _function.name;
        case UMTermType_identifier:
            dict[@"identifier"] = _identifier;
        case UMTermType_nullterm:
            dict[@"null"] = @"null";
        case UMTermType_token:
            dict[@"token"] = @(_token);
    }
    return dict;
}

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)xenv
{
    return [self evaluateWithEnvironment:xenv continueFrom:NULL];
}

- (UMDiscreteValue *)evaluateWithEnvironment:(UMEnvironment *)xenv continueFrom:(UMTerm_Interrupt *)interruptedFrom;
{
    UMDiscreteValue *returnvalue;
    switch(_type)
    {
        case UMTermType_identifier:
        {
            returnvalue = [UMDiscreteValue discreteString:_identifier];
            break;
        }
        case UMTermType_discrete:
        {
            returnvalue = _discrete;
            break;
        }
        case UMTermType_variable:
        {
            returnvalue = [xenv variableForKey:_varname];
            break;
        }
        case UMTermType_field:
        {
            returnvalue = [xenv fieldForKey:_fieldname];
            break;
        }
        case UMTermType_functionCall:
        {
            @try
            {
                [xenv pushStack];
                returnvalue = [_function evaluateWithParams:_param environment:xenv continueFrom:interruptedFrom];
                [xenv popStack];
            }
            @catch(UMTerm_Interrupt *interruption)
            {
                @throw(interruption);
            }
            break;
        }
        case UMTermType_functionDefinition:
        {
            returnvalue = [UMDiscreteValue discreteNull];
            break;
        }
        case UMTermType_nullterm:
        {
            returnvalue = [UMDiscreteValue discreteNull];
            break;
        }
        case UMTermType_token:
        {
            returnvalue = [_identifier discreteValue];
            break;
        }
        default:
        {
            returnvalue = [UMDiscreteValue discreteNull];
            break;
        }
    }
    if(xenv.trace)
    {
        [xenv trace:[NSString stringWithFormat:@"evaluating: %@ returns %@",self.description,returnvalue.description]];
    }
    return returnvalue;
}

- (id)initWithNullWithEnvironment:(UMEnvironment *)e
{
    self = [super init];
    if(self)
    {
        self.type = UMTermType_nullterm;
        self.env = e;
    }
    return self;
}


- (id)initWithDiscreteValue:(UMDiscreteValue *)d withEnvironment:(UMEnvironment *)e
{
    self = [super init];
    if(self)
    {
        _type = UMTermType_discrete;
        _discrete = d;
        _env = e;
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)ident withEnvironment:(UMEnvironment *)e
{
    if([ident hasPrefix:@"$"])
    {
        return [self initWithVariableName:ident  withEnvironment:e];
    }
    if([ident hasPrefix:@"%"])
    {
        return [self initWithFieldName:ident  withEnvironment:e];
    }

    UMDiscreteValue *d = [ident discreteValue];
    if(d)
    {
        return [self initWithDiscreteValue:d withEnvironment:e];
    }
    self = [super init];
    if(self)
    {
        _type = UMTermType_identifier;
        _identifier = ident;
        _env = e;
    }
    return self;
}

- (id)initWithFieldName:(NSString *)fieldName withEnvironment:(UMEnvironment *)e
{
    self = [super init];
    if(self)
    {
        _type = UMTermType_field;
        _fieldname = fieldName;
        _env = e;
    }
    return self;
}

- (id)initWithVariableName:(NSString *)variableName  withEnvironment:(UMEnvironment *)e
{
    self = [super init];
    if(self)
    {
        _type = UMTermType_variable;
        _varname = variableName;
        _env = e;
    }
    return self;
}

- (id)initWithFunction:(UMFunction *)func andParams:(NSArray *)params  withEnvironment:(UMEnvironment *)e
{
    self = [super init];
    if(self)
    {
        _type = UMTermType_functionCall;
        _function = func;
        _param = params;
        _env = e;
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
    switch(_type)
    {
        case UMTermType_nullterm:
            return @{@"NULLTERM" :@"NULL"};
        case UMTermType_identifier:
            return @{@"IDENTIFIER" : _identifier };
        case UMTermType_discrete:
            return [_discrete descriptionDictVal];
        case UMTermType_variable:
            return @{@"VAR" : _varname}; //[env variableForKey:varname];
        case UMTermType_field:
            return @{@"FIELD" : _fieldname};
        case UMTermType_token:
            return @{@"TOKEN" : [NSString stringWithFormat:@"%d",_token], @"IDENTIFIER" : _identifier};
        case UMTermType_functionCall:
        {
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            dict[@"function"] = [_function descriptionDictVal];
            NSMutableArray *pdesc =[[NSMutableArray alloc]init];
            for (UMTerm *p in _param)
            {
                [pdesc addObject:[p descriptionDictVal]];
            }
            dict[@"params"] = pdesc;
            return dict;
        }
        case UMTermType_functionDefinition:
        {
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            dict[@"functionDefinition"] = [_function descriptionDictVal];
            NSMutableArray *pdesc =[[NSMutableArray alloc]init];
            for (UMTerm *p in _param)
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
        _type= UMTermType_functionCall;
        _function = func;
        _param = p;
    }
    return self;
}

- (NSString *)codeWithEnvironment:(UMEnvironment *)e
{

    if(_type==UMTermType_discrete)
    {
        return [_discrete codeWithEnvironment:e];
    }
    if(_type==UMTermType_field)
    {
        return [NSString stringWithFormat:@"%%%@",_fieldname];
    }
    if(_type==UMTermType_variable)
    {
        return [NSString stringWithFormat:@"%%%@",_varname];
    }
    if(_type==UMTermType_functionCall)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [s appendString:[_function codeWithEnvironmentStart:e]];
        NSUInteger i=0;
        NSUInteger n = _param.count;
        for(UMTerm *p in _param)
        {
            i++;
            if(i==1)
            {
                [s appendString:[_function codeWithEnvironmentFirstParam:p env:e]];
            }
            else if(i==n)
            {
                [s appendString:[_function codeWithEnvironmentLastParam:p env:e]];
            }
            else 
            {
                [s appendString:[_function codeWithEnvironmentNextParam:p env:e]];
            }
        }
        [s appendString:[_function codeWithEnvironmentStop:_env]];
        return s;
    }
    if(_type==UMTermType_functionDefinition)
    {
        /* FIXME */;
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

+ (id)termWithConstantFromTag:(UMTerm *)stringTagTerm  withEnvironment:(UMEnvironment *)e
{
    UMDiscreteValue *d = [stringTagTerm.identifier discreteValue];
    UMTerm *term = [[UMTerm alloc]initWithDiscreteValue:d withEnvironment:e];
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
    switch(_type)
    {
        case UMTermType_discrete:
            [s appendFormat:@"_discrete: %@\r",[_discrete description]];
            break;
        case UMTermType_field:
            [s appendFormat:@"field: %@\r",_fieldname];
            break;
        case UMTermType_variable:
            [s appendFormat:@"variable: %@\r",_varname];
            break;
        case UMTermType_functionCall:
            [s appendFormat:@"function: %@\r",_function.name];
            [s appendFormat:@" parameter.count=%d\r", (int)_param.count ];
            break;
        case UMTermType_functionDefinition:
            [s appendFormat:@"functionDefinition: %@\r",_function.name];
            /* FIXME */
            break;
        case UMTermType_identifier:
            [s appendFormat:@"identifier: %@\r",_identifier];
            break;
        case UMTermType_token:
            [s appendFormat:@"token: %d\r",_token];
            [s appendFormat:@"value: %@\r",_identifier];
            break;
        default:
            [s appendString:@"unknown UMTerm type\r"];
            break;
    }
    return s;
}

- (UMTerm *)invertSign
{
    UMFunction *func = [[UMFunction_sub alloc]initWithEnvironment:_env];
    
    UMDiscreteValue *_discreteZero = [[UMDiscreteValue alloc]initWithInt:0];
    UMTerm *zero = [[UMTerm alloc]initWithDiscreteValue:_discreteZero withEnvironment:NULL];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[zero,self]  withEnvironment:self.env];
    return result;
}
- (UMTerm *)add:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_add alloc]initWithEnvironment:_env];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b]  withEnvironment:self.env];
    return result;
}

- (UMTerm *)sub:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_sub alloc]initWithEnvironment:_env];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)mul:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_mul alloc]initWithEnvironment:_env];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)div:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)modulo:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_div alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)dot:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_dot alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_not
{
    UMFunction *func = [[UMFunction_not alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:self.env];
    return result;
}

- (UMTerm *)equal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_equal alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)notequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_notequal alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)greaterthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterthan alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)lessthan:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessthan alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)greaterorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_greaterorequal alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)lessorequal:(UMTerm *)b;
{
    UMFunction *func = [[UMFunction_lessorequal alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)assign:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_assign alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_and alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)logical_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_or alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)logical_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_xor alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)bit_and:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_and alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_or:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_or alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_xor:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_xor alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;

}

- (UMTerm *)bit_not
{
    UMFunction *func = [[UMFunction_bit_not alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:self.env];
    return result;

}

- (UMTerm *)leftshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftleft alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self,b] withEnvironment:self.env];
    return result;
}

- (UMTerm *)rightshift:(UMTerm *)b
{
    UMFunction *func = [[UMFunction_bit_shiftright alloc]initWithEnvironment:_cenv];
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
    UMFunction *func = [[UMFunction_preincrease alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:_cenv];
    return result;
}

- (UMTerm *)postincrease
{
    UMFunction *func = [[UMFunction_postincrease alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:_cenv];
    return result;
}
- (UMTerm *)predecrease
{
    UMFunction *func = [[UMFunction_predecrease alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self] withEnvironment:_cenv];
    return result;

}

- (UMTerm *)postdecrease
{
    UMFunction *func = [[UMFunction_postdecrease alloc]initWithEnvironment:_cenv];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams: @[self]  withEnvironment:_cenv];
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
    if((_type == UMTermType_functionCall) && ([_function isKindOfClass:[UMFunction_block class]]))
    {
        _param = [_param arrayByAddingObject:term];
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
    if((_type == UMTermType_functionCall) && ([_function isKindOfClass:[UMFunction_list class]]))
    {
        _param = [_param arrayByAddingObject:term];
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


+ (UMTerm *)functionDefinitionWithName:(UMTerm *)name
                            statements:(UMTerm *)statements
                           environment:(UMEnvironment *)context
{
    return [[UMTerm alloc]initWithfunctionDefinitionName:name statements:statements environment:context];
}

- (UMTerm *)initWithfunctionDefinitionName:(UMTerm *)name
                                statements:(UMTerm *)statements
                               environment:(UMEnvironment *)env1
{
    self = [super init];
    if(self)
    {
        _type = UMTermType_functionDefinition;
        _function = [[UMFunction alloc]initWithName:name.identifier statements:statements];
    }
    return self;
}

- (UMTerm *)functionCallWithArguments:(UMTerm *)list environment:(UMEnvironment *)context;
{
    UMFunction *f = NULL;
    NSString *name = _identifier;
    if([name isEqualTo:[UMFunction_add functionName]])
    {
        f = [[UMFunction_add alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_sub functionName]])
    {
        f = [[UMFunction_sub alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_mul functionName]])
    {
        f = [[UMFunction_mul alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_div functionName]])
    {
        f = [[UMFunction_div alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_dot functionName]])
    {
        f = [[UMFunction_dot alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_modulo functionName]])
    {
        f = [[UMFunction_modulo alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_if functionName]])
    {
        f = [[UMFunction_if alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_not functionName]])
    {
        f = [[UMFunction_not alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_and functionName]])
    {
        f = [[UMFunction_and alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_or functionName]])
    {
        f = [[UMFunction_or alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_xor functionName]])
    {
        f = [[UMFunction_xor alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_not functionName]])
    {
        f = [[UMFunction_bit_not alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_and functionName]])
    {
        f = [[UMFunction_bit_and alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_or functionName]])
    {
        f = [[UMFunction_bit_or alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_xor functionName]])
    {
        f = [[UMFunction_bit_xor alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_shiftleft functionName]])
    {
        f = [[UMFunction_bit_shiftleft alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_bit_shiftright functionName]])
    {
        f = [[UMFunction_bit_shiftright alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_equal functionName]])
    {
        f = [[UMFunction_equal alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_notequal functionName]])
    {
        f = [[UMFunction_notequal alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_greaterthan functionName]])
    {
        f = [[UMFunction_greaterthan alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_greaterorequal functionName]])
    {
        f = [[UMFunction_greaterorequal alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_lessthan functionName]])
    {
        f = [[UMFunction_lessthan alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_lessorequal functionName]])
    {
        f = [[UMFunction_lessorequal alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_startswith functionName]])
    {
        f = [[UMFunction_startswith alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_endswith functionName]])
    {
        f = [[UMFunction_endswith alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_setvar functionName]])
    {
        f = [[UMFunction_setvar alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_setfield functionName]])
    {
        f = [[UMFunction_setfield alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_getvar functionName]])
    {
        f = [[UMFunction_getvar alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_getfield functionName]])
    {
        f = [[UMFunction_getfield alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_block functionName]])
    {
        f = [[UMFunction_block alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_return functionName]])
    {
        f = [[UMFunction_return alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_assign functionName]])
    {
        f = [[UMFunction_assign alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_while functionName]])
    {
        f = [[UMFunction_while alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_dowhile functionName]])
    {
        f = [[UMFunction_dowhile alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_for functionName]])
    {
        f = [[UMFunction_for alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_preincrease functionName]])
    {
        f = [[UMFunction_preincrease alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_predecrease functionName]])
    {
        f = [[UMFunction_predecrease alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_postincrease functionName]])
    {
        f = [[UMFunction_postincrease alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_postdecrease functionName]])
    {
        f = [[UMFunction_postdecrease alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_switch functionName]])
    {
        f = [[UMFunction_switch alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_print functionName]])
    {
        f = [[UMFunction_print alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_goto functionName]])
    {
        f = [[UMFunction_goto alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_continue functionName]])
    {
        f = [[UMFunction_continue alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_break functionName]])
    {
        f = [[UMFunction_break alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_substr functionName]])
    {
        f = [[UMFunction_substr alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_list functionName]])
    {
        f = [[UMFunction_list alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_equalCaseInsensitive functionName]])
    {
        f = [[UMFunction_list alloc]initWithEnvironment:context];
    }

    else if([name isEqualTo:[UMFunction_namedlist_add functionName]])
    {
        f = [[UMFunction_namedlist_add alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_namedlist_remove functionName]])
    {
        f = [[UMFunction_namedlist_remove alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_namedlist_contains functionName]])
    {
        f = [[UMFunction_namedlist_contains alloc]initWithEnvironment:context];
    }
    else if([name isEqualTo:[UMFunction_regex functionName]])
    {
        f = [[UMFunction_regex alloc]initWithEnvironment:context];
    }
    

    if(_type != UMTermType_identifier)
    {
        return [UMTerm termWithNullWithEnvironment:context];
    }
    _type = UMTermType_functionCall;

    NSArray *params;
    if(list == NULL)
    {
        params = @[];
    }
    else if((list.type == UMTermType_functionCall) && ([list.function isKindOfClass:[UMFunction_list class]]))
    {
        /* this is a list with multiple items */
        params = list.param;
    }
    else
    {
        /* this is not yet a list but a single item */
        params = @[list];
    }

    if(f==NULL)
    {
        f = [context functionByName:name];
    }
    if(f == NULL)
    {
        return [UMTerm termWithNullWithEnvironment:context];
    }
    f.cenv = context;
    
    UMTerm *result =  [[UMTerm alloc] initWithFunction:f andParams:params withEnvironment:_cenv];
    return result;
}

- (UMTerm *)arrayAccess:(UMTerm *)index environment:(UMEnvironment *)xcenv
{
    
    NSArray *params = @[_identifier];
    UMFunction *func = [[UMFunction_arrayAccess alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:params withEnvironment:xcenv];
    return result;
}

- (UMTerm *)starIdentifierWithEnvironment:(UMEnvironment *)xcenv
{
    NSArray *params = @[_identifier];
    UMFunction *func = [[UMFunction_starIdentifier alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:params withEnvironment:xcenv];
    return result;
}

- (UMTerm *)sizeofTypeWithEnvironment:(UMEnvironment *)xcenv
{
    
    NSArray *params = @[_identifier];
    UMFunction *func = [[UMFunction_sizeOfType alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:params withEnvironment:xcenv];
    return result;
}

- (UMTerm *)sizeofVarWithEnvironment:(UMEnvironment *)cenv
{
    
    NSArray *params = @[_identifier];
    UMFunction *func = [[UMFunction_sizeOfVar alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:params withEnvironment:cenv];
    return result;
}

- (UMTerm *)dotIdentifier:(UMTerm *)list environment:(UMEnvironment *)cenv /* object.access */
{
    /*TODO: missing implemementation */
    return self;
}

- (UMTerm *)arrowIdentifier:(UMTerm *)list environment:(UMEnvironment *)cenv/* object->access */
{
    /*TODO: missing implemementation */
    return self;
}

- (UMTerm *)addressOfIdentifierWithEnvironment:(UMEnvironment *)cenv/* object->access */
{
    /* TODO missing implementation */
    NSArray *params = @[_identifier];
    UMFunction *func = [[UMFunction_addressOf alloc]init];
    UMTerm *result =  [[UMTerm alloc] initWithFunction:func andParams:params withEnvironment:cenv];
    return result;
    
    return self;
}

- (UMTerm *)castTo:(UMTerm *)newType environment:(UMEnvironment *)cenv/* (newtype)object */
{
    /* TODO missing implementation */
    return self;
}

- (NSString *)constantStringValue
{
    switch(_type)
    {
        case UMTermType_discrete:
            return [_discrete stringValue];
            break;
        case UMTermType_field:
            return _fieldname;
            break;
        case UMTermType_variable:
            return _varname;
            break;
        case UMTermType_functionCall:
            return [_function name];
            break;
        case UMTermType_functionDefinition:
            return [NSString stringWithFormat:@"_%@()",_function.name];
            break;
        case UMTermType_identifier:
            return _identifier;
            break;
        case UMTermType_token:
            return _identifier;
            break;
        default:
            return @"";
            break;
    }
}

- (NSString *)labelValue
{
    switch(_type)
    {
        case UMTermType_discrete:
            return [_discrete labelValue];
            break;
        case UMTermType_field:
            @throw([NSException exceptionWithName:@"NONSTATIC_LABEL"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : [NSString stringWithFormat:@"nonstatic label %@",_function.name],
                                                    @"func": @(__func__),
                                                    @"obj":self,
                                                    }
                    ]);
            break;
        case UMTermType_variable:
            @throw([NSException exceptionWithName:@"NONSTATIC_LABEL"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : [NSString stringWithFormat:@"nonstatic label %@",_function.name],
                                                                 @"func": @(__func__),
                                                                 @"obj":self,
                                                                 }
                    ]);
            break;
        case UMTermType_functionCall:
            @throw([NSException exceptionWithName:@"UNKNOWN_LABEL"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : [NSString stringWithFormat:@"invalid label %@",_function.name],
                                                    @"func": @(__func__),
                                                    @"obj":self
                                                    }
                    ]);
            break;
        case UMTermType_functionDefinition:
            @throw([NSException exceptionWithName:@"UNKNOWN_LABEL"
                                           reason:NULL
                                         userInfo:@{
                                                    @"sysmsg" : [NSString stringWithFormat:@"invalid label %@",_function.name],
                                                    @"func": @(__func__),
                                                    @"obj":self
                                                    }
                    ]);
            break;
       case UMTermType_identifier:
            return _identifier;
            break;
        case UMTermType_token:
            return _identifier;
            break;
        default:
            return @"";
            break;
    }
}

- (NSString *)logDescription
{
    switch(_type)
    {
        case UMTermType_discrete:
            return _discrete.labelValue;
        case UMTermType_field:
            return [NSString stringWithFormat:@"(field)%@",_fieldname];
        case UMTermType_variable:
            return [NSString stringWithFormat:@"(variable)%@",_varname];
        case UMTermType_functionCall:
            return [NSString stringWithFormat:@"(functionCall)%@",_function.name];
        case UMTermType_functionDefinition:
            return [NSString stringWithFormat:@"(functionDefinition)%@",_function.name];
        case UMTermType_identifier:
            return [NSString stringWithFormat:@"(identifier)%@",_identifier];
        case UMTermType_nullterm:
            return [NSString stringWithFormat:@"(nullterm)"];
        case UMTermType_token:
            return [NSString stringWithFormat:@"(token)%d",_token];
        default:
            return @"(unknown)";
    }
}


- (UMTerm *) copyWithZone:(NSZone *)zone
{
    UMTerm *c = [[UMTerm alloc]init];
    c.cenv = _cenv;
    c.env = _env;
    c.type = _type;
    c.discrete = _discrete;
    c.function = _function;
    c.fieldname = _fieldname;
    c.varname = _varname;
    c.identifier = _identifier;
    c.label = _label;
    c.token = _token;
    c.param = _param;
    return c;
}

@end
