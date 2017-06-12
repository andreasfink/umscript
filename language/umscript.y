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
 

#import "glueterm.h"
#define YYSTYPE_IS_DECLARED 1
#define YYSTYPE glueterm
#define YYDEBUG     1

#import "flex_definitions.h"
#import "bison_definitions.h"

#import "umscript.yl.h"

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
        }                                       \
        (x).value=newval;                       \
}

#define XRETAIN(a)   cenv.root=a;XCFBridgingRetain(a); NSLog(@"%@",a)
#define APPLY(a)    cenv.root=a;NSLog(@"%@",a)
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
        { UMASSIGN($$,$1); };
    | CONSTANT
        {
            UMASSIGN($$,$1);
            
        };
    | STRING_LITERAL
        {
            UMASSIGN($$,$1);
        };
    | '(' expression ')'
        {
            UMASSIGN($$,$2);
        };
    ;

postfix_expression
    : primary_expression
        {
            UMASSIGN($$,$1);
        };
    | postfix_expression '[' expression ']'
        {
            UMTerm *a       = UMGET($1);
            UMTerm *index   = UMGET($3);
            UMTerm *r       = [a arrayAccess:index environment:cenv];
            UMSET($$,r);
        };
    | postfix_expression '(' ')'
        {
            UMTerm *a       = UMGET($1);
            UMTerm *r       = [a functionCallWithArguments:NULL environment:cenv];
            UMSET($$,r);
        };
    | postfix_expression '(' argument_expression_list ')'
        {
            UMTerm *a       = UMGET($1);
            UMTerm *b       = UMGET($3);
            UMTerm *r       = [a functionCallWithArguments:b environment:cenv];
            UMSET($$,r);
        };
    | postfix_expression '.' IDENTIFIER
        {
            UMTerm *a       = UMGET($1);
            UMTerm *b       = UMGET($3);
            UMTerm *r       = [a dotIdentifier:b environment:cenv];
            UMSET($$,r);
        };
    | postfix_expression PTR_OP IDENTIFIER
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *r = [a arrowIdentifier:b environment:cenv];
            UMSET($$,r);
        };
    | postfix_expression INC_OP
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a postincrease];
            UMSET($$,r);
        };
    | postfix_expression DEC_OP
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a postdecrease];
            UMSET($$,r);
        };
    ;

argument_expression_list
    : assignment_expression
        {
            UMASSIGN($$,$1);
        };
    | argument_expression_list ',' assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *r = [a listAppendStatement:b];
            UMSET($$,r);
        };
    ;

unary_expression
    : postfix_expression
        {
            UMASSIGN($$,$1);
        };
    | INC_OP unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a preincrease];
            UMSET($$,r);
        };
    | DEC_OP unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a predecrease];
            UMSET($$,r);
        };
    | '&' cast_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a addressOfIdentifierWithEnvironment:cenv];
            UMSET($$,r);
            UMASSIGN($$,$1);
        };
    | '*' cast_expression
    {
        UMTerm *a = UMGET($2);
        UMTerm *r = [a starIdentifierWithEnvironment:cenv];
        UMSET($$,r);
    };
    | '+' cast_expression
    {
        UMASSIGN($$,$2);
    };
    | '-' cast_expression
    {
        UMTerm *a = UMGET($2);
        UMTerm *c = [a invertSign];
        UMSET($$,c);
    };
    | '~' cast_expression
    {
        UMTerm *a = UMGET($2);
        UMTerm *r = [a bit_not];
        UMSET($$,r);
    };
    | '!' cast_expression
    {
        UMTerm *a = UMGET($2);
        UMTerm *r = [a logical_not];
        UMSET($$,r);
    };


    | SIZEOF unary_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a sizeofWithEnvironment:cenv];
            UMSET($$,r);
        };
    | SIZEOF '(' type_name ')'
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a sizeofWithEnvironment:cenv];
            UMSET($$,r);
        };
    ;

cast_expression
    : unary_expression
    | '(' type_name ')' cast_expression
    ;

multiplicative_expression
    : cast_expression
    | multiplicative_expression '*' cast_expression
    | multiplicative_expression '/' cast_expression
    | multiplicative_expression '%' cast_expression
    ;

additive_expression
    : multiplicative_expression
    | additive_expression '+' multiplicative_expression
    | additive_expression '-' multiplicative_expression
    ;

shift_expression
    : additive_expression
    | shift_expression LEFT_OP additive_expression
    | shift_expression RIGHT_OP additive_expression
    ;

relational_expression
    : shift_expression
    | relational_expression '<' shift_expression
    | relational_expression '>' shift_expression
    | relational_expression LE_OP shift_expression
    | relational_expression GE_OP shift_expression
    ;

equality_expression
    : relational_expression
    | equality_expression EQ_OP relational_expression
    | equality_expression NE_OP relational_expression
    ;

and_expression
    : equality_expression
    | and_expression '&' equality_expression
    ;

exclusive_or_expression
    : and_expression
    | exclusive_or_expression '^' and_expression
    ;

inclusive_or_expression
    : exclusive_or_expression
    | inclusive_or_expression '|' exclusive_or_expression
    ;

logical_and_expression
    : inclusive_or_expression
    | logical_and_expression AND_OP inclusive_or_expression
    ;

logical_or_expression
    : logical_and_expression
    | logical_or_expression OR_OP logical_and_expression
    ;

conditional_expression
    : logical_or_expression
    | logical_or_expression '?' expression ':' conditional_expression
    ;

assignment_expression
    : conditional_expression { UMASSIGN($$,$1); };
    | unary_expression '=' assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign: b];
            UMSET($$,c);
        };
    | unary_expression MUL_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a mul: b]];
            UMSET($$,c);
        };
    | unary_expression DIV_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a div: b]];
            UMSET($$,c);
        };
    | unary_expression MOD_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a modulo: b]];
            UMSET($$,c);
        };
    | unary_expression ADD_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a add: b]];
            UMSET($$,c);
        };
    | unary_expression SUB_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a sub: b]];
            UMSET($$,c);
        };
    | unary_expression LEFT_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a leftshift: b]];
            UMSET($$,c);
        };
    | unary_expression RIGHT_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a rightshift: b]];
            UMSET($$,c);
        };
    | unary_expression AND_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_and: b]];
            UMSET($$,c);
        };
    | unary_expression XOR_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_xor: b]];
            UMSET($$,c);
        };
    | unary_expression OR_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_or: b]];
            UMSET($$,c);
        };
    ;


assignment_operator
    : '='
    | MUL_ASSIGN
    | DIV_ASSIGN
    | MOD_ASSIGN
    | ADD_ASSIGN
    | SUB_ASSIGN
    | LEFT_ASSIGN
    | RIGHT_ASSIGN
    | AND_ASSIGN
    | XOR_ASSIGN
    | OR_ASSIGN
    ;

expression
    : assignment_expression
    | expression ',' assignment_expression
    ;

constant_expression
    : conditional_expression
    ;

declaration
    : declaration_specifiers ';'
    | declaration_specifiers init_declarator_list ';'
    ;

declaration_specifiers
    : storage_class_specifier
    | storage_class_specifier declaration_specifiers
    | type_specifier
    | type_specifier declaration_specifiers
    | type_qualifier
    | type_qualifier declaration_specifiers
    ;

init_declarator_list
    : init_declarator
    | init_declarator_list ',' init_declarator
    ;

init_declarator
    : declarator
    | declarator '=' initializer
    ;

storage_class_specifier
    : TYPEDEF
    | EXTERN
    | STATIC
    | AUTO
    | REGISTER
    ;

type_specifier
    : VOID
    | CHAR
    | SHORT
    | INT
    | LONG
    | FLOAT
    | DOUBLE
    | SIGNED
    | UNSIGNED
    | struct_or_union_specifier
    | enum_specifier
    | TYPE_NAME
    ;

struct_or_union_specifier
    : struct_or_union IDENTIFIER '{' struct_declaration_list '}'
    | struct_or_union '{' struct_declaration_list '}'
    | struct_or_union IDENTIFIER
    ;

struct_or_union
    : STRUCT
    | UNION
    ;

struct_declaration_list
    : struct_declaration
    | struct_declaration_list struct_declaration
    ;

struct_declaration
    : specifier_qualifier_list struct_declarator_list ';'
    ;

specifier_qualifier_list
    : type_specifier specifier_qualifier_list
    | type_specifier
    | type_qualifier specifier_qualifier_list
    | type_qualifier
    ;

struct_declarator_list
    : struct_declarator
    | struct_declarator_list ',' struct_declarator
    ;

struct_declarator
    : declarator
    | ':' constant_expression
    | declarator ':' constant_expression
    ;

enum_specifier
    : ENUM '{' enumerator_list '}'
    | ENUM IDENTIFIER '{' enumerator_list '}'
    | ENUM IDENTIFIER
    ;

enumerator_list
    : enumerator
    | enumerator_list ',' enumerator
    ;

enumerator
    : IDENTIFIER
    | IDENTIFIER '=' constant_expression
    ;

type_qualifier
    : CONST
    | VOLATILE
    ;

declarator
    : pointer direct_declarator
    | direct_declarator
    ;

direct_declarator
    : IDENTIFIER
    | '(' declarator ')'
    | direct_declarator '[' constant_expression ']'
    | direct_declarator '[' ']'
    | direct_declarator '(' parameter_type_list ')'
    | direct_declarator '(' identifier_list ')'
    | direct_declarator '(' ')'
    ;

pointer
    : '*'
    | '*' type_qualifier_list
    | '*' pointer
    | '*' type_qualifier_list pointer
    ;

type_qualifier_list
    : type_qualifier
    | type_qualifier_list type_qualifier
    ;


parameter_type_list
    : parameter_list
    | parameter_list ',' ELLIPSIS
    ;

parameter_list
    : parameter_declaration
    | parameter_list ',' parameter_declaration
    ;

parameter_declaration
    : declaration_specifiers declarator
    | declaration_specifiers abstract_declarator
    | declaration_specifiers
    ;

identifier_list
    : IDENTIFIER
    | identifier_list ',' IDENTIFIER
    ;

type_name
    : specifier_qualifier_list
    | specifier_qualifier_list abstract_declarator
    ;

abstract_declarator
    : pointer
    | direct_abstract_declarator
    | pointer direct_abstract_declarator
    ;

direct_abstract_declarator
    : '(' abstract_declarator ')'
    | '[' ']'
    | '[' constant_expression ']'
    | direct_abstract_declarator '[' ']'
    | direct_abstract_declarator '[' constant_expression ']'
    | '(' ')'
    | '(' parameter_type_list ')'
    | direct_abstract_declarator '(' ')'
    | direct_abstract_declarator '(' parameter_type_list ')'
    ;

initializer
    : assignment_expression
    | '{' initializer_list '}'
    | '{' initializer_list ',' '}'
    ;

initializer_list
    : initializer
    | initializer_list ',' initializer
    ;

statement
    : labeled_statement     { UMASSIGN($$,$1); };
    | compound_statement    { UMASSIGN($$,$1); };
    | expression_statement  { UMASSIGN($$,$1); };
    | selection_statement   { UMASSIGN($$,$1); };
    | iteration_statement   { UMASSIGN($$,$1); };
    | jump_statement        { UMASSIGN($$,$1); };
    ;

labeled_statement
: IDENTIFIER ':' statement
            {
                UMTerm *a = UMGET($1);
                UMASSIGN($$,$3);
                SET_LABEL($$,a);
            };
    | CASE constant_expression ':' statement
            {
                UMTerm *a = UMGET($2);
                UMASSIGN($$,$4);
                SET_LABEL($$,a);
            };
    | DEFAULT ':' statement
            {
                UMASSIGN($$,$3);
                SET_DEFAULT_LABEL($$);
            };

    ;

compound_statement
: '{' '}'                                           { UMTerm *r = UMTERM_NULL; UMSET($$,r); }
    | '{' statement_list '}'                        { UMASSIGN($$,$1); };
    | '{' declaration_list '}'                      { UMASSIGN($$,$1); };
    | '{' declaration_list statement_list '}'       { UMASSIGN($$,$1); };
    ;

declaration_list
    : declaration                                   { UMASSIGN($$,$1); };
    | declaration_list declaration                  { UMASSIGN($$,$1); };
    ;

statement_list
    : statement                                      { UMASSIGN($$,$1); };
    | statement_list statement                       { UMASSIGN($$,$1); };
    ;

expression_statement
    : ';'
        {
            UMTerm *r = UMTERM_NULL;
            UMSET($$,r);
        }

    | expression ';'
        {
            UMASSIGN($$,$1);
        };
    ;

selection_statement
    : IF '(' expression ')' statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm ifCondition:a  thenDo:b  elseDo: UMTERM_NULL withEnvironment:cenv];
            UMSET($$,r);
        };

    | IF '(' expression ')' statement ELSE statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *c = UMGET($7);
            UMTerm *r = [UMTerm ifCondition:a thenDo:b elseDo:c withEnvironment:cenv];
            UMSET($$,r);
        };
    | SWITCH '(' expression ')' statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm switchCondition:a thenDo:b withEnvironment:cenv];
            UMSET($$,r);
        };
    ;

iteration_statement
    : WHILE '(' expression ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOR '(' expression_statement expression_statement ')' statement
    | FOR '(' expression_statement expression_statement expression ')' statement
    ;

jump_statement
    : GOTO IDENTIFIER ';'
        {
            UMTerm *r = [UMTerm letsGoto: UMGET($2) withEnvironment:cenv];
            UMSET($$,r);
        }

    | CONTINUE ';'
        {
            UMTerm *r = [UMTerm letsContinueWithEnvironment:cenv];
            UMSET($$,r);
        }
    | BREAK ';'
        {
            UMTerm *r = [UMTerm letsBreakWithEnvironment:cenv];
            UMSET($$,r);
        };

    | RETURN ';'
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [UMTerm returnValue:a withEnvironment:cenv];
            UMSET($$,r);
        };

    | RETURN expression ';'  { UMASSIGN($$,$2); };
    ;

translation_unit
    : external_declaration                      { UMASSIGN($$,$1); };
    | translation_unit external_declaration     { UMASSIGN($$,$1); };
    ;

external_declaration
    : function_definition   { UMASSIGN($$,$1); };
    | declaration           { UMASSIGN($$,$1); };
    ;

function_definition
    : declaration_specifiers declarator declaration_list compound_statement     { UMASSIGN($$,$1); };
    | declaration_specifiers declarator compound_statement                      { UMASSIGN($$,$1); };
    | declarator declaration_list compound_statement                            { UMASSIGN($$,$1); };
    | declarator compound_statement                                     { UMASSIGN($$,$1); };
    ;

%%
#include <stdio.h>

extern int yylex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t yyscanner);


