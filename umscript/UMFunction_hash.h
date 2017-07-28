//
//  UMFunction_hash.h
//  umscript
//
//  Created by Andreas Fink on 28.07.17.
//
//

#import "UMFunction.h"

@interface UMFunction_hash : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
