//
//  UMFunction_sub.h
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction.h"

@interface UMFunction_sub : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env;

@end
