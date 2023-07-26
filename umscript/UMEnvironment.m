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

- (void)identAdd
{
    _identValue++;
    _identPrefix = [_identPrefix stringByAppendingString:@"    "];
}

- (void)identRemove
{
    _identValue--;
    int n = (int)[_identPrefix length];
    n = n - 4;
    if(n<=0)
    {
        _identPrefix = @"";
    }
    else
    {
        _identPrefix = [_identPrefix substringToIndex:n];
    }
}

- (UMDiscreteValue *)variableForKey:(NSString *)key
{
    if(key.length<1)
    {
        return [UMDiscreteValue discreteNull];
    }
    if([key hasPrefix:@"$"])
    {
        key = [key substringFromIndex:1]; /* skip the $ */
    }
    return  _variables[key];
}


- (void)defineLocalVariable:(NSString *)name
{
    [_stack defineLocalVariable:name];
}

- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val
{
    if(name.length<1)
    {
        return;
    }
    if([name hasPrefix:@"$"])
    {
        name = [name substringFromIndex:1]; /* skip the $ */
    }
    [_stack setLocalVariable:name value:val];
}

- (UMDiscreteValue *)localVariable:(NSString *)name
{
    return     [_stack localVariable:name];
}


- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key
{
    if(key.length<1)
    {
        return;
    }
    if([key hasPrefix:@"$"])
    {
        key = [key substringFromIndex:1]; /* skip the $ */
    }
    _variables[key] = val;
}


- (UMDiscreteValue *)fieldForKey:(NSString *)key
{
    if(key.length<1)
    {
        return [UMDiscreteValue discreteNull];
    }
    if([key hasPrefix:@"%"])
    {
        key = [key substringFromIndex:1]; /* skip the % */
    }

    return _fields[key];
}

- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key
{
    if(key.length<1)
    {
        return;
    }
    if([key hasPrefix:@"%"])
    {
        key = [key substringFromIndex:1]; /* skip the % */
    }
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
        
        _environmentLog = [[UMHistoryLog alloc]initWithMaxLines:10240];
        _identPrefix          = @"";
        _functionDictionary  = [[UMSynchronizedSortedDictionary alloc]init];
        _variables           = [[UMSynchronizedSortedDictionary alloc]init];
        _fields              = [[UMSynchronizedSortedDictionary alloc]init];
        _stack               = [[UMStack alloc]init];
        _namedListsProvider  = NULL;
    }
    return self;
}

- (UMEnvironment *)initWithTemplate:(UMEnvironment *)template
{
    self = [super init];
    if(self)
    {
        _environmentLog       = [[UMHistoryLog alloc]initWithMaxLines:10240];
        _identPrefix          = @"";
        _functionDictionary  = [template.functionDictionary copy];
        _variables           = [[UMSynchronizedSortedDictionary alloc]init];
        _fields              = [[UMSynchronizedSortedDictionary alloc]init];
        _namedListsProvider  = template.namedListsProvider;
    }
    return self;
}

- (UMEnvironment *)initWithVarFile:(NSString *)varfile
{
    self = [super init];
    if(self)
    {

        _environmentLog = [[UMHistoryLog alloc]initWithMaxLines:10240];

        _identPrefix          = @"";
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
    [_environmentLog addLogEntry:entry];
}

- (void) trace:(NSString *)entry
{
    [_trace addLogEntry:entry];
}

- (void) print:(NSString *)entry
{
    [_standardOutput addLogEntry:entry];
}

- (void)namedlistReplaceList:(NSString *)listName withContentsOfFile:(NSString *)filename
{
    if(_namedListsProvider)
    {
        [_namedListsProvider namedlistReplaceList:listName withContentsOfFile:filename];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
    }
}
- (void)namedlistsFlushAll
{
    if(_namedListsProvider)
    {
        [_namedListsProvider namedlistsFlushAll];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
    }
}

- (void)namedlistsLoadFromDirectory:(NSString *)directory
{
    if(_namedListsProvider)
    {
        [_namedListsProvider namedlistsLoadFromDirectory:directory];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
    }
}

- (void)namedlistAdd:(NSString *)listName value:(NSString *)value
{
    if(_namedListsProvider)
    {
        [_namedListsProvider namedlistAdd:listName value:value];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
    }

}
- (void)namedlistRemove:(NSString *)listName value:(NSString *)value
{
    if(_namedListsProvider)
    {
        [_namedListsProvider namedlistRemove:listName value:value];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
    }
}

- (BOOL)namedlistContains:(NSString *)listName value:(NSString *)value
{
    if(_namedListsProvider)
    {
        return [_namedListsProvider namedlistContains:listName value:value];
    }
    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
        return NO;
    }
}

- (NSArray *)namedlistGetAllEntriesOfList:(NSString *)listName
{
    if(_namedListsProvider)
    {
        return [_namedListsProvider namedlistGetAllEntriesOfList:listName];
    }

    else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
        return @[];
    }
}

- (NSArray<NSString *>*)namedlistsListNames
{
    if(_namedListsProvider)
    {
        return [_namedListsProvider namedlistsListNames];
    }
    else
   {
       NSLog(@"UMEnvironment: _namedListsProvider is not set");
       return @[];
   }
}

- (UMNamedList *)getNamedList:(NSString *)name
{
     if(_namedListsProvider)
     {
         return [_namedListsProvider getNamedList:name];
     }
     else
    {
        NSLog(@"UMEnvironment: _namedListsProvider is not set");
        return NULL;
    }
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
