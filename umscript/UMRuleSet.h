//
//  UMRuleSet.h
//  umruleengine
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <ulib/ulib.h>


@interface UMRuleSet : UMObject
{
    NSString *name;
    NSArray  *rules;
    NSString *comment;
    BOOL    active;
}

@property(strong)   NSString    *name;
@property(strong)   NSArray     *rules;
@property(strong)   NSString    *comment;
@property(assign)   BOOL        active;

- (NSString *)description;
- (NSDictionary *)descriptionDict;

@end
