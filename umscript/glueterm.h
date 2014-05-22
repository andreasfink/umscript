//
//  glueterm.h
//  umscript
//
//  Created by Andreas Fink on 22.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UMTerm;

typedef struct glueterm
{
    int     token;
    __unsafe_unretained UMTerm  *value;
} glueterm;

