//
//  UMEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@class UMDiscreteValue;
@class UMFunction;

@interface UMEnvironment : UMObject
{
    NSMutableDictionary *variables;
    NSMutableDictionary *fields;
    NSMutableDictionary *functionDictionary;
    UMDiscreteValue *returnValue;
    int     identValue;
    NSString *identPrefix;
    BOOL    traceExecutionFlag;
    BOOL    traceTreeBuildupFlag;
    UMHistoryLog    *environmentLog;
}

@property (readwrite,strong) UMDiscreteValue *returnValue;
@property (readwrite,assign) int     identValue;
@property (readwrite,strong) NSString *identPrefix;
@property (readwrite,strong) UMHistoryLog *environmentLog;

- (void)identAdd;
- (void)identRemove;

- (UMDiscreteValue *)variableForKey:(NSString *)key;
- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMDiscreteValue *)fieldForKey:(NSString *)key;
- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMFunction *)functionByName:(NSString *)name;
- (void) addFunction:(UMFunction *)f;
- (void) log:(NSString *)entry;

@end
