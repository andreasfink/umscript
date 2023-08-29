//
//  UMFunction_block.m
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_block.h"
#import "UMEnvironment.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_block

+ (NSString *)functionName
{
    return @"__block";
}

- (NSString *)functionName
{
    return [UMFunction_block functionName];
}


- (id)initWithEnvironment:(UMEnvironment *)env
{
    self = [super initWithEnvironment:env];
    if(self)
    {
        [env log:self.functionName];
   }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
{
    NSInteger start;
    if(interruptedAt)
    {
        UMTerm_CallStackEntry *entry = [interruptedAt pullEntry];
        start = entry.position;
    }
    else
    {
        start = 0;
    }
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
        i=start;
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

        UMDiscreteValue *r;
        @try
        {
            r = [term evaluateWithEnvironment:env continueFrom:interruptedAt];
        }
        @catch(UMTerm_Interrupt *interrupt)
        {
            UMTerm_CallStackEntry *e = [[UMTerm_CallStackEntry alloc]init];
            e.name = [self functionName];
            e.position = i;
            [interrupt recordEntry:e];
            @throw(interrupt);
        }
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
    NSString *s=[NSString stringWithFormat:@"%@{\r%@    ",env.identPrefix,env.identPrefix];
    [env identAdd];
    return s;
}

- (NSString *)codeWithEnvironmentFirstParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,env.identPrefix];
}

- (NSString *)codeWithEnvironmentNextParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r%@",pstring,env.identPrefix];
}

- (NSString *)codeWithEnvironmentLastParam:(UMTerm *)param env:(UMEnvironment *)env
{
    NSString *pstring = [param codeWithEnvironment:env];
    return [NSString stringWithFormat:@"%@;\r",pstring];
}

- (NSString *)codeWithEnvironmentStop:(UMEnvironment *)env
{
    [env identRemove];
    return [NSString stringWithFormat:@"%@}\r",env.identPrefix];
}

@end
