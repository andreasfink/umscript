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

static void comment(void);
static void count(void);
static int column=0;
int yywrap(void);

//#define  YYPARSEPARAM  yyparseparam


#define SAVE_TOKEN  yylval.discreteString = [[NSString alloc]initWithBytes:yytext length:yyleng encoding:NSUTF8StringEncoding];
#define TOKEN(t)    yylval.token = t

%}

%%
"/*"			{ comment(); }
"break"			{ count(); SAVE_TOKEN; return TOKEN(BREAK); }
"case"			{ count(); SAVE_TOKEN; return TOKEN(CASE); }
"continue"		{ count(); SAVE_TOKEN; return TOKEN(CONTINUE); }
"default"		{ count(); SAVE_TOKEN; return TOKEN(DEFAULT); }
"do"			{ count(); SAVE_TOKEN; return TOKEN(DO); }
"else"			{ count(); SAVE_TOKEN; return TOKEN(ELSE); }
"for"			{ count(); SAVE_TOKEN; return TOKEN(FOR); }
"goto"			{ count(); SAVE_TOKEN; return TOKEN(GOTO); }
"if"			{ count(); SAVE_TOKEN; return TOKEN(IF); }
"return"		{ count(); SAVE_TOKEN; return TOKEN(RETURN); }
"switch"		{ count(); SAVE_TOKEN; return TOKEN(SWITCH); }
"while"			{ count(); SAVE_TOKEN; return TOKEN(WHILE); }

{LETTER}({LETTER}|{DECIMAL})*			{ count(); SAVE_TOKEN; return(IDENTIFIER); }
\${LETTER}({LETTER}|{DECIMAL})*			{ count(); SAVE_TOKEN; return(VARIABLE); }
\%{LETTER}({LETTER}|{DECIMAL})*			{ count(); SAVE_TOKEN; return(FIELD); }

0[xX]{HEXDIGIT}+{IS}?					{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
0{DECIMAL}+{IS}?						{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+{IS}?							{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
L?'(\\.|[^\\'])+'						{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+{E}{FS}?						{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}*"."{DECIMAL}+({E})?{FS}?		{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }
{DECIMAL}+"."{DECIMAL}*({E})?{FS}?		{ count(); SAVE_TOKEN; return TOKEN(CONSTANT); }

L?\"(\\.|[^\\"])*\"						{ count(); SAVE_TOKEN; return TOKEN(STRING_LITERAL); }

"="				{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_ASSIGNMENT); }
">>="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_RIGHT_ASSIGN); }
"<<="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_LEFT_ASSIGN); }
"+="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_ADD_ASSIGN); }
"-="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_SUB_ASSIGN); }
"*="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_MUL_ASSIGN); }
"/="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_DIV_ASSIGN); }
"%="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_MOD_ASSIGN); }
"&="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_AND_ASSIGN); }
"^="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_XOR_ASSIGN); }
"|="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_OR_ASSIGN); }
">>"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_RIGHT); }
"<<"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_LEFT); }
"++"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_INCREASE); }
"--"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_DECREASE); }
"<"				{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_LESS); }
">"				{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_GREATER); }
"&&"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_AND); }
"||"			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_OR); }
"<="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_LESS_OR_EQUAL); }
">="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_GREATER_OR_EQUAL); }
"=="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_EQUAL); }
"!="			{ count(); SAVE_TOKEN; return TOKEN(OPERATOR_NOT_EQUAL); }
";"				{ count(); SAVE_TOKEN; return TOKEN(';'); }
"{"				{ count(); SAVE_TOKEN; return TOKEN('{'); }
"}"				{ count(); SAVE_TOKEN; return TOKEN('}'); }
","				{ count(); SAVE_TOKEN; return TOKEN(','); }
":"				{ count(); SAVE_TOKEN; return TOKEN(':'); }
"("				{ count(); SAVE_TOKEN; return TOKEN('('); }
")"				{ count(); SAVE_TOKEN; return TOKEN(')'); }
("[")			{ count(); SAVE_TOKEN; return TOKEN('['); }
("]")			{ count(); SAVE_TOKEN; return TOKEN(']'); }
"."				{ count(); SAVE_TOKEN; return TOKEN('.'); }
"&"				{ count(); SAVE_TOKEN; return TOKEN('&'); }
"!"				{ count(); SAVE_TOKEN; return TOKEN('!'); }
"~"				{ count(); SAVE_TOKEN; return TOKEN('~'); }
"-"				{ count(); SAVE_TOKEN; return TOKEN('-'); }
"+"				{ count(); SAVE_TOKEN; return TOKEN('+'); }
"*"				{ count(); SAVE_TOKEN; return TOKEN('*'); }
"/"				{ count(); SAVE_TOKEN; return TOKEN('/'); }
"%"				{ count(); SAVE_TOKEN; return TOKEN('%'); }
"^"				{ count(); SAVE_TOKEN; return TOKEN('^'); }
"|"				{ count(); SAVE_TOKEN; return TOKEN('|'); }
"?"				{ count(); SAVE_TOKEN; return TOKEN('?'); }
"$"				{ count(); SAVE_TOKEN; return TOKEN('$'); }

[ \t\v\n\f]		{ count(); }
.				{ /* ignore bad characters */ }

%%


static void comment(void)
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

static void count(void)
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
    [global_UMScriptCompilerEnvironment setColumn:column];
	ECHO;
}


int yywrap(void)
{
	return(1);
}



