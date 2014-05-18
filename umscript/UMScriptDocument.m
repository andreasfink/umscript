//
//  UMScriptDocument.m
//  umruleengine
//
//  Created by Andreas Fink on 18.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMScriptDocument.h"
#import "UMTerm.h"
#import "UMEnvironment.h"

@implementation UMScriptDocument

@synthesize sourceCode;
@synthesize execCode;

- (UMDiscreteValue *)runScriptWithEnvironment:(UMEnvironment *)env
{
    UMDiscreteValue *result = [execCode evaluateWithEnvironment:env];
    return result;
}

- (NSString *)sourceCode
{
    return sourceCode;
}

- (void)setSourceCode:(NSString *)s
{
    sourceCode = s;
    isCompiled = NO;
}

- (NSString *)compileSource
{
    return @"";
}

- (NSString *)sourceWithoutComment
{
    /* step1: split source into lines */
    
    NSArray *lines = [sourceCode componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableArray *linesWithoutComments = [[NSMutableArray alloc]init];
    for(NSString *line in lines)
    {
        NSRange r = [line rangeOfString:@"//"];
        if(r.location != NSNotFound)
        {
            [linesWithoutComments addObject:[line substringToIndex:r.location]];
        }
        else
        {
            [linesWithoutComments addObject:line];
        }
    }
    NSString *sourceNoComment = [linesWithoutComments componentsJoinedByString:@"\r"];
    return sourceNoComment;
}


@end
