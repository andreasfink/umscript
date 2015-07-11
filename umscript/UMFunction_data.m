//
//  UMFunction_data.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_data.h"

@implementation UMFunction_data


- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_data"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"data";
        [env log:self.name];
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
