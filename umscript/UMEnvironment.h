//
//  UMEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#import <ulibasn1/ulibasn1.h>
#import "UMEnvironmentNamedListProviderProtocol.h"

@class UMDiscreteValue;
@class UMFunction;
@class UMStack;
@class UMStackFrame;

@interface UMEnvironment : UMObject<UMEnvironmentNamedListProviderProtocol>
{
    UMSynchronizedSortedDictionary 	*_variables;
    UMSynchronizedSortedDictionary 	*_fields;
    UMSynchronizedSortedDictionary 	*_functionDictionary;
    id<UMEnvironmentNamedListProviderProtocol>  _namedListsProvider;
    UMDiscreteValue 				*_returnValue;
    BOOL                            _returnCalled; /* if this is set to TRUE, a block executor should jump out (like in a return statement) */
    BOOL                            _breakCalled; /* if this is set to TRUE, a block executor should jump out (like in a return statement) */
    NSString                        *_jumpTo; /* if this is set, a block should jump to that label like in a goto or continue statement */
    int                             _identValue;
    NSString                        *_identPrefix;
    BOOL                            _traceExecutionFlag;
    BOOL                            _traceTreeBuildupFlag;
    UMHistoryLog                    *_environmentLog;
    UMHistoryLog                    *_standardOutput;
    UMHistoryLog                    *_trace;

    UMStack *_stack;
}

@property (readwrite,strong) UMDiscreteValue *returnValue;
@property (readwrite,assign) int _identValue;
@property (readwrite,strong) NSString *identPrefix;
@property (readwrite,strong) UMHistoryLog *environmentLog;
@property (readwrite,strong) UMHistoryLog *standardOutput;
@property (readwrite,strong) UMHistoryLog *trace;
@property (readwrite,strong) NSString *jumpTo;
@property (readwrite,assign) BOOL returnCalled;
@property (readwrite,assign) BOOL breakCalled;
@property (readwrite,assign) BOOL traceExecutionFlag;
@property (readwrite,assign) BOOL traceTreeBuildupFlag;
@property (readwrite,strong) id<UMEnvironmentNamedListProviderProtocol> namedListsProvider;
@property (readwrite,strong) UMSynchronizedSortedDictionary *functionDictionary;

- (UMEnvironment *)initWithTemplate:(UMEnvironment *)template;
- (UMEnvironment *)initWithVarFile:(NSString *)varfile;

- (void)identAdd;
- (void)identRemove;
        
- (UMDiscreteValue *)variableForKey:(NSString *)key;
- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMDiscreteValue *)fieldForKey:(NSString *)key;
- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMFunction *)functionByName:(NSString *)name;
- (void) addFunction:(UMFunction *)f;
- (void) log:(NSString *)entry;
- (void) trace:(NSString *)entry;
- (void) print:(NSString *)entry;
- (void)pushFrame:(UMStackFrame *)frame;
- (void)popFrame;

- (void)defineLocalVariable:(NSString *)name;
- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val;
- (UMDiscreteValue *)localVariable:(NSString *)name;

@end
