//
//  UMFunction_list.m
//  umscript
//
//  Created by Andreas Fink on 10.06.14.
//  Copyright (c) 2016 Andreas Fink
//

#import "UMFunction_list.h"

@implementation UMFunction_list

+ (NSString *)functionName
{
    return @"list";
}

- (id)initWithEnvironment:(UMEnvironment *)env
{
    return [self initWithEnvironment:env magic:@"UMFunction_list"];
}

- (id)initWithEnvironment:(UMEnvironment *)env magic:(NSString *)m
{
    self = [super initWithEnvironment:env magic:m];    if(self)
    {
        self.name = @"list";
        [env log:self.name];
    }
    return self;
}

- (UMDiscreteValue *)evaluateWithParams:(NSArray *)params environment:(UMEnvironment *)env
{
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
                @throw([NSException exceptionWithName:@"UMSCRIPT Unknown lablel"
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

@end
