//
//  UMFunction_startswith.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_startswith.h"

@implementation UMFunction_startswith

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_startswith"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"startswith";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if([params count] != 2)
    {
        return [UMDiscreteValue discreteNull];
    }

    UMTerm *leftTerm = params[0];
    UMTerm *rightTerm = params[1];

    UMDiscreteValue *leftValue = [leftTerm evaluateWithEnvironment:env];
    UMDiscreteValue *rightValue = [rightTerm evaluateWithEnvironment:env];

    NSString *leftString = [leftValue stringValue];
    NSString *rightString = [rightValue stringValue];
    
    if([leftString length] < [rightString length])
    {
        return [UMDiscreteValue discreteBool:NO];
    }
    leftString = [leftString substringToIndex:[rightString length]];
    BOOL result = [leftString isEqualToString:rightString];
    return [UMDiscreteValue discreteBool:result];
}
@end
