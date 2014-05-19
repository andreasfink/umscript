/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     IDENTIFIER = 258,
     VARIABLE_IDENTIFIER = 259,
     FIELD_IDENTIFIER = 260,
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
/* Tokens.  */
#define IDENTIFIER 258
#define VARIABLE_IDENTIFIER 259
#define FIELD_IDENTIFIER 260
#define CONSTANT 261
#define STRING_LITERAL 262
#define OPERATOR_ASSIGNMENT 263
#define OPERATOR_INCREASE 264
#define OPERATOR_DECREASE 265
#define OPERATOR_LEFT 266
#define OPERATOR_RIGHT 267
#define OPERATOR_LESS 268
#define OPERATOR_LESS_OR_EQUAL 269
#define OPERATOR_GREATER 270
#define OPERATOR_GREATER_OR_EQUAL 271
#define OPERATOR_EQUAL 272
#define OPERATOR_NOT_EQUAL 273
#define OPERATOR_AND 274
#define OPERATOR_OR 275
#define OPERATOR_MUL_ASSIGN 276
#define OPERATOR_DIV_ASSIGN 277
#define OPERATOR_MOD_ASSIGN 278
#define OPERATOR_ADD_ASSIGN 279
#define OPERATOR_SUB_ASSIGN 280
#define OPERATOR_LEFT_ASSIGN 281
#define OPERATOR_RIGHT_ASSIGN 282
#define OPERATOR_AND_ASSIGN 283
#define OPERATOR_XOR_ASSIGN 284
#define OPERATOR_OR_ASSIGN 285
#define CASE 286
#define DEFAULT 287
#define IF 288
#define ELSE 289
#define SWITCH 290
#define WHILE 291
#define DO 292
#define FOR 293
#define GOTO 294
#define CONTINUE 295
#define BREAK 296
#define RETURN 297




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

