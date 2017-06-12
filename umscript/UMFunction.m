//
//  UMFunction
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import <ulib/ulib.h>
#import "UMFunction.h"
#import "UMEnvironment.h"
#import "UMTerm.h"
#import "NSNumber+UMScript.h"

@implementation UMFunction

@synthesize comment;
//@synthesize cenv;


- (id) objectValue
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"functionName"] = self.name;
    return dict;
}

- (id)initWithEnvironment:(UMEnvironment *)compile_env
{
    self = [super init];
    if(self)
    {
        _name = [[self class] description];
        _name = self.name; /* if the name accessor is overwritten, this will use it */
        self.cenv = compile_env;
    }
    return self;
}

- (void)setCenv:(UMEnvironment *)env;
{
    _cenv = env;
    [_cenv log:self.name];
}

- (UMEnvironment *)cenv
{
    return _cenv;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
    return [UMDiscreteValue discreteNull];
}

- (NSString *)debugDescription
{
    return self.name;
}

- (NSString *)description
{
    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
    NSString *s = [writer stringWithObject:[self descriptionDictVal]];
    return s;
}

- (id)descriptionDictVal
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(_name)
    {
        dict[@"function"] = _name;
    }
    return dict;
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    return [NSString stringWithFormat:@"%@(",_name];
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@",pstring];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@",%@",pstring];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@",%@",pstring];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    return @")";
}

+(NSString *)functionName
{
    return @"undefined-function";
}
@end

