//
//  UMFunction_sizeOfType.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_sizeOfType.h"

@implementation UMFunction_sizeOfType


+ (NSString *)functionName
{
    return @"__sizeOfType";
}

- (NSString *)functionName
{
    return [UMFunction_sizeOfType functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    UMDiscreteValue *result = NULL;
    for(UMTerm *entry in params)
    {
        if(result == NULL)
        {
            result = [entry evaluateWithEnvironment:env];
        }
        else
        {
            result = [result addValue:[entry evaluateWithEnvironment:env]];
        }
    }
    return result;
}


- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"("];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"+%@",[param codeWithEnvironment:env]];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

@end
