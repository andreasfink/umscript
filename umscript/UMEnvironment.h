//
//  UMEnvironment.h
//  umruleengine
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
}

@property (readwrite,strong) UMDiscreteValue *returnValue;
@property (readwrite,assign) int     identValue;
@property (readwrite,strong) NSString *identPrefix;

- (void)identAdd;
- (void)identRemove;

- (UMDiscreteValue *)variableForKey:(NSString *)key;
- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMDiscreteValue *)fieldForKey:(NSString *)key;
- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMFunction *)functionByName:(NSString *)name;
- (void) addFunction:(UMFunction *)f;

@end
