/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "1605103.y" /* yacc.c:339  */

#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<cmath>

#include "1605103_SymbolTable.h"
//#define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;
FILE *fp;

int lines=1;
int errors=0;

SymbolTable *symbolTable=new SymbolTable(100);

vector<SymbolInfo*>param_list;
vector<SymbolInfo*>declaration_list;
vector<SymbolInfo*>arg_list;


void yyerror(char *s){
	fprintf(stderr,"Line no %d : %s\n",s);
}




#line 101 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
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
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
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
    IF = 258,
    ELSE = 259,
    FOR = 260,
    WHILE = 261,
    DO = 262,
    BREAK = 263,
    INT = 264,
    FLOAT = 265,
    CHAR = 266,
    DOUBLE = 267,
    VOID = 268,
    RETURN = 269,
    SWITCH = 270,
    CASE = 271,
    DEFAULT = 272,
    CONTINUE = 273,
    CONST_INT = 274,
    CONST_FLOAT = 275,
    CONST_CHAR = 276,
    ADDOP = 277,
    MULOP = 278,
    INCOP = 279,
    RELOP = 280,
    ASSIGNOP = 281,
    LOGICOP = 282,
    BITOP = 283,
    NOT = 284,
    DECOP = 285,
    LPAREN = 286,
    RPAREN = 287,
    LCURL = 288,
    RCURL = 289,
    LTHIRD = 290,
    RTHIRD = 291,
    COMMA = 292,
    SEMICOLON = 293,
    STRING = 294,
    ID = 295,
    PRINTLN = 296,
    LOWER_THAN_ELSE = 297
  };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define FOR 260
#define WHILE 261
#define DO 262
#define BREAK 263
#define INT 264
#define FLOAT 265
#define CHAR 266
#define DOUBLE 267
#define VOID 268
#define RETURN 269
#define SWITCH 270
#define CASE 271
#define DEFAULT 272
#define CONTINUE 273
#define CONST_INT 274
#define CONST_FLOAT 275
#define CONST_CHAR 276
#define ADDOP 277
#define MULOP 278
#define INCOP 279
#define RELOP 280
#define ASSIGNOP 281
#define LOGICOP 282
#define BITOP 283
#define NOT 284
#define DECOP 285
#define LPAREN 286
#define RPAREN 287
#define LCURL 288
#define RCURL 289
#define LTHIRD 290
#define RTHIRD 291
#define COMMA 292
#define SEMICOLON 293
#define STRING 294
#define ID 295
#define PRINTLN 296
#define LOWER_THAN_ELSE 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 52 "1605103.y" /* yacc.c:355  */

	SymbolInfo* symbolinfo;
	vector<string>*s;

#line 230 "y.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 247 "y.tab.c" /* yacc.c:358  */

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

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
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
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

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
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   147

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  43
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  27
/* YYNRULES -- Number of rules.  */
#define YYNRULES  67
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  121

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   297

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
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
      35,    36,    37,    38,    39,    40,    41,    42
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    62,    62,    69,    78,    91,   100,   109,   121,   174,
     209,   209,   265,   265,   306,   315,   325,   332,   343,   343,
     358,   374,   401,   407,   413,   423,   430,   438,   445,   455,
     461,   469,   475,   481,   487,   500,   513,   525,   537,   543,
     556,   562,   570,   589,   621,   628,   649,   656,   672,   679,
     694,   701,   717,   724,   765,   778,   790,   801,   808,   853,
     860,   868,   876,   884,   894,   900,   906,   913
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IF", "ELSE", "FOR", "WHILE", "DO",
  "BREAK", "INT", "FLOAT", "CHAR", "DOUBLE", "VOID", "RETURN", "SWITCH",
  "CASE", "DEFAULT", "CONTINUE", "CONST_INT", "CONST_FLOAT", "CONST_CHAR",
  "ADDOP", "MULOP", "INCOP", "RELOP", "ASSIGNOP", "LOGICOP", "BITOP",
  "NOT", "DECOP", "LPAREN", "RPAREN", "LCURL", "RCURL", "LTHIRD", "RTHIRD",
  "COMMA", "SEMICOLON", "STRING", "ID", "PRINTLN", "LOWER_THAN_ELSE",
  "$accept", "start", "program", "unit", "func_declaration",
  "func_definition", "@1", "@2", "parameter_list", "compound_statement",
  "$@3", "var_declaration", "type_specifier", "declaration_list",
  "statements", "statement", "expression_statement", "variable",
  "expression", "logic_expression", "rel_expression", "simple_expression",
  "term", "unary_expression", "factor", "argument_list", "arguments", YY_NULLPTR
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
     295,   296,   297
};
# endif

#define YYPACT_NINF -74

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-74)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      46,   -74,   -74,   -74,    44,    46,   -74,   -74,   -74,   -74,
     -35,   -74,   -74,   -19,     8,     5,    28,    17,   -74,    20,
      -6,    27,    42,    40,   -74,    47,    41,    46,   -74,   -74,
      62,    50,   -74,   -74,    47,    48,    51,   -74,   102,   -74,
     -74,   -74,    55,    58,    59,    31,   -74,   -74,    31,    31,
      31,   -74,    39,    60,   -74,   -74,    53,    63,   -74,   -74,
      -7,    57,   -74,    71,     7,    76,   -74,   -74,    31,    98,
      31,    64,     0,   -74,   -74,    68,    31,    31,    66,    74,
     -74,   -74,   -74,    31,   -74,   -74,    31,    31,    31,    31,
      78,    98,    81,   -74,   -74,   -74,    82,    86,    83,    93,
     -74,   -74,    76,   104,   -74,   102,    31,   102,   -74,    31,
     -74,    90,   126,   100,   -74,   -74,   -74,   102,   102,   -74,
     -74
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    22,    23,    24,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    27,     0,     0,     0,     0,    21,    12,
       0,    17,     0,    25,     9,     0,    10,     0,    16,    28,
       0,    18,    13,     8,     0,    15,     0,    20,     0,    11,
      14,    26,     0,     0,     0,     0,    60,    61,     0,     0,
       0,    40,    42,     0,    33,    31,     0,     0,    29,    32,
      57,     0,    44,    46,    48,    50,    52,    56,     0,     0,
       0,     0,    57,    54,    55,     0,    65,     0,     0,    27,
      19,    30,    62,     0,    63,    41,     0,     0,     0,     0,
       0,     0,     0,    39,    59,    67,     0,    64,     0,     0,
      45,    47,    51,    49,    53,     0,     0,     0,    58,     0,
      43,     0,    35,     0,    37,    66,    38,     0,     0,    36,
      34
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -74,   -74,   -74,   129,   -74,   -74,   -74,   -74,   -74,   -12,
     -74,    43,     6,   -74,   -74,   -53,   -49,   -48,   -43,   -73,
      61,    49,    52,   -40,   -74,   -74,   -74
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,     7,     8,    34,    25,    20,    54,
      38,    55,    56,    14,    57,    58,    59,    60,    61,    62,
      63,    64,    65,    66,    67,    96,    97
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      72,    72,    71,    95,    81,    13,    10,    75,    73,    74,
     100,    10,    15,    32,     1,     2,    16,    82,     3,    83,
      91,    21,    39,    84,    82,    90,    26,    92,    72,    87,
      84,    27,    88,    35,    98,    72,   115,    19,    72,    72,
      72,    72,   106,     9,    11,    17,    18,    22,     9,   104,
      46,    47,   112,    48,   114,     1,     2,    23,    24,     3,
      49,    72,    50,   113,   119,   120,    42,    28,    43,    44,
      76,    52,     1,     2,    77,    30,     3,    45,    29,    33,
      31,    36,    46,    47,    37,    48,    68,    41,    40,    69,
      70,    78,    49,    79,    50,    85,    31,    80,    86,    89,
      94,    51,    93,    52,    53,    42,    99,    43,    44,    16,
     105,     1,     2,   107,   108,     3,    45,    46,    47,   110,
      48,    46,    47,   109,    48,   111,    87,    49,   116,    50,
     117,    49,   118,    50,    12,    31,    51,   103,    52,   102,
      51,     0,    52,    53,     0,     0,     0,   101
};

static const yytype_int8 yycheck[] =
{
      48,    49,    45,    76,    57,    40,     0,    50,    48,    49,
      83,     5,    31,    25,     9,    10,    35,    24,    13,    26,
      69,    15,    34,    30,    24,    68,    32,    70,    76,    22,
      30,    37,    25,    27,    77,    83,   109,    32,    86,    87,
      88,    89,    91,     0,     0,    37,    38,    19,     5,    89,
      19,    20,   105,    22,   107,     9,    10,    40,    38,    13,
      29,   109,    31,   106,   117,   118,     3,    40,     5,     6,
      31,    40,     9,    10,    35,    35,    13,    14,    36,    38,
      33,    19,    19,    20,    34,    22,    31,    36,    40,    31,
      31,    31,    29,    40,    31,    38,    33,    34,    27,    23,
      32,    38,    38,    40,    41,     3,    40,     5,     6,    35,
      32,     9,    10,    32,    32,    13,    14,    19,    20,    36,
      22,    19,    20,    37,    22,    32,    22,    29,    38,    31,
       4,    29,    32,    31,     5,    33,    38,    88,    40,    87,
      38,    -1,    40,    41,    -1,    -1,    -1,    86
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     9,    10,    13,    44,    45,    46,    47,    48,    54,
      55,     0,    46,    40,    56,    31,    35,    37,    38,    32,
      51,    55,    19,    40,    38,    50,    32,    37,    40,    36,
      35,    33,    52,    38,    49,    55,    19,    34,    53,    52,
      40,    36,     3,     5,     6,    14,    19,    20,    22,    29,
      31,    38,    40,    41,    52,    54,    55,    57,    58,    59,
      60,    61,    62,    63,    64,    65,    66,    67,    31,    31,
      31,    61,    60,    66,    66,    61,    31,    35,    31,    40,
      34,    58,    24,    26,    30,    38,    27,    22,    25,    23,
      61,    59,    61,    38,    32,    62,    68,    69,    61,    40,
      62,    63,    65,    64,    66,    32,    59,    32,    32,    37,
      36,    32,    58,    61,    58,    62,    38,     4,    32,    58,
      58
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    43,    44,    45,    45,    46,    46,    46,    47,    47,
      49,    48,    50,    48,    51,    51,    51,    51,    53,    52,
      52,    54,    55,    55,    55,    56,    56,    56,    56,    57,
      57,    58,    58,    58,    58,    58,    58,    58,    58,    58,
      59,    59,    60,    60,    61,    61,    62,    62,    63,    63,
      64,    64,    65,    65,    66,    66,    66,    67,    67,    67,
      67,    67,    67,    67,    68,    68,    69,    69
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     5,
       0,     7,     0,     6,     4,     3,     2,     1,     0,     4,
       2,     3,     1,     1,     1,     3,     6,     1,     4,     1,
       2,     1,     1,     1,     7,     5,     7,     5,     5,     3,
       1,     2,     1,     4,     1,     3,     1,     3,     1,     3,
       1,     3,     1,     3,     2,     2,     1,     1,     4,     3,
       1,     1,     2,     2,     1,     0,     3,     1
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
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



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

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
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
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
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
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
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
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
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
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
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
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
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
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

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

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
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

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

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
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

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
      yychar = yylex ();
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


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 62 "1605103.y" /* yacc.c:1646  */
    {	}
#line 1416 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 69 "1605103.y" /* yacc.c:1646  */
    {
		
		(yyval.symbolinfo) = new SymbolInfo();
		parserLog(lines,"program->program unit");
		parserLog((yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName()); 
		
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
	}
#line 1429 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 78 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"program->unit");
		parserLog((yyvsp[0].symbolinfo)->getName());

		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());
	}
#line 1442 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 91 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"unit->var_declaration");
		parserLog((yyvsp[0].symbolinfo)->getName()); 

		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()+"\n");
	}
#line 1455 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 100 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.symbolinfo) = new SymbolInfo();
		parserLog(lines,"unit->func_declaration");
		parserLog((yyvsp[0].symbolinfo)->getName()); 

		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()+"\n");
	}
#line 1468 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 109 "1605103.y" /* yacc.c:1646  */
    { 

		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"unit->func_definition");
		parserLog((yyvsp[0].symbolinfo)->getName());

		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()+"\n");
	}
#line 1481 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 121 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"func_declaration->type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		parserLog((yyvsp[-5].symbolinfo)->getName()+" "+(yyvsp[-4].symbolinfo)->getName()+"("+(yyvsp[-2].symbolinfo)->getName()+")");
		
		SymbolInfo *s = symbolTable->lookUp((yyvsp[-4].symbolinfo)->getName());
		
		if(s == nullptr){
			
			//TODO : Function
			symbolTable->insert(SymbolInfo((yyvsp[-4].symbolinfo)->getName(),"ID","Function"));

			s = symbolTable->lookUp((yyvsp[-4].symbolinfo)->getName());

			s->set_isFunction();
			
			for(int i=0 ;i < param_list.size() ; i++){
			
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
				//cout<<param_list[i]->getDeclarationType()<<endl;
			}
			param_list.clear();
			s->get_isFunction()->set_return_type((yyvsp[-5].symbolinfo)->getName());
		} 
		else{
			int num=s->get_isFunction()->get_number_of_parameter();
			
			if(num!=param_list.size()){
			
				errors++;
				appendLogError(lines,"Invalid number of parameters ");
			
			}else{
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for( int i=0;i < param_list.size(); i++){
					if(param_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						appendLogError(lines,"Type Mismatch ! Expected "+param_list[i]->getDeclarationType()+" Found "+ para_type[i] +" for "+to_string(i)+"th parameter");
						break;
					}
				}
				if(s->get_isFunction()->get_return_type()!=(yyvsp[-5].symbolinfo)->getName()){
					errors++;
					appendLogError(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + (yyvsp[-5].symbolinfo)->getName());
				}
				param_list.clear();
			}
		}

		(yyval.symbolinfo)->setName((yyvsp[-5].symbolinfo)->getName()+" "+(yyvsp[-4].symbolinfo)->getName()+"("+(yyvsp[-2].symbolinfo)->getName()+");");

	}
#line 1539 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 174 "1605103.y" /* yacc.c:1646  */
    {

			(yyval.symbolinfo) = new SymbolInfo();
			
			parserLog(lines,"func_declaration->type_specifier ID LPAREN RPAREN SEMICOLON");
			parserLog((yyvsp[-4].symbolinfo)->getName()+" "+(yyvsp[-3].symbolinfo)->getName()+"();");
			
			SymbolInfo *s=symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName());
			
			if(s == nullptr){

				//TODO : Function
				symbolTable->insert(SymbolInfo((yyvsp[-3].symbolinfo)->getName(),"ID","Function"));
				s=symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName());
				s->set_isFunction();
				s->get_isFunction()->set_return_type((yyvsp[-4].symbolinfo)->getName());
			
			}
			else{

				if(s->get_isFunction()->get_number_of_parameter()!=0){
					errors++;
					appendLogError(lines,"Invalid number of parameters ");
		
				}
				if(s->get_isFunction()->get_return_type()!=(yyvsp[-4].symbolinfo)->getName()){
					errors++;
					appendLogError(lines," Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " +(yyvsp[-4].symbolinfo)->getName());
				}

			}
			(yyval.symbolinfo)->setName((yyvsp[-4].symbolinfo)->getName()+" "+(yyvsp[-3].symbolinfo)->getName()+"();");
	}
#line 1577 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 209 "1605103.y" /* yacc.c:1646  */
    {
		
		(yyval.symbolinfo)=new SymbolInfo(); 
		SymbolInfo *s=symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName()); 

		if(s!=0){ 
			if(s->get_isFunction()->get_isdefined()==0){
				int num = s->get_isFunction()->get_number_of_parameter();
				if(num != param_list.size()){
					errors++;
					appendLogError(lines," Invalid number of parameters ");
				} else{
					vector<string>para_type=s->get_isFunction()->get_paratype();
					for(int i=0;i<param_list.size();i++){
						if(param_list[i]->getDeclarationType()!=para_type[i]){
							errors++;
							appendLogError(lines,"Type Mismatch Expected! "+param_list[i]->getDeclarationType()+" Found "+para_type[i]+" for "+ to_string(i)+"th "+"Parameter");
							break;
						}
					}
					if(s->get_isFunction()->get_return_type() != (yyvsp[-4].symbolinfo)->getName()){
						errors++;
						appendLogError(lines,"Return Type Mismatch ! Expected "+s->get_isFunction()->get_return_type()+ " Found " + (yyvsp[-4].symbolinfo)->getName());
					}	
				}
				s->get_isFunction()->set_isdefined();
			}
			else{
				errors++;
				appendLogError(lines,"Multiple defination of function "+(yyvsp[-3].symbolinfo)->getName());
			}
		}
		else{ 
			//cout<<param_list.size()<<" "<<lines<<endl;
			symbolTable->insert(SymbolInfo((yyvsp[-3].symbolinfo)->getName(),"ID","Function"));
			s=symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName());
			s->set_isFunction();
			//cout<<s->get_isFunction()->get_number_of_parameter()<<endl;
			s->get_isFunction()->set_isdefined();
			
			for(int i=0;i<param_list.size();i++){
				s->get_isFunction()->add_number_of_parameter(param_list[i]->getName(),param_list[i]->getDeclarationType());
				//	cout<<param_list[i]->getDeclarationType()<<param_list[i]->getName()<<endl;
			}
			//	param_list.clear();
			s->get_isFunction()->set_return_type((yyvsp[-4].symbolinfo)->getName());
			//cout<<lines<<" "<<s->get_isFunction()->get_return_type()<<endl;
		}

	}
#line 1632 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 259 "1605103.y" /* yacc.c:1646  */
    {
		parserLog("func_definition->type_specifier ID LPAREN parameter_list RPAREN compound_statement ");
		parserLog((yyvsp[-6].symbolinfo)->getName()+" "+(yyvsp[-5].symbolinfo)->getName()+"("
		+(yyvsp[-3].symbolinfo)->getName()+")"+ (yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[-6].symbolinfo)->getName()+" "+(yyvsp[-5].symbolinfo)->getName()+"("+(yyvsp[-3].symbolinfo)->getName()+")"+(yyvsp[0].symbolinfo)->getName());
	}
#line 1643 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 265 "1605103.y" /* yacc.c:1646  */
    { 
		(yyval.symbolinfo)=new SymbolInfo();
		SymbolInfo *s = symbolTable->lookUp((yyvsp[-2].symbolinfo)->getName());
		if(s==0){
			symbolTable->insert(SymbolInfo((yyvsp[-2].symbolinfo)->getName(),"ID","Function"));
			s = symbolTable->lookUp((yyvsp[-2].symbolinfo)->getName());
			s -> set_isFunction();
			s -> get_isFunction()->set_isdefined();
			s -> get_isFunction()->set_return_type((yyvsp[-3].symbolinfo)->getName());
			//	cout<<lines<<" "<<s->get_isFunction()->get_return_type()<<endl;
		}
		else if(s->get_isFunction()->get_isdefined()==0){
			if(s->get_isFunction()->get_number_of_parameter()!=0){
				errors++;
				appendLogError(lines," Invalid number of parameters ");
			}
			if(s->get_isFunction()->get_return_type()!=(yyvsp[-3].symbolinfo)->getName()){
				errors++;
				appendLogError(lines,"Return Type Mismatch ");
			}

			s->get_isFunction()->set_isdefined();
		}
		else{
			errors++;
			appendLogError(lines,"Multiple defination of function "+(yyvsp[-2].symbolinfo)->getName());
		}
											
		(yyvsp[-3].symbolinfo)->setName((yyvsp[-3].symbolinfo)->getName()+" "+(yyvsp[-2].symbolinfo)->getName()+"()");
	}
#line 1678 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 294 "1605103.y" /* yacc.c:1646  */
    {
		parserLog("func_definition->type_specifier ID LPAREN RPAREN compound_statement");
		parserLog((yyvsp[-5].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[-5].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
			
	}
#line 1689 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 306 "1605103.y" /* yacc.c:1646  */
    {
		
		(yyval.symbolinfo) = new SymbolInfo();
		parserLog(lines,"parameter_list -> parameter_list COMMA type_specifier ID");
		parserLog((yyvsp[-3].symbolinfo)->getName()+","+(yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName());
		
		param_list.push_back(new SymbolInfo((yyvsp[0].symbolinfo)->getName(),"ID",(yyvsp[-1].symbolinfo)->getName()));
		(yyval.symbolinfo)->setName((yyvsp[-3].symbolinfo)->getName()+","+(yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName());
	}
#line 1703 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 315 "1605103.y" /* yacc.c:1646  */
    {
		
		(yyval.symbolinfo) = new SymbolInfo();
		parserLog(lines,"parameter_list->parameter_list COMMA type_specifier");
		parserLog((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());
		
		param_list.push_back(new SymbolInfo("","ID",(yyvsp[0].symbolinfo)->getName()));
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());

	}
#line 1718 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 325 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"parameter_list -> type_specifier ID");
		parserLog((yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName());
		param_list.push_back(new SymbolInfo((yyvsp[0].symbolinfo)->getName(),"ID",(yyvsp[-1].symbolinfo)->getName()));
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName());
	}
#line 1730 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 332 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"parameter_list -> type_specifier");
		parserLog((yyvsp[0].symbolinfo)->getName());
		param_list.push_back(new SymbolInfo("","ID",(yyvsp[0].symbolinfo)->getName()));
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()+" ");
	}
#line 1742 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 343 "1605103.y" /* yacc.c:1646  */
    {
	symbolTable->enterScope();
	//	cout<<lines<<" "<<param_list.size()<<endl;
	for(int i=0;i<param_list.size();i++)
		symbolTable->insert(SymbolInfo(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType()));
		//symbolTable->printcurrent();
	param_list.clear();
	}
#line 1755 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 350 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"compound_statement -> LCURL statements RCURL");
		parserLog("{$<symbolinfo>3->getName()}");
		(yyval.symbolinfo)->setName("{\n"+(yyvsp[-1].symbolinfo)->getName()+"\n}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
#line 1768 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 358 "1605103.y" /* yacc.c:1646  */
    {
		symbolTable->enterScope();
		for(int i=0;i<param_list.size();i++)
			symbolTable->insert(SymbolInfo(param_list[i]->getName(),"ID",param_list[i]->getDeclarationType()));
		//symbolTable->printcurrent();
		param_list.clear();
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"compound_statement->LCURL RCURL");
		parserLog("{}");
		(yyval.symbolinfo)->setName("{}");
		symbolTable->printAllScopeTables();
		symbolTable->exitScope();
	}
#line 1786 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 374 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"var_declaration -> type_specifier declaration_list SEMICOLON");
		parserLog((yyvsp[-2].symbolinfo)->getName()+" "+(yyvsp[-1].symbolinfo)->getName()+";");
		if((yyvsp[-2].symbolinfo)->getName()=="void "){
			errors++;
			appendLogError(lines,"Cannot Declare void Type");																
		}
		else{
			for(int i=0;i < declaration_list.size() ; i++){
				if(symbolTable->lookUpLocal(declaration_list[i]->getName())){
					errors++;
					appendLogError(lines," Multiple Declaration of " + declaration_list[i]->getName());
					continue;
				}
				if(declaration_list[i]->getType().size()==3){
					declaration_list[i]->setType(declaration_list[i]->getType().substr(0,declaration_list[i]->getType().size () - 1));
					symbolTable->insert(SymbolInfo(declaration_list[i]->getName(),declaration_list[i]->getType(),(yyvsp[-2].symbolinfo)->getName()+"array"));
				} else symbolTable->insert(SymbolInfo(declaration_list[i]->getName(),declaration_list[i]->getType(),(yyvsp[-2].symbolinfo)->getName()));
			}
		}
		declaration_list.clear();
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+" "+(yyvsp[-1].symbolinfo)->getName()+";");
	}
#line 1815 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 401 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"type_specifier -> INT");
		parserLog("int ");
		(yyval.symbolinfo)->setName("int ");
	}
#line 1826 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 407 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"type_specifier -> FLOAT");
		parserLog("float ");
		(yyval.symbolinfo)->setName("float ");
	}
#line 1837 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 413 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"type_specifier -> VOID");
		parserLog("void ");
		(yyval.symbolinfo)->setName("void ");
	}
#line 1848 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 423 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"declaration_list -> declaration_list COMMA ID");
		parserLog((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());
		declaration_list.push_back(new SymbolInfo((yyvsp[0].symbolinfo)->getName(),"ID"));
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());
	}
#line 1860 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 430 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"declaration_list -> declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		parserLog((yyvsp[-5].symbolinfo)->getName()+","+(yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");
		
		declaration_list.push_back(new SymbolInfo((yyvsp[-3].symbolinfo)->getName(),"IDa")); //TODO : why IDa ?
		(yyval.symbolinfo)->setName((yyvsp[-5].symbolinfo)->getName()+","+(yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");
	}
#line 1873 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 438 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"declaration_list -> ID");
		parserLog((yyvsp[0].symbolinfo)->getName());
		declaration_list.push_back(new SymbolInfo((yyvsp[0].symbolinfo)->getName(),"ID"));
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());
	}
#line 1885 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 445 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"declaration_list -> ID LTHIRD CONST_INT RTHIRD");
		parserLog((yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");
		declaration_list.push_back(new SymbolInfo((yyvsp[-3].symbolinfo)->getName(),"IDa"));
		(yyval.symbolinfo)->setName((yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");
	}
#line 1897 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 455 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statements -> statement");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());
	}
#line 1908 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 461 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statements -> statements statement");
		parserLog((yyvsp[-1].symbolinfo)->getName()+" "+(yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+"\n"+(yyvsp[0].symbolinfo)->getName()); 
	}
#line 1919 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 469 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo) = new SymbolInfo();
		parserLog(lines,"statement -> var_declaration");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
	}
#line 1930 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 475 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement -> expression_statement");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
	}
#line 1941 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 481 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement -> compound_statement");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
	}
#line 1952 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 487 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement -> FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		parserLog("for("+(yyvsp[-4].symbolinfo)->getName()+" "+(yyvsp[-3].symbolinfo)->getName()+" "+
		(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[0].symbolinfo)->getName());
		
		if((yyvsp[-4].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setName("for("+(yyvsp[-4].symbolinfo)->getName()+(yyvsp[-3].symbolinfo)->getName()+(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[-2].symbolinfo)->getName()); 
	}
#line 1970 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 500 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement->IF LPAREN expression RPAREN statement");
		parserLog("if("+(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[0].symbolinfo)->getName());
		
		if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines,"Type Mismatch! Variable Cannot Be Declared void ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setName("if("+(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[0].symbolinfo)->getName()); 

	}
#line 1988 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 513 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement->IF LPAREN expression RPAREN statement ELSE statement");
		parserLog("if("+(yyvsp[-4].symbolinfo)->getName()+")\n"+(yyvsp[-2].symbolinfo)->getName()+"else\n"+(yyvsp[0].symbolinfo)->getName());
		if((yyvsp[-4].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			//$<symbolinfo>$->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setName("if("+(yyvsp[-4].symbolinfo)->getName()+")\n"+(yyvsp[-2].symbolinfo)->getName()+" else \n"+(yyvsp[0].symbolinfo)->getName()); 
	}
#line 2004 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 525 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement->WHILE LPAREN expression RPAREN statement");
		parserLog("while("+(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[0].symbolinfo)->getName());

		if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			//	$<symbolinfo>$->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setName("while("+(yyvsp[-2].symbolinfo)->getName()+")\n"+(yyvsp[0].symbolinfo)->getName()); 
	}
#line 2021 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 537 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement->PRINTLN LPAREN ID RPAREN SEMICOLON");
		parserLog("\n ("+(yyvsp[-2].symbolinfo)->getName()+")");
		(yyval.symbolinfo)->setName("\n("+(yyvsp[-2].symbolinfo)->getName()+")"); 
	}
#line 2032 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 543 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"statement->RETURN expression SEMICOLON");
		parserLog("return "+(yyvsp[-1].symbolinfo)->getName());
		if((yyvsp[-1].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setName("return "+(yyvsp[-1].symbolinfo)->getName()+";"); 
	}
#line 2048 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 556 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"expression_statement->SEMICOLON");
		parserLog(";"); 
		(yyval.symbolinfo)->setName(";"); 
	}
#line 2059 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 562 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"expression_statement->expression SEMICOLON");
		//TODO :Uncomment? parserLog($<symbolinfo>1->getName()+";")
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+";"); 
	}
#line 2070 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 570 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"variable->ID");
		parserLog((yyvsp[0].symbolinfo)->getName());
		if(symbolTable->lookUp((yyvsp[0].symbolinfo)->getName())==0){
			errors++;
			appendLogError(lines," Undeclared Variable: "+(yyvsp[0].symbolinfo)->getName());
		}
		else if(symbolTable->lookUp((yyvsp[0].symbolinfo)->getName())->getDeclarationType()=="int array" || symbolTable->lookUp((yyvsp[0].symbolinfo)->getName())->getDeclarationType()=="float array"){
			errors++;
			appendLogError(lines," Not an array: "+(yyvsp[0].symbolinfo)->getName());
		}
		if(symbolTable->lookUp((yyvsp[0].symbolinfo)->getName())!=0){
			//cout<<lines<<" "<<$<symbolinfo>1->getName()<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			(yyval.symbolinfo)->setDeclarationType(symbolTable->lookUp((yyvsp[0].symbolinfo)->getName())->getDeclarationType()); 
		}
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
												
	}
#line 2094 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 589 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"variable->ID LTHIRD expression RTHIRD");
		parserLog((yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");
		if(symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())==0){
			errors++;
			appendLogError(lines,"Undeclared Variable :"+ (yyvsp[-3].symbolinfo)->getName());
		}
		//cout<<lines<<" "<<$<symbolinfo>3->getDeclarationType()<<endl;
		if((yyvsp[-1].symbolinfo)->getDeclarationType()=="float "||(yyvsp[-1].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Non-integer Array Index  ");
		}
		if(symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())!=0){
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<endl;
			if(symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())->getDeclarationType()!="int array" && symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())->getDeclarationType()!="float array"){
				errors++;
				appendLogError(lines," Type Mismatch ");	
			}
			if(symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())->getDeclarationType()=="int array"){
				(yyvsp[-3].symbolinfo)->setDeclarationType("int ");
			}
			if(symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName())->getDeclarationType()=="float array"){
				(yyvsp[-3].symbolinfo)->setDeclarationType("float ");
			}
			(yyval.symbolinfo)->setDeclarationType((yyvsp[-3].symbolinfo)->getDeclarationType()); 
			
		}
		(yyval.symbolinfo)->setName((yyvsp[-3].symbolinfo)->getName()+"["+(yyvsp[-1].symbolinfo)->getName()+"]");  
		
	}
#line 2130 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 621 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"expression->logic_expression");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
	}
#line 2142 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 628 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"expression->variable ASSIGNOP logic_expression");
	   	parserLog((yyvsp[-2].symbolinfo)->getName()+"="+(yyvsp[0].symbolinfo)->getName());
		
		if((yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}else if(symbolTable->lookUp((yyvsp[-2].symbolinfo)->getName())!=0) {
			//cout<<lines<<" "<<symbolTable->lookUp($<symbolinfo>1->getName())->getDeclarationType()<<""<<$<symbolinfo>3->getDeclarationType()<<endl;
			if(symbolTable->lookUp((yyvsp[-2].symbolinfo)->getName())->getDeclarationType()!=(yyvsp[0].symbolinfo)->getDeclarationType()){
				errors++;
				appendLogError(lines,"Type Mismatch ");
			}
		}
		(yyval.symbolinfo)->setDeclarationType((yyvsp[-2].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+"="+(yyvsp[0].symbolinfo)->getName());  

	}
#line 2167 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 649 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"logic_expression->rel_expression");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
	}
#line 2179 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 656 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"logic_expression->rel_expression LOGICOP rel_expression");
		parserLog((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
		
		if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}
		(yyval.symbolinfo)->setDeclarationType("int "); 
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());  

	}
#line 2198 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 672 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"rel_expression->simple_expression");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
	}
#line 2210 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 679 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
			parserLog(lines,"rel_expression->simple_expression RELOP simple_expression");
			parserLog((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
			if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch! ");
				(yyval.symbolinfo)->setDeclarationType("int "); 
			}
			(yyval.symbolinfo)->setDeclarationType("int "); 
			
			(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());  
		}
#line 2228 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 694 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"simple_expression->term");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());  
	}
#line 2240 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 701 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo(); 
		parserLog(lines,"simple_expression->simple_expression ADDOP term");
		parserLog((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
		//cout<<$<symbolinfo>3->getDeclarationType()<<endl;
		if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}else if((yyvsp[-2].symbolinfo)->getDeclarationType()=="float " ||(yyvsp[0].symbolinfo)->getDeclarationType()=="float ")
			(yyval.symbolinfo)->setDeclarationType("float ");
			else  (yyval.symbolinfo)->setDeclarationType("int ");
			(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());  
	}
#line 2259 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 717 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"term->unary_expression");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
	}
#line 2271 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 724 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"term->term MULOP unary_expression");
		parserLog((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
		if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}else if((yyvsp[-1].symbolinfo)->getName()=="%"){
			if((yyvsp[-2].symbolinfo)->getDeclarationType()!="int " ||(yyvsp[0].symbolinfo)->getDeclarationType()!="int "){
			errors++;
			appendLogError(lines," Integer operand on modulus operator  ");

			} 
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}
		else if((yyvsp[-1].symbolinfo)->getName()=="/"){
			if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch ");
				(yyval.symbolinfo)->setDeclarationType("int "); 
			}
			else  if((yyvsp[-2].symbolinfo)->getDeclarationType()=="int " && (yyvsp[0].symbolinfo)->getDeclarationType()=="int ")(yyval.symbolinfo)->setDeclarationType("int "); 
			else (yyval.symbolinfo)->setDeclarationType("float "); 
			
		}
		else{
			if((yyvsp[-2].symbolinfo)->getDeclarationType()=="void "||(yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
				errors++;
				appendLogError(lines," Type Mismatch!");
				(yyval.symbolinfo)->setDeclarationType("int "); 
			}
			else  if((yyvsp[-2].symbolinfo)->getDeclarationType()=="float " || (yyvsp[0].symbolinfo)->getDeclarationType()=="float ") (yyval.symbolinfo)->setDeclarationType("float "); 
			else (yyval.symbolinfo)->setDeclarationType("int "); 
		}
	
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+(yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName()); 
								
	}
#line 2315 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 765 "1605103.y" /* yacc.c:1646  */
    {
	(yyval.symbolinfo)=new SymbolInfo();
	parserLog(lines,"unary_expression->ADDOP unary_expression");
	parserLog((yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName());
	if((yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
		errors++;
		appendLogError(lines," Type Mismatch ");
		(yyval.symbolinfo)->setDeclarationType("int "); 
	}else 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 	
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+(yyvsp[0].symbolinfo)->getName()); 

	}
#line 2333 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 778 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"unary_expression->NOT unary_expression");
		parserLog("!"+(yyvsp[0].symbolinfo)->getName()); 
		if((yyvsp[0].symbolinfo)->getDeclarationType()=="void "){
			errors++;
			appendLogError(lines," Type Mismatch ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}else 
			(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType());  
			(yyval.symbolinfo)->setName("!"+(yyvsp[0].symbolinfo)->getName()); 
	}
#line 2350 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 790 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"unary_expression->factor");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
				
	}
#line 2364 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 801 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->variable");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setDeclarationType((yyvsp[0].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
	}
#line 2376 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 808 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->ID LPAREN argument_list RPAREN");
		parserLog((yyvsp[-3].symbolinfo)->getName()+"("+(yyvsp[-1].symbolinfo)->getName()+")");
		SymbolInfo* s=symbolTable->lookUp((yyvsp[-3].symbolinfo)->getName());
		if(s==0){
			errors++;
			appendLogError(lines," Undefined Function ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}
		else if(s->get_isFunction()==0){
			errors++;
			appendLogError(lines," Not A Function ");
			(yyval.symbolinfo)->setDeclarationType("int "); 
		}
		else {
			if(s->get_isFunction()->get_isdefined()==0){
				errors++;
				appendLogError(lines," Undeclared Function ");
			}
			int num=s->get_isFunction()->get_number_of_parameter();
			//cout<<lines<<" "<<arg_list.size()<<endl;
			(yyval.symbolinfo)->setDeclarationType(s->get_isFunction()->get_return_type());
			if(num!=arg_list.size()){
				errors++;
				appendLogError(lines," Invalid number of arguments ");
			}
			else{
				//cout<<s->get_isFunction()->get_return_type()<<endl;
				vector<string>param_list=s->get_isFunction()->get_paralist();
				vector<string>para_type=s->get_isFunction()->get_paratype();
				for(int i=0;i<arg_list.size();i++){
					if(arg_list[i]->getDeclarationType()!=para_type[i]){
						errors++;
						appendLogError(lines,"Type Mismatch ");
						break;
					}
				}

			}
		}
		arg_list.clear();
		//cout<<lines<<" "<<$<symbolinfo>$->getDeclarationType()<<endl;
		(yyval.symbolinfo)->setName((yyvsp[-3].symbolinfo)->getName()+"("+(yyvsp[-1].symbolinfo)->getName()+")"); 
	}
#line 2426 "y.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 853 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->LPAREN expression RPAREN");
		parserLog("("+(yyvsp[-1].symbolinfo)->getName()+")"); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[-1].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName("("+(yyvsp[-1].symbolinfo)->getName()+")"); 
	}
#line 2438 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 860 "1605103.y" /* yacc.c:1646  */
    { 
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->CONST_INT");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setDeclarationType("int "); 	
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
			
	}
#line 2451 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 868 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->CONST_FLOAT");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		(yyval.symbolinfo)->setDeclarationType("float "); 	
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName()); 
				
	}
#line 2464 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 876 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->variable INCOP");
		parserLog((yyvsp[-1].symbolinfo)->getName()+"++"); 
		(yyval.symbolinfo)->setDeclarationType((yyvsp[-1].symbolinfo)->getDeclarationType());
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+"++"); 
					 
	}
#line 2477 "y.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 884 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"factor->variable DECOP");
		parserLog((yyvsp[-1].symbolinfo)->getName()+"--");
		(yyval.symbolinfo)->setDeclarationType((yyvsp[-1].symbolinfo)->getDeclarationType()); 
		(yyval.symbolinfo)->setName((yyvsp[-1].symbolinfo)->getName()+"--"); 
					 
	}
#line 2490 "y.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 894 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"argument_list->arguments");
		parserLog((yyvsp[0].symbolinfo)->getName());
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());
	}
#line 2501 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 900 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"argument_list-> ");
		(yyval.symbolinfo)->setName("");}
#line 2510 "y.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 906 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"arguments->arguments COMMA logic_expression ");
		parserLog((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());
		arg_list.push_back((yyvsp[0].symbolinfo));
		(yyval.symbolinfo)->setName((yyvsp[-2].symbolinfo)->getName()+","+(yyvsp[0].symbolinfo)->getName());
	}
#line 2522 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 913 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.symbolinfo)=new SymbolInfo();
		parserLog(lines,"arguments->logic_expression");
		parserLog((yyvsp[0].symbolinfo)->getName()); 
		arg_list.push_back(new SymbolInfo((yyvsp[0].symbolinfo)->getName(),(yyvsp[0].symbolinfo)->getType(),(yyvsp[0].symbolinfo)->getDeclarationType()));
		// cout<<$<symbolinfo>1->getDeclarationType()<<endl;
		(yyval.symbolinfo)->setName((yyvsp[0].symbolinfo)->getName());					
	}
#line 2535 "y.tab.c" /* yacc.c:1646  */
    break;


#line 2539 "y.tab.c" /* yacc.c:1646  */
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
      yyerror (YY_("syntax error"));
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
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



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
                      yytoken, &yylval);
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


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


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
  yyerror (YY_("memory exhausted"));
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
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
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
#line 922 "1605103.y" /* yacc.c:1906  */




int main(int argc,char *argv[])
{

	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		return 0;
	}
	yyin=fp;
	symbolTable->enterScope();
	yyparse();
	parserLog(" Symbol symbolTable : ");
	symbolTable->printAllScopeTables();
	parserLog("Total Lines :"+lines);
	parserLog("Total Errors :"+errors);
	// appendLogError("Total Errors : %d,errors);

	fclose(fp);
	
	return 0;
}

