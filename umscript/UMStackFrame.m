//
//  UMStackFrame.m
//  umscript
//
//  Created by Andreas Fink on 16.02.18.
//

#import "UMStackFrame.h"
#import "UMDiscreteValue.h"

@implementation UMStackFrame

- (UMStackFrame *)init
{
    self = [super init];
    if(self)
    {
        _localVariables = [[NSMutableDictionary alloc]init];
        _parameters = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)defineLocalVariable:(NSString *)name
{
    _localVariables[name] = [UMDiscreteValue discreteNull];
}

- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val
{
    _localVariables[name] = val;
}

- (UMDiscreteValue *)localVariable:(NSString *)name /* returns NULL if variable not found */
{
    return     _localVariables[name];
}

- (void)setParameters:(NSArray *)params
{
    _parameters = [params mutableCopy];
}

@end
