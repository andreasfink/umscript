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
#import "umscript.yl.h"

}

%option reentrant
%option bison-bridge
%option bison-locations

%{

#import "umscript.yl.h"
#import "_generated_umscript.y.h"

//extern int yylex (YYSTYPE * yylval_param ,yyscan_t yyscanner);
//extern int yylex (YYSTYPE * lvalp, YYLTYPE * llocp, yyscan_t scanner);

static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner);

static void comment(yyscan_t yyscanner);
int yywrap (yyscan_t yyscanner );

#define YY_EXTRA_TYPE struct user_type *


//#define  YYPARSEPARAM  yyparseparam

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
"break"			{ return BREAK;    }
"case"			{ return CASE;     }
"continue"		{ return CONTINUE; }
"default"		{ return DEFAULT;  }
"do"			{ return DO;       }
"else"			{ return ELSE;     }
"for"			{ return FOR;      }
"goto"			{ return GOTO;     }
"if"			{ return IF;       }
"return"		{ return RETURN;   }
"switch"		{ return SWITCH;   }
"while"			{ return WHILE;    }

{LETTER}({LETTER}|{DECIMAL})*			{ return IDENTIFIER;  }
\${LETTER}({LETTER}|{DECIMAL})*			{ return VARIABLE;    }
\%{LETTER}({LETTER}|{DECIMAL})*			{ return FIELD;       }

0[xX]{HEXDIGIT}+{IS}?					{ return CONSTANT; }
0{DECIMAL}+{IS}?						{ return CONSTANT; }
{DECIMAL}+{IS}?							{ return CONSTANT; }
L?'(\\.|[^\\'])+'						{ return CONSTANT; }
{DECIMAL}+{E}{FS}?						{ return CONSTANT; }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ return CONSTANT; }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ return CONSTANT; }

L?\"(\\.|[^\\"])*\"						{ return STRING_LITERAL; }

"="				{ return OPERATOR_ASSIGNMENT;   }
">>="			{ return OPERATOR_RIGHT_ASSIGN; }
"<<="			{ return OPERATOR_LEFT_ASSIGN;  }
"+="			{ return OPERATOR_ADD_ASSIGN;   }
"-="			{ return OPERATOR_SUB_ASSIGN;   }
"*="			{ return OPERATOR_MUL_ASSIGN;   }
"/="			{ return OPERATOR_DIV_ASSIGN;   }
"%="			{ return OPERATOR_MOD_ASSIGN;   }
"&="			{ return OPERATOR_AND_ASSIGN;   }
"^="			{ return OPERATOR_XOR_ASSIGN;   }
"|="			{ return OPERATOR_OR_ASSIGN;    }
">>"			{ return OPERATOR_RIGHT;        }
"<<"			{ return OPERATOR_LEFT;         }
"++"			{ return OPERATOR_INCREASE;     }
"--"			{ return OPERATOR_DECREASE;     }
"<"				{ return OPERATOR_LESS;         }
">"				{ return OPERATOR_GREATER;      }
"&&"			{ return OPERATOR_AND;          }
"||"			{ return OPERATOR_OR;           }
"<="			{ return OPERATOR_LESS_OR_EQUAL;}
">="			{ return OPERATOR_GREATER_OR_EQUAL; }
"=="			{ return OPERATOR_EQUAL;            }
"!="			{ return OPERATOR_NOT_EQUAL;        }
";"				{ return ';'; }
"{"				{ return '{'; }
"}"				{ return '}'; }
","				{ return ','; }
":"				{ return ':'; }
"("				{ return '('; }
")"				{ return ')'; }
("[")			{ return '['; }
("]")			{ return ']'; }
"."				{ return '.'; }
"&"				{ return '&'; }
"!"				{ return '!'; }
"~"				{ return '~'; }
"-"				{ return '-'; }
"+"				{ return '+'; }
"*"				{ return '*'; }
"/"				{ return '/'; }
"%"				{ return '%'; }
"^"				{ return '^'; }
"|"				{ return '|'; }
"?"				{ return '?'; }
"$"				{ return '$'; }

[ \t\v\n\f]		{  }
.				{ /* ignore bad characters */ }

%%

extern int yylex (YYSTYPE * yylval_param, YYLTYPE * yylloc_param , bisonbridge *bb);

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



