//
//  UMFunction_print.m
//  umscript
//
//  Created by Andreas Fink on 23/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_print.h"

@implementation UMFunction_print

+ (NSString *)functionName
{
    return @"print";
}

- (NSString *)functionName
{
    return @"print";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)    {
        self.name = @"print";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    for (UMTerm *param in params)
    {
        UMDiscreteValue *d = [param evaluateWithEnvironment:env];
        NSString *s = d.stringValue;
        fprintf(stdout,"%s",s.UTF8String);
    }
    return [UMDiscreteValue discreteNull];
}

@end
