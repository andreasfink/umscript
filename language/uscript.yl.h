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

#define CENV    global_UMScriptCompilerEnvironment;

#define YYSTYPE_IS_DECLARED 1
typedef UMTerm *YYSTYPE;

//#define YYPARSE_PARAM   parm


//extern char yytext[];
extern int column;
int yylex();

extern void *parm;



/*
typedef struct MyGlueStruct {  CFTypeRef *object; } MyGlueStruct;
//#define YYSTYPE ((__bridge void *)id)

typedef struct YYSTYPE_Struct
{
    id object;
    int integer;
    NSString *string;
} YYSTYPE_Struct;

typedef YYSTYPE_Struct YYSTYPE;
*/
