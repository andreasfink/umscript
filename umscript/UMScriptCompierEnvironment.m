//
//  UMScriptCompierEnvironment.m
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMScriptCompierEnvironment.h"
#import "UMTerm.h"

extern int yyparse(void *);

@implementation UMScriptCompierEnvironment


- (void)compile
{
        
    self->linenum = 1;
    self->input_name = @"input-name";
    self->num_errors = 0;
    self->num_warnings = 0;
    self->num_extern_functions = 0;
    self->num_local_functions = 0;
    self->errors = 0;
    self->last_syntax_error_line = 0;
    
    void *p = (__bridge void *)self;
    
    yyparse(p);
    
}

@end
