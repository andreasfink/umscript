//
//  UMFunction_string.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_string.h"

@implementation UMFunction_string

+ (NSString *)functionName
{
    return @"string";
}

- (NSString *)functionName
{
    return @"string";
}


- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"string";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_STRING)
    {
        return d;
    }
    return [UMDiscreteValue discreteLongLong:d.longLongValue];
}

@end
