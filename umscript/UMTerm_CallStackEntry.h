//
//  UMTerm_CallStackEntry.h
//  umscript
//
//  Created by Andreas Fink on 18.07.17.
//
//

#import <ulib/ulib.h>

@class UMDiscreteValue;

@interface UMTerm_CallStackEntry : UMObject
{
    UMSynchronizedSortedDictionary *_localVariables;
    UMDiscreteValue *_temporaryResult;
    UMDiscreteValue *_temporaryResult2;
    NSInteger _position;
    NSString *_name;
}

@property(readwrite,assign,atomic)  NSInteger position;
@property(readwrite,strong,atomic)  UMDiscreteValue *temporaryResult;
@property(readwrite,strong,atomic)  UMDiscreteValue *temporaryResult2;
@property(readwrite,strong,atomic)  NSString *name;


@end
