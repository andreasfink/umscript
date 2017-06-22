//
//  UMFunction_if.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_if.h"

@implementation UMFunction_if

+ (NSString *)functionName
{
    return @"if";
}

- (NSString *)functionName
{
    return @"if";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"if";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)p environment:(id)env
{
    if(p.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *condition = p[0];
    UMTerm *ifBlock = p[1];
    UMTerm *elseBlock = nil;
    if(p.count == 3)
    {
        elseBlock = p[2];
    }
    UMDiscreteValue *result = [condition evaluateWithEnvironment:env];
    if(result.boolValue)
    {
        result = [ifBlock evaluateWithEnvironment:env];
    }
    else
    {
        result = [elseBlock evaluateWithEnvironment:env];

    }
    return result;
}

@end
