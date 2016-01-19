//
//  UMFunction_equal.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction.h"

@interface UMFunction_equal : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env;

@end
