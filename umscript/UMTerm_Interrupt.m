//
//  UMTerm_Interrupt.m
//  umscript
//
//  Created by Andreas Fink on 18.07.17.
//
//

#import "UMTerm_Interrupt.h"
#import "UMTerm_CallStackEntry.h"

@implementation UMTerm_Interrupt

- (UMTerm_CallStackEntry *)pullEntry
{
    return [callStackEntries getFirst];
}

- (void)recordEntry:(UMTerm_CallStackEntry *)entry
{
    [callStackEntries insertFirst:entry];
}

@end
