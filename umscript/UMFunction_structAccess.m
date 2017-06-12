//
//  UMFunction_structAccess.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_structAccess.h"

@implementation UMFunction_structAccess

+ (NSString *)functionName
{
    return @"[structAccess]";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"[structAccess]";
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
            result = [result arrayAccess:d];
        }
    }
    return result;
}

@end

