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
#import "UMFunctionMacros.h"

#undef YYSTYPE_IS_DECLARED
#define YYSTYPE_IS_DECLARED 1
#undef YYSTYPE

typedef UMTerm *YYSTYPE;


/*
extern  void yyerror(void *yyscanner,const char *s);
int redirected_fprintf(FILE *f,char *format,...);

#undef YYFPRINTF
#define YYFPRINTF redirected_fprintf

#undef YY_INPUT
#define YY_INPUT(b,r,s) readInputForLexer(b,&r,s)
*/

//#define YY_EXTRA_TYPE struct user_type *



//#define YYSTYPE_IS_DECLARED 1
//#typedef UMTerm *YYSTYPE;
//#undef YY_EXTRA_TYPE
//typedef UMObject *YY_EXTRA_TYPE;




#define YYERROR_VERBOSE 1
#define YYDEBUG 1



#undef YYPARSE_PARAM
#define YYPARSE_PARAM	context

#undef YYLEX_PARAM
#define YYLEX_PARAM     context


#define     ROOT    (global_UMScriptCompilerEnvironment.root)
/*
extern void yyerror(char *s);
extern void lex_count(void);
extern void lex_comment(void);
extern int  lex_check_type(void);
extern int yywrap(void);
extern int yylex();
extern size_t readInputForLexer(char *buffer, size_t * numBytesRead, size_t maxBytesToRead);


*/