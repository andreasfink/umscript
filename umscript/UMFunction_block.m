//
//  UMFunction_block.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_block.h"
#import "UMEnvironment.h"

@implementation UMFunction_block

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_block"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
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

    if(env.jumpTo != NULL) /* a block of a switch statement where we are being jumped into */
    {
        NSNumber *goTo = [labelsDict objectForKey:env.jumpTo];
        if(goTo != NULL)
        {
            i =  [goTo integerValue];
        }
        else
        {
            NSNumber *goTo = [labelsDict objectForKey:@"default"];
            if(goTo != NULL)
            {
                i =  [goTo integerValue];
            }
            else
            {
                /* fall through the whole block */
                i = n+1;
            }
        }
    }
    else
    {
        i=0;
    }
    do
    {
        if(i>=n)
        {
            break;
        }
        UMTerm *term  = [params objectAtIndex:i];

        env.jumpTo = NULL;
        env.returnCalled = NO;
        env.breakCalled = NO;

        UMDiscreteValue *r = [term evaluateWithEnvironment:env];
        if(env.returnCalled)
        {
            env.returnValue = r;
            break;
        }
        if(env.breakCalled)
        {
            break;
        }
        if(env.jumpTo)
        {
            NSNumber *goTo = [labelsDict objectForKey:[env.jumpTo description]];
            if(goTo != NULL)
            {
                i =  [goTo integerValue];
                continue;
            }
            else
            {
                /* we use discreteNull as placeholder for any default: switch statement */
                NSNumber *goTo = [labelsDict objectForKey:[[UMDiscreteValue discreteNull]description]];
                if(goTo != NULL)
                {
                    i =  [goTo integerValue];
                    continue;
                }
                @throw([NSException exceptionWithName:@"umscript unknown lablel"
                                               reason:NULL
                                             userInfo:@{
                                                        @"sysmsg" : [NSString stringWithFormat:@"Unknown label %@",env.jumpTo.description],
                                                        @"func": @(__func__),
                                                        @"err": @(1)
                                                        }]);

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
