//
//  UMFunction_equal.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <umscript/UMFunction.h>

@interface UMFunction_equal : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
