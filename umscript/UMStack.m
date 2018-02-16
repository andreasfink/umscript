//
//  UMStack.m
//  umscript
//
//  Created by Andreas Fink on 16.02.18.
//

#import "UMStack.h"
#import "UMStackFrame.h"

@implementation UMStack

- (UMStack *)init
{
    self = [super init];
    if(self)
    {
        _stackFrames = [[NSMutableArray alloc]init];
    }
    return self;
}



- (void)pushFrame:(UMStackFrame *)newFrame
{
    _currentFrame = newFrame;
    [_stackFrames addObject:newFrame];
}

- (void)popFrame
{
    NSUInteger cnt = [_stackFrames count];
    if(cnt>0)
    {
        [_stackFrames removeLastObject];
    }
    cnt--;
    if(cnt <= 0)
    {
        _currentFrame = NULL;
    }
    else
    {
        _currentFrame = [_stackFrames objectAtIndex:cnt-1];
    }
}

- (void)defineLocalVariable:(NSString *)name
{
    [_currentFrame defineLocalVariable:name];
}

- (void)setLocalVariable:(NSString *)name value:(UMDiscreteValue *)val
{
    [_currentFrame setLocalVariable:name value:val];
}

- (UMDiscreteValue *)localVariable:(NSString *)name
{
    return [_currentFrame localVariable:name];
}

@end
