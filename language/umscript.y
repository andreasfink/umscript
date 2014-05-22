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

%start assignment_expression

%%

statement_list
: statement
        {
           UMTerm *t = [UMTerm blockWithStatement:$1.value];
           $$.value=RETAIN(t);
        };
	| statement_list statement
        {
            cenv.root=$$.value;
            [$$.value blockAppendStatement:$1.value];
        };
	;

block : '{' '}'
    | '{' statement_list '}'
       { $$.value=RETAIN($2.value);};
    ;

statement
	: labeled_statement
        { $$.value=RETAIN($1.value);};
	| block
        { $$.value=RETAIN($1.value);};
	| expression_statement
        { $$.value=RETAIN($1.value);};
	| selection_statement
        { $$.value=RETAIN($1.value);};
	| iteration_statement
        { $$.value=RETAIN($1.value);};
	| jump_statement
        { $$.value=RETAIN($1.value);};
	;

expression_statement
	: ';'
    | expression ';'
        { $$.value=RETAIN($1.value);};
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

selection_statement
    : IF '(' expression ')' block
        {$$.value=RETAIN([UMTerm ifCondition: $2.value .value  thenDo: $5.value .value  elseDo: [UMTerm termWithNull]]);};
    | IF '(' expression ')' block ELSE block
        { $$.value=RETAIN([UMTerm ifCondition: $2.value  thenDo: $5.value  elseDo: $7.value]);};
	| SWITCH '(' expression ')' block
        { $$.value=RETAIN([UMTerm switchCondition: $2.value  thenDo: $5.value]);};
	;

jump_statement
    : GOTO IDENTIFIER ';'
    | CONTINUE ';'
    | BREAK ';'
    | RETURN ';'
	| RETURN expression ';'     { $$.value=RETAIN($2.value);};
	;


iteration_statement
    : WHILE '(' expression ')' statement
        { $$.value=RETAIN([UMTerm whileCondition: $2.value  thenDo: $3.value]);};
    | DO statement WHILE '(' expression ')' ';'
        { $$.value=RETAIN([UMTerm thenDo: $2.value  whileCondition: $3.value]);};
	| FOR '(' expression_statement expression_statement ')' statement
        { $$.value=RETAIN([UMTerm forInitializer:$3.value endCondition:$4.value every:NULL thenDo: $6.value]);};
    | FOR '(' expression_statement expression_statement expression ')' statement
        { $$.value=RETAIN([UMTerm forInitializer:$3.value endCondition:$4.value every:$5.value  thenDo: $7.value]);};
	;


expression
	: assignment_expression
        { $$.value=RETAIN($1.value);};
	| expression ',' assignment_expression
        { $$.value=RETAIN($1.value);};

	;

assignment_expression
	: conditional_expression
        { $$.value=RETAIN($1.value);};
	| unary_expression '=' assignment_expression
        { $$.value=RETAIN([$1.value  assign:$3.value]);};
    | unary_expression OPERATOR_MUL_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value mul: $3.value]]);};
    | unary_expression OPERATOR_DIV_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value div: $3.value]]);};
    | unary_expression OPERATOR_MOD_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value mul: $3.value]]);};
    | unary_expression OPERATOR_ADD_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value add: $3.value]]);};
    | unary_expression OPERATOR_SUB_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value sub: $2.value]]);};
    | unary_expression OPERATOR_LEFT_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value leftshift: $3.value]]);};
    | unary_expression OPERATOR_RIGHT_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value rightshift: $3.value]]);};
    | unary_expression OPERATOR_AND_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value logical_and: $3.value]]);};
    | unary_expression OPERATOR_XOR_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value logical_xor: $3.value]]);};
    | unary_expression OPERATOR_OR_ASSIGN assignment_expression
        { $$.value=RETAIN([$1.value  assign:[$1.value logical_or: $3.value]]);};
	;

conditional_expression
	: logical_or_expression
        { $$.value=RETAIN($1.value);};
    | logical_or_expression '?' expression ':' conditional_expression
        { $$.value=RETAIN([UMTerm ifCondition: $1.value thenDo: $3.value  elseDo: $5.value]);};
	;

logical_or_expression
	: logical_and_expression
        { $$.value=RETAIN($1.value);};
    | logical_or_expression OPERATOR_OR logical_and_expression
        { $$.value=RETAIN([$1.value logical_or: $3.value]);};
	;

logical_and_expression
    : inclusive_or_expression
        { $$.value=RETAIN($1.value);};
    | logical_and_expression OPERATOR_AND inclusive_or_expression
        { $$.value=RETAIN([$1.value logical_and: $3.value]);};
	;

inclusive_or_expression
    : exclusive_or_expression
        { $$.value=RETAIN($1.value);};
	| inclusive_or_expression '|' exclusive_or_expression
        { $$.value=RETAIN([$1.value bit_or: $3.value]);};
	;

exclusive_or_expression
	: and_expression
        { $$.value=RETAIN($1.value);};
	| exclusive_or_expression '^' and_expression
        { $$.value=RETAIN([$1.value bit_xor: $3.value]);};
	;

and_expression
	: equality_expression
        { $$.value=RETAIN($1.value);};
	| and_expression '&' equality_expression
        { $$.value=RETAIN([$1.value bit_and: $3.value]);};
	;

equality_expression
	: relational_expression
        { $$.value=RETAIN($1.value);};
	| equality_expression OPERATOR_EQUAL relational_expression
        { $$.value=RETAIN([$1.value equal: $3.value]);};
	| equality_expression OPERATOR_NOT_EQUAL relational_expression
        { $$.value=RETAIN([$1.value notequal: $3.value]);};
	;

relational_expression
	: shift_expression
        { $$.value=RETAIN($1.value);};
	| relational_expression OPERATOR_LESS shift_expression
        { $$.value=RETAIN([$1.value lessthan: $3.value]);};
	| relational_expression OPERATOR_GREATER shift_expression
        { $$.value=RETAIN([$1.value greaterthan:    $3.value]);};
	| relational_expression OPERATOR_LESS_OR_EQUAL shift_expression
        { $$.value=RETAIN([$1.value lessorequal:    $3.value]);};
	| relational_expression OPERATOR_GREATER_OR_EQUAL shift_expression
        { $$.value=RETAIN([$1.value greaterorequal: $3.value]);};
	;

shift_expression
	: additive_expression
        { $$.value=RETAIN($1.value);};
	| shift_expression OPERATOR_LEFT additive_expression
    { $$.value=RETAIN([$1.value leftshift:  $3.value]);};
	| shift_expression OPERATOR_RIGHT additive_expression
        { $$.value=RETAIN([$1.value rightshift: $3.value]);};
	;

additive_expression
	: multiplicative_expression
        { $$.value=RETAIN($1.value);};
    | additive_expression '+' multiplicative_expression
        { $$.value=RETAIN([$1.value add: $3.value]);};
	| additive_expression '-' multiplicative_expression
        { $$.value=RETAIN([$1.value sub: $3.value]);};
	;

multiplicative_expression
	: unary_expression
        { $$.value=RETAIN($1.value);};
	| multiplicative_expression '*' unary_expression
        { $$.value=RETAIN([$1.value mul:    $3.value]);};
	| multiplicative_expression '/' unary_expression
        { $$.value=RETAIN([$1.value div:    $3.value]);};
    | multiplicative_expression '%' unary_expression
        { $$.value=RETAIN([$1.value modulo: $3.value]);};

	;
	
unary_expression
	: postfix_expression
        { $$.value=RETAIN($1.value);};
    | OPERATOR_INCREASE unary_expression
        { $$.value=RETAIN([$2.value preincrease]);};
	| OPERATOR_DECREASE unary_expression
        { $$.value=RETAIN([$2.value predecrease]);};
    | '!' unary_expression
        { $$.value=RETAIN([$1.value logical_not]);};
    | '~' unary_expression
        { $$.value=RETAIN([$1.value bit_not]);};
	;

postfix_expression
	: primary_expression
        { $$.value=RETAIN($1.value);};
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression OPERATOR_INCREASE
        { $$.value=RETAIN([$1.value postincrease]);};
	| postfix_expression OPERATOR_DECREASE
        { $$.value=RETAIN([$1.value postdecrease]);};
	;

primary_expression
    : IDENTIFIER
            { $$.value=RETAIN([UMTerm termWithIdentifierFromTag:$1.value]);};
    | VARIABLE
            { $$.value=RETAIN([UMTerm termWithVariableFromTag:$1.value]);};
    | FIELD
            { $$.value=RETAIN([UMTerm termWithFieldFromTag:$1.value]);};
    | CONST_BOOLEAN
            { $$.value=RETAIN([UMTerm termWithBooleanFromTag:$1.value]);};
    | CONST_STRING
            { $$.value=RETAIN([UMTerm termWithStringFromTag:$1.value]);};
    | CONST_HEX
        { $$.value=RETAIN([UMTerm termWithHexFromTag:$1.value]);};
    | CONST_LONGLONG
        { $$.value=RETAIN([UMTerm termWithLongLongFromTag:$1.value]);};
    | CONST_BINARY
        { $$.value=RETAIN([UMTerm termWithBinaryFromTag:$1.value]);};
    | CONST_INTEGER
        { $$.value=RETAIN([UMTerm termWithIntegerFromTag:$1.value]);};
    | CONST_OCTAL
        { $$.value=RETAIN([UMTerm termWithOctalFromTag:$1.value]);};
    | CONST_DOUBLE
        { $$.value=RETAIN([UMTerm termWithDoubleFromTag:$1.value]);};
	| '(' expression ')'
        { $$.value=RETAIN($2.value);};
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

