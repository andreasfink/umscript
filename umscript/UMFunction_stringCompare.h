//
//  UMFunction_stringCompare.h
//  umscript
//
//  Created by Andreas Fink on 26.07.17.
//
//

#import "UMFunction.h"

@interface UMFunction_stringCompare : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
