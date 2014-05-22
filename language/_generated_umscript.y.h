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
    CONST_BOOLEAN = 261,
    CONST_STRING = 262,
    CONST_HEX = 263,
    CONST_LONGLONG = 264,
    CONST_BINARY = 265,
    CONST_INTEGER = 266,
    CONST_OCTAL = 267,
    CONST_DOUBLE = 268,
    OPERATOR_ASSIGNMENT = 269,
    OPERATOR_INCREASE = 270,
    OPERATOR_DECREASE = 271,
    OPERATOR_LEFT = 272,
    OPERATOR_RIGHT = 273,
    OPERATOR_LESS = 274,
    OPERATOR_LESS_OR_EQUAL = 275,
    OPERATOR_GREATER = 276,
    OPERATOR_GREATER_OR_EQUAL = 277,
    OPERATOR_EQUAL = 278,
    OPERATOR_NOT_EQUAL = 279,
    OPERATOR_AND = 280,
    OPERATOR_OR = 281,
    OPERATOR_MUL_ASSIGN = 282,
    OPERATOR_DIV_ASSIGN = 283,
    OPERATOR_MOD_ASSIGN = 284,
    OPERATOR_ADD_ASSIGN = 285,
    OPERATOR_SUB_ASSIGN = 286,
    OPERATOR_LEFT_ASSIGN = 287,
    OPERATOR_RIGHT_ASSIGN = 288,
    OPERATOR_AND_ASSIGN = 289,
    OPERATOR_XOR_ASSIGN = 290,
    OPERATOR_OR_ASSIGN = 291,
    CASE = 292,
    DEFAULT = 293,
    IF = 294,
    ELSE = 295,
    SWITCH = 296,
    WHILE = 297,
    DO = 298,
    FOR = 299,
    GOTO = 300,
    CONTINUE = 301,
    BREAK = 302,
    RETURN = 303
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



int yyparse (yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv);

#endif /* !YY_YY_LANGUAGE_GENERATED_UMSCRIPT_Y_H_INCLUDED  */
