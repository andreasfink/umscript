/*
//
//  umscript.l
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//
*/

%top{


#import "glueterm.h"
#define YYSTYPE_IS_DECLARED 1
#define YYSTYPE glueterm


#import "flex_definitions.h"
#import "umscript.yl.h"

}

%option reentrant
%option bison-bridge
%option bison-locations

%{

#import "umscript.yl.h"
#import "_generated_umscript.y.h"


static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner);

static void comment(yyscan_t yyscanner);
int yywrap (yyscan_t yyscanner );

#define YY_EXTRA_TYPE struct user_type *


//#define  YYPARSEPARAM  yyparseparam

#define result(x)  (*yylval_param).value = (__bridge CFTypeRef)[UMTerm token:(x) text:yyget_text(yyscanner)];yylval_param->token = (x);

%}


DECIMAL		[0-9]
LETTER		[a-zA-Z_]
HEXDIGIT	[a-fA-F0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{DECIMAL}+
FS			(f|F|l|L)
IS			(u|U|l|L)*


%%
"/*"			{ comment(yyscanner);}
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

{LETTER}({LETTER}|{DECIMAL})*			{ result(IDENTIFIER);  }
\${LETTER}({LETTER}|{DECIMAL})*			{ result(VARIABLE);    }
\%{LETTER}({LETTER}|{DECIMAL})*			{ result(FIELD);       }

0[xX]{HEXDIGIT}+{IS}?					{ result(CONSTANT); }
0{DECIMAL}+{IS}?						{ result(CONSTANT); }
{DECIMAL}+{IS}?							{ result(CONSTANT); }
L?'(\\.|[^\\'])+'						{ result(CONSTANT); }
{DECIMAL}+{E}{FS}?						{ result(CONSTANT); }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ result(CONSTANT); }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ result(CONSTANT); }

L?\"(\\.|[^\\"])*\"						{ result(STRING_LITERAL); }

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

[ \t\v\n\f]		{  }
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

int yywrap (yyscan_t scanner )
{
	return 1;
}


extern int yyparse (yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv);

int yycompile(UMScriptCompilerEnvironment *cenv, int fdes_input, int fdes_output)
{
    yyscan_t yyscanner;
    yylex_init(&yyscanner);
    FILE *infile = fdopen(fdes_input, "r");
    FILE *outfile = fdopen(fdes_output,"w");
    yyset_in(infile,yyscanner);
    yyset_out(outfile,yyscanner);

    struct glueterm return_value;
    return_value.token = 0;
    return_value.value = 0;

    yyparse(yyscanner,cenv);
    /*
yyscanner
     while (yylex(&return_value, &location_info, yyscanner) > 0)
    {
        NSLog(@"Tok: %d yytext=%@\n",return_value.token, return_value.value);
        return_value.token = 0;
    }
     */
    yylex_destroy(yyscanner);
    return 0;
}

