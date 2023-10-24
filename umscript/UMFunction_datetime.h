//
//  UMFunction_datetime.h
//  umscript
//
//  Created by Andreas Fink on 27.07.17.
//
//

#import <umscript/UMFunction.h>

@interface UMFunction_datetime : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
