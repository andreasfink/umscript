//
//  UMScriptResume.h
//  umscript
//
//  Created by Andreas Fink on 18.07.17.
//
//

#import <ulib/ulib.h>

@class UMTerm_Interrupt;

@protocol UMScriptResume <NSObject>
- (void)  resumeScript:(UMTerm_Interrupt *)irq;
@end
