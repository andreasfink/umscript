//
//  uscript.yl.h
//  umscript
//
//  Created by Andreas Fink on 19/05/14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//

// common definitions for lex and bison files


#undef YYFPRINTF
#define YYFPRINTF redirected_fprintf


/*
extern  void yyerror(void *yyscanner,const char *s);
int redirected_fprintf(FILE *f,char *format,...);


#undef YY_INPUT
#define YY_INPUT(b,r,s) readInputForLexer(b,&r,s)
*/

//#define YY_EXTRA_TYPE struct user_type *




//#undef YY_EXTRA_TYPE
//typedef UMObject *YY_EXTRA_TYPE;



#define     ROOT    (global_UMScriptCompilerEnvironment.root)
