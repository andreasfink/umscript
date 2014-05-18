//
//  UMRuleProtocol.h
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@class UMDiscreteValue;

/* the environment which are passed to a rule engine must objey the following protocol */
/* keys are usually NSStrings but could be also integer indexes wrapped into NSNumber */
/* values can be anything but for prefix and postfix rules they need to be NSStrings */
/* values are called with isEqualTo: isGreaterThan: etc. */

@protocol UMEnvironmentProtocol <NSObject>

- (UMDiscreteValue *)variableForKey:(NSString *)key;
- (void)setVariable:(UMDiscreteValue *)val forKey:(NSString *)key;

- (UMDiscreteValue *)fieldForKey:(NSString *)key;
- (void)setField:(UMDiscreteValue *)val forKey:(NSString *)key;

@end
