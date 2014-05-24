/*
 //
 //  umscript.l
 //  umscript
 //
 //  Created by Andreas Fink on 17.05.14.
 //  Copyright (c) 2014 SMSRelay AG. All rights reserved.
 //
 */

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

#define RETAIN(a)   cenv.root=a;CFBridgingRetain(a); NSLog(@"%@",a)
#define APPLY(a)    cenv.root=a;NSLog(@"%@",a)

#define SET_RESULT(r,n)                     \
{                                           \
    UMTerm *new_value = n;                  \
    CFBridgingRetain(new_value);            \
    if(r!=NULL)                             \
    {                                       \
        CFBridgingRelease(r);               \
    }                                       \
    cenv.root=new_value;                    \
    r=n;                                    \
}

#define SET_NULL(r) { if(r.value) CFBridgingRelease(r.value);}

#define SET_LABEL(r,n) { r.label = n.constantStringValue;}
//unused macro to silence the compiler
#define UU(x)   (x.token=x.token)


%}

/*%pure-parser*/
%lex-param      {yyscan_t yyscanner}
%parse-param    {yyscan_t yyscanner}
%parse-param    {UMScriptCompilerEnvironment *cenv}

%define api.pure
%locations
%destructor     { CFBridgingRelease($$.value); } <>
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

%start statement_list

%%

statement_list
    : statement                     { SET_RESULT($$.value,[UMTerm blockWithStatement:$1.value]); };
    | statement_list statement      { SET_RESULT($$.value,[$1.value blockAppendStatement:$2.value]); };
	;

block
: '{' '}'                           { SET_NULL($$); UU($1); UU($2); }
    | '{' statement_list '}'        { SET_RESULT($$.value,$2.value); };
    ;

statement
	: labeled_statement             { SET_RESULT($$.value,$1.value); };
	| block                         { SET_RESULT($$.value,$1.value); };
	| expression_statement          { SET_RESULT($$.value,$1.value); };
	| selection_statement           { SET_RESULT($$.value,$1.value); };
	| iteration_statement           { SET_RESULT($$.value,$1.value); };
	| jump_statement                { SET_RESULT($$.value,$1.value); };
	;

expression_statement
	: ';'
    | expression ';'                { SET_RESULT($$.value,$1.value); };
	;

labeled_statement
    : IDENTIFIER ':' statement
            {
                UU($2);
                SET_RESULT($$.value,$3.value);
                SET_LABEL($$.value,$1.value);
            };
    | CASE constant_expression ':' statement
            {
                UU($1);
                SET_RESULT($$.value,$4.value);
                SET_LABEL($$.value,$2.value);
            };
    | DEFAULT ':' statement
            {
                UU($2);
                SET_RESULT($$.value,$3.value);
                SET_LABEL($$.value,$1.value);
            };
	;

selection_statement
    : IF '(' expression ')' block
            {
                    SET_RESULT($$.value,[UMTerm ifCondition: $2.value .value  thenDo: $5.value .value  elseDo: [UMTerm termWithNull]]);
                    UU($1);
                    UU($2);
                    UU($4);
            };
    | IF '(' expression ')' block ELSE block
            {
                SET_RESULT($$.value,[UMTerm ifCondition: $2.value  thenDo: $5.value  elseDo: $7.value]);
                UU($1);
                UU($2);
                UU($4);
                UU($6);
            };
	| SWITCH '(' expression ')' block
            {
                SET_RESULT($$.value,[UMTerm switchCondition: $2.value  thenDo: $5.value]);
                UU($1);
                UU($2);
                UU($4);
            };
	;

jump_statement
    : GOTO IDENTIFIER ';'
            {
                SET_RESULT($$.value,[UMTerm letsGoto: $1.value]);
                UU($2);
            }
    | CONTINUE ';'
            {
                SET_RESULT($$.value,[UMTerm letsContinue]);
                UU($1);
                UU($2);
            }
    | BREAK ';'
            {
                SET_RESULT($$.value,[UMTerm letsBreak]);
                UU($1);
                UU($2);
            }
    | RETURN expression ';'     { SET_RESULT($$.value,$2.value); };
    | RETURN ';'
	;


iteration_statement
    : WHILE '(' expression ')' statement
        { SET_RESULT($$.value,[UMTerm whileCondition: $2.value  thenDo: $3.value]); };
    | DO statement WHILE '(' expression ')' ';'
        { SET_RESULT($$.value,[UMTerm thenDo: $2.value  whileCondition: $3.value]); };
	| FOR '(' expression_statement expression_statement ')' statement
        { SET_RESULT($$.value,[UMTerm forInitializer:$3.value endCondition:$4.value every:NULL thenDo: $6.value]); };
    | FOR '(' expression_statement expression_statement expression ')' statement
        { SET_RESULT($$.value,[UMTerm forInitializer:$3.value endCondition:$4.value every:$5.value  thenDo: $7.value]); };
	;


expression
	: assignment_expression
        { SET_RESULT($$.value,$1.value); };
	| expression ',' assignment_expression
        { SET_RESULT($$.value,$1.value); };

	;

assignment_expression
	: conditional_expression
        { SET_RESULT($$.value,$1.value); };
	| unary_expression '=' assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:$3.value]); };
    | unary_expression OPERATOR_MUL_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value mul: $3.value]]); };
    | unary_expression OPERATOR_DIV_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value div: $3.value]]); };
    | unary_expression OPERATOR_MOD_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value mul: $3.value]]); };
    | unary_expression OPERATOR_ADD_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value add: $3.value]]); };
    | unary_expression OPERATOR_SUB_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value sub: $2.value]]); };
    | unary_expression OPERATOR_LEFT_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value leftshift: $3.value]]); };
    | unary_expression OPERATOR_RIGHT_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value rightshift: $3.value]]); };
    | unary_expression OPERATOR_AND_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value logical_and: $3.value]]); };
    | unary_expression OPERATOR_XOR_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value logical_xor: $3.value]]); };
    | unary_expression OPERATOR_OR_ASSIGN assignment_expression
        { SET_RESULT($$.value,[$1.value  assign:[$1.value logical_or: $3.value]]); };
	;

conditional_expression
	: logical_or_expression
        { SET_RESULT($$.value,$1.value); };
    | logical_or_expression '?' expression ':' conditional_expression
        { SET_RESULT($$.value,[UMTerm ifCondition: $1.value thenDo: $3.value  elseDo: $5.value]); };
	;

logical_or_expression
	: logical_and_expression
        { SET_RESULT($$.value,$1.value); };
    | logical_or_expression OPERATOR_OR logical_and_expression
        { SET_RESULT($$.value,[$1.value logical_or: $3.value]); };
	;

logical_and_expression
    : inclusive_or_expression
        { SET_RESULT($$.value,$1.value); };
    | logical_and_expression OPERATOR_AND inclusive_or_expression
        { SET_RESULT($$.value,[$1.value logical_and: $3.value]); };
	;

inclusive_or_expression
    : exclusive_or_expression
        { SET_RESULT($$.value,$1.value); };
	| inclusive_or_expression '|' exclusive_or_expression
        { SET_RESULT($$.value,[$1.value bit_or: $3.value]); };
	;

exclusive_or_expression
	: and_expression
        { SET_RESULT($$.value,$1.value); };
	| exclusive_or_expression '^' and_expression
        { SET_RESULT($$.value,[$1.value bit_xor: $3.value]); };
	;

and_expression
	: equality_expression
        { SET_RESULT($$.value,$1.value); };
	| and_expression '&' equality_expression
        { SET_RESULT($$.value,[$1.value bit_and: $3.value]); };
	;

equality_expression
	: relational_expression
        { SET_RESULT($$.value,$1.value); };
	| equality_expression OPERATOR_EQUAL relational_expression
        { SET_RESULT($$.value,[$1.value equal: $3.value]); };
	| equality_expression OPERATOR_NOT_EQUAL relational_expression
        { SET_RESULT($$.value,[$1.value notequal: $3.value]); };
	;

relational_expression
	: shift_expression
        { SET_RESULT($$.value,$1.value); };
	| relational_expression OPERATOR_LESS shift_expression
        { SET_RESULT($$.value,[$1.value lessthan: $3.value]); };
	| relational_expression OPERATOR_GREATER shift_expression
        { SET_RESULT($$.value,[$1.value greaterthan:    $3.value]); };
	| relational_expression OPERATOR_LESS_OR_EQUAL shift_expression
        { SET_RESULT($$.value,[$1.value lessorequal:    $3.value]); };
	| relational_expression OPERATOR_GREATER_OR_EQUAL shift_expression
        { SET_RESULT($$.value,[$1.value greaterorequal: $3.value]); };
	;

shift_expression
	: additive_expression
        { SET_RESULT($$.value,$1.value); };
	| shift_expression OPERATOR_LEFT additive_expression
    { SET_RESULT($$.value,[$1.value leftshift:  $3.value]); };
	| shift_expression OPERATOR_RIGHT additive_expression
        { SET_RESULT($$.value,[$1.value rightshift: $3.value]); };
	;

additive_expression
	: multiplicative_expression
        { SET_RESULT($$.value,$1.value); };
    | additive_expression '+' multiplicative_expression
        { SET_RESULT($$.value,[$1.value add: $3.value]); };
	| additive_expression '-' multiplicative_expression
        { SET_RESULT($$.value,[$1.value sub: $3.value]); };
	;

multiplicative_expression
	: unary_expression
        { SET_RESULT($$.value,$1.value); };
	| multiplicative_expression '*' unary_expression
        { SET_RESULT($$.value,[$1.value mul:    $3.value]); };
	| multiplicative_expression '/' unary_expression
        { SET_RESULT($$.value,[$1.value div:    $3.value]); };
    | multiplicative_expression '%' unary_expression
        { SET_RESULT($$.value,[$1.value modulo: $3.value]); };

	;
	
unary_expression
	: postfix_expression
        { SET_RESULT($$.value,$1.value); };
    | OPERATOR_INCREASE unary_expression
        { SET_RESULT($$.value,[$2.value preincrease]); };
	| OPERATOR_DECREASE unary_expression
        { SET_RESULT($$.value,[$2.value predecrease]); };
    | '!' unary_expression
        { SET_RESULT($$.value,[$1.value logical_not]); };
    | '~' unary_expression
        { SET_RESULT($$.value,[$1.value bit_not]); };
	;

postfix_expression
	: primary_expression
        { SET_RESULT($$.value,$1.value); };
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression OPERATOR_INCREASE
        { SET_RESULT($$.value,[$1.value postincrease]); };
	| postfix_expression OPERATOR_DECREASE
        { SET_RESULT($$.value,[$1.value postdecrease]); };
	;

primary_expression
    : IDENTIFIER
            { SET_RESULT($$.value,[UMTerm termWithIdentifierFromTag:$1.value]); };
    | VARIABLE
            { SET_RESULT($$.value,[UMTerm termWithVariableFromTag:$1.value]); };
    | FIELD
            { SET_RESULT($$.value,[UMTerm termWithFieldFromTag:$1.value]); };
    | CONST_BOOLEAN
            { SET_RESULT($$.value,[UMTerm termWithBooleanFromTag:$1.value]); };
    | CONST_STRING
            { SET_RESULT($$.value,[UMTerm termWithStringFromTag:$1.value]); };
    | CONST_HEX
        { SET_RESULT($$.value,[UMTerm termWithHexFromTag:$1.value]); };
    | CONST_LONGLONG
        { SET_RESULT($$.value,[UMTerm termWithLongLongFromTag:$1.value]); };
    | CONST_BINARY
        { SET_RESULT($$.value,[UMTerm termWithBinaryFromTag:$1.value]); };
    | CONST_INTEGER
        { SET_RESULT($$.value,[UMTerm termWithIntegerFromTag:$1.value]); };
    | CONST_OCTAL
        { SET_RESULT($$.value,[UMTerm termWithOctalFromTag:$1.value]); };
    | CONST_DOUBLE
        { SET_RESULT($$.value,[UMTerm termWithDoubleFromTag:$1.value]); };
	| '(' expression ')'
        { SET_RESULT($$.value,$2.value); };
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

