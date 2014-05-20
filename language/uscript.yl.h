//
//  uscript.yl.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

// common definitions for lex and bison files

#import <Foundation/Foundation.h>
#import "UMTerm.h"
#import "UMScriptCompilerEnvironment.h"


#undef YYFPRINTF
#define YYFPRINTF redirected_fprintf

#undef YY_INPUT
#define YY_INPUT(b,r,s) readInputForLexer(b,&r,s)

#define YYSTYPE_IS_DECLARED 1
typedef UMTerm *YYSTYPE;

#define     ROOT    (global_UMScriptCompilerEnvironment.root)

extern void yyerror(char *s);
extern void lex_count(void);
extern void lex_comment(void);
extern int  lex_check_type(void);
extern int yywrap(void);
extern int yylex();
extern size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead);


