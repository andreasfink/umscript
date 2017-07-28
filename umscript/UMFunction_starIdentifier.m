//
//  UMFunction_starIdentifier.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_starIdentifier.h"

@implementation UMFunction_starIdentifier


+ (NSString *)functionName
{
    return @"__starIdentifier";
}

- (NSString *)functionName
{
    return [UMFunction_starIdentifier functionName];
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
    /* FIXME: what to do here? */
    return NULL;
}

@end
