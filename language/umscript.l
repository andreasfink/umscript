/*
//
//  umscript.l
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2016 Andreas Fink
//
*/

%top{

#import "glueterm.h"
#define YYSTYPE_IS_DECLARED 1
#define YYSTYPE glueterm

#import "flex_definitions.h"
#import "umscript.yl.h"

typedef UMScriptCompilerEnvironment *YY_EXTRA_TYPE;

}

%option reentrant
%option bison-bridge
%option bison-locations
%option noyywrap

D            [0-9]
L            [a-zA-Z_\$]
H            [a-fA-F0-9]
E            [Ee][+-]?{D}+
FS            (f|F|l|L)
IS            (u|U|l|L)*

%{

//#import "umscript.yl.h"
#import "_generated_umscript.y.h"


static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner);
static void comment(yyscan_t yyscanner);
static void count(yyscan_t yyscanner);
static int check_type(yyscan_t yyscanner);


@class UMScriptCompilerEnvironment;
extern UMScriptCompilerEnvironment *cenv;


static inline  void * XCFBridgingRetain(id X)
{
    return (__bridge_retained void *)X;
}

static inline  id XCFBridgingRelease(void *X)
{
    return (__bridge_transfer id)X;
}


#define UMGET(x)          ((__bridge UMTerm *)x.value)
#define UMSET(x,val)                            \
{                                               \
    void *newval = XCFBridgingRetain((val));    \
    if((x).value!=NULL)                         \
    {                                           \
        XCFBridgingRelease((x).value);          \
    }                                           \
    (x).value=newval;                           \
}

/* Note: we are not using UMSET here as the structure is allocated by malloc and not initialized to zero */
#define result(x)       \
{       \
    UMScriptCompilerEnvironment *cenv = (__bridge UMScriptCompilerEnvironment *)yyextra; \
    char *text =yyget_text(yyscanner); \
    UMTerm *term = [UMTerm token:(x) text:text withEnvironment:cenv];      \
    yylval_param->value=XCFBridgingRetain(term);                                              \
    yylval_param->token = (x);                                                              \
    NSString *s = [NSString stringWithFormat:@"%d %s {%s}",x,#x,text]; \
    [cenv.lexerLog addLogEntry:s];  \
    return (x);\
}

%}

%%
"/*"            { comment(yyscanner);                 }
"auto"          { count(yyscanner); return(AUTO);     }
"break"         { count(yyscanner); return(BREAK);    }
"case"          { count(yyscanner); return(CASE);     }
"char"          { count(yyscanner); return(CHAR);     }
"const"         { count(yyscanner); return(CONST);    }
"continue"      { count(yyscanner); return(CONTINUE); }
"default"       { count(yyscanner); return(DEFAULT);  }
"do"            { count(yyscanner); return(DO);       }
"double"        { count(yyscanner); return(DOUBLE);   }
"else"          { count(yyscanner); return(ELSE);     }
"enum"          { count(yyscanner); return(ENUM);     }
"extern"        { count(yyscanner); return(EXTERN);   }
"float"         { count(yyscanner); return(FLOAT);    }
"for"           { count(yyscanner); return(FOR);      }
"goto"          { count(yyscanner); return(GOTO);     }
"if"            { count(yyscanner); return(IF);       }
"int"           { count(yyscanner); return(INT);      }
"long"          { count(yyscanner); return(LONG);     }
"register"      { count(yyscanner); return(REGISTER); }
"return"        { count(yyscanner); return(RETURN);   }
"short"         { count(yyscanner); return(SHORT);    }
"signed"        { count(yyscanner); return(SIGNED);   }
"sizeof"        { count(yyscanner); return(SIZEOF);   }
"static"        { count(yyscanner); return(STATIC);   }
"struct"        { count(yyscanner); return(STRUCT);   }
"switch"        { count(yyscanner); return(SWITCH);   }
"typedef"       { count(yyscanner); return(TYPEDEF);  }
"union"         { count(yyscanner); return(UNION);    }
"unsigned"      { count(yyscanner); return(UNSIGNED); }
"void"          { count(yyscanner); return(VOID);     }
"volatile"      { count(yyscanner); return(VOLATILE); }
"while"         { count(yyscanner); return(WHILE);    }

{L}({L}|{D})*   { count(yyscanner); return(check_type(yyscanner)); }

0[xX]{H}+{IS}?      { count(yyscanner); return(CONSTANT); }
0{D}+{IS}?          { count(yyscanner); return(CONSTANT); }
{D}+{IS}?                 { count(yyscanner); return(CONSTANT); }
L?'(\\.|[^\\'])+'         { count(yyscanner); return(CONSTANT); }

{D}+{E}{FS}?              { count(yyscanner); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?    { count(yyscanner); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?    { count(yyscanner); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"    { count(yyscanner); return(STRING_LITERAL); }

"..."           { count(yyscanner); return(ELLIPSIS); }
">>="           { count(yyscanner); return(RIGHT_ASSIGN); }
"<<="           { count(yyscanner); return(LEFT_ASSIGN); }
"+="            { count(yyscanner); return(ADD_ASSIGN); }
"-="            { count(yyscanner); return(SUB_ASSIGN); }
"*="            { count(yyscanner); return(MUL_ASSIGN); }
"/="            { count(yyscanner); return(DIV_ASSIGN); }
"%="            { count(yyscanner); return(MOD_ASSIGN); }
"&="            { count(yyscanner); return(AND_ASSIGN); }
"^="            { count(yyscanner); return(XOR_ASSIGN); }
"|="            { count(yyscanner); return(OR_ASSIGN); }
">>"            { count(yyscanner); return(RIGHT_OP); }
"<<"            { count(yyscanner); return(LEFT_OP); }
"++"            { count(yyscanner); return(INC_OP); }
"--"            { count(yyscanner); return(DEC_OP); }
"->"            { count(yyscanner); return(PTR_OP); }
"&&"            { count(yyscanner); return(AND_OP); }
"||"            { count(yyscanner); return(OR_OP); }
"<="            { count(yyscanner); return(LE_OP); }
">="            { count(yyscanner); return(GE_OP); }
"=="            { count(yyscanner); return(EQ_OP); }
"!="            { count(yyscanner); return(NE_OP); }
";"             { count(yyscanner); return(';'); }
("{"|"<%")      { count(yyscanner); return('{'); }
("}"|"%>")      { count(yyscanner); return('}'); }
","             { count(yyscanner); return(','); }
":"             { count(yyscanner); return(':'); }
"="             { count(yyscanner); return('='); }
"("             { count(yyscanner); return('('); }
")"             { count(yyscanner); return(')'); }
("["|"<:")      { count(yyscanner); return('['); }
("]"|":>")      { count(yyscanner); return(']'); }
"."             { count(yyscanner); return('.'); }
"&"             { count(yyscanner); return('&'); }
"!"             { count(yyscanner); return('!'); }
"~"             { count(yyscanner); return('~'); }
"-"             { count(yyscanner); return('-'); }
"+"             { count(yyscanner); return('+'); }
"*"             { count(yyscanner); return('*'); }
"/"             { count(yyscanner); return('/'); }
"%"             { count(yyscanner); return('%'); }
"<"             { count(yyscanner); return('<'); }
">"             { count(yyscanner); return('>'); }
"^"             { count(yyscanner); return('^'); }
"|"             { count(yyscanner); return('|'); }
"?"             { count(yyscanner); return('?'); }

[ \t\v\n\f]        { count(yyscanner); }
.            { /* ignore bad characters */ }

%%


extern int yylex (YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t bb);

static void comment(yyscan_t yyscanner)
{
    struct yyguts_t * yyg = (struct yyguts_t*)yyscanner;

	char c, c1;
loop:
	while ((c = input(yyscanner)) != '*' && c != 0)
	{
		putchar(c);
	}
	if ((c1 = input(yyscanner)) != '/' && c != 0)
	{
		yyunput( c, yyg->yytext_ptr , yyscanner );
		goto loop;
	}
	if (c != 0)
	{
		putchar(c1);
	}
}

extern int yyparse (yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv);
extern int yydebug;

int yycompile(UMScriptCompilerEnvironment *cenv, int fdes_input, int fdes_output)
{
    yyscan_t yyscanner;
    yylex_init(&yyscanner);
    FILE *infile = fdopen(fdes_input, "r");
    FILE *outfile = fdopen(fdes_output,"w");
    yyset_in(infile,yyscanner);
    yyset_out(outfile,yyscanner);
    void * cenv2 = (void *)XCFBridgingRetain(cenv);
    yyset_extra(cenv2,yyscanner);
//    yydebug = 1;
    yyparse(yyscanner,cenv);
    XCFBridgingRelease(cenv2);
    yylex_destroy(yyscanner);
    return 0;
}

int column = 0;

static void count(yyscan_t yyscanner)
{
    struct yyguts_t * yyg = (struct yyguts_t*)yyscanner;
    
    int i;
    
    for (i = 0; yytext[i] != '\0'; i++)
    if (yytext[i] == '\n')
    column = 0;
    else if (yytext[i] == '\t')
    column += 8 - (column % 8);
    else
    column++;
    
    ECHO;
}


static int check_type(yyscan_t yyscanner)
{
    /*
     * pseudo code --- this is what it should check
     *
     *    if (yytext == type_name)
     *        return(TYPE_NAME);
     *
     *    return(IDENTIFIER);
     */
    
    /*
     *    it actually will only return IDENTIFIER
     */
    
    return(IDENTIFIER);
}
