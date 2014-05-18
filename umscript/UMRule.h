//
//  UMRule.h
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>

@class UMFunction;
@class UMRuleAction;


@interface UMRule : UMObject
{
    BOOL                active;
    UMFunction     *condition;
    UMRuleAction        *action;
    NSString            *comment;
}

@property(readwrite,assign)   BOOL             active;
@property(readwrite,strong)   UMFunction   *condition;
@property(readwrite,strong)   UMRuleAction     *action;
@property(readwrite,strong)   NSString         *comment;

- (id)initWithCondition:(UMFunction *)c action:(UMRuleAction *)a;

- (NSString *)description;
- (id)descriptionDictVal;

@end
