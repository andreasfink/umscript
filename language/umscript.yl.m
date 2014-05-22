//
//  uscript.yl.m
//  umscript
//
//  Created by Andreas Fink on 20/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

/* functions which are used by the lexer and the parser jointly */

#import "flex_definitions.h"
#import "bison_definitions.h"

#import "umscript.yl.h"


#import "UMScriptCompilerEnvironment.h"

int redirected_fprintf(FILE *f,char *format,...)
{
    char buffer[1024];
    memset(buffer,0x00,sizeof(buffer));
    va_list args;
    va_start(args, format);
    vsnprintf(buffer,sizeof(buffer)-1, format,args);
    va_end(args);
    
    NSString *errStr = [NSString stringWithUTF8String:buffer];
    
// FIXME:     [global_UMScriptCompilerEnvironment addStdOut:errStr];
    fprintf(f,"<*%s*>\n",buffer);
    return (int)strlen(buffer);
}

extern void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg);

void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg)
{
    NSString *err = [NSString stringWithFormat:@"\nLocation %d.%d - %d.%d: %s\n",
             llocp->first_line,llocp->first_column,
             llocp->last_line,llocp->last_column,msg];
    NSLog(@"ERR:%@",err);
    [cenv addStdErr:err];
}
