/*
 //
 //  umscript.l
 //  umscript
 //
 //  Created by Andreas Fink on 17.05.14.
 //  Copyright (c) 2014 SMSRelay AG. All rights reserved.
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

#define RETAIN(a)   cenv.root=a;CFBridgingRetain(a); NSLog(@"%@",a)
#define APPLY(a)    cenv.root=a;NSLog(@"%@",a)


#define UMGET(x)          ((__bridge UMTerm *)x.value)

#define UMSET(x,val)  \
{                   \
    if((x).value!=NULL) \
    {                   \
        CFBridgingRelease((x).value); \
    }           \
    (x).value=CFBridgingRetain(val); \
    cenv.root = (x).value; \
}

#define UMASSIGN(a,b) \
    { \
        UMTerm *t = UMGET(b); \
        UMSET(a,t); \
    }

#define SET_NULL(r) { if(r.value) CFBridgingRelease(r.value);}

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
%destructor     { CFBridgingRelease($$.value); $$.value=NULL;} <>
%{
 
extern void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg);

%}

%token IDENTIFIER
%token VARIABLE
%token FIELD
%token CONST_BOOLEAN
%token CONST_STRING
%token CONST_HEX
%token CONST_LONGLONG
%token CONST_BINARY
%token CONST_INTEGER
%token CONST_OCTAL
%token CONST_DOUBLE


%token OPERATOR_ASSIGNMENT
%token OPERATOR_INCREASE
%token OPERATOR_DECREASE
%token OPERATOR_LEFT
%token OPERATOR_RIGHT
%token OPERATOR_LESS
%token OPERATOR_LESS_OR_EQUAL
%token OPERATOR_GREATER
%token OPERATOR_GREATER_OR_EQUAL
%token OPERATOR_EQUAL
%token OPERATOR_NOT_EQUAL
%token OPERATOR_AND
%token OPERATOR_OR
%token OPERATOR_MUL_ASSIGN
%token OPERATOR_DIV_ASSIGN
%token OPERATOR_MOD_ASSIGN
%token OPERATOR_ADD_ASSIGN
%token OPERATOR_SUB_ASSIGN
%token OPERATOR_LEFT_ASSIGN
%token OPERATOR_RIGHT_ASSIGN
%token OPERATOR_AND_ASSIGN
%token OPERATOR_XOR_ASSIGN
%token OPERATOR_OR_ASSIGN

%token CASE
%token DEFAULT 
%token IF
%token ELSE
%token SWITCH
%token WHILE 
%token DO
%token FOR 
%token GOTO 
%token CONTINUE
%token BREAK 
%token RETURN
%token FUNC_NAME
%token FILE_NAME
%token LINE_NUMBER

%start statement_list

%%

statement_list
    : statement
        {
            UMASSIGN($$,$1);
        };
    | statement_list statement
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($2);
            UMTerm *r = [a blockAppendStatement:b];
            UMSET($$,r);
        };
	;
block
: '{' '}'
        {
            UMTerm *r = [UMTerm termWithNullWithEnvironment:cenv];
            UMSET($$,r);
        }
    | '{' statement_list '}'
        {
            UMASSIGN($$,$2);
        };
    ;

statement
	: labeled_statement             { UMASSIGN($$,$1); };
	| block                         { UMASSIGN($$,$1); };
	| expression_statement          { UMASSIGN($$,$1); };
	| selection_statement           { UMASSIGN($$,$1); };
	| iteration_statement           { UMASSIGN($$,$1); };
	| jump_statement                { UMASSIGN($$,$1); };
	;

expression_statement
	: ';'
        {
            UMTerm *r = [UMTerm termWithNullWithEnvironment:cenv];
            UMSET($$,r);
        }
    | expression ';'
        {
            UMASSIGN($$,$1);
        };
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

selection_statement
    : IF '(' expression ')' block
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm ifCondition:a  thenDo:b  elseDo: [UMTerm termWithNullWithEnvironment:cenv] withEnvironment:cenv];
            UMSET($$,r);
        };
    | IF '(' expression ')' block ELSE block
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *c = UMGET($7);
            UMTerm *r = [UMTerm ifCondition:a thenDo:b elseDo:c withEnvironment:cenv];
            UMSET($$,r);
        };
	| SWITCH '(' expression ')' block
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm switchCondition:a thenDo:b withEnvironment:cenv];
            UMSET($$,r);
        };
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
    | RETURN expression ';'
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [UMTerm returnValue:a withEnvironment:cenv];
            UMSET($$,r);
        };

    | RETURN ';'
        {
            UMTerm *r = [UMTerm termWithNullWithEnvironment:cenv];
            UMSET($$,r);
        };
	;


iteration_statement
    : WHILE '(' expression ')' statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm whileCondition:a thenDo:b withEnvironment:cenv];
            UMSET($$,r);
        };

    | DO statement WHILE '(' expression ')' ';'
        {
            UMTerm *a = UMGET($2);
            UMTerm *b = UMGET($5);
            UMTerm *r = [UMTerm thenDo:a whileCondition:b withEnvironment:cenv];
            UMSET($$,r);
        };
	| FOR '(' expression_statement expression_statement ')' statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($4);
            UMTerm *c = UMGET($6);
            UMTerm *r = [UMTerm forInitializer:a endCondition:b every:NULL thenDo:c withEnvironment:cenv];
            UMSET($$,r);
        };

    | FOR '(' expression_statement expression_statement expression ')' statement
        {
            UMTerm *a = UMGET($3);
            UMTerm *b = UMGET($4);
            UMTerm *c = UMGET($5);
            UMTerm *d = UMGET($7);
            UMTerm *r = [UMTerm forInitializer:a endCondition:b every:c  thenDo:d withEnvironment:cenv];
            UMSET($$,r);
        };
	;


expression
	: assignment_expression
        {
            UMASSIGN($$,$1);
        };
	| expression ',' assignment_expression
        {
            UMASSIGN($$,$1);
        };
	;

assignment_expression
	: conditional_expression
        {
            UMASSIGN($$,$1);
        };
	| unary_expression OPERATOR_ASSIGNMENT assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign: b];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_MUL_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a mul: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_DIV_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a div: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_MOD_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a modulo: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_ADD_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a add: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_SUB_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a sub: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_LEFT_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a leftshift: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_RIGHT_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a rightshift: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_AND_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_and: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_XOR_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_xor: b]];
            UMSET($$,c);
        };
    | unary_expression OPERATOR_OR_ASSIGN assignment_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a assign:[a logical_or: b]];
            UMSET($$,c);
        };
	;

conditional_expression
	: logical_or_expression
        {
            UMASSIGN($$,$1);
        };

    | logical_or_expression '?' expression ':' conditional_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = UMGET($5);
            UMTerm *d = [UMTerm ifCondition: a thenDo:b  elseDo:c withEnvironment:cenv];
            UMSET($$,d);
        };
    ;
logical_or_expression
	: logical_and_expression
        {
            UMASSIGN($$,$1);
        };
    | logical_or_expression OPERATOR_OR logical_and_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a logical_or: b];
            UMSET($$,c);
        };
	;

logical_and_expression
    : inclusive_or_expression
        {
            UMASSIGN($$,$1);
        };
    | logical_and_expression OPERATOR_AND inclusive_or_expression    { UMSET($$,[UMGET($1) logical_and: UMGET($3)]); };
	;

inclusive_or_expression
    : exclusive_or_expression
        {
            UMASSIGN($$,$1);
        };
    | inclusive_or_expression '|' exclusive_or_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a bit_or: b];
            UMSET($$,c);
        };
    ;

exclusive_or_expression
	: and_expression
        {
            UMASSIGN($$,$1);
        };
    | exclusive_or_expression '^' and_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a bit_xor: b];
            UMSET($$,c);
        };

and_expression
	: equality_expression
        {
            UMASSIGN($$,$1);
        };
	| and_expression '&' equality_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a bit_and: b];
            UMSET($$,c);
        };
	;

equality_expression
	: relational_expression
        {
            UMASSIGN($$,$1);
        };
	| equality_expression OPERATOR_EQUAL relational_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a equal: b];
            UMSET($$,c);
        };
	| equality_expression OPERATOR_NOT_EQUAL relational_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a notequal: b];
            UMSET($$,c);
        }
	;

relational_expression
	: shift_expression
        {
            UMASSIGN($$,$1);
        };
	| relational_expression OPERATOR_LESS shift_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a lessthan: b];
            UMSET($$,c);
        }
	| relational_expression OPERATOR_GREATER shift_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a greaterthan: b];
            UMSET($$,c);
        }
	| relational_expression OPERATOR_LESS_OR_EQUAL shift_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a lessorequal: b];
            UMSET($$,c);
        }
	| relational_expression OPERATOR_GREATER_OR_EQUAL shift_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a greaterorequal: b];
            UMSET($$,c);
        };
	;

shift_expression
	: additive_expression
        {
            UMASSIGN($$,$1);
        };
	| shift_expression OPERATOR_LEFT  additive_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a leftshift:b];
            UMSET($$,c);
        };
	| shift_expression OPERATOR_RIGHT additive_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a rightshift:b];
            UMSET($$,c);
        };
	;

additive_expression
	: multiplicative_expression   { UMASSIGN($$,$1); };
    | additive_expression '+' multiplicative_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a add:b];
            UMSET($$,c);
        };
	| additive_expression '-' multiplicative_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a sub:b];
            UMSET($$,c);
        };
	;

multiplicative_expression
	: unary_expression  { UMASSIGN($$,$1); };
	| multiplicative_expression '*' unary_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a mul:b];
            UMSET($$,c);
        };
	| multiplicative_expression '/' unary_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a div:b];
            UMSET($$,c);
        };

    | multiplicative_expression '%' unary_expression
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *c = [a modulo:b];
            UMSET($$,c);
        };
	;
	
unary_expression
	: postfix_expression
        {
            UMASSIGN($$,$1);
        };
    | OPERATOR_INCREASE unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a preincrease];
            UMSET($$,r);
        }
	| OPERATOR_DECREASE unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a predecrease];
            UMSET($$,r);
        }

    | '!' unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a logical_not];
            UMSET($$,r);
        }
    | '~' unary_expression
        {
            UMTerm *a = UMGET($2);
            UMTerm *r = [a bit_not];
            UMSET($$,r);
        };
	;

postfix_expression
	: primary_expression
        {
            UMASSIGN($$,$1);
        };
	| postfix_expression '(' ')'
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a functionCallWithArguments:NULL];
            UMSET($$,r);
        };
    | postfix_expression '(' argument_expression_list ')'
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *r = [a functionCallWithArguments: b];
            UMSET($$,r);
        };
    | postfix_expression '.' IDENTIFIER
        {
            UMTerm *a = UMGET($1);
            UMTerm *b = UMGET($3);
            UMTerm *r = [a dotIdentifier: b];
            UMSET($$,r);
        };
	| postfix_expression OPERATOR_INCREASE
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a postincrease];
            UMSET($$,r);
        };
	| postfix_expression OPERATOR_DECREASE
        {
            UMTerm *a = UMGET($1);
            UMTerm *r = [a postdecrease];
            UMSET($$,r);
        };
	;

primary_expression
    : IDENTIFIER
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithIdentifierFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | VARIABLE
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithVariableFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | FIELD
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithFieldFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_BOOLEAN
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithBooleanFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_STRING
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithStringFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_HEX
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithHexFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_LONGLONG
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithLongLongFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_BINARY
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithBinaryFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_INTEGER
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithIntegerFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_OCTAL
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithOctalFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
    | CONST_DOUBLE
        {
            UMTerm *tag = UMGET($1);
            UMTerm *r = [UMTerm termWithDoubleFromTag:tag withEnvironment:cenv];
            UMSET($$,r);
        };
	| '(' expression ')'
        {
            UMTerm *term = UMGET($1);
            UMSET($$,term);
        }
	;


argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

constant_expression
	: conditional_expression
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	;

function_definition
	:  block
	;

%%
#include <stdio.h>

extern int yylex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t yyscanner);

