//
//  UMFunction_substr.m
//  umscript
//
//  Created by Andreas Fink on 10.06.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_substr.h"

@implementation UMFunction_substr

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"substr";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(id)env
{
    NSUInteger c = params.count;
    if((c<2) || (c>3))
    {
        return [UMDiscreteValue discreteNull];
    }
    UMTerm *stringTerm = params[0];
    UMDiscreteValue *stringValue = [stringTerm evaluateWithEnvironment:env];
    NSString *string = stringValue.stringValue;

    UMTerm *startTerm = params[1];
    UMDiscreteValue *startValue = [startTerm evaluateWithEnvironment:env];
    int start = startValue.intValue;
    if(start >= [string length])
    {
        return [UMDiscreteValue discreteString:@""];
    }

    UMTerm *lenTerm = NULL;
    UMDiscreteValue *lenValue = NULL;
    int len;
    if(c>2)
    {
        lenTerm = params[2];
        lenValue = [lenTerm evaluateWithEnvironment:env];
        len = lenValue.intValue;
        NSString *result = [string substringWithRange:NSMakeRange(start,len)];
        return [UMDiscreteValue discreteString:result];
    }
    NSString *result = [string substringFromIndex:start];
    return [UMDiscreteValue discreteString:result];
}

@end
