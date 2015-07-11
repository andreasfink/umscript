//
//  UMFunction_typecast_int.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_typecast_int.h"

@implementation UMFunction_typecast_int


- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_typecast_int"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"typecast_int";
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
    UMTerm *p = params[0];
    UMDiscreteValue *v = [p evaluateWithEnvironment:env];
    return [UMDiscreteValue discreteInt:[v intValue]];
}
    

@end
