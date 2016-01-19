//
//  uscript.yl.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2016 Andreas Fink
//

/* functions which are used by the lexer and the parser jointly */

#import "flex_definitions.h"
#import "bison_definitions.h"

#import "umscript.yl.h"


#import "UMScriptCompilerEnvironment.h"

extern void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg);

void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg)
{
    NSString *err = [NSString stringWithFormat:@"\nLocation %d.%d - %d.%d: %s\n",
             llocp->first_line,llocp->first_column,
             llocp->last_line,llocp->last_column,msg];
    NSLog(@"ERR:%@",err);
    [cenv addStdErr:err];
}
