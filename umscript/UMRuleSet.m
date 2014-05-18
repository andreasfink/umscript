//
//  UMRuleSet.m
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMRuleSet.h"
#import "UMRUle.h"

@implementation UMRuleSet

@synthesize name;
@synthesize rules;
@synthesize active;
@synthesize comment;

- (NSString *)description
{
    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
    NSString *s = [writer stringWithObject:[self descriptionDict]];
    return s;
}

- (NSDictionary *)descriptionDict
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(name)
    {
        dict[@"name"] = name;
    }
    if(active==NO)
    {
        dict[@"disabled"] = @"YES";
    }
    if(comment)
    {
        dict[@"comment"] = comment;
    }
    if(rules)
    {
        NSMutableArray *r = [[NSMutableArray alloc]init];
        for(UMRule *rule in rules)
        {
            [r addObject:[rule descriptionDictVal]];
        }
        dict[@"rules"] = r;
    }
    return dict;
}
@end
