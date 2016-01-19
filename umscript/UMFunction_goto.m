//
//  UMFunction_goto.m
//  umscript
//
//  Created by Andreas Fink on 23.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_goto.h"

@implementation UMFunction_goto


- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_goto"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"goto";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    UMTerm *label = params[0];
    env.jumpTo = label.labelValue;
    return NULL;
}

@end
