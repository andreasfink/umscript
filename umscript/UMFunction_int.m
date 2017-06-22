//
//  UMFunction_int.m
//  umscript
//
//  Created by Andreas Fink on 21/05/14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_int.h"

@implementation UMFunction_int

+ (NSString *)functionName
{
    return @"int";
}

- (NSString *)functionName
{
    return @"int";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"int";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)p environment:(UMEnvironment *)env
{
    id entry0 = [p objectAtIndex:0];
    
    UMTerm *currentTerm =entry0;
    UMDiscreteValue *d = [currentTerm evaluateWithEnvironment:env];
    
    if(d.type == UMVALUE_INT)
    {
        return d;
    }
    return [UMDiscreteValue discreteLongLong:d.intValue];
}

@end
