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
    
#import "umscript.yl.h"


/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
    int first_line;
    int first_column;
    int last_line;
    int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


%}

/*%pure-parser*/
%lex-param      {UMScriptCompilerEnvironment *cenv}
%parse-param    {UMScriptCompilerEnvironment *cenv}
%define api.pure
%locations

%{
 
extern void yyerror (YYLTYPE *llocp, UMScriptCompilerEnvironment *cenv, const char *msg);

%}

%token IDENTIFIER
%token VARIABLE
%token FIELD
%token CONSTANT
%token STRING_LITERAL

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

%start translation_unit
%%

block
	: '{' '}'
	| '{' statement_list '}'
	;

statement_list
	: statement
	| statement_list statement
	;

statement
	: labeled_statement
	| block
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

expression_statement
	: ';'
    | expression ';'                                    { $$ = ROOT = $1;  }
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

selection_statement
    : IF '(' expression ')' block                        { $$ = ROOT = [UMTerm ifCondition: $2 thenDo: $5 elseDo: [UMTerm termWithNull]];  };
    | IF '(' expression ')' block ELSE block             { $$ = ROOT = [UMTerm ifCondition: $2 thenDo: $5 elseDo: $7];  };
	| SWITCH '(' expression ')' block                    { $$ = ROOT = [UMTerm switchCondition: $2 thenDo: $5 ];  };
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	;


iteration_statement
    : WHILE '(' expression ')' statement                { $$ = ROOT = [UMTerm whileCondition: $2 thenDo: $3];  };
    | DO statement WHILE '(' expression ')' ';'         { $$ = ROOT = [UMTerm thenDo: $2 whileCondition: $3];  };
	| FOR '(' expression_statement expression_statement ')' statement
{ $$ = ROOT = [UMTerm forInitializer:$3 endCondition:$4 every:NULL thenDo: $6]; };
    | FOR '(' expression_statement expression_statement expression ')' statement
{ $$ = ROOT = [UMTerm forInitializer:$3 endCondition:$4 every:$5 thenDo: $7]; };
	;


expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression '=' assignment_expression                        { $$ = ROOT = [$1 assign:$3];  };
    | unary_expression OPERATOR_MUL_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 mul: $3]];  };
    | unary_expression OPERATOR_DIV_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 div: $3]];  };
    | unary_expression OPERATOR_MOD_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 mul: $3]];  };
    | unary_expression OPERATOR_ADD_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 add: $2]];  };
    | unary_expression OPERATOR_SUB_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 sub: $2]];  };
    | unary_expression OPERATOR_LEFT_ASSIGN assignment_expression       { $$ = ROOT = [$1 assign:[$1 leftshift: $3]];  };
    | unary_expression OPERATOR_RIGHT_ASSIGN assignment_expression      { $$ = ROOT = [$1 assign:[$1 rightshift: $3]];  };
    | unary_expression OPERATOR_AND_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 logical_and: $3]];  };
    | unary_expression OPERATOR_XOR_ASSIGN assignment_expression        { $$ = ROOT = [$1 assign:[$1 logical_xor: $3]];  };
    | unary_expression OPERATOR_OR_ASSIGN assignment_expression         { $$ = ROOT = [$1 assign:[$1 logical_or: $3]];  };
	;

conditional_expression
	: logical_or_expression
    | logical_or_expression '?' expression ':' conditional_expression
        { $$ = ROOT = [UMTerm ifCondition: $1 thenDo: $3 elseDo: $5];  };
	;

logical_or_expression
	: logical_and_expression
    | logical_or_expression OPERATOR_OR logical_and_expression          { $$ = ROOT = [$1 logical_or: $3];  };

	;

logical_and_expression
	: inclusive_or_expression
    | logical_and_expression OPERATOR_AND inclusive_or_expression       { $$ = ROOT = [$1 logical_and: $3];  };

	;

inclusive_or_expression
    : exclusive_or_expression                                           { $$ = ROOT = $1;};
	| inclusive_or_expression '|' exclusive_or_expression               { $$ = ROOT = [$1 bit_or: $3];  };
	;

exclusive_or_expression
	: and_expression                                                    { $$ = ROOT = $1;};
	| exclusive_or_expression '^' and_expression                        { $$ = ROOT = [$1 bit_xor: $3];  };
	;

and_expression
	: equality_expression                                               { $$ = ROOT = $1;};
	| and_expression '&' equality_expression                            { $$ = ROOT = [$1 bit_and: $3];  };
	;

equality_expression
	: relational_expression                                             { $$ = ROOT = $1;};
	| equality_expression OPERATOR_EQUAL relational_expression          { $$ = ROOT = [$1 equal: $3];     };
	| equality_expression OPERATOR_NOT_EQUAL relational_expression      { $$ = ROOT = [$1 notequal: $3];  };
	;

relational_expression
	: shift_expression                                                  { $$ = ROOT = $1;};
	| relational_expression OPERATOR_LESS shift_expression              { $$ = ROOT = [$1 lessthan:       $3];  };
	| relational_expression OPERATOR_GREATER shift_expression           { $$ = ROOT = [$1 greaterthan:    $3];  };
	| relational_expression OPERATOR_LESS_OR_EQUAL shift_expression     { $$ = ROOT = [$1 lessorequal:    $3];  };
	| relational_expression OPERATOR_GREATER_OR_EQUAL shift_expression  { $$ = ROOT = [$1 greaterorequal: $3];  };
	;

shift_expression
	: additive_expression                                               { $$ = ROOT = $1;};
	| shift_expression OPERATOR_LEFT additive_expression                { $$ = ROOT = [$1 leftshift:  $3];  };
	| shift_expression OPERATOR_RIGHT additive_expression               { $$ = ROOT = [$1 rightshift: $3];  };
	;

additive_expression
	: multiplicative_expression                                         { $$ = ROOT = $1;};
    | additive_expression '+' multiplicative_expression                 { $$ = ROOT = [$1 add: $3];  };
	| additive_expression '-' multiplicative_expression                 { $$ = ROOT = [$1 sub: $3];  };
	;

multiplicative_expression
	: unary_expression                                                  { $$ = ROOT = $1;};
	| multiplicative_expression '*' unary_expression                    { $$ = ROOT = [$1 mul:    $3]; };
	| multiplicative_expression '/' unary_expression                    { $$ = ROOT = [$1 div:    $3]; };
    | multiplicative_expression '%' unary_expression                    { $$ = ROOT = [$1 modulo: $3]; };

	;
	
unary_expression
	: postfix_expression                                                { $$ = ROOT = $1;};
    | OPERATOR_INCREASE unary_expression                                { $$ = ROOT = [$2 preincrease]; };
	| OPERATOR_DECREASE unary_expression                                { $$ = ROOT = [$2 predecrease]; };
| '!' unary_expression                                              { $$ = ROOT = [$1 logical_not];};
| '~' unary_expression                                              { $$ = ROOT = [$1 bit_not];};
	;

postfix_expression
	: primary_expression
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression OPERATOR_INCREASE                              { $$ = ROOT = [$1 postincrease]; };
	| postfix_expression OPERATOR_DECREASE                              { $$ = ROOT = [$1 postdecrease]; };
	;

primary_expression
    : IDENTIFIER            { $$ = ROOT = [UMTerm termWithIdentifier:$1];  };
    | VARIABLE              { $$ = ROOT = [UMTerm termWithVariable:$1];    };
    | FIELD                 { $$ = ROOT = [UMTerm termWithField:$1];       };
    | CONSTANT              { $$ = ROOT = [UMTerm termWithConstant:$1];    };
    | STRING_LITERAL        { $$ = ROOT = [UMTerm termWithString:$1];      };
	| '(' expression ')'
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

extern char yytext[];
extern int column;
int yylex();

int push_field(void *p)
{
    return 0;
}

int push_variable(void *p)
{
    return 0;
}

