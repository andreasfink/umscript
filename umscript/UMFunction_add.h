//
//  UMFunction_math_add.h
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction.h"

@interface UMFunction_add : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env;

@end
