//
//  UMFunction_arrayAccess.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_arrayAccess.h"

@implementation UMFunction_arrayAccess


+ (NSString *)functionName
{
    return @"arrayAccess";
}


- (NSString *)functionName
{
    return @"arrayAccess";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"[arrayAccess]";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count < 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    UMDiscreteValue *result = nil;
    for(UMTerm *entry in params)
    {
        UMDiscreteValue *d = [entry evaluateWithEnvironment:env];
        if(result == nil)
        {
            result = d;
        }
        else
        {
            result = [result logicXor:d];
        }
    }
    return result;
}

@end
