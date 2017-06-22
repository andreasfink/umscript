//
//  UMFunction_addressOf.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_addressOf.h"

@implementation UMFunction_addressOf



+ (NSString *)functionName
{
    return @"addressOf";
}

- (NSString *)functionName
{
    return @"addressOf";
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
