/*
//
//  umscript.l
//  umscript
//
//  Created by Andreas Fink on 17.05.14.
//  Copyright (c) 2014 SMSRelay AG. All rights reserved.
//
*/

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
static void count(yyscan_t yyscanner);
int yywrap (yyscan_t yyscanner );

#define YY_EXTRA_TYPE struct user_type *


//#define  YYPARSEPARAM  yyparseparam


#define COUNT   count(yyscanner);
#define SAVE_TOKEN
//yylval.discreteString = [[NSString alloc]initWithBytes:yytext length:yyleng encoding:NSUTF8StringEncoding];
#define TOKEN(t)    t

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
"break"			{ COUNT; SAVE_TOKEN; return TOKEN(BREAK); }
"case"			{ COUNT; SAVE_TOKEN; return TOKEN(CASE); }
"continue"		{ COUNT; SAVE_TOKEN; return TOKEN(CONTINUE); }
"default"		{ COUNT; SAVE_TOKEN; return TOKEN(DEFAULT); }
"do"			{ COUNT; SAVE_TOKEN; return TOKEN(DO); }
"else"			{ COUNT; SAVE_TOKEN; return TOKEN(ELSE); }
"for"			{ COUNT; SAVE_TOKEN; return TOKEN(FOR); }
"goto"			{ COUNT; SAVE_TOKEN; return TOKEN(GOTO); }
"if"			{ COUNT; SAVE_TOKEN; return TOKEN(IF); }
"return"		{ COUNT; SAVE_TOKEN; return TOKEN(RETURN); }
"switch"		{ COUNT; SAVE_TOKEN; return TOKEN(SWITCH); }
"while"			{ COUNT; SAVE_TOKEN; return TOKEN(WHILE); }

{LETTER}({LETTER}|{DECIMAL})*			{ COUNT; SAVE_TOKEN; return(IDENTIFIER); }
\${LETTER}({LETTER}|{DECIMAL})*			{ COUNT; SAVE_TOKEN; return(VARIABLE); }
\%{LETTER}({LETTER}|{DECIMAL})*			{ COUNT; SAVE_TOKEN; return(FIELD); }

0[xX]{HEXDIGIT}+{IS}?					{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
0{DECIMAL}+{IS}?						{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+{IS}?							{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
L?'(\\.|[^\\'])+'						{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+{E}{FS}?						{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ COUNT; SAVE_TOKEN; return TOKEN(CONSTANT); }

L?\"(\\.|[^\\"])*\"						{ COUNT; SAVE_TOKEN; return TOKEN(STRING_LITERAL); }

"="				{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_ASSIGNMENT); }
">>="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_RIGHT_ASSIGN); }
"<<="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_LEFT_ASSIGN); }
"+="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_ADD_ASSIGN); }
"-="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_SUB_ASSIGN); }
"*="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_MUL_ASSIGN); }
"/="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_DIV_ASSIGN); }
"%="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_MOD_ASSIGN); }
"&="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_AND_ASSIGN); }
"^="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_XOR_ASSIGN); }
"|="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_OR_ASSIGN); }
">>"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_RIGHT); }
"<<"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_LEFT); }
"++"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_INCREASE); }
"--"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_DECREASE); }
"<"				{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_LESS); }
">"				{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_GREATER); }
"&&"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_AND); }
"||"			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_OR); }
"<="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_LESS_OR_EQUAL); }
">="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_GREATER_OR_EQUAL); }
"=="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_EQUAL); }
"!="			{ COUNT; SAVE_TOKEN; return TOKEN(OPERATOR_NOT_EQUAL); }
";"				{ COUNT; SAVE_TOKEN; return TOKEN(';'); }
"{"				{ COUNT; SAVE_TOKEN; return TOKEN('{'); }
"}"				{ COUNT; SAVE_TOKEN; return TOKEN('}'); }
","				{ COUNT; SAVE_TOKEN; return TOKEN(','); }
":"				{ COUNT; SAVE_TOKEN; return TOKEN(':'); }
"("				{ COUNT; SAVE_TOKEN; return TOKEN('('); }
")"				{ COUNT; SAVE_TOKEN; return TOKEN(')'); }
("[")			{ COUNT; SAVE_TOKEN; return TOKEN('['); }
("]")			{ COUNT; SAVE_TOKEN; return TOKEN(']'); }
"."				{ COUNT; SAVE_TOKEN; return TOKEN('.'); }
"&"				{ COUNT; SAVE_TOKEN; return TOKEN('&'); }
"!"				{ COUNT; SAVE_TOKEN; return TOKEN('!'); }
"~"				{ COUNT; SAVE_TOKEN; return TOKEN('~'); }
"-"				{ COUNT; SAVE_TOKEN; return TOKEN('-'); }
"+"				{ COUNT; SAVE_TOKEN; return TOKEN('+'); }
"*"				{ COUNT; SAVE_TOKEN; return TOKEN('*'); }
"/"				{ COUNT; SAVE_TOKEN; return TOKEN('/'); }
"%"				{ COUNT; SAVE_TOKEN; return TOKEN('%'); }
"^"				{ COUNT; SAVE_TOKEN; return TOKEN('^'); }
"|"				{ COUNT; SAVE_TOKEN; return TOKEN('|'); }
"?"				{ COUNT; SAVE_TOKEN; return TOKEN('?'); }
"$"				{ COUNT; SAVE_TOKEN; return TOKEN('$'); }

[ \t\v\n\f]		{ COUNT; }
.				{ /* ignore bad characters */ }

%%

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


static void count(yyscan_t yyscanner)
{
    return; /*
    struct yyguts_t * yyg = (struct yyguts_t*)yyscanner;

	int i;
    
	for (i = 0; yytext[i] != '\0'; i++)
	{
		if (yytext[i] == '\n')
		{
			yyscanner->column = 0;
		}
		else if (yytext[i] == '\t')
		{
			yyscanner->column += 8 - (yyscanner->column % 8);
		}
		else
		{
			yyscanner->column++;
		}
	}
 //   [global_UMScriptCompilerEnvironment setColumn:column];
	ECHO;*/
}


int yywrap (yyscan_t scanner )
{
	return 1;
}



