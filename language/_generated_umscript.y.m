/* A Bison parser, made by GNU Bison 3.0.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 1

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 11 "language/umscript.y" /* yacc.c:339  */



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

#line 41 "language/umscript.y" /* yacc.c:339  */

 
extern void yyerror (YYLTYPE *llocp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv, const char *msg);


#line 93 "language/_generated_umscript.y.m" /* yacc.c:339  */

# ifndef YY_NULL
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULL nullptr
#  else
#   define YY_NULL 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "_generated_umscript.y.h".  */
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

/* Copy the second part of user declarations.  */

#line 206 "language/_generated_umscript.y.m" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef __attribute__
/* This feature is available in gcc versions 2.5 and later.  */
# if (! defined __GNUC__ || __GNUC__ < 2 \
      || (__GNUC__ == 2 && __GNUC_MINOR__ < 5))
#  define __attribute__(Spec) /* empty */
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  38
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   139

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  69
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  18
/* YYNRULES -- Number of rules.  */
#define YYNRULES  70
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  116

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   303

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    66,     2,     2,     2,    65,    60,     2,
      53,    54,    63,    61,    55,    62,    68,    64,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    52,    51,
       2,    56,     2,    57,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    59,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    49,    58,    50,    67,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   102,   177,   179,   185,   187,   189,   191,   193,   195,
     197,   199,   201,   203,   205,   207,   212,   214,   219,   221,
     226,   228,   233,   235,   240,   242,   247,   249,   254,   256,
     258,   263,   265,   267,   269,   271,   276,   278,   280,   285,
     287,   289,   294,   296,   298,   300,   306,   308,   310,   312,
     314,   319,   321,   322,   323,   324,   326,   331,   333,   335,
     337,   339,   341,   343,   345,   347,   349,   351,   353,   359,
     360
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IDENTIFIER", "VARIABLE", "FIELD",
  "CONST_BOOLEAN", "CONST_STRING", "CONST_HEX", "CONST_LONGLONG",
  "CONST_BINARY", "CONST_INTEGER", "CONST_OCTAL", "CONST_DOUBLE",
  "OPERATOR_ASSIGNMENT", "OPERATOR_INCREASE", "OPERATOR_DECREASE",
  "OPERATOR_LEFT", "OPERATOR_RIGHT", "OPERATOR_LESS",
  "OPERATOR_LESS_OR_EQUAL", "OPERATOR_GREATER",
  "OPERATOR_GREATER_OR_EQUAL", "OPERATOR_EQUAL", "OPERATOR_NOT_EQUAL",
  "OPERATOR_AND", "OPERATOR_OR", "OPERATOR_MUL_ASSIGN",
  "OPERATOR_DIV_ASSIGN", "OPERATOR_MOD_ASSIGN", "OPERATOR_ADD_ASSIGN",
  "OPERATOR_SUB_ASSIGN", "OPERATOR_LEFT_ASSIGN", "OPERATOR_RIGHT_ASSIGN",
  "OPERATOR_AND_ASSIGN", "OPERATOR_XOR_ASSIGN", "OPERATOR_OR_ASSIGN",
  "CASE", "DEFAULT", "IF", "ELSE", "SWITCH", "WHILE", "DO", "FOR", "GOTO",
  "CONTINUE", "BREAK", "RETURN", "'{'", "'}'", "';'", "':'", "'('", "')'",
  "','", "'='", "'?'", "'|'", "'^'", "'&'", "'+'", "'-'", "'*'", "'/'",
  "'%'", "'!'", "'~'", "'.'", "$accept", "expression",
  "assignment_expression", "conditional_expression",
  "logical_or_expression", "logical_and_expression",
  "inclusive_or_expression", "exclusive_or_expression", "and_expression",
  "equality_expression", "relational_expression", "shift_expression",
  "additive_expression", "multiplicative_expression", "unary_expression",
  "postfix_expression", "primary_expression", "argument_expression_list", YY_NULL
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   123,
     125,    59,    58,    40,    41,    44,    61,    63,   124,    94,
      38,    43,    45,    42,    47,    37,    33,   126,    46
};
# endif

#define YYPACT_NINF -34

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-34)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      72,   -34,   -34,   -34,   -34,   -34,   -34,   -34,   -34,   -34,
     -34,   -34,    72,    72,    72,    72,    72,    17,   -34,    -6,
     -22,   -33,   -32,   -13,    49,     2,    88,    46,    39,    62,
      33,   -34,   -34,   -34,    55,   -34,   -34,   -34,   -34,    72,
      72,    72,    72,    72,    72,    72,    72,    72,    72,    72,
      72,    72,    72,    72,    72,    72,    72,    72,    72,    72,
      72,    72,    72,    72,    72,    72,    72,    72,    72,   -34,
     -34,     3,    47,   -34,    72,   -22,   -34,   -26,   -33,   -32,
     -13,    49,     2,     2,    88,    88,    88,    88,    46,    46,
      39,    39,   -34,   -34,   -34,   -34,   -34,   -34,   -34,   -34,
     -34,   -34,   -34,   -34,   -34,   -34,   -34,   -34,    57,   -34,
     -34,    72,   -34,    72,   -34,   -34
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    57,    58,    59,    60,    61,    62,    63,    64,    65,
      66,    67,     0,     0,     0,     0,     0,     0,     4,    16,
      18,    20,    22,    24,    26,    28,    31,    36,    39,    42,
      46,    51,    47,    48,     0,     2,    49,    50,     1,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    55,
      56,     0,     0,    68,     0,    19,    42,     0,    21,    23,
      25,    27,    29,    30,    32,    34,    33,    35,    37,    38,
      40,    41,    43,    44,    45,     6,     7,     8,     9,    10,
      11,    12,    13,    14,    15,     5,    52,    69,     0,    54,
       3,     0,    53,     0,    17,    70
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -34,    59,     0,    10,   -34,    83,    82,    84,    81,    85,
      69,     5,    65,    66,   -11,   -34,   -34,   -34
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    34,    35,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,   108
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      17,    32,    33,    41,    36,    37,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    38,    12,    13,
      39,    47,    48,    49,    50,    42,   111,    43,    76,    74,
      76,    76,    76,    76,    76,    76,    76,    76,    76,    76,
      76,    76,    76,    76,    92,    93,    94,    44,    69,    70,
     109,    40,    84,    85,    86,    87,    14,   106,    95,    96,
      97,    98,    99,   100,   101,   102,   103,   104,   105,    15,
      16,   107,    45,    46,   110,     1,     2,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    71,    12,    13,    58,
      59,    60,    61,    62,    63,    64,    65,    66,    67,    77,
      76,    72,    55,    56,    57,    51,    52,    53,    54,    73,
      74,   112,   113,   115,    82,    83,    88,    89,    68,    90,
      91,   114,    75,    78,    80,    14,    79,     0,     0,    81,
       0,     0,     0,     0,     0,     0,     0,     0,    15,    16
};

static const yytype_int8 yycheck[] =
{
       0,    12,    13,    25,    15,    16,     3,     4,     5,     6,
       7,     8,     9,    10,    11,    12,    13,     0,    15,    16,
      26,    19,    20,    21,    22,    58,    52,    59,    39,    55,
      41,    42,    43,    44,    45,    46,    47,    48,    49,    50,
      51,    52,    53,    54,    55,    56,    57,    60,    15,    16,
       3,    57,    47,    48,    49,    50,    53,    54,    58,    59,
      60,    61,    62,    63,    64,    65,    66,    67,    68,    66,
      67,    71,    23,    24,    74,     3,     4,     5,     6,     7,
       8,     9,    10,    11,    12,    13,    53,    15,    16,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    40,
     111,    68,    63,    64,    65,    17,    18,    61,    62,    54,
      55,    54,    55,   113,    45,    46,    51,    52,    56,    53,
      54,   111,    39,    41,    43,    53,    42,    -1,    -1,    44,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    66,    67
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,     4,     5,     6,     7,     8,     9,    10,    11,
      12,    13,    15,    16,    53,    66,    67,    71,    72,    73,
      74,    75,    76,    77,    78,    79,    80,    81,    82,    83,
      84,    85,    83,    83,    70,    71,    83,    83,     0,    26,
      57,    25,    58,    59,    60,    23,    24,    19,    20,    21,
      22,    17,    18,    61,    62,    63,    64,    65,    27,    28,
      29,    30,    31,    32,    33,    34,    35,    36,    56,    15,
      16,    53,    68,    54,    55,    74,    83,    70,    75,    76,
      77,    78,    79,    79,    80,    80,    80,    80,    81,    81,
      82,    82,    83,    83,    83,    71,    71,    71,    71,    71,
      71,    71,    71,    71,    71,    71,    54,    71,    86,     3,
      71,    52,    54,    55,    72,    71
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    69,    70,    70,    71,    71,    71,    71,    71,    71,
      71,    71,    71,    71,    71,    71,    72,    72,    73,    73,
      74,    74,    75,    75,    76,    76,    77,    77,    78,    78,
      78,    79,    79,    79,    79,    79,    80,    80,    80,    81,
      81,    81,    82,    82,    82,    82,    83,    83,    83,    83,
      83,    84,    84,    84,    84,    84,    84,    85,    85,    85,
      85,    85,    85,    85,    85,    85,    85,    85,    85,    86,
      86
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     3,     1,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     1,     5,     1,     3,
       1,     3,     1,     3,     1,     3,     1,     3,     1,     3,
       3,     1,     3,     3,     3,     3,     1,     3,     3,     1,
       3,     3,     1,     3,     3,     3,     1,     2,     2,     2,
       2,     1,     3,     4,     3,     2,     2,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     3,     1,
       3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (&yylloc, yyscanner, cenv, YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

__attribute__((__unused__))
static unsigned
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  unsigned res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location, yyscanner, cenv); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  YYUSE (yylocationp);
  YYUSE (yyscanner);
  YYUSE (cenv);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp, yyscanner, cenv);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       , yyscanner, cenv);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, yyscanner, cenv); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULL;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  YYUSE (yyscanner);
  YYUSE (cenv);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  switch (yytype)
    {
          case 3: /* IDENTIFIER  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1186 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 4: /* VARIABLE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1192 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 5: /* FIELD  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1198 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 6: /* CONST_BOOLEAN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1204 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 7: /* CONST_STRING  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1210 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 8: /* CONST_HEX  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1216 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 9: /* CONST_LONGLONG  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1222 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 10: /* CONST_BINARY  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1228 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 11: /* CONST_INTEGER  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1234 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 12: /* CONST_OCTAL  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1240 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 13: /* CONST_DOUBLE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1246 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 14: /* OPERATOR_ASSIGNMENT  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1252 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 15: /* OPERATOR_INCREASE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1258 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 16: /* OPERATOR_DECREASE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1264 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 17: /* OPERATOR_LEFT  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1270 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 18: /* OPERATOR_RIGHT  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1276 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 19: /* OPERATOR_LESS  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1282 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 20: /* OPERATOR_LESS_OR_EQUAL  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1288 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 21: /* OPERATOR_GREATER  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1294 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 22: /* OPERATOR_GREATER_OR_EQUAL  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1300 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 23: /* OPERATOR_EQUAL  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1306 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 24: /* OPERATOR_NOT_EQUAL  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1312 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 25: /* OPERATOR_AND  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1318 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 26: /* OPERATOR_OR  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1324 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 27: /* OPERATOR_MUL_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1330 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 28: /* OPERATOR_DIV_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1336 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 29: /* OPERATOR_MOD_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1342 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 30: /* OPERATOR_ADD_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1348 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 31: /* OPERATOR_SUB_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1354 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 32: /* OPERATOR_LEFT_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1360 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 33: /* OPERATOR_RIGHT_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1366 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 34: /* OPERATOR_AND_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1372 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 35: /* OPERATOR_XOR_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1378 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 36: /* OPERATOR_OR_ASSIGN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1384 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 37: /* CASE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1390 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 38: /* DEFAULT  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1396 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 39: /* IF  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1402 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 40: /* ELSE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1408 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 41: /* SWITCH  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1414 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 42: /* WHILE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1420 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 43: /* DO  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1426 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 44: /* FOR  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1432 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 45: /* GOTO  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1438 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 46: /* CONTINUE  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1444 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 47: /* BREAK  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1450 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 48: /* RETURN  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1456 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 49: /* '{'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1462 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 50: /* '}'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1468 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 51: /* ';'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1474 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 52: /* ':'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1480 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 53: /* '('  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1486 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 54: /* ')'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1492 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 55: /* ','  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1498 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 56: /* '='  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1504 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 57: /* '?'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1510 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 58: /* '|'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1516 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 59: /* '^'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1522 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 60: /* '&'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1528 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 61: /* '+'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1534 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 62: /* '-'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1540 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 63: /* '*'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1546 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 64: /* '/'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1552 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 65: /* '%'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1558 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 66: /* '!'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1564 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 67: /* '~'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1570 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 68: /* '.'  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1576 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 70: /* expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1582 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 71: /* assignment_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1588 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 72: /* conditional_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1594 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 73: /* logical_or_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1600 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 74: /* logical_and_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1606 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 75: /* inclusive_or_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1612 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 76: /* exclusive_or_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1618 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 77: /* and_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1624 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 78: /* equality_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1630 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 79: /* relational_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1636 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 80: /* shift_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1642 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 81: /* additive_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1648 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 82: /* multiplicative_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1654 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 83: /* unary_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1660 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 84: /* postfix_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1666 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 85: /* primary_expression  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1672 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;

    case 86: /* argument_expression_list  */
#line 40 "language/umscript.y" /* yacc.c:1257  */
      { CFBridgingRelease(((*yyvaluep)).value); }
#line 1678 "language/_generated_umscript.y.m" /* yacc.c:1257  */
        break;


      default:
        break;
    }
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/*----------.
| yyparse.  |
`----------*/

int
yyparse (yyscan_t yyscanner, UMScriptCompilerEnvironment *cenv)
{
/* The lookahead symbol.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

/* Location data for the lookahead symbol.  */
static YYLTYPE yyloc_default
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
YYLTYPE yylloc = yyloc_default;

    /* Number of syntax errors so far.  */
    int yynerrs;

    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  yylsp[0] = yylloc;
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yyls1, yysize * sizeof (*yylsp),
                    &yystacksize);

        yyls = yyls1;
        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex (&yylval, &yylloc, yyscanner);
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 178 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 1972 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 3:
#line 180 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[-2]).value);}
#line 1978 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 4:
#line 186 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 1984 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 5:
#line 188 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:(yyvsp[0]).value]);}
#line 1990 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 6:
#line 190 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value mul: (yyvsp[0]).value]]);}
#line 1996 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 7:
#line 192 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value div: (yyvsp[0]).value]]);}
#line 2002 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 8:
#line 194 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value mul: (yyvsp[0]).value]]);}
#line 2008 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 9:
#line 196 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value add: (yyvsp[0]).value]]);}
#line 2014 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 10:
#line 198 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value sub: (yyvsp[-1]).value]]);}
#line 2020 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 11:
#line 200 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value leftshift: (yyvsp[0]).value]]);}
#line 2026 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 12:
#line 202 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value rightshift: (yyvsp[0]).value]]);}
#line 2032 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 13:
#line 204 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value logical_and: (yyvsp[0]).value]]);}
#line 2038 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 14:
#line 206 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value logical_xor: (yyvsp[0]).value]]);}
#line 2044 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 15:
#line 208 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value  assign:[(yyvsp[-2]).value logical_or: (yyvsp[0]).value]]);}
#line 2050 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 16:
#line 213 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2056 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 17:
#line 215 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm ifCondition: (yyvsp[-4]).value thenDo: (yyvsp[-2]).value  elseDo: (yyvsp[0]).value]);}
#line 2062 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 18:
#line 220 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2068 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 19:
#line 222 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value logical_or: (yyvsp[0]).value]);}
#line 2074 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 20:
#line 227 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2080 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 21:
#line 229 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value logical_and: (yyvsp[0]).value]);}
#line 2086 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 22:
#line 234 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2092 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 23:
#line 236 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value bit_or: (yyvsp[0]).value]);}
#line 2098 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 24:
#line 241 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2104 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 25:
#line 243 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value bit_xor: (yyvsp[0]).value]);}
#line 2110 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 26:
#line 248 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2116 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 27:
#line 250 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value bit_and: (yyvsp[0]).value]);}
#line 2122 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 28:
#line 255 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2128 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 29:
#line 257 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value equal: (yyvsp[0]).value]);}
#line 2134 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 30:
#line 259 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value notequal: (yyvsp[0]).value]);}
#line 2140 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 31:
#line 264 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2146 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 32:
#line 266 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value lessthan: (yyvsp[0]).value]);}
#line 2152 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 33:
#line 268 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value greaterthan:    (yyvsp[0]).value]);}
#line 2158 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 34:
#line 270 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value lessorequal:    (yyvsp[0]).value]);}
#line 2164 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 35:
#line 272 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value greaterorequal: (yyvsp[0]).value]);}
#line 2170 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 36:
#line 277 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2176 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 37:
#line 279 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value leftshift:  (yyvsp[0]).value]);}
#line 2182 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 38:
#line 281 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value rightshift: (yyvsp[0]).value]);}
#line 2188 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 39:
#line 286 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2194 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 40:
#line 288 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value add: (yyvsp[0]).value]);}
#line 2200 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 41:
#line 290 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value sub: (yyvsp[0]).value]);}
#line 2206 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 42:
#line 295 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2212 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 43:
#line 297 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value mul:    (yyvsp[0]).value]);}
#line 2218 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 44:
#line 299 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value div:    (yyvsp[0]).value]);}
#line 2224 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 45:
#line 301 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-2]).value modulo: (yyvsp[0]).value]);}
#line 2230 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 46:
#line 307 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2236 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 47:
#line 309 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[0]).value preincrease]);}
#line 2242 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 48:
#line 311 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[0]).value predecrease]);}
#line 2248 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 49:
#line 313 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-1]).value logical_not]);}
#line 2254 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 50:
#line 315 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-1]).value bit_not]);}
#line 2260 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 51:
#line 320 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[0]).value);}
#line 2266 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 55:
#line 325 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-1]).value postincrease]);}
#line 2272 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 56:
#line 327 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([(yyvsp[-1]).value postdecrease]);}
#line 2278 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 57:
#line 332 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithIdentifierFromTag:(yyvsp[0]).value]);}
#line 2284 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 58:
#line 334 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithVariableFromTag:(yyvsp[0]).value]);}
#line 2290 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 59:
#line 336 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithFieldFromTag:(yyvsp[0]).value]);}
#line 2296 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 60:
#line 338 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithBooleanFromTag:(yyvsp[0]).value]);}
#line 2302 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 61:
#line 340 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithStringFromTag:(yyvsp[0]).value]);}
#line 2308 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 62:
#line 342 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithHexFromTag:(yyvsp[0]).value]);}
#line 2314 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 63:
#line 344 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithLongLongFromTag:(yyvsp[0]).value]);}
#line 2320 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 64:
#line 346 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithBinaryFromTag:(yyvsp[0]).value]);}
#line 2326 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 65:
#line 348 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithIntegerFromTag:(yyvsp[0]).value]);}
#line 2332 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 66:
#line 350 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithOctalFromTag:(yyvsp[0]).value]);}
#line 2338 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 67:
#line 352 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN([UMTerm termWithDoubleFromTag:(yyvsp[0]).value]);}
#line 2344 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;

  case 68:
#line 354 "language/umscript.y" /* yacc.c:1661  */
    { (yyval).value=RETAIN((yyvsp[-1]).value);}
#line 2350 "language/_generated_umscript.y.m" /* yacc.c:1661  */
    break;


#line 2354 "language/_generated_umscript.y.m" /* yacc.c:1661  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (&yylloc, yyscanner, cenv, YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (&yylloc, yyscanner, cenv, yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc, yyscanner, cenv);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[1] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp, yyscanner, cenv);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (&yylloc, yyscanner, cenv, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc, yyscanner, cenv);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp, yyscanner, cenv);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 380 "language/umscript.y" /* yacc.c:1906  */

#include <stdio.h>

extern int yylex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , yyscan_t yyscanner);

