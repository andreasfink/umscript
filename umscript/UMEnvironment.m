//
//  UMEnvironment.m
//  umscript
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
@synthesize environmentLog;
@synthesize jumpTo;
@synthesize returnCalled;
@synthesize breakCalled;

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
        result = variables[key];
    }
    return result;
}

- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;
{
    @synchronized(self)
    {
        variables[key] = val;
//        variables[key] = val;
    }
}

- (UMDiscreteValue *)fieldForKey:(NSString *)key
{
    UMDiscreteValue *result;
    
    @synchronized(self)
    {
        result = fields[key];
    }
    return result;
   
}

- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key
{
    @synchronized(self)
    {
        fields[key] = val;
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
            UMFunction *func = functionDictionary[n];
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
        
        environmentLog = [[UMHistoryLog alloc]init];
        
        identPrefix = @"";
        functionDictionary  = [[NSMutableDictionary alloc]init];
        variables = [[NSMutableDictionary alloc]init];
        fields = [[NSMutableDictionary alloc]init];

        [self addFunction:[[UMFunction_add alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_sub alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_mul alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_div alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_dot alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_modulo alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_if alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_not alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_and alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_or alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_xor alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_not alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_and alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_or alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_xor alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_shiftleft alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_bit_shiftright alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_equal alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_notequal alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_greaterthan alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_lessthan alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_startswith alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_endswith alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_setvar alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_getvar alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_setfield alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_getfield alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_block alloc]initWithEnvironment:NULL]];
        [self addFunction:[[UMFunction_return alloc]initWithEnvironment:NULL]];
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
  //      id func = functionDictionary[fname];
        id func = functionDictionary[fname];

        [s appendFormat:@"func %@=%@\n",fname,[func description]];
    }
    return s;
}

- (void) log:(NSString *)entry
{
    [environmentLog addLogEntry:entry];
}
@end
