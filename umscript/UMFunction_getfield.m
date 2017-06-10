//
//  UMFunction_getfield.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_getfield.h"

@implementation UMFunction_getfield

+ (NSString *)functionName
{
    return @"getfield";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_getfield"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"getfield";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if([params count] != 1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *fieldNameTerm = params[0];
    UMDiscreteValue *fieldNameValue  = [fieldNameTerm evaluateWithEnvironment:env];
    NSString *fieldName = [fieldNameValue stringValue];
    return [env fieldForKey:fieldName ];
}

@end
