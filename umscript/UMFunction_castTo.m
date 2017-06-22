//
//  UMFunction_castTo.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_castTo.h"

@implementation UMFunction_castTo



+ (NSString *)functionName
{
    return @"castTo";
}

- (NSString *)functionName
{
    return @"castTo";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        [env log:self.functionName];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    /* FIXME */
    return [UMDiscreteValue discreteNull];
}

@end


