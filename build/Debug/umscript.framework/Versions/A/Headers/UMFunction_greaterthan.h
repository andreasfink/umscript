//
//  UMFunctionType_greaterthan.h
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction.h"

@interface UMFunction_greaterthan : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env;

@end
