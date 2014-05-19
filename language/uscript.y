%token IDENTIFIER
%token VARIABLE_IDENTIFIER 
%token FIELD_IDENTIFIER 
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
	| expression ';'
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

selection_statement
	: IF '(' expression ')' block
	| IF '(' expression ')' block ELSE block
	| SWITCH '(' expression ')' statement
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expression ';'
	;


iteration_statement
	: WHILE '(' expression ')' statement
	| DO statement WHILE '(' expression ')' ';'
	| FOR '(' expression_statement expression_statement ')' statement
	| FOR '(' expression_statement expression_statement expression ')' statement
	;


expression
	: assignment_expression
	| expression ',' assignment_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OPERATOR_OR logical_and_expression
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression OPERATOR_AND inclusive_or_expression
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression
	;

equality_expression
	: relational_expression
	| equality_expression OPERATOR_EQUAL relational_expression
	| equality_expression OPERATOR_NOT_EQUAL relational_expression
	;

relational_expression
	: shift_expression
	| relational_expression OPERATOR_LESS shift_expression
	| relational_expression OPERATOR_GREATER shift_expression
	| relational_expression OPERATOR_LESS_OR_EQUAL shift_expression
	| relational_expression OPERATOR_GREATER_OR_EQUAL shift_expression
	;

shift_expression
	: additive_expression
	| shift_expression OPERATOR_LEFT additive_expression
	| shift_expression OPERATOR_RIGHT additive_expression
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression
	| additive_expression '-' multiplicative_expression
	;

multiplicative_expression
	: unary_expression
	| multiplicative_expression '*' unary_expression
	| multiplicative_expression '/' unary_expression
	| multiplicative_expression '%' unary_expression
	;
	
unary_expression
	: postfix_expression
	| OPERATOR_INCREASE unary_expression
	| OPERATOR_DECREASE unary_expression
	| unary_operator unary_expression
	;

postfix_expression
	: primary_expression
	| postfix_expression '(' ')'
	| postfix_expression '(' argument_expression_list ')'
	| postfix_expression '.' IDENTIFIER
	| postfix_expression OPERATOR_INCREASE
	| postfix_expression OPERATOR_DECREASE
	;

field_identifier	: '%' IDENTIFIER;
variable_identifier : '$' IDENTIFIER;

primary_expression
	: IDENTIFIER
	| variable_identifier
	| field_identifier
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

assignment_operator
	: '='
	| OPERATOR_MUL_ASSIGN
	| OPERATOR_DIV_ASSIGN
	| OPERATOR_MOD_ASSIGN
	| OPERATOR_ADD_ASSIGN
	| OPERATOR_SUB_ASSIGN
	| OPERATOR_LEFT_ASSIGN
	| OPERATOR_RIGHT_ASSIGN
	| OPERATOR_AND_ASSIGN
	| OPERATOR_XOR_ASSIGN
	| OPERATOR_OR_ASSIGN
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;


unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
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
int yyerror(char *s);
void yylex(void);

int yyerror(char *s)
{
	fflush(stdout);
	printf("\n%*s\n%*s\n", column, "^", column, s);
}
