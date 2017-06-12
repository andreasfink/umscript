//
//  UMFunction_lessorequal.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_lessorequal.h"

@implementation UMFunction_lessorequal

+ (NSString *)functionName
{
    return @"lessorequal";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_lessorequal"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"lessorequal";
        [env log:self.name];
    }
    return self;
}


- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    if(params.count != 2)
    {
        return [UMDiscreteValue discreteNull];
    }
    
    UMTerm *param0 = params[0];
    UMDiscreteValue *value0 = [param0 evaluateWithEnvironment:env];
    
    UMTerm *param1 = params[1];
    UMDiscreteValue *value1 = [param1 evaluateWithEnvironment:env];
    
    UMDiscreteValue *r = [value0 discreteIsLessThanOrEqualTo:value1];
    return r;
}

@end
