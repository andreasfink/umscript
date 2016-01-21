//
//  UMEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>

@class UMDiscreteValue;
@class UMFunction;

@interface UMEnvironment : UMObject
{
    UMSynchronizedDictionary *variables;
    UMSynchronizedDictionary *fields;
    UMSynchronizedDictionary *functionDictionary;
    UMDiscreteValue *returnValue;
    BOOL    returnCalled; /* if this is set to TRUE, a block executor should jump out (like in a return statement) */
    BOOL    breakCalled; /* if this is set to TRUE, a block executor should jump out (like in a return statement) */
    NSString *jumpTo; /* if this is set, a block should jump to that label like in a goto or continue statement */
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
@property (readwrite,strong) NSString *jumpTo;
@property (readwrite,assign) BOOL returnCalled;
@property (readwrite,assign) BOOL breakCalled;

- (void)identAdd;
- (void)identRemove;
- (UMEnvironment *)initWithMagic:(NSString *)m;
        
- (UMDiscreteValue *)variableForKey:(NSString *)key;
- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMDiscreteValue *)fieldForKey:(NSString *)key;
- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMFunction *)functionByName:(NSString *)name;
- (void) addFunction:(UMFunction *)f;
- (void) log:(NSString *)entry;

@end
