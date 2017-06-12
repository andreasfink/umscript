//
//  UMFunction_setfield.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_setfield.h"

@implementation UMFunction_setfield

+ (NSString *)functionName
{
    return @"setfield";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"setfield";
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
    
    UMTerm *leftTerm  = params[0];
    UMTerm *rightTerm = params[1];
    UMDiscreteValue *leftValue  = [leftTerm evaluateWithEnvironment:env];
    UMDiscreteValue *rightValue = [rightTerm evaluateWithEnvironment:env];
    NSString *variableName = [leftValue stringValue];

    [env setVariable:rightValue forKey:variableName];
    return rightValue;
}

@end
