//
//  UMFunction_endswith.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_endswith.h"

@implementation UMFunction_endswith

+ (NSString *)functionName
{
    return @"endswith";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"endswith";
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
    leftString = [leftString substringFromIndex:([leftString length] - [rightString length])];
    BOOL result = [leftString isEqualToString:rightString];
    return [UMDiscreteValue discreteBool:result];
}

@end
