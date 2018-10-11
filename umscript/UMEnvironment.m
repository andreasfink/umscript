//
//  UMEnvironment.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMDiscreteValue.h"
#import "UMEnvironment.h"
#import "UMFunctionMacros.h"
#import "NSString+UMScript.h"
#import "UMStack.h"

@implementation UMEnvironment

@synthesize identValue;
@synthesize identPrefix;
@synthesize returnValue;
@synthesize environmentLog;
@synthesize standardOutput;
@synthesize trace;

@synthesize jumpTo;
@synthesize returnCalled;
@synthesize breakCalled;
@synthesize traceExecutionFlag;
@synthesize traceTreeBuildupFlag;

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
    return  _variables[key];
}


- (void)defineLocalVariable:(NSString *)name
{
    [_stack defineLocalVariable:name];

}

- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val
{
    [_stack setLocalVariable:name value:val];
}

- (UMDiscreteValue *)localVariable:(NSString *)name
{
    return     [_stack localVariable:name];
}


- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key
{
    _variables[key] = val;
}

- (UMDiscreteValue *)fieldForKey:(NSString *)key
{
    return _fields[key];
}

- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key
{
    _fields[key] = val;
}

- (UMFunction *)functionByName:(NSString *)n
{
	UMFunction *func = _functionDictionary[n];
	return func;
}

- (void) addFunction:(UMFunction *)f
{
    _functionDictionary[f.name] = f;
}

- (UMEnvironment *)init
{
    self = [super init];
    if(self)
    {
        
        environmentLog = [[UMHistoryLog alloc]initWithMaxLines:10240];
        
        identPrefix = @"";
        _functionDictionary  = [[UMSynchronizedSortedDictionary alloc]init];
        _variables           = [[UMSynchronizedSortedDictionary alloc]init];
        _fields              = [[UMSynchronizedSortedDictionary alloc]init];
        _namedLists          = [[UMSynchronizedDictionary alloc]init];
        _stack              = [[UMStack alloc]init];
    }
    return self;
}

- (UMEnvironment *)initWithTemplate:(UMEnvironment *)template
{
    self = [super init];
    if(self)
    {

        environmentLog = [[UMHistoryLog alloc]initWithMaxLines:10240];
        identPrefix = @"";
        _functionDictionary  = [template.functionDictionary copy];
        _variables           = [[UMSynchronizedSortedDictionary alloc]init];
        _fields              = [[UMSynchronizedSortedDictionary alloc]init];
        _namedLists          = template.namedLists;
    }
    return self;
}


- (UMEnvironment *)initWithVarFile:(NSString *)varfile
{
    self = [super init];
    if(self)
    {

        environmentLog = [[UMHistoryLog alloc]initWithMaxLines:10240];

        identPrefix = @"";
        _functionDictionary  = [[UMSynchronizedSortedDictionary alloc]init];
        _variables           = [[UMSynchronizedSortedDictionary alloc]init];
        _fields              = [[UMSynchronizedSortedDictionary alloc]init];

        NSError *error = NULL;
        NSString *fileContent = [NSString stringWithContentsOfFile:varfile encoding:NSUTF8StringEncoding error:&error];
        if(fileContent)
        {
            NSArray *lines = [fileContent componentsSeparatedByCharactersInSet:[UMObject newlineCharacterSet]];
            for(NSString *line in lines)
            {
                NSArray *parts = [line componentsSeparatedByString:@"="];
                if(parts.count == 2)
                {
                    NSString *var = [parts[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString *val = [parts[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    _variables[var]=[val  discreteValue];
                }
            }
        }
    }
    return self;
}


-(NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];

    NSArray *keys = [_variables allKeys];
    for (NSString *varname in keys)
    {
        id val = _variables[varname];
        [s appendFormat:@"var %@=%@\n",varname,[val description]];
    }
    
    keys = [_fields allKeys];
    for (NSString *fieldname in keys)
    {
        id val = _fields[fieldname];
        [s appendFormat:@"field %@=%@\n",fieldname,[val description]];
    }
    
    keys = [_functionDictionary allKeys];

    for (NSString *fname in keys)
    {
        id func = _functionDictionary[fname];
        [s appendFormat:@"func %@=%@\n",fname,[func description]];
    }
    return s;
}

- (void) log:(NSString *)entry
{
    [environmentLog addLogEntry:entry];
}

- (void) trace:(NSString *)entry
{
    [trace addLogEntry:entry];
}

- (void) print:(NSString *)entry
{
    [standardOutput addLogEntry:entry];
}

- (void)namedlist_add:(NSString *)listName value:(NSString *)value
{
    if((value) && (listName))
    {
        @synchronized (self)
        {
            UMSynchronizedDictionary *list = _namedLists[listName];
            if(list == NULL)
            {
                list = [[UMSynchronizedDictionary alloc]init];
                _namedLists[listName] = list;
            }
            list[value] = value;
        }
    }
}

- (void)namedlist_remove:(NSString *)listName value:(NSString *)value
{
    if((value) && (listName))
    {
        @synchronized (self)
        {
            UMSynchronizedDictionary *list = _namedLists[listName];
            if(list == NULL)
            {
                return;
            }
            [list removeObjectForKey:value];
        }
    }
}

- (BOOL)namedlist_contains:(NSString *)listName value:(NSString *)value
{
    if((value) && (listName))
    {
        @synchronized (self)
        {
            UMSynchronizedDictionary *list = _namedLists[listName];
            if((list) && (list[value]))
            {
                return YES;
            }
       }
    }
    return NO;
}

- (void)pushFrame:(UMStackFrame *)frame
{
    [_stack pushFrame:frame];
}

- (void)popFrame
{
    [_stack popFrame];
}


@end
