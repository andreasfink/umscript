//
//  UMFunction_equalCaseInsensitive.h
//  umscript
//
//  Created by Andreas Fink on 26.07.17.
//
//

#import <umscript/UMFunction.h>

@interface UMFunction_equalCaseInsensitive : UMFunction

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end
