//
//  UMFunction_notequal.h
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction.h"

@interface UMFunction_notequal : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
