//
//  UMRule.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMRule.h"
#import "UMFunction.h"

@implementation UMRule

@synthesize condition;
@synthesize action;
@synthesize comment;
@synthesize active;


- (id)initWithCondition:(UMFunction *)c action:(UMRuleAction *)a
{
    self = [super init];
    if(self)
    {
        self.condition = c;
        self.action = a;
        self.active = YES;
    }
    return self;
}

- (NSString *)description
{
    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
    NSString *s = [writer stringWithObject:[self descriptionDictVal]];
    return s;
}

- (id)descriptionDictVal
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(condition)
    {
        dict[@"condition"] = [condition descriptionDictVal];
    }
    if(active==NO)
    {
        dict[@"disabled"] = @"YES";
    }
    if(comment)
    {
        dict[@"comment"] = comment;
    }
    if(action)
    {
        dict[@"action"] = action;
    }
    return dict;
}

@end
