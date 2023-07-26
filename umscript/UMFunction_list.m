//
//  UMFunction_list.m
//  umscript
//
//  Created by Andreas Fink on 10.06.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_list.h"
#import "UMTerm_CallStackEntry.h"
#import "UMTerm_Interrupt.h"

@implementation UMFunction_list


+ (NSString *)functionName
{
    return @"__list";
}

- (NSString *)functionName
{
    return [UMFunction_list functionName];
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

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)xparams environment:(UMEnvironment *)env continueFrom:(UMTerm_Interrupt *)interruptedAt
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

    env._returnValue = nil;
    
    NSMutableDictionary *labelsDict = [[NSMutableDictionary alloc]init];
    NSUInteger i=0;
    NSUInteger n=[xparams count];
    for(i=0;i<n;i++)
    {
        UMTerm *term  = [xparams objectAtIndex:i];
        if(term.label)
        {
            [labelsDict setObject:[NSNumber numberWithInteger:i] forKey:term.label];
        }
    }
    
    if(env._jumpTo != NULL) /* a block of a switch statement where we are being jumped into */
    {
        NSNumber *goTo = [labelsDict objectForKey:env._jumpTo];
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
        UMTerm *term  = [xparams objectAtIndex:i];
        
        env._jumpTo = NULL;
        env._returnCalled = NO;
        env._breakCalled = NO;
        
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
        
        if(env._returnCalled)
        {
            env._returnValue = r;
            break;
        }
        if(env._breakCalled)
        {
            break;
        }
        if(env._jumpTo)
        {
            NSNumber *goTo = [labelsDict objectForKey:[env._jumpTo description]];
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
                @throw([NSException exceptionWithName:@"UMSCRIPT Unknown lablel"
                                               reason:NULL
                                             userInfo:@{
                                                        @"sysmsg" : [NSString stringWithFormat:@"Unknown label %@",env._jumpTo.description],
                                                        @"func": @(__func__),
                                                        @"err": @(1)
                                                        }]);

                break;
            }
        }
        i++;
    } while (i<n);
    return  env._returnValue;
}

@end
