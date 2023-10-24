/*
 //
 //  umscript.l
 //  umscript
 //
 //  Created by Andreas Fink on 17.05.14.
 //  Copyright (c) 2016 Andreas Fink
 //
 */

%code requires {
    typedef void*                 yyscan_t;
    @class UMScriptCompilerEnvironment;
}

%{
 

#import <umscript/glueterm.h>
#define YYSTYPE_IS_DECLARED 1
#define YYSTYPE glueterm
#define YYDEBUG     1
#define	AUTORELEASEPOOL	@autoreleasepool

#import <umscript/flex_definitions.h>
#import <umscript/bison_definitions.h>

#import <umscript/umscript.yl.h>

extern int yylex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t yyscanner);
extern int yydebug;
typedef void *yyscan_t;
extern int yyparse (yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv);



static inline  void * XCFBridgingRetain(id X)
{
    return (__bridge_retained void *)X;
}

static inline  id XCFBridgingRelease(void *X)
{
    return (__bridge_transfer id)X;
}

#define UMTERM_NULL      [UMTerm termWithNullWithEnvironment:cenv]
#define UMGET(x)          ( x.value ? (__bridge UMTerm *)(x.value) : UMTERM_NULL)

#define UMSET(x,val)                            \
{                                               \
    void *newval = XCFBridgingRetain((val));    \
    if((x).value!=NULL)                         \
    {                                           \
        XCFBridgingRelease((x).value);          \
    }                                           \
    (x).value=newval;                           \
}

#define UMASSIGN(a,b) \
    { \
        UMTerm *t = UMGET(b); \
        UMSET(a,t); \
    }

#define SET_NULL(r) { if((r).value) XCFBridgingRelease((r).value);}
#define SET_LABEL(r,n) { UMTerm *t = UMGET(r); t.label = n.labelValue;}
#define SET_DEFAULT_LABEL(r) { UMTerm *t = UMGET(r); t.label = @"default"; }
//unused macro to silence the compiler
#define UU(x)   (x.token=x.token)


static void UMLog(const char *name, glueterm x)
{
    #if 0
    if(x.value)
    {
        UMTerm *t = (__bridge UMTerm *)(x.value);
        NSLog(@"%s: %@",name,t.logDescription);
    }
    else
    {
        NSLog(@"%s: undefined",name);
    }
    #endif
}

#define UMLOG1(a)       { UMLog("$1",a); }
#define UMLOG2(a,b)    { UMLog("$1",a);     UMLog("$2",b); }
#define UMLOG3(a,b,c)    { UMLog("$1",a);     UMLog("$2",b);   UMLog("$3",c); }
#define UMLOG4(a,b,c,d)    { UMLog("$1",a);     UMLog("$2",b);   UMLog("$3",c);   UMLog("$4",d); }
#define UMLOG5(a,b,c,d,e)    { UMLog("$1",a);     UMLog("$2",b);   UMLog("$3",c);   UMLog("$4",d); UMLog("$5",e); }


    %}

/*%pure-parser*/
%lex-param      {yyscan_t yyscanner}
%parse-param    {yyscan_t yyscanner}
%parse-param    {UMScriptCompilerEnvironment *cenv}

%define api.pure
%locations
%destructor     { XCFBridgingRelease($$.value); $$.value=NULL;} <>
%{
 
extern void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg);

%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit

%%



primary_expression
    : IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMTerm *tag = UMGET($1);
                UMTerm *r = [UMTerm termWithIdentifierFromTag:tag withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | CONSTANT
        {
            AUTORELEASEPOOL
            {
                UMTerm *tag = UMGET($1);
                UMTerm *r = [UMTerm termWithConstantFromTag:tag withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | STRING_LITERAL
        {
            AUTORELEASEPOOL
            {
                UMTerm *tag = UMGET($1);
                UMTerm *r = [UMTerm termWithStringFromTag:tag withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '(' expression ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

postfix_expression
    : primary_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | postfix_expression '[' expression ']'
        {
            AUTORELEASEPOOL
            {
                UMTerm *var     = UMGET($1);
                UMTerm *index   = UMGET($3);
                UMTerm *r       = [var arrayAccess:index environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression '(' ')'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a       = UMGET($1);
                UMTerm *r       = [a functionCallWithArguments:NULL environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression '(' argument_expression_list ')'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a       = UMGET($1);
                UMTerm *b       = UMGET($3);
                UMTerm *r       = [a functionCallWithArguments:b environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression '.' IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMTerm *a       = UMGET($1);
                UMTerm *b       = UMGET($3);
                UMTerm *r       = [a dotIdentifier:b environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression PTR_OP IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a arrowIdentifier:b environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression INC_OP
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *r = [a postincrease];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | postfix_expression DEC_OP
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *r = [a postdecrease];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

argument_expression_list
    : assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | argument_expression_list ',' assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a listAppendStatement:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

unary_expression
    : postfix_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | INC_OP unary_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a preincrease];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | DEC_OP unary_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a predecrease];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '&' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a addressOfIdentifierWithEnvironment:cenv];
                UMSET($$,r);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '*' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a starIdentifierWithEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '+' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '-' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *c = [a invertSign];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | '~' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a bit_not];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '!' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a logical_not];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | SIZEOF unary_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [a sizeofVarWithEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | SIZEOF '(' type_name ')'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *r = [a sizeofTypeWithEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

cast_expression
    : unary_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '(' type_name ')' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($4);
                UMTerm *b = UMGET($2);
                UMTerm *r = [a castTo:b environment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

multiplicative_expression
    : cast_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | multiplicative_expression '*' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a mul:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | multiplicative_expression '/' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a div:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | multiplicative_expression '%' cast_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a modulo:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

additive_expression
    : multiplicative_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | additive_expression '+' multiplicative_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a add:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | additive_expression '-' multiplicative_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a sub:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

shift_expression
    : additive_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | shift_expression LEFT_OP additive_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a leftshift:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | shift_expression RIGHT_OP additive_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a rightshift:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

relational_expression
    : shift_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | relational_expression '<' shift_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a lessthan:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | relational_expression '>' shift_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a greaterthan:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | relational_expression LE_OP shift_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a lessorequal:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | relational_expression GE_OP shift_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a greaterorequal:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

equality_expression
    : relational_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);

            }
        };
    | equality_expression EQ_OP relational_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a equal:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | equality_expression NE_OP relational_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a notequal:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

and_expression
    : equality_expression
        {
            UMASSIGN($$,$1);
            UMLog("$$",$$);
        };
    | and_expression '&' equality_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a bit_and:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

exclusive_or_expression
    : and_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | exclusive_or_expression '^' and_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a bit_xor:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

inclusive_or_expression
    : exclusive_or_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | inclusive_or_expression '|' exclusive_or_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a bit_or:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

logical_and_expression
    : inclusive_or_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | logical_and_expression AND_OP inclusive_or_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a logical_and:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

logical_or_expression
    : logical_and_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | logical_or_expression OR_OP logical_and_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *r = [a logical_or:b];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

conditional_expression
    : logical_or_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | logical_or_expression '?' expression ':' conditional_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = UMGET($5);
                UMTerm *r = [UMTerm ifCondition:a thenDo:b elseDo:c withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

assignment_expression
    : conditional_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | unary_expression '=' assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign: b];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression MUL_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a mul: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression DIV_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a div: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression MOD_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a modulo: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression ADD_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a add: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression SUB_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a sub: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression LEFT_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a leftshift: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression RIGHT_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a rightshift: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression AND_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a logical_and: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression XOR_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a logical_xor: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    | unary_expression OR_ASSIGN assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMTerm *b = UMGET($3);
                UMTerm *c = [a assign:[a logical_or: b]];
                UMSET($$,c);
                UMLog("$$",$$);
            }
        };
    ;


assignment_operator
    : '='
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | MUL_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | DIV_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | MOD_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | ADD_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | SUB_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | LEFT_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | RIGHT_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | AND_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | XOR_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | OR_ASSIGN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

expression
    : assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | expression ',' assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

constant_expression
    : conditional_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

declaration
    : declaration_specifiers ';'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declaration_specifiers init_declarator_list ';'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

declaration_specifiers
    : storage_class_specifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | storage_class_specifier declaration_specifiers
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }

        };
    | type_specifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | type_specifier declaration_specifiers
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | type_qualifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | type_qualifier declaration_specifiers
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

init_declarator_list
    : init_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | init_declarator_list ',' init_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

init_declarator
    : declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declarator '=' initializer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

storage_class_specifier
    : TYPEDEF
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | EXTERN
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | STATIC
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | AUTO
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | REGISTER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

type_specifier
    : VOID
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | CHAR
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | SHORT
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | INT
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | LONG
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | FLOAT
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | DOUBLE
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | SIGNED
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | UNSIGNED
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | struct_or_union_specifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | enum_specifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | TYPE_NAME
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

struct_or_union_specifier
    : struct_or_union IDENTIFIER '{' struct_declaration_list '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$3);
                UMLog("$$",$$);
            }
        };
    | struct_or_union '{' struct_declaration_list '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$3);
                UMLog("$$",$$);
            }
        };
    | struct_or_union IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

struct_or_union
    : STRUCT
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | UNION
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

struct_declaration_list
    : struct_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | struct_declaration_list struct_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

struct_declaration
    : specifier_qualifier_list struct_declarator_list ';'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
   ;

specifier_qualifier_list
    : type_specifier specifier_qualifier_list
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | type_specifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | type_qualifier specifier_qualifier_list
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | type_qualifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

struct_declarator_list
    : struct_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | struct_declarator_list ',' struct_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

struct_declarator
    : declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | ':' constant_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | declarator ':' constant_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

enum_specifier
    : ENUM '{' enumerator_list '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$3);
                UMLog("$$",$$);
            }
        };
    | ENUM IDENTIFIER '{' enumerator_list '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$3);
                UMLog("$$",$$);
            }
        };
    | ENUM IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

enumerator_list
    : enumerator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | enumerator_list ',' enumerator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

enumerator
    : IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | IDENTIFIER '=' constant_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

type_qualifier
    : CONST
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | VOLATILE
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

declarator
    : pointer direct_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

direct_declarator
    : IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMTerm *tag = UMGET($1);
                UMTerm *r = [UMTerm termWithIdentifierFromTag:tag withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '(' declarator ')'
        {
            AUTORELEASEPOOL
            {
                UMLog("$2",$2);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator '[' constant_expression ']'
        { /*FIXME array access ? */
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMLog("$3",$3);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator '[' ']'
        {
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator '(' parameter_type_list ')'
        {
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMLog("$3",$3);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator '(' identifier_list ')'
        {
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMLog("$3",$3);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_declarator '(' ')'
        {
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

pointer
    : '*'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '*' type_qualifier_list
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '*' pointer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '*' type_qualifier_list pointer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

type_qualifier_list
    : type_qualifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | type_qualifier_list type_qualifier
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;


parameter_type_list
    : parameter_list
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | parameter_list ',' ELLIPSIS
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

parameter_list
    : parameter_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | parameter_list ',' parameter_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

parameter_declaration
    : declaration_specifiers declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declaration_specifiers abstract_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declaration_specifiers
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

identifier_list
    : IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | identifier_list ',' IDENTIFIER
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

type_name
    : specifier_qualifier_list
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | specifier_qualifier_list abstract_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

abstract_declarator
    : pointer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | direct_abstract_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | pointer direct_abstract_declarator
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

direct_abstract_declarator
    : '(' abstract_declarator ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '[' ']'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '[' constant_expression ']'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | direct_abstract_declarator '[' ']'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | direct_abstract_declarator '[' constant_expression ']'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '(' ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '(' parameter_type_list ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | direct_abstract_declarator '(' ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | direct_abstract_declarator '(' parameter_type_list ')'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

initializer
    : assignment_expression
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | '{' initializer_list '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    | '{' initializer_list ',' '}'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$2);
                UMLog("$$",$$);
            }
        };
    ;

initializer_list
    : initializer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | initializer_list ',' initializer
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

statement
    : labeled_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | compound_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | expression_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | selection_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | iteration_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | jump_statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

labeled_statement
    : IDENTIFIER ':' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($1);
                UMASSIGN($$,$3);
                SET_LABEL($$,a);
                UMLog("$$",$$);
            }
        };
    | CASE constant_expression ':' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMASSIGN($$,$4);
                SET_LABEL($$,a);
                UMLog("$$",$$);
            }
        };
    | DEFAULT ':' statement
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$3);
                SET_DEFAULT_LABEL($$);
                UMLog("$$",$$);
            }
        };
    ;

compound_statement
    : '{' '}'
        {
            AUTORELEASEPOOL
            {
                UMTerm *r = UMTERM_NULL;
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | '{' statement_list '}'
        {
            AUTORELEASEPOOL
            {
                UMLog("$2",$2);
                UMTerm *statement_list = UMGET($2);
                UMSET($$,statement_list);
                UMLog("$$",$$);
            }
        };
    | '{' declaration_list '}'
        {
            AUTORELEASEPOOL
            {
                UMTerm *declaration_list = UMGET($2);
                UMSET($$,declaration_list);
                UMLog("$$",$$);
            }
        };
    | '{' declaration_list statement_list '}'
        {
            AUTORELEASEPOOL
            {
                UMTerm *statement_list = UMGET($2);
                UMSET($$,statement_list);
                UMLog("$$",$$);
            }
        };
    ;

declaration_list
    : declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declaration_list declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

statement_list
    : statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *statement = UMGET($1);
                UMSET($$,statement);
                UMLog("$$",$$);
            }
        };
    | statement_list statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *statement1 = UMGET($1);
                UMTerm *statement2 = UMGET($2);
                UMTerm *statement_list = [statement1 listAppendStatement:statement2];
                UMSET($$,statement_list);
                UMLog("$$",$$);
            }
        };
    ;

expression_statement
    : ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *r = UMTERM_NULL;
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | expression ';'
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

selection_statement
    : IF '(' expression ')' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($5);
                UMTerm *r = [UMTerm ifCondition:a  thenDo:b  elseDo: UMTERM_NULL withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | IF '(' expression ')' statement ELSE statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($5);
                UMTerm *c = UMGET($7);
                UMTerm *r = [UMTerm ifCondition:a thenDo:b elseDo:c withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | SWITCH '(' expression ')' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($5);
                UMTerm *r = [UMTerm switchCondition:a thenDo:b withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

iteration_statement
    : WHILE '(' expression ')' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($5);
                UMTerm *r = [UMTerm whileCondition:a thenDo:b withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | DO statement WHILE '(' expression ')' ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *b = UMGET($5);
                UMTerm *r = [UMTerm thenDo:a whileCondition:b withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | FOR '(' expression_statement expression_statement ')' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($4);
                UMTerm *c = UMTERM_NULL;
                UMTerm *d = UMGET($6);
                UMTerm *r = [UMTerm forInitializer:a endCondition:b every:c thenDo:d withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | FOR '(' expression_statement expression_statement expression ')' statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($3);
                UMTerm *b = UMGET($4);
                UMTerm *c = UMGET($5);
                UMTerm *d = UMGET($7);
                UMTerm *r = [UMTerm forInitializer:a endCondition:b every:c thenDo:d withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

jump_statement
    : GOTO IDENTIFIER ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *r = [UMTerm letsGoto: UMGET($2) withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | CONTINUE ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *r = [UMTerm letsContinueWithEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    | BREAK ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *r = [UMTerm letsBreakWithEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | RETURN ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMTERM_NULL;
                UMTerm *r = [UMTerm returnValue:a withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };

    | RETURN expression ';'
        {
            AUTORELEASEPOOL
            {
                UMTerm *a = UMGET($2);
                UMTerm *r = [UMTerm returnValue:a withEnvironment:cenv];
                UMSET($$,r);
                UMLog("$$",$$);
            }
        };
    ;

translation_unit
    : external_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | translation_unit external_declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

external_declaration
    : function_definition
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    | declaration
        {
            AUTORELEASEPOOL
            {
                UMASSIGN($$,$1);
                UMLog("$$",$$);
            }
        };
    ;

function_definition
    : declaration_specifiers declarator declaration_list compound_statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *declarator                  = UMGET($2);
                UMTerm *compound_statement          = UMGET($3);
                
                UMTerm *r       = [UMTerm functionDefinitionWithName:declarator
                                   statements:compound_statement
                                   environment:cenv];
                                   UMSET($$,r);
                                   UMLog("$$",$$);
            }
        };
    | declaration_specifiers declarator compound_statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *declarator                  = UMGET($2);
                UMTerm *compound_statement          = UMGET($3);
                UMTerm *r       = [UMTerm functionDefinitionWithName:declarator
                                   statements:compound_statement
                                   environment:cenv];
                                   [cenv addFunctionDefinition:r];
                                   UMSET($$,r);
                                   UMLog("$$",$$);
            }
        };
    | declarator declaration_list compound_statement
        {
            AUTORELEASEPOOL
            {
                UMTerm *declarator                  = UMGET($1);
                UMTerm *compound_statement          = UMGET($3);
                UMTerm *r       = [UMTerm functionDefinitionWithName:declarator
                                   statements:compound_statement
                                   environment:cenv];
                                   [cenv addFunctionDefinition:r];
                                   UMSET($$,r);
                                   UMLog("$$",$$);
            }
        };
    | declarator compound_statement
        {
            AUTORELEASEPOOL
            {
                UMLog("$1",$1);
                UMLog("$1",$2);
                UMTerm *declarator                  = UMGET($1);
                UMTerm *compound_statement          = UMGET($2);
                UMTerm *r       = [UMTerm functionDefinitionWithName:declarator
                                   statements:compound_statement
                                   environment:cenv];
                                   [cenv addFunctionDefinition:r];
                                   UMSET($$,r);
                                   UMLog("$$",$$);
            }
        };
    ;

%%
#include <stdio.h>

extern int yylex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t yyscanner);


