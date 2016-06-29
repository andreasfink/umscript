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


%{

//#import "umscript.yl.h"
#import "_generated_umscript.y.h"


static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner);

static void comment(yyscan_t yyscanner);
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

OCTAL       [0-7]
DECIMAL		[0-9]
NONZERO     [1-9]
LETTER		[a-zA-Z_]
ALPHA       [a-zA-Z_0-9]
HEXDIGIT	[a-fA-F0-9]
HEXPREFIX   (0[xX])
BINARYDIGIT [0,1]
BINARYPREFIX (0[bB])
OCTALPREFIX  (0)
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{DECIMAL}+
FS			(f|F|l|L)
IS			(u|U|l|L)*
SIGN        [+-]?
SP  (u8|u|U|L)
ESCAPE_SEQUENCE  (\\(['"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))
WHITESPACE  [ \t\v\n\f]

%%
"/*"			{ comment(yyscanner);}
"//".*          { /* consume // comment */ }
"break"			{ result(BREAK);    }
"case"			{ result(CASE);     }
"continue"		{ result(CONTINUE); }
"default"		{ result(DEFAULT);  }
"do"			{ result(DO);       }
"else"			{ result(ELSE);     }
"for"			{ result(FOR);      }
"goto"			{ result(GOTO);     }
"if"			{ result(IF);       }
"return"		{ result(RETURN);   }
"switch"		{ result(SWITCH);   }
"while"			{ result(WHILE);    }
"__func__"      { return(FUNC_NAME);  }
"__FILE__"      { return(FILE_NAME);  }
"__LINE__"      { return(LINE_NUMBER);}

"YES"|"NO"                              { result(CONST_BOOLEAN);  }
{HEXPREFIX}{HEXDIGIT}+                  { result(CONST_HEX);      }
{BINARYPREFIX}{BINARYDIGIT}+            { result(CONST_BINARY);   }
{OCTALPREFIX}{OCTAL}+                   { result(CONST_OCTAL);    }
{SIGN}?{DECIMAL}+                       { result(CONST_INTEGER);  }
{DECIMAL}+LL                            { result(CONST_LONGLONG); }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ result(CONST_DOUBLE);   }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ result(CONST_DOUBLE);   }

\${LETTER}({LETTER}|{DECIMAL})*			{ result(VARIABLE);       }
\%{LETTER}({LETTER}|{DECIMAL})*			{ result(FIELD);          }
{LETTER}({LETTER}|{DECIMAL})*			{ result(IDENTIFIER);     }

({SP}?\"([^"\\\n]|{ESCAPE_SEQUENCE})*\"{WHITESPACE}*)+       { result(CONST_STRING); }

"="				{ result(OPERATOR_ASSIGNMENT);   }
">>="			{ result(OPERATOR_RIGHT_ASSIGN); }
"<<="			{ result(OPERATOR_LEFT_ASSIGN);  }
"+="			{ result(OPERATOR_ADD_ASSIGN);   }
"-="			{ result(OPERATOR_SUB_ASSIGN);   }
"*="			{ result(OPERATOR_MUL_ASSIGN);   }
"/="			{ result(OPERATOR_DIV_ASSIGN);   }
"%="			{ result(OPERATOR_MOD_ASSIGN);   }
"&="			{ result(OPERATOR_AND_ASSIGN);   }
"^="			{ result(OPERATOR_XOR_ASSIGN);   }
"|="			{ result(OPERATOR_OR_ASSIGN);    }
">>"			{ result(OPERATOR_RIGHT);        }
"<<"			{ result(OPERATOR_LEFT);         }
"++"			{ result(OPERATOR_INCREASE);     }
"--"			{ result(OPERATOR_DECREASE);     }
"<"				{ result(OPERATOR_LESS);         }
">"				{ result(OPERATOR_GREATER);      }
"&&"			{ result(OPERATOR_AND);          }
"||"			{ result(OPERATOR_OR);           }
"<="			{ result(OPERATOR_LESS_OR_EQUAL);}
">="			{ result(OPERATOR_GREATER_OR_EQUAL); }
"=="			{ result(OPERATOR_EQUAL);            }
"!="			{ result(OPERATOR_NOT_EQUAL);        }
";"				{ result(';'); }
"{"				{ result('{'); }
"}"				{ result('}'); }
","				{ result(','); }
":"				{ result(':'); }
"("				{ result('('); }
")"				{ result(')'); }
("[")			{ result('['); }
("]")			{ result(']'); }
"."				{ result('.'); }
"&"				{ result('&'); }
"!"				{ result('!'); }
"~"				{ result('~'); }
"-"				{ result('-'); }
"+"				{ result('+'); }
"*"				{ result('*'); }
"/"				{ result('/'); }
"%"				{ result('%'); }
"^"				{ result('^'); }
"|"				{ result('|'); }
"?"				{ result('?'); }
"$"				{ result('$'); }

{WHITESPACE}    { /* whitespace separates tokens */ }
.				{ /* ignore bad characters */ }

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

