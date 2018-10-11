//
//  UMFunction_has_suffix.h
//  umscript
//
//  Created by Andreas Fink on 10.10.18.
//

#import <umscript/umscript.h>

@interface UMFunction_has_suffix : UMFunction
- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt;

@end

