//
//  UMTerm_Interrupt.h
//  umscript
//
//  Created by Andreas Fink on 18.07.17.
//
//

#import <ulib/ulib.h>
#import <umscript/UMScriptResume.h>
/*
    UMTerm_Interrupt is a object to store the exact location of
    a function chain so it can be paused and continued at this 
    very same location later. this for example if it calls an external network
    function which returns later. Such a function can then throw a UMTerm_Interrupt object
    which tells the caller, it can now go do other work. When the external function
    then wants to continue it feeds this UMTerm_Interrupt object back into UMTerm
    and then it knows where to continue.
 */

@class UMTerm_CallStackEntry;
@class UMScriptDocument;

@interface UMTerm_Interrupt : UMObject
{
    UMQueueSingle *callStackEntries;
    UMScriptDocument *_currentScript;
    UMObject<UMScriptResume> *_delegate;
}

@property(readwrite,strong,atomic)  UMScriptDocument *currentScript;
@property(readwrite,strong,atomic)  UMObject<UMScriptResume> *delegate;


- (UMTerm_CallStackEntry *)pullEntry;
- (void)recordEntry:(UMTerm_CallStackEntry *)entry;


@end
