//
//  UMFunction_startswith.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_startswith.h"

@implementation UMFunction_startswith

+ (NSString *)functionName
{
    return @"startswith";
}

- (NSString *)functionName
{
    return @"startswith";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
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
