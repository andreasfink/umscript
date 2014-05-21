/* A Bison parser, made by GNU Bison 3.0.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_LANGUAGE_GENERATED_UMSCRIPT_Y_H_INCLUDED
# define YY_YY_LANGUAGE_GENERATED_UMSCRIPT_Y_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    VARIABLE = 259,
    FIELD = 260,
    CONSTANT = 261,
    STRING_LITERAL = 262,
    OPERATOR_ASSIGNMENT = 263,
    OPERATOR_INCREASE = 264,
    OPERATOR_DECREASE = 265,
    OPERATOR_LEFT = 266,
    OPERATOR_RIGHT = 267,
    OPERATOR_LESS = 268,
    OPERATOR_LESS_OR_EQUAL = 269,
    OPERATOR_GREATER = 270,
    OPERATOR_GREATER_OR_EQUAL = 271,
    OPERATOR_EQUAL = 272,
    OPERATOR_NOT_EQUAL = 273,
    OPERATOR_AND = 274,
    OPERATOR_OR = 275,
    OPERATOR_MUL_ASSIGN = 276,
    OPERATOR_DIV_ASSIGN = 277,
    OPERATOR_MOD_ASSIGN = 278,
    OPERATOR_ADD_ASSIGN = 279,
    OPERATOR_SUB_ASSIGN = 280,
    OPERATOR_LEFT_ASSIGN = 281,
    OPERATOR_RIGHT_ASSIGN = 282,
    OPERATOR_AND_ASSIGN = 283,
    OPERATOR_XOR_ASSIGN = 284,
    OPERATOR_OR_ASSIGN = 285,
    CASE = 286,
    DEFAULT = 287,
    IF = 288,
    ELSE = 289,
    SWITCH = 290,
    WHILE = 291,
    DO = 292,
    FOR = 293,
    GOTO = 294,
    CONTINUE = 295,
    BREAK = 296,
    RETURN = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

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



int yyparse (UMScriptCompilerEnvironment *cenv);

#endif /* !YY_YY_LANGUAGE_GENERATED_UMSCRIPT_Y_H_INCLUDED  */
