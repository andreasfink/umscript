//
//  UMFunction_data.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_data.h"

@implementation UMFunction_data


- (id)init
{
    self = [super init];
    if(self)
    {
        self.name = @"(data)";
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_DATA)
    {
        return d;
    }
    return [UMDiscreteValue discreteData:d.dataValue];
}

@end
