//
//  UMFunction_has_prefix.h
//  umscript
//
//  Created by Andreas Fink on 10.10.18.
//

#import <umscript/UMFunction.h>


@interface UMFunction_has_prefix : UMFunction
- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end


