//
//  UMFunction_data.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_data.h"

@implementation UMFunction_data

+ (NSString *)functionName
{
    return @"data";
}

- (NSString *)functionName
{
    return @"data";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"data";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *currentTerm = params[0];
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_DATA)
    {
        return d;
    }
    return [UMDiscreteValue discreteData:d.dataValue];
}

@end
