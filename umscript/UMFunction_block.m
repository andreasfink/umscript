//
//  UMFunction_block.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMFunction_block.h"
#import "UMEnvironment.h"

@implementation UMFunction_block

- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        self.name = @"block";
        [env log:self.name];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
//    UMDiscreteValue *previousReturnValue = env.returnValue;
    env.returnValue = nil;

    NSMutableDictionary *labelsDict = [[NSMutableDictionary alloc]init];
    NSUInteger i=0;
    NSUInteger n=[params count];
    for(i=0;i<n;i++)
    {
        UMTerm *term  = [params objectAtIndex:i];
        if(term.label)
        {
            [labelsDict setObject:[NSNumber numberWithInteger:i] forKey:term.label];
        }
    }

    i=0;
    do
    {
        if(i>=n)
        {
            break;
        }
        UMTerm *term  = [params objectAtIndex:i];

        env.jumpTo = NULL;
        env.executionDone = NO;

        UMDiscreteValue *r = [term evaluateWithEnvironment:env];
        if(env.executionDone)
        {
            env.returnValue = r;
            break;
        }
        if(env.jumpTo)
        {
            NSNumber *goTo = [labelsDict objectForKey:env.jumpTo];
            if(goTo != NULL)
            {
                i =  [goTo integerValue];
                continue;
            }
            else
            {
                /* TODO: goto a unknown label */
                break;
            }
        }
        i++;
    } while (i<n);
    return  env.returnValue;
}

- (NSString *)codeWithEnvironmentStart:(UMEnvironment *)env
{
    NSString *s=[NSString stringWithFormat:@"%@{\r%@    ",[env identPrefix],[env identPrefix]];
    [env identAdd];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,[env identPrefix]];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,[env identPrefix]];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r",pstring];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    [env identRemove];
    return [NSString stringWithFormat:@"%@}\r",[env identPrefix]];
}

@end
