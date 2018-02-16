//
//  UMStackFrame.h
//  umscript
//
//  Created by Andreas Fink on 16.02.18.
//

#import <ulib/ulib.h>

@class UMDiscreteValue;

@interface UMStackFrame : UMObject
{
    NSMutableDictionary *_localVariables;
    NSMutableArray *_parameters;
    UMStackFrame *_upperFrame;
    int _codePosition;
}

- (void)setParameters:(NSArray *)params;

- (void)defineLocalVariable:(NSString *)name;
- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val;
- (UMDiscreteValue *)localVariable:(NSString *)name;

@end
