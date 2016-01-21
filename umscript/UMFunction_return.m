//
//  UMFunction_return.m
//  umscript
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_return.h"
#import "UMEnvironment.h"
@implementation UMFunction_return

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_return"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"return";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    if(params.count !=1)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMDiscreteValue *returnValue =[params[0] evaluateWithEnvironment:env];
    env.returnValue =  returnValue;
    env.returnCalled = YES;
    return returnValue;
}
@end
