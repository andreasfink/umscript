//
//  UMEnvironment.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMDiscreteValue.h"
#import "UMEnvironment.h"
#import "UMFunctionMacros.h"

@implementation UMEnvironment

@synthesize identValue;
@synthesize identPrefix;
@synthesize returnValue;

- (void)identAdd
{
    identValue++;
    identPrefix = [identPrefix stringByAppendingString:@"    "];
}

- (void)identRemove
{
    identValue--;
    int n = (int)[identPrefix length];
    n = n - 4;
    if(n<=0)
    {
        identPrefix = @"";
    }
    else
    {
        identPrefix = [identPrefix substringToIndex:n];
    }
    
}


- (UMDiscreteValue *)variableForKey:(NSString *)key
{
    UMDiscreteValue *result;

    @synchronized(self)
    {
        result = [variables objectForKey:key];
    }
    return result;
}

- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;
{
    @synchronized(self)
    {
        [variables setObject:val forKey:key];
    }
}

- (UMDiscreteValue *)fieldForKey:(NSString *)key
{
    UMDiscreteValue *result;
    
    @synchronized(self)
    {
        result = [fields objectForKey:key];
    }
    return result;
   
}

- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key
{
    @synchronized(self)
    {
        [fields setObject:val forKey:key];
    }
   
}

- (UMFunction *)functionByName:(NSString *)n
{
    @synchronized(self)
    {
        if(functionDictionary == NULL)
        {
            functionDictionary = [[NSMutableDictionary alloc]init];
            return nil;
        }
        else
        {
            UMFunction *func = [functionDictionary objectForKey:n];
            return func;
        }
    }
}

- (void) addFunction:(UMFunction *)f
{
    @synchronized(self)
    {
        functionDictionary[f.name] = f;
    }
   
}

- (id)init
{
    self = [super init];
    if(self)
    {
        identPrefix = @"";
        functionDictionary  = [[NSMutableDictionary alloc]init];
        variables = [[NSMutableDictionary alloc]init];
        fields = [[NSMutableDictionary alloc]init];

        [self addFunction:[[UMFunction_math_add alloc]init]];
        [self addFunction:[[UMFunction_math_substract alloc]init]];
        [self addFunction:[[UMFunction_math_multiply alloc]init]];
        [self addFunction:[[UMFunction_math_division alloc]init]];
        [self addFunction:[[UMFunction_math_dot alloc]init]];
        [self addFunction:[[UMFunction_math_percent alloc]init]];
        [self addFunction:[[UMFunction_if alloc]init]];
        [self addFunction:[[UMFunction_logic_not alloc]init]];
        [self addFunction:[[UMFunction_logic_and alloc]init]];
        [self addFunction:[[UMFunction_logic_or alloc]init]];
        [self addFunction:[[UMFunction_logic_xor alloc]init]];
        [self addFunction:[[UMFunction_bit_not alloc]init]];
        [self addFunction:[[UMFunction_bit_and alloc]init]];
        [self addFunction:[[UMFunction_bit_or alloc]init]];
        [self addFunction:[[UMFunction_bit_xor alloc]init]];
        [self addFunction:[[UMFunction_bit_shiftleft alloc]init]];
        [self addFunction:[[UMFunction_bit_shiftright alloc]init]];
        [self addFunction:[[UMFunction_equal alloc]init]];
        [self addFunction:[[UMFunction_notequal alloc]init]];
        [self addFunction:[[UMFunction_greaterthan alloc]init]];
        [self addFunction:[[UMFunction_lessthan alloc]init]];
        [self addFunction:[[UMFunction_startswith alloc]init]];
        [self addFunction:[[UMFunction_endswith alloc]init]];
        [self addFunction:[[UMFunction_setvar alloc]init]];
        [self addFunction:[[UMFunction_getvar alloc]init]];
        [self addFunction:[[UMFunction_setfield alloc]init]];
        [self addFunction:[[UMFunction_getfield alloc]init]];
        [self addFunction:[[UMFunction_block alloc]init]];
        [self addFunction:[[UMFunction_return alloc]init]];
        /* we TODO: have to preload all the functions defined and add them to a dictionary */
    }
    return self;
}

-(NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];

    for (NSString *varname in variables)
    {
        id val = variables[varname];
        [s appendFormat:@"var %@=%@\n",varname,[val description]];
    }
    for (NSString *fieldname in fields)
    {
        id val = fields[fieldname];
        [s appendFormat:@"field %@=%@\n",fieldname,[val description]];
    }
    for (NSString *fname in functionDictionary)
    {
        id func = functionDictionary[fname];
        [s appendFormat:@"func %@=%@\n",fname,[func description]];
    }
    return s;
}

@end
