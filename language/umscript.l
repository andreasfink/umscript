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

#import <umscript/glueterm.h>
#define YYSTYPE_IS_DECLARED 1
#define YYSTYPE glueterm

#import <umscript/flex_definitions.h>
#import <umscript/umscript.yl.h>

typedef UMScriptCompilerEnvironment *YY_EXTRA_TYPE;

}

%option reentrant
%option bison-bridge
%option bison-locations
%option noyywrap

D            [0-9]
FIRST        [a-zA-Z_\$]
L            [a-zA-Z_]
H            [a-fA-F0-9]
E            [Ee][+-]?{D}+
FS            (f|F|l|L)
IS            (u|U|l|L)*

%{

#import <umscript/_generated_umscript.y.h>


static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner);
static void comment(yyscan_t yyscanner);
static void count(yyscan_t yyscanner);

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
#define UMTOKEN(x)                                                                        \
{                                                                                        \
    UMScriptCompilerEnvironment *cenv = (__bridge UMScriptCompilerEnvironment *)yyextra; \
    char *text =yyget_text(yyscanner);                                                   \
    UMTerm *term = [UMTerm token:(x) text:text withEnvironment:cenv];                    \
    yylval_param->value=XCFBridgingRetain(term);                                         \
    yylval_param->token = (x);                                                           \
    NSString *s = [NSString stringWithFormat:@"%d %s {%s}",x,#x,text];                   \
    [cenv.lexerLog addLogEntry:s];                                                       \
    return (x);                                                                          \
}

%}

%%
"/*"            { comment(yyscanner);                  }
"auto"          { count(yyscanner); UMTOKEN(AUTO);     }
"break"         { count(yyscanner); UMTOKEN(BREAK);    }
"case"          { count(yyscanner); UMTOKEN(CASE);     }
"char"          { count(yyscanner); UMTOKEN(CHAR);     }
"const"         { count(yyscanner); UMTOKEN(CONST);    }
"continue"      { count(yyscanner); UMTOKEN(CONTINUE); }
"default"       { count(yyscanner); UMTOKEN(DEFAULT);  }
"do"            { count(yyscanner); UMTOKEN(DO);       }
"double"        { count(yyscanner); UMTOKEN(DOUBLE);   }
"else"          { count(yyscanner); UMTOKEN(ELSE);     }
"enum"          { count(yyscanner); UMTOKEN(ENUM);     }
"extern"        { count(yyscanner); UMTOKEN(EXTERN);   }
"float"         { count(yyscanner); UMTOKEN(FLOAT);    }
"for"           { count(yyscanner); UMTOKEN(FOR);      }
"goto"          { count(yyscanner); UMTOKEN(GOTO);     }
"if"            { count(yyscanner); UMTOKEN(IF);       }
"int"           { count(yyscanner); UMTOKEN(INT);      }
"long"          { count(yyscanner); UMTOKEN(LONG);     }
"register"      { count(yyscanner); UMTOKEN(REGISTER); }
"return"        { count(yyscanner); UMTOKEN(RETURN);   }
"short"         { count(yyscanner); UMTOKEN(SHORT);    }
"signed"        { count(yyscanner); UMTOKEN(SIGNED);   }
"sizeof"        { count(yyscanner); UMTOKEN(SIZEOF);   }
"static"        { count(yyscanner); UMTOKEN(STATIC);   }
"struct"        { count(yyscanner); UMTOKEN(STRUCT);   }
"switch"        { count(yyscanner); UMTOKEN(SWITCH);   }
"typedef"       { count(yyscanner); UMTOKEN(TYPEDEF);  }
"union"         { count(yyscanner); UMTOKEN(UNION);    }
"unsigned"      { count(yyscanner); UMTOKEN(UNSIGNED); }
"void"          { count(yyscanner); UMTOKEN(VOID);     }
"volatile"      { count(yyscanner); UMTOKEN(VOLATILE); }
"while"         { count(yyscanner); UMTOKEN(WHILE);    }

{FIRST}({L}|{D})*   { count(yyscanner); UMTOKEN(IDENTIFIER); }

0[xX]{H}+{IS}?      { count(yyscanner); UMTOKEN(CONSTANT); }
0{D}+{IS}?          { count(yyscanner); UMTOKEN(CONSTANT); }
{D}+{IS}?                 { count(yyscanner); UMTOKEN(CONSTANT); }
L?'(\\.|[^\\'])+'         { count(yyscanner); UMTOKEN(CONSTANT); }

{D}+{E}{FS}?              { count(yyscanner); UMTOKEN(CONSTANT); }
{D}*"."{D}+({E})?{FS}?    { count(yyscanner); UMTOKEN(CONSTANT); }
{D}+"."{D}*({E})?{FS}?    { count(yyscanner); UMTOKEN(CONSTANT); }

L?\"(\\.|[^\\"])*\"    { count(yyscanner); UMTOKEN(STRING_LITERAL); }

"..."           { count(yyscanner); UMTOKEN(ELLIPSIS); }
">>="           { count(yyscanner); UMTOKEN(RIGHT_ASSIGN); }
"<<="           { count(yyscanner); UMTOKEN(LEFT_ASSIGN); }
"+="            { count(yyscanner); UMTOKEN(ADD_ASSIGN); }
"-="            { count(yyscanner); UMTOKEN(SUB_ASSIGN); }
"*="            { count(yyscanner); UMTOKEN(MUL_ASSIGN); }
"/="            { count(yyscanner); UMTOKEN(DIV_ASSIGN); }
"%="            { count(yyscanner); UMTOKEN(MOD_ASSIGN); }
"&="            { count(yyscanner); UMTOKEN(AND_ASSIGN); }
"^="            { count(yyscanner); UMTOKEN(XOR_ASSIGN); }
"|="            { count(yyscanner); UMTOKEN(OR_ASSIGN); }
">>"            { count(yyscanner); UMTOKEN(RIGHT_OP); }
"<<"            { count(yyscanner); UMTOKEN(LEFT_OP); }
"++"            { count(yyscanner); UMTOKEN(INC_OP); }
"--"            { count(yyscanner); UMTOKEN(DEC_OP); }
"->"            { count(yyscanner); UMTOKEN(PTR_OP); }
"&&"            { count(yyscanner); UMTOKEN(AND_OP); }
"||"            { count(yyscanner); UMTOKEN(OR_OP); }
"<="            { count(yyscanner); UMTOKEN(LE_OP); }
">="            { count(yyscanner); UMTOKEN(GE_OP); }
"=="            { count(yyscanner); UMTOKEN(EQ_OP); }
"!="            { count(yyscanner); UMTOKEN(NE_OP); }
";"             { count(yyscanner); UMTOKEN(';'); }
("{"|"<%")      { count(yyscanner); UMTOKEN('{'); }
("}"|"%>")      { count(yyscanner); UMTOKEN('}'); }
","             { count(yyscanner); UMTOKEN(','); }
":"             { count(yyscanner); UMTOKEN(':'); }
"="             { count(yyscanner); UMTOKEN('='); }
"("             { count(yyscanner); UMTOKEN('('); }
")"             { count(yyscanner); UMTOKEN(')'); }
("["|"<:")      { count(yyscanner); UMTOKEN('['); }
("]"|":>")      { count(yyscanner); UMTOKEN(']'); }
"."             { count(yyscanner); UMTOKEN('.'); }
"&"             { count(yyscanner); UMTOKEN('&'); }
"!"             { count(yyscanner); UMTOKEN('!'); }
"~"             { count(yyscanner); UMTOKEN('~'); }
"-"             { count(yyscanner); UMTOKEN('-'); }
"+"             { count(yyscanner); UMTOKEN('+'); }
"*"             { count(yyscanner); UMTOKEN('*'); }
"/"             { count(yyscanner); UMTOKEN('/'); }
"%"             { count(yyscanner); UMTOKEN('%'); }
"<"             { count(yyscanner); UMTOKEN('<'); }
">"             { count(yyscanner); UMTOKEN('>'); }
"^"             { count(yyscanner); UMTOKEN('^'); }
"|"             { count(yyscanner); UMTOKEN('|'); }
"?"             { count(yyscanner); UMTOKEN('?'); }

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
    @autoreleasepool
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

