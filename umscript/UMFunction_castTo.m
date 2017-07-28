//
//  UMFunction_castTo.m
//  umscript
//
//  Created by Andreas Fink on 12.06.17.
//

#import "UMFunction_castTo.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_castTo



+ (NSString *)functionName
{
    return @"__castTo";
}

- (NSString *)functionName
{
    return [UMFunction_castTo functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    /* FIXME */
    return [UMDiscreteValue discreteNull];
}

@end


