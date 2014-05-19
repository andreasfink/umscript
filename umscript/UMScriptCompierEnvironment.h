//
//  UMScriptCompierEnvironment.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

#import "UMEnvironment.h"

@interface UMScriptCompierEnvironment : UMEnvironment
{
    NSString        *source;
    NSMutableString *compilingOutput;
    
    int linenum;
    NSString *input_name;
    int num_errors;
    int num_warnings;
    int num_extern_functions;
    int num_local_functions;
    int errors;
    int last_syntax_error_line;
}
- (void)compile;

@end
