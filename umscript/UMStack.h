//
//  UMStack.h
//  umscript
//
//  Created by Andreas Fink on 16.02.18.
//

#import <ulib/ulib.h>
@class UMDiscreteValue;
@class UMStackFrame;

@interface UMStack : UMObject
{
    NSMutableArray *_stackFrames;

    UMStackFrame *_currentFrame;
}

- (void)pushFrame:(UMStackFrame *)newFrame;
- (void)popFrame;

- (void)defineLocalVariable:(NSString *)name;
- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val;
- (UMDiscreteValue *)localVariable:(NSString *)name;

@end
