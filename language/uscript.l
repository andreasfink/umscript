DECIMAL		[0-9]
LETTER		[a-zA-Z_]
HEXDIGIT	[a-fA-F0-9]

L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{DECIMAL}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{

#import "uscript.yl.h"
#import "uscript.y.h" 

void count(void);
void comment(void);
int check_type(void);
int yywrap(void);


#define SAVE_TOKEN  yylval.discreteString = [[NSString alloc]initWithBytes:yytext length:yyleng encoding:NSUTF8StringEncoding];
#define TOKEN(t)    yylval.token = t

%}

%%
"/*"			{ comment(); }
"break"			{ count(); return(BREAK); }
"case"			{ count(); return(CASE); }
"continue"		{ count(); return(CONTINUE); }
"default"		{ count(); return(DEFAULT); }
"do"			{ count(); return(DO); }
"else"			{ count(); return(ELSE); }
"for"			{ count(); return(FOR); }
"goto"			{ count(); return(GOTO); }
"if"			{ count(); return(IF); }
"return"		{ count(); return(RETURN); }
"switch"		{ count(); return(SWITCH); }
"while"			{ count(); return(WHILE); }

{LETTER}({LETTER}|{DECIMAL})*			{ count(); SAVE_TOKEN; return(IDENTIFIER); }

0[xX]{HEXDIGIT}+{IS}?					{ count(); return(CONSTANT); }
0{DECIMAL}+{IS}?						{ count(); return(CONSTANT); }
{DECIMAL}+{IS}?							{ count(); return(CONSTANT); }
L?'(\\.|[^\\'])+'						{ count(); return(CONSTANT); }
{DECIMAL}+{E}{FS}?						{ count(); return(CONSTANT); }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ count(); return(CONSTANT); }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ count(); return(CONSTANT); }

L?\"(\\.|[^\\"])*\"						{ count(); return(STRING_LITERAL); }

"="				{ count(); return(OPERATOR_ASSIGNMENT); }
">>="			{ count(); return(OPERATOR_RIGHT_ASSIGN); }
"<<="			{ count(); return(OPERATOR_LEFT_ASSIGN); }
"+="			{ count(); return(OPERATOR_ADD_ASSIGN); }
"-="			{ count(); return(OPERATOR_SUB_ASSIGN); }
"*="			{ count(); return(OPERATOR_MUL_ASSIGN); }
"/="			{ count(); return(OPERATOR_DIV_ASSIGN); }
"%="			{ count(); return(OPERATOR_MOD_ASSIGN); }
"&="			{ count(); return(OPERATOR_AND_ASSIGN); }
"^="			{ count(); return(OPERATOR_XOR_ASSIGN); }
"|="			{ count(); return(OPERATOR_OR_ASSIGN); }
">>"			{ count(); return(OPERATOR_RIGHT); }
"<<"			{ count(); return(OPERATOR_LEFT); }
"++"			{ count(); return(OPERATOR_INCREASE); }
"--"			{ count(); return(OPERATOR_DECREASE); }
"<"				{ count(); return(OPERATOR_LESS); }
">"				{ count(); return(OPERATOR_GREATER); }
"&&"			{ count(); return(OPERATOR_AND); }
"||"			{ count(); return(OPERATOR_OR); }
"<="			{ count(); return(OPERATOR_LESS_OR_EQUAL); }
">="			{ count(); return(OPERATOR_GREATER_OR_EQUAL); }
"=="			{ count(); return(OPERATOR_EQUAL); }
"!="			{ count(); return(OPERATOR_NOT_EQUAL); }
";"				{ count(); return(';'); }
"{"				{ count(); return('{'); }
"}"				{ count(); return('}'); }
","				{ count(); return(','); }
":"				{ count(); return(':'); }
"("				{ count(); return('('); }
")"				{ count(); return(')'); }
("[")			{ count(); return('['); }
("]")			{ count(); return(']'); }
"."				{ count(); return('.'); }
"&"				{ count(); return('&'); }
"!"				{ count(); return('!'); }
"~"				{ count(); return('~'); }
"-"				{ count(); return('-'); }
"+"				{ count(); return('+'); }
"*"				{ count(); return('*'); }
"/"				{ count(); return('/'); }
"%"				{ count(); return('%'); }
"^"				{ count(); return('^'); }
"|"				{ count(); return('|'); }
"?"				{ count(); return('?'); }
"$"				{ count(); return('$'); }

[ \t\v\n\f]		{ count(); }
.				{ /* ignore bad characters */ }

%%

int yywrap(void)
{
	return(1);
}


void comment(void)
{
	char c, c1;
loop:
	while ((c = input()) != '*' && c != 0)
	{
		putchar(c);
	}
	if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}
	if (c != 0)
	{
		putchar(c1);
	}
}


int column = 0;

void count(void)
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
	{
		if (yytext[i] == '\n')
		{
			column = 0;
		}
		else if (yytext[i] == '\t')
		{
			column += 8 - (column % 8);
		}
		else
		{
			column++;
		}
	}
	ECHO;
}


int check_type(void)
{
/*
* pseudo code --- this is what it should check
*
*	if (yytext == type_name)
*		return(TYPE_NAME);
*
*	return(IDENTIFIER);
*/

/*
*	it actually will only return IDENTIFIER
*/
	return(IDENTIFIER);
}


