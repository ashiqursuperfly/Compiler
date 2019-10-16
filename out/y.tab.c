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
#include "../headers/1605103_SymbolTable.h"
#include "../headers/1605103_AsmCodeGenerator.h"
//#define Util::appendLogError Util::appendLogError
//#define LOG Util::parserLog
#define TOKEN new SymbolInfo()
void optimize(string asmFile);

using namespace std;
int yyparse(void);
int yylex(void);

int lines=1,errors=0;
FILE *fp;
extern FILE *yyin;
string currentFile;
bool DEBUG = false;
bool isParsingSuccessful = true;

SymbolTable *symbolTable = new SymbolTable(100);
AsmCodeGenerator asmGen;

vector<pair<string,int>> possiblyUndefinedFunctions;
vector<SymbolInfo*>paramList,declarationList,argList;


void yyerror(const char *s){
	errors++;
	cerr<<errors<<":"<<s<<" at Line:"<<lines<<endl;
}


#line 100 "y.tab.c" /* yacc.c:339  */

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
# define YYERROR_VERBOSE 1
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
    CONST_INT = 269,
    CONST_FLOAT = 270,
    CONST_CHAR = 271,
    RETURN = 272,
    SWITCH = 273,
    CASE = 274,
    DEFAULT = 275,
    CONTINUE = 276,
    STRING = 277,
    ID = 278,
    PRINTLN = 279,
    LPAREN = 280,
    RPAREN = 281,
    LCURL = 282,
    RCURL = 283,
    LTHIRD = 284,
    RTHIRD = 285,
    COMMA = 286,
    SEMICOLON = 287,
    ADDOP = 288,
    MULOP = 289,
    INCOP = 290,
    RELOP = 291,
    ASSIGNOP = 292,
    LOGICOP = 293,
    BITOP = 294,
    NOT = 295,
    DECOP = 296,
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
#define CONST_INT 269
#define CONST_FLOAT 270
#define CONST_CHAR 271
#define RETURN 272
#define SWITCH 273
#define CASE 274
#define DEFAULT 275
#define CONTINUE 276
#define STRING 277
#define ID 278
#define PRINTLN 279
#define LPAREN 280
#define RPAREN 281
#define LCURL 282
#define RCURL 283
#define LTHIRD 284
#define RTHIRD 285
#define COMMA 286
#define SEMICOLON 287
#define ADDOP 288
#define MULOP 289
#define INCOP 290
#define RELOP 291
#define ASSIGNOP 292
#define LOGICOP 293
#define BITOP 294
#define NOT 295
#define DECOP 296
#define LOWER_THAN_ELSE 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 49 "1605103.y" /* yacc.c:355  */

	SymbolInfo* Symbol;

#line 228 "y.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 245 "y.tab.c" /* yacc.c:358  */

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


#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

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
# define YYCOPY_NEEDED 1
#endif


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
#define YYLAST   158

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  43
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  27
/* YYNRULES -- Number of rules.  */
#define YYNRULES  74
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  128

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
       0,    57,    57,    75,    83,    97,   110,   119,   131,   192,
     196,   225,   231,   231,   341,   341,   412,   421,   429,   438,
     447,   447,   471,   492,   526,   532,   538,   544,   552,   566,
     574,   581,   593,   599,   608,   614,   622,   632,   663,   689,
     714,   742,   761,   766,   785,   790,   796,   804,   807,   811,
     835,   888,   900,   939,   949,   982,   991,  1055,  1065,  1102,
    1117,  1197,  1222,  1243,  1252,  1265,  1332,  1343,  1359,  1372,
    1403,  1432,  1439,  1444,  1456
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IF", "ELSE", "FOR", "WHILE", "DO",
  "BREAK", "INT", "FLOAT", "CHAR", "DOUBLE", "VOID", "CONST_INT",
  "CONST_FLOAT", "CONST_CHAR", "RETURN", "SWITCH", "CASE", "DEFAULT",
  "CONTINUE", "STRING", "ID", "PRINTLN", "LPAREN", "RPAREN", "LCURL",
  "RCURL", "LTHIRD", "RTHIRD", "COMMA", "SEMICOLON", "ADDOP", "MULOP",
  "INCOP", "RELOP", "ASSIGNOP", "LOGICOP", "BITOP", "NOT", "DECOP",
  "LOWER_THAN_ELSE", "$accept", "start", "program", "unit",
  "func_declaration", "func_definition", "@1", "@2", "parameter_list",
  "compound_statement", "$@3", "var_declaration", "type_specifier",
  "declarationList", "statements", "statement", "expression_statement",
  "variable", "expression", "logic_expression", "rel_expression",
  "simple_expression", "term", "unary_expression", "factor",
  "argument_list", "arguments", YY_NULLPTR
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

#define YYPACT_NINF -75

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-75)))

#define YYTABLE_NINF -15

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      48,   -75,   -75,   -75,    35,    48,   -75,   -75,   -75,   -75,
      37,   -75,   -75,   -11,     2,   107,    59,   -75,    49,   -75,
       4,   -16,    60,    54,    71,   -75,   -75,    79,     5,    48,
     -75,   -75,    95,    86,   -75,   -75,   -75,    79,    96,    88,
     -75,    98,   -75,   -75,   -75,   -75,    99,   102,   104,   -75,
     -75,    62,    40,   109,    62,   -75,    62,    62,   -75,   -75,
     112,    65,   -75,   -75,    91,    19,   -75,   101,    58,   103,
     -75,   -75,    62,    15,    62,    22,    62,    62,   113,   114,
      18,   -75,   -75,   115,   -75,   -75,   -75,    62,   -75,   -75,
     -75,    62,    62,    62,    62,   116,    15,   117,   -75,   -75,
     -75,   119,   110,   118,   120,   -75,   -75,   -75,   103,   121,
     -75,    98,    62,    98,   -75,    62,   -75,    24,   143,   123,
     -75,   -75,   -75,   -75,    98,    98,   -75,   -75
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,    25,    26,    27,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    30,     0,     0,     0,    24,     0,    23,
       0,     0,    19,     0,    28,    11,    10,     0,     0,     0,
      18,    31,     0,    20,    15,     9,     8,     0,    17,     0,
      22,     0,    13,    16,    29,    47,     0,     0,     0,    67,
      68,     0,    49,     0,     0,    45,     0,     0,    36,    34,
       0,     0,    32,    35,    64,     0,    51,    53,    55,    57,
      59,    63,     0,     0,     0,     0,    72,     0,     0,     0,
      64,    61,    62,    30,    21,    33,    69,     0,    70,    48,
      46,     0,     0,     0,     0,     0,     0,     0,    44,    43,
      74,     0,    71,     0,     0,    66,    52,    54,    58,    56,
      60,     0,     0,     0,    65,     0,    50,     0,    38,     0,
      40,    73,    42,    41,     0,     0,    39,    37
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -75,   -75,   -75,   145,   -75,   -75,   -75,   -75,   -75,   -20,
     -75,    21,    81,   -75,   -75,   -61,   -54,   -48,   -50,   -74,
      61,    63,    66,   -45,   -75,   -75,   -75
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,     7,     8,    37,    27,    21,    58,
      41,    59,    60,    14,    61,    62,    63,    64,    65,    66,
      67,    68,    69,    70,    71,   101,   102
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      85,    75,   100,    17,    79,    25,    35,    34,    80,    80,
      28,    81,    82,   106,    15,    29,    45,    42,    16,    96,
      89,     9,    95,    98,    97,   122,     9,   103,    80,    49,
      50,   -14,   -12,    18,    19,    11,    26,    36,    52,    80,
      54,   121,   112,    80,    80,    80,    80,    55,    56,   110,
     118,    90,   120,    86,    99,    57,   123,     1,     2,    88,
      13,     3,   119,   126,   127,    76,    45,    80,    46,    77,
      47,    48,    24,    23,     1,     2,    49,    50,     3,    49,
      50,    10,    51,    30,    31,    52,    10,    54,    52,    53,
      54,    92,    33,    84,    93,    56,    22,    55,    56,    45,
      32,    46,    57,    47,    48,    57,    33,     1,     2,    39,
      38,     3,    49,    50,    40,    51,     1,     2,    44,    43,
       3,    52,    53,    54,    72,    33,    86,    73,    87,    74,
      55,    56,    88,    20,    78,    83,   104,    94,    57,    91,
     105,   115,   111,   113,    16,   114,   117,   124,   116,   125,
      12,     0,   107,     0,    92,     0,   109,     0,   108
};

static const yytype_int8 yycheck[] =
{
      61,    51,    76,     1,    54,     1,     1,    27,    56,    57,
      26,    56,    57,    87,    25,    31,     1,    37,    29,    73,
       1,     0,    72,     1,    74,     1,     5,    77,    76,    14,
      15,    27,    27,    31,    32,     0,    32,    32,    23,    87,
      25,   115,    96,    91,    92,    93,    94,    32,    33,    94,
     111,    32,   113,    35,    32,    40,    32,     9,    10,    41,
      23,    13,   112,   124,   125,    25,     1,   115,     3,    29,
       5,     6,    23,    14,     9,    10,    14,    15,    13,    14,
      15,     0,    17,    23,    30,    23,     5,    25,    23,    24,
      25,    33,    27,    28,    36,    33,    15,    32,    33,     1,
      29,     3,    40,     5,     6,    40,    27,     9,    10,    14,
      29,    13,    14,    15,    28,    17,     9,    10,    30,    23,
      13,    23,    24,    25,    25,    27,    35,    25,    37,    25,
      32,    33,    41,    26,    25,    23,    23,    34,    40,    38,
      26,    31,    26,    26,    29,    26,    26,     4,    30,    26,
       5,    -1,    91,    -1,    33,    -1,    93,    -1,    92
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     9,    10,    13,    44,    45,    46,    47,    48,    54,
      55,     0,    46,    23,    56,    25,    29,     1,    31,    32,
      26,    51,    55,    14,    23,     1,    32,    50,    26,    31,
      23,    30,    29,    27,    52,     1,    32,    49,    55,    14,
      28,    53,    52,    23,    30,     1,     3,     5,     6,    14,
      15,    17,    23,    24,    25,    32,    33,    40,    52,    54,
      55,    57,    58,    59,    60,    61,    62,    63,    64,    65,
      66,    67,    25,    25,    25,    61,    25,    29,    25,    61,
      60,    66,    66,    23,    28,    58,    35,    37,    41,     1,
      32,    38,    33,    36,    34,    61,    59,    61,     1,    32,
      62,    68,    69,    61,    23,    26,    62,    63,    65,    64,
      66,    26,    59,    26,    26,    31,    30,    26,    58,    61,
      58,    62,     1,    32,     4,    26,    58,    58
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    43,    44,    45,    45,    46,    46,    46,    47,    47,
      47,    47,    49,    48,    50,    48,    51,    51,    51,    51,
      53,    52,    52,    54,    54,    55,    55,    55,    56,    56,
      56,    56,    57,    57,    58,    58,    58,    58,    58,    58,
      58,    58,    58,    58,    58,    59,    59,    59,    59,    60,
      60,    61,    61,    62,    62,    63,    63,    64,    64,    65,
      65,    66,    66,    66,    67,    67,    67,    67,    67,    67,
      67,    68,    68,    69,    69
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     6,
       5,     5,     0,     7,     0,     6,     4,     3,     2,     1,
       0,     4,     2,     3,     3,     1,     1,     1,     3,     6,
       1,     4,     1,     2,     1,     1,     1,     7,     5,     7,
       5,     5,     5,     3,     3,     1,     2,     1,     2,     1,
       4,     1,     3,     1,     3,     1,     3,     1,     3,     1,
       3,     2,     2,     1,     1,     4,     3,     1,     1,     2,
       2,     1,     0,     3,     1
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
      YY_LAC_DISCARD ("YYBACKUP");                              \
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

/* Given a state stack such that *YYBOTTOM is its bottom, such that
   *YYTOP is either its top or is YYTOP_EMPTY to indicate an empty
   stack, and such that *YYCAPACITY is the maximum number of elements it
   can hold without a reallocation, make sure there is enough room to
   store YYADD more elements.  If not, allocate a new stack using
   YYSTACK_ALLOC, copy the existing elements, and adjust *YYBOTTOM,
   *YYTOP, and *YYCAPACITY to reflect the new capacity and memory
   location.  If *YYBOTTOM != YYBOTTOM_NO_FREE, then free the old stack
   using YYSTACK_FREE.  Return 0 if successful or if no reallocation is
   required.  Return 1 if memory is exhausted.  */
static int
yy_lac_stack_realloc (YYSIZE_T *yycapacity, YYSIZE_T yyadd,
#if YYDEBUG
                      char const *yydebug_prefix,
                      char const *yydebug_suffix,
#endif
                      yytype_int16 **yybottom,
                      yytype_int16 *yybottom_no_free,
                      yytype_int16 **yytop, yytype_int16 *yytop_empty)
{
  YYSIZE_T yysize_old =
    *yytop == yytop_empty ? 0 : *yytop - *yybottom + 1;
  YYSIZE_T yysize_new = yysize_old + yyadd;
  if (*yycapacity < yysize_new)
    {
      YYSIZE_T yyalloc = 2 * yysize_new;
      yytype_int16 *yybottom_new;
      /* Use YYMAXDEPTH for maximum stack size given that the stack
         should never need to grow larger than the main state stack
         needs to grow without LAC.  */
      if (YYMAXDEPTH < yysize_new)
        {
          YYDPRINTF ((stderr, "%smax size exceeded%s", yydebug_prefix,
                      yydebug_suffix));
          return 1;
        }
      if (YYMAXDEPTH < yyalloc)
        yyalloc = YYMAXDEPTH;
      yybottom_new =
        (yytype_int16*) YYSTACK_ALLOC (yyalloc * sizeof *yybottom_new);
      if (!yybottom_new)
        {
          YYDPRINTF ((stderr, "%srealloc failed%s", yydebug_prefix,
                      yydebug_suffix));
          return 1;
        }
      if (*yytop != yytop_empty)
        {
          YYCOPY (yybottom_new, *yybottom, yysize_old);
          *yytop = yybottom_new + (yysize_old - 1);
        }
      if (*yybottom != yybottom_no_free)
        YYSTACK_FREE (*yybottom);
      *yybottom = yybottom_new;
      *yycapacity = yyalloc;
    }
  return 0;
}

/* Establish the initial context for the current lookahead if no initial
   context is currently established.

   We define a context as a snapshot of the parser stacks.  We define
   the initial context for a lookahead as the context in which the
   parser initially examines that lookahead in order to select a
   syntactic action.  Thus, if the lookahead eventually proves
   syntactically unacceptable (possibly in a later context reached via a
   series of reductions), the initial context can be used to determine
   the exact set of tokens that would be syntactically acceptable in the
   lookahead's place.  Moreover, it is the context after which any
   further semantic actions would be erroneous because they would be
   determined by a syntactically unacceptable token.

   YY_LAC_ESTABLISH should be invoked when a reduction is about to be
   performed in an inconsistent state (which, for the purposes of LAC,
   includes consistent states that don't know they're consistent because
   their default reductions have been disabled).  Iff there is a
   lookahead token, it should also be invoked before reporting a syntax
   error.  This latter case is for the sake of the debugging output.

   For parse.lac=full, the implementation of YY_LAC_ESTABLISH is as
   follows.  If no initial context is currently established for the
   current lookahead, then check if that lookahead can eventually be
   shifted if syntactic actions continue from the current context.
   Report a syntax error if it cannot.  */
#define YY_LAC_ESTABLISH                                         \
do {                                                             \
  if (!yy_lac_established)                                       \
    {                                                            \
      YYDPRINTF ((stderr,                                        \
                  "LAC: initial context established for %s\n",   \
                  yytname[yytoken]));                            \
      yy_lac_established = 1;                                    \
      {                                                          \
        int yy_lac_status =                                      \
          yy_lac (yyesa, &yyes, &yyes_capacity, yyssp, yytoken); \
        if (yy_lac_status == 2)                                  \
          goto yyexhaustedlab;                                   \
        if (yy_lac_status == 1)                                  \
          goto yyerrlab;                                         \
      }                                                          \
    }                                                            \
} while (0)

/* Discard any previous initial lookahead context because of Event,
   which may be a lookahead change or an invalidation of the currently
   established initial context for the current lookahead.

   The most common example of a lookahead change is a shift.  An example
   of both cases is syntax error recovery.  That is, a syntax error
   occurs when the lookahead is syntactically erroneous for the
   currently established initial context, so error recovery manipulates
   the parser stacks to try to find a new initial context in which the
   current lookahead is syntactically acceptable.  If it fails to find
   such a context, it discards the lookahead.  */
#if YYDEBUG
# define YY_LAC_DISCARD(Event)                                           \
do {                                                                     \
  if (yy_lac_established)                                                \
    {                                                                    \
      if (yydebug)                                                       \
        YYFPRINTF (stderr, "LAC: initial context discarded due to "      \
                   Event "\n");                                          \
      yy_lac_established = 0;                                            \
    }                                                                    \
} while (0)
#else
# define YY_LAC_DISCARD(Event) yy_lac_established = 0
#endif

/* Given the stack whose top is *YYSSP, return 0 iff YYTOKEN can
   eventually (after perhaps some reductions) be shifted, return 1 if
   not, or return 2 if memory is exhausted.  As preconditions and
   postconditions: *YYES_CAPACITY is the allocated size of the array to
   which *YYES points, and either *YYES = YYESA or *YYES points to an
   array allocated with YYSTACK_ALLOC.  yy_lac may overwrite the
   contents of either array, alter *YYES and *YYES_CAPACITY, and free
   any old *YYES other than YYESA.  */
static int
yy_lac (yytype_int16 *yyesa, yytype_int16 **yyes,
        YYSIZE_T *yyes_capacity, yytype_int16 *yyssp, int yytoken)
{
  yytype_int16 *yyes_prev = yyssp;
  yytype_int16 *yyesp = yyes_prev;
  YYDPRINTF ((stderr, "LAC: checking lookahead %s:", yytname[yytoken]));
  if (yytoken == YYUNDEFTOK)
    {
      YYDPRINTF ((stderr, " Always Err\n"));
      return 1;
    }
  while (1)
    {
      int yyrule = yypact[*yyesp];
      if (yypact_value_is_default (yyrule)
          || (yyrule += yytoken) < 0 || YYLAST < yyrule
          || yycheck[yyrule] != yytoken)
        {
          yyrule = yydefact[*yyesp];
          if (yyrule == 0)
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
        }
      else
        {
          yyrule = yytable[yyrule];
          if (yytable_value_is_error (yyrule))
            {
              YYDPRINTF ((stderr, " Err\n"));
              return 1;
            }
          if (0 < yyrule)
            {
              YYDPRINTF ((stderr, " S%d\n", yyrule));
              return 0;
            }
          yyrule = -yyrule;
        }
      {
        YYSIZE_T yylen = yyr2[yyrule];
        YYDPRINTF ((stderr, " R%d", yyrule - 1));
        if (yyesp != yyes_prev)
          {
            YYSIZE_T yysize = yyesp - *yyes + 1;
            if (yylen < yysize)
              {
                yyesp -= yylen;
                yylen = 0;
              }
            else
              {
                yylen -= yysize;
                yyesp = yyes_prev;
              }
          }
        if (yylen)
          yyesp = yyes_prev -= yylen;
      }
      {
        int yystate;
        {
          int yylhs = yyr1[yyrule] - YYNTOKENS;
          yystate = yypgoto[yylhs] + *yyesp;
          if (yystate < 0 || YYLAST < yystate
              || yycheck[yystate] != *yyesp)
            yystate = yydefgoto[yylhs];
          else
            yystate = yytable[yystate];
        }
        if (yyesp == yyes_prev)
          {
            yyesp = *yyes;
            *yyesp = yystate;
          }
        else
          {
            if (yy_lac_stack_realloc (yyes_capacity, 1,
#if YYDEBUG
                                      " (", ")",
#endif
                                      yyes, yyesa, &yyesp, yyes_prev))
              {
                YYDPRINTF ((stderr, "\n"));
                return 2;
              }
            *++yyesp = yystate;
          }
        YYDPRINTF ((stderr, " G%d", yystate));
      }
    }
}


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
   YYSSP.  In order to see if a particular token T is a
   valid looakhead, invoke yy_lac (YYESA, YYES, YYES_CAPACITY, YYSSP, T).

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store or if
   yy_lac returned 2.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyesa, yytype_int16 **yyes,
                YYSIZE_T *yyes_capacity, yytype_int16 *yyssp, int yytoken)
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
       In the first two cases, it might appear that the current syntax
       error should have been detected in the previous state when yy_lac
       was invoked.  However, at that time, there might have been a
       different syntax error that discarded a different initial context
       during error recovery, leaving behind the current lookahead.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      YYDPRINTF ((stderr, "Constructing syntax error message\n"));
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          int yyx;

          for (yyx = 0; yyx < YYNTOKENS; ++yyx)
            if (yyx != YYTERROR && yyx != YYUNDEFTOK)
              {
                {
                  int yy_lac_status = yy_lac (yyesa, yyes, yyes_capacity,
                                              yyssp, yyx);
                  if (yy_lac_status == 2)
                    return 2;
                  if (yy_lac_status == 1)
                    continue;
                }
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
# if YYDEBUG
      else if (yydebug)
        YYFPRINTF (stderr, "No expected tokens.\n");
# endif
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

    yytype_int16 yyesa[20];
    yytype_int16 *yyes;
    YYSIZE_T yyes_capacity;

  int yy_lac_established = 0;
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

  yyes = yyesa;
  yyes_capacity = sizeof yyesa / sizeof *yyes;
  if (YYMAXDEPTH < yyes_capacity)
    yyes_capacity = YYMAXDEPTH;

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
    {
      YY_LAC_ESTABLISH;
      goto yydefault;
    }
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      YY_LAC_ESTABLISH;
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
  YY_LAC_DISCARD ("shift");

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
  {
    int yychar_backup = yychar;
    switch (yyn)
      {
          case 2:
#line 57 "1605103.y" /* yacc.c:1646  */
    {
	if(errors==0){
		(yyvsp[0].Symbol)->setAssemblyCode(
		asmGen.getIntro()
		+asmGen.getDeclarations()
		+".CODE\n"
		+(yyvsp[0].Symbol)->getAssemblyCode()+asmGen.getPrintlnAssembly());

		string asmFile = currentFile.substr(0,currentFile.size()-2)+".asm";
		asmGen.generateFinalAsmFile(asmFile,(yyvsp[0].Symbol)->getAssemblyCode());
		optimize(asmFile);

	}


}
#line 1668 "y.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 75 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"program : program-unit");
		Util::parserLog((yyvsp[-1].Symbol)->getName()+" "+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[-1].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 1681 "y.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 83 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"program : unit");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());

		Util::parserLog((yyvsp[0].Symbol)->getName()+'\n');
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());


	}
#line 1696 "y.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 97 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;

		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName()+"\n");
		Util::parserLog(lines,"unit : var_declaration");
		Util::parserLog((yyvsp[0].Symbol)->getName());

		asmGen.funcLocalVars.clear();
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 1713 "y.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 110 "1605103.y" /* yacc.c:1646  */
    {

		Util::parserLog(lines,"unit : func_declaration");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName()+"\n");
		Util::parserLog((yyvsp[0].Symbol)->getName());

		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
	}
#line 1727 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 119 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName()+"\n");
		Util::parserLog(lines,"unit : func_definition");
		Util::parserLog((yyvsp[0].Symbol)->getName());

		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 1742 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 131 "1605103.y" /* yacc.c:1646  */
    {
		SymbolInfo *func = symbolTable->lookUp((yyvsp[-4].Symbol)->getName());
		Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-parameter_list-RPAREN-SEMICOLON");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-5].Symbol)->getName()+" "+(yyvsp[-4].Symbol)->getName()+"("+(yyvsp[-2].Symbol)->getName()+")");

 		if(func != nullptr){
			int num = func->getFunction()->getParamCount();
			if(num == paramList.size()){

				vector<string>paramType = func->getFunction()->getAllParamTypes();

				int len = paramList.size();
				for( int i=0;i < len; i++){
					if(paramList[i]->getDeclarationType() != paramType[i]){
						string err = "Expected "+paramList[i]->getDeclarationType()+" Found "+ paramType[i] +"for "+to_string(i)+"th parameter";
						Util::appendLogError(lines,err,PARSER);
						yyerror(err.c_str());
						break;
					}
				}
				if(func->getFunction()->getReturnType()!=(yyvsp[-5].Symbol)->getName()){
					string err = "Invalid Return Type.Expected "+func->getFunction()->getReturnType()+ " Found " + (yyvsp[-5].Symbol)->getName();
					Util::appendLogError(lines,err,PARSER);
					yyerror(err.c_str());

				}
				paramList.clear();

			}else{
				string err = "Invalid number of parameters.Found:"+to_string(num)
				+" params, Expected:"+to_string(paramList.size())+" params";

				Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());
			}
		}
		else{
			string name2 = (yyvsp[-4].Symbol)->getName();
			symbolTable->insert(SymbolInfo(name2,"ID","Function"));
			func = symbolTable->lookUp(name2);
			func->setFunction(true);
			int len = paramList.size();
			for(int i=0 ;i < len ; i++){
				string name = paramList[i]->getName();
				string decType = paramList[i]->getDeclarationType();
				func->getFunction()->addParam(name,decType);
				if(DEBUG)cout<<paramList[i]->getDeclarationType()<<endl;
			}

			paramList.clear();

			func->getFunction()->setReturnType((yyvsp[-5].Symbol)->getName());
		}

		string name1 = (yyvsp[-5].Symbol)->getName();
		string name2 = (yyvsp[-4].Symbol)->getName();
		string name4 = (yyvsp[-2].Symbol)->getName();
		(yyval.Symbol)->setName(name1+" "+name2+"("+name4+");");

	}
#line 1808 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 192 "1605103.y" /* yacc.c:1646  */
    {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
#line 1817 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 196 "1605103.y" /* yacc.c:1646  */
    {

			Util::parserLog(lines,"func_declaration : type_specifier-ID-LPAREN-RPAREN-SEMICOLON");
			(yyval.Symbol) = TOKEN;
			Util::parserLog((yyvsp[-4].Symbol)->getName()+" "+(yyvsp[-3].Symbol)->getName()+"();");

			SymbolInfo *s=symbolTable->lookUp((yyvsp[-3].Symbol)->getName());

			if(s != nullptr){
				if(s->getFunction()->getParamCount()!=0){
					string err = "Invalid number of parameters! Expected 0 Found "+to_string(s->getFunction()->getParamCount());
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());

				}
				if(s->getFunction()->getReturnType()!=(yyvsp[-4].Symbol)->getName()){
					string err = "Return Type Does not Match! Expected "+s->getFunction()->getReturnType()+ " Found " +(yyvsp[-4].Symbol)->getName();
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
				}

			}
			else{
				SymbolInfo id((yyvsp[-3].Symbol)->getName(),"ID","Function");
				symbolTable->insert(id);
				s = symbolTable->lookUp((yyvsp[-3].Symbol)->getName());s->setFunction(true);
				s->getFunction()->setReturnType((yyvsp[-4].Symbol)->getName());
			}
			(yyval.Symbol)->setName((yyvsp[-4].Symbol)->getName()+" "+(yyvsp[-3].Symbol)->getName()+"();");
	}
#line 1850 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 225 "1605103.y" /* yacc.c:1646  */
    {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
#line 1859 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 231 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;
		SymbolInfo *s = symbolTable->lookUp((yyvsp[-3].Symbol)->getName());

		if(s != nullptr){
			if(s->getFunction()->isDefined()==0){
				int num = s->getFunction()->getParamCount();
				if(num != paramList.size()){
					string err = "Invalid number of parameters.";
					Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
				} else {

					vector<string>paramType = s->getFunction()->getAllParamTypes();
					int len = paramList.size();
					for(int i=0;i<len;i++){
						if(paramList[i]->getDeclarationType() != paramType[i]){
							string err = "Expected "+Util::trim(paramList[i]->getDeclarationType())
							+" Found "+Util::trim(paramType[i])+" for "+ to_string(i)+"th "+"Parameter";
							yyerror(err.c_str());
							Util::appendLogError(lines,err,PARSER);
							break;
						}
					}
					if(s->getFunction()->getReturnType() != (yyvsp[-4].Symbol)->getName()){
						string err = "Invalid Return Types ! Expected "+s->getFunction()->getReturnType()+ " Found " + (yyvsp[-4].Symbol)->getName();
						yyerror(err.c_str());
						Util::appendLogError(lines,err,PARSER);
					}
					s->getFunction()->clear();
					for(int i=0;i<paramList.size();i++){
							s->getFunction()->addParam(paramList[i]->getName()+to_string(symbolTable->getScopeCount()+1),paramList[i]->getDeclarationType());
					//	cout<<paramListTemp[i]->get_dectype()<<paramListTemp[i]->get_name()<<endl;
					}
				}
				s->getFunction()->setDefined();
			}
			else{
				string err = "Function "+(yyvsp[-3].Symbol)->getName()+" defined Multiple times";
				yyerror(err.c_str());
				Util::appendLogError(lines,err,PARSER);
			}
		}
		else{
			SymbolInfo sym((yyvsp[-3].Symbol)->getName(),"ID","Function");
			symbolTable->insert(sym);
			s = symbolTable->lookUp((yyvsp[-3].Symbol)->getName());s->setFunction(true);s->getFunction()->setDefined();
			if(DEBUG)cout<<s->getFunction()->getParamCount()<<endl;
			int len = paramList.size();
			//cout<<$<Symbol>2->getName()<<endl;
			for(int i=0;i<len;i++){
				string name = paramList[i]->getName()+to_string(symbolTable->getScopeCount()+1);

				string decType = paramList[i]->getDeclarationType();
				s->getFunction()->addParam(name,decType);
			}
			Function * func = s->getFunction();
			func->setReturnType((yyvsp[-4].Symbol)->getName());
		}
		asmGen.currentProcedure=(yyvsp[-3].Symbol)->getName();
		asmGen.vars.push_back(asmGen.currentProcedure+"_return");
	}
#line 1926 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 293 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-parameter_list-RPAREN-compound_statement ");
		Util::parserLog((yyvsp[-6].Symbol)->getName()+" "+(yyvsp[-5].Symbol)->getName()+"("+(yyvsp[-3].Symbol)->getName()+") "+ (yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[-6].Symbol)->getName()+" "+(yyvsp[-5].Symbol)->getName()+"("+(yyvsp[-3].Symbol)->getName()+")"+(yyvsp[0].Symbol)->getName());

		//@CODE-GEN
		(yyval.Symbol)->setAssemblyCode((yyvsp[-5].Symbol)->getName()+" PROC\n");

		if((yyvsp[-5].Symbol)->getName()=="main"){
			(yyval.Symbol)->setAssemblyCode((yyval.Symbol)->getAssemblyCode()
			+asmGen.getMainIntro()+(yyvsp[0].Symbol)->getAssemblyCode()
			+"LabelReturn"+asmGen.getMainOutro());
		}
		else {
			SymbolInfo *s=symbolTable->lookUp((yyvsp[-5].Symbol)->getName());

			for(int i=0;i<asmGen.funcLocalVars.size();i++){
				s->getFunction()->addVar(asmGen.funcLocalVars[i]);
			}
			asmGen.funcLocalVars.clear();

			AssemblyCode asmCode;
			asmCode.append((yyval.Symbol)->getAssemblyCode()).append(asmGen.getPushAllRegs());
			vector<string>paramListTemp=s->getFunction()->getAllParams(),varListTemp=s->getFunction()->getVars();

			for(int i=0;i<paramListTemp.size();i++){
				//asmCode.append("\tpush "+paramListTemp[i]+"\n";
				asmCode.append("\tpush "+paramListTemp[i]+"\n");
			}

			for(int i=0;i<varListTemp.size();i++){
				asmCode.append("\tpush "+varListTemp[i]+"\n");
			}
			asmCode.append(	(yyvsp[0].Symbol)->getAssemblyCode()+
				"L_Return_"+asmGen.currentProcedure+":\n");
				for(int i=varListTemp.size()-1;i>=0;i--){
				asmCode.append("\tpop "+varListTemp[i]+"\n");
			}
			for(int i=paramListTemp.size()-1;i>=0;i--){
				asmCode.append("\tpop "+paramListTemp[i]+"\n");
			}
			asmCode.append("\tpop DX\n\tpop CX\n\tpop BX\n\tpop ax\n\tret\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode() + (yyvsp[-5].Symbol)->getName() + " ENDP\n");
		}
		string name1 = (yyvsp[-6].Symbol)->getName()+" ",name2 = (yyvsp[-5].Symbol)->getName()+"(";
		string name3 = (yyvsp[-3].Symbol)->getName()+")"+(yyvsp[0].Symbol)->getName();
		(yyval.Symbol)->setName(name1 + name2 + name3);
	}
#line 1979 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 341 "1605103.y" /* yacc.c:1646  */
    {
		SymbolInfo *s = symbolTable->lookUp((yyvsp[-2].Symbol)->getName());
		(yyval.Symbol) = TOKEN;
		if(s == nullptr){
			SymbolInfo sym((yyvsp[-2].Symbol)->getName(),"ID","Function");
			symbolTable->insert(sym);
			s = symbolTable->lookUp((yyvsp[-2].Symbol)->getName());
			s -> setFunction(true);s -> getFunction()->setReturnType((yyvsp[-3].Symbol)->getName());s -> getFunction()->setDefined();
		}
		else if(s->getFunction()->isDefined()==0){
			if(s->getFunction()->getReturnType()!=(yyvsp[-3].Symbol)->getName()){
				string err = "Invalid Return Type Expected :"+(yyvsp[-3].Symbol)->getName()+" Found :"+s->getFunction()->getReturnType();
				yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
			}
			if(s->getFunction()->getParamCount()!=0){
				string err = "Invalid number of parameters ";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}

			s->getFunction()->setDefined();
		}
		else{
			string err = "Multiple Definition Of Function "+(yyvsp[-2].Symbol)->getName();
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		asmGen.currentProcedure=(yyvsp[-2].Symbol)->getName();
		asmGen.vars.push_back(asmGen.currentProcedure+"_return");
		string name1 = (yyvsp[-3].Symbol)->getName(),name2 = (yyvsp[-2].Symbol)->getName();
		(yyvsp[-3].Symbol)->setName((yyvsp[-3].Symbol)->getName()+" "+(yyvsp[-2].Symbol)->getName()+"()");
	}
#line 2014 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 370 "1605103.y" /* yacc.c:1646  */
    {

		Util::parserLog(lines,"func_definition : type_specifier-ID-LPAREN-RPAREN-compound_statement");
		(yyval.Symbol)->setName((yyvsp[-5].Symbol)->getName()+(yyvsp[0].Symbol)->getName());Util::parserLog((yyvsp[-5].Symbol)->getName()+" "
		+(yyvsp[0].Symbol)->getName());(yyval.Symbol)->setAssemblyCode((yyvsp[-4].Symbol)->getName()+" PROC\n");
		if((yyvsp[-4].Symbol)->getName()=="main"){
			(yyval.Symbol)->setAssemblyCode((yyval.Symbol)->getAssemblyCode()+asmGen.getMainIntro()+(yyvsp[0].Symbol)->getAssemblyCode()+"L_Return_"
			+asmGen.getMainOutro());
		}
		else {
			SymbolInfo *s=symbolTable->lookUp((yyvsp[-4].Symbol)->getName());

		for(int i=0;i<asmGen.funcLocalVars.size();i++){
			s->getFunction()->addVar(asmGen.funcLocalVars[i]);
		}
		asmGen.funcLocalVars.clear();

		AssemblyCode asmCode;asmCode.append((yyval.Symbol)->getAssemblyCode()+"\tpush ax\n\tpush BX \n\tpush CX \n\tpush DX\n");

		vector<string>paramListTemp=s->getFunction()->getAllParams(),varListTemp=s->getFunction()->getVars();
		for(int i=0;i<paramListTemp.size();i++){
			asmCode.append("\tpush "+paramListTemp[i]+"\n");
		}
		for(int i=0;i<varListTemp.size();i++){
			asmCode.append("\tpush "+varListTemp[i]+"\n");
		}

		asmCode.append(	(yyvsp[0].Symbol)->getAssemblyCode()+"L_Return_"+asmGen.currentProcedure+":\n");

		for(int i=varListTemp.size()-1;i>=0;i--){
			asmCode.append("\tpop "+varListTemp[i]+"\n");
		}

		for(int i=paramListTemp.size()-1;i>=0;i--){
			asmCode.append("\tpop "+paramListTemp[i]+"\n");
		}
		asmCode.append("\tpop DX\n\tpop CX\n\tpop BX\n\tpop ax\n\tret\n");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode()+(yyvsp[-4].Symbol)->getName()+" ENDP\n");
		}
		(yyval.Symbol)->setName((yyvsp[-5].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
	}
#line 2060 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 412 "1605103.y" /* yacc.c:1646  */
    {

		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier-ID");
		(yyval.Symbol) = TOKEN;

		Util::parserLog((yyvsp[-3].Symbol)->getName()+","+(yyvsp[-1].Symbol)->getName()+" "+(yyvsp[0].Symbol)->getName());
		SymbolInfo * pl = new SymbolInfo((yyvsp[0].Symbol)->getName(),"ID",(yyvsp[-1].Symbol)->getName());
		paramList.push_back(pl);(yyval.Symbol)->setName((yyvsp[-3].Symbol)->getName()+","+(yyvsp[-1].Symbol)->getName()+" "+(yyvsp[0].Symbol)->getName());
	}
#line 2074 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 421 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"parameter_list : parameter_list-COMMA-type_specifier");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-2].Symbol)->getName()+","+(yyvsp[0].Symbol)->getName());
		SymbolInfo * type = new SymbolInfo("","ID",(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+","+(yyvsp[0].Symbol)->getName());
		paramList.push_back(type);
	}
#line 2087 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 429 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"parameter_list : type_specifier-ID");
		Util::parserLog((yyvsp[-1].Symbol)->getName()+" "+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol) = TOKEN;
		string name1 = (yyvsp[-1].Symbol)->getName(),name2 = (yyvsp[0].Symbol)->getName();
		SymbolInfo * si = new SymbolInfo(name2,"ID",name1);
		(yyval.Symbol)->setName(name1+" "+name2);
		paramList.push_back(si);
	}
#line 2101 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 438 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"parameter_list : type_specifier");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName()+" ");
		paramList.push_back(new SymbolInfo("","ID",(yyvsp[0].Symbol)->getName()));
	}
#line 2113 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 447 "1605103.y" /* yacc.c:1646  */
    {

	symbolTable->enterScope();
	int len = paramList.size();
	for(int i=0;i<len;i++){
		string name = paramList[i]->getName();
		string type = paramList[i]->getDeclarationType();
		symbolTable->insert(SymbolInfo(name,"ID",type));
		asmGen.vars.push_back(paramList[i]->getName()+to_string(symbolTable->currentScopeId));
	}
	paramList.clear();

	}
#line 2131 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 459 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"compound_statement : LCURL-statements-RCURL");

		symbolTable->printAllScopeTables();
		(yyval.Symbol)->setName("{\n"+(yyvsp[-1].Symbol)->getName()+"\n}");
		symbolTable->exitScope();
		Util::parserLog("{"+(yyvsp[-1].Symbol)->getName()+"}");
		(yyval.Symbol)->setAssemblyCode((yyvsp[-1].Symbol)->getAssemblyCode());

	}
#line 2148 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 471 "1605103.y" /* yacc.c:1646  */
    {
		symbolTable->enterScope();
		int len = paramList.size();

		for(int i=0;i<len;i++){
			string name = paramList[i]->getName();
			string type = paramList[i]->getDeclarationType();
			symbolTable->insert(SymbolInfo(name,"ID",type));
			asmGen.vars.push_back(paramList[i]->getName()+to_string(symbolTable->currentScopeId));
		}

		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"compound_statement : LCURL-RCURL");
		paramList.clear();
		Util::parserLog("{}");;
		symbolTable->printAllScopeTables();
		(yyval.Symbol)->setName("{}");
		symbolTable->exitScope();
	}
#line 2172 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 492 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"var_declaration : type_specifier-declarationList-SEMICOLON");
		Util::parserLog((yyvsp[-2].Symbol)->getName()+" "+(yyvsp[-1].Symbol)->getName()+";");
		if((yyvsp[-2].Symbol)->getName()=="void "){
			string err = "Cannot Declare void Type";
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else{
			int len = declarationList.size();
			for(int i=0;i < len ; i++){
				if(symbolTable->lookUpLocal(declarationList[i]->getName()) != nullptr){
					string err = declarationList[i]->getName()+" defined multiple times";
					yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
					continue;
				}
				if(declarationList[i]->getType().size()<3){
					asmGen.funcLocalVars.push_back(declarationList[i]->getName()+to_string(symbolTable->currentScopeId));
					asmGen.vars.push_back(declarationList[i]->getName()+to_string(symbolTable->currentScopeId));
					symbolTable->insert(SymbolInfo(declarationList[i]->getName(),declarationList[i]->getType(),(yyvsp[-2].Symbol)->getName()));
				} else{
					asmGen.arrays.push_back(make_pair(declarationList[i]->getName()+to_string(symbolTable->currentScopeId),
					declarationList[i]->getType().substr(2,declarationList[i]->getType().size () - 1)));

					string type = declarationList[i]->getType().substr(0,declarationList[i]->getType().size () - 1);
					declarationList[i]->setType(type);
					symbolTable->insert(SymbolInfo(declarationList[i]->getName(),declarationList[i]->getType(),(yyvsp[-2].Symbol)->getName()+"array"));
				}
			}
		}
		declarationList.clear();
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+" "+(yyvsp[-1].Symbol)->getName()+";");
	}
#line 2210 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 526 "1605103.y" /* yacc.c:1646  */
    {
		string err = "Missing SEMICOLON";
		Util::appendLogError(lines,err,PARSER);
	}
#line 2219 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 532 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"type_specifier : INT");
		Util::parserLog("int ");
		(yyval.Symbol)->setName("int ");
	}
#line 2230 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 538 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"type_specifier : FLOAT");
		Util::parserLog("float ");
		(yyval.Symbol)->setName("float ");
	}
#line 2241 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 544 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"type_specifier : VOID");
		Util::parserLog("void ");
		(yyval.Symbol)->setName("void ");
	}
#line 2252 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 552 "1605103.y" /* yacc.c:1646  */
    {
	Util::parserLog(lines,"declarationList : declarationList-COMMA-ID");
	(yyval.Symbol) = TOKEN;
	string name1 = (yyvsp[-2].Symbol)->getName();
	string name3 = (yyvsp[0].Symbol)->getName();
	Util::parserLog(name1+","+name3);

	SymbolInfo * id = new SymbolInfo(name3,"ID");

	declarationList.push_back(id);

	(yyval.Symbol)->setName(name1+","+name3);

	}
#line 2271 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 566 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"declarationList : declarationList-COMMA-ID-LTHIRD-CONST_INT-RTHIRD");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-5].Symbol)->getName()+","+(yyvsp[-3].Symbol)->getName()+"["+(yyvsp[-1].Symbol)->getName()+"]");
		SymbolInfo * id = new SymbolInfo((yyvsp[-3].Symbol)->getName(),"ID"+(yyvsp[-1].Symbol)->getName());
		declarationList.push_back(id);
		(yyval.Symbol)->setName((yyvsp[-5].Symbol)->getName()+","+(yyvsp[-3].Symbol)->getName()+"["+(yyvsp[-1].Symbol)->getName()+"]");
	}
#line 2284 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 574 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"declarationList : ID");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		declarationList.push_back(new SymbolInfo((yyvsp[0].Symbol)->getName(),"ID"));
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
	}
#line 2296 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 581 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"declarationList : ID-LTHIRD-CONST_INT-RTHIRD");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-3].Symbol)->getName()+"["+(yyvsp[-1].Symbol)->getName()+"]");

		SymbolInfo * id = new SymbolInfo((yyvsp[-3].Symbol)->getName(),"ID"+(yyvsp[-1].Symbol)->getName());

		declarationList.push_back(id);
		(yyval.Symbol)->setName((yyvsp[-3].Symbol)->getName()+"["+(yyvsp[-1].Symbol)->getName()+"]");
	}
#line 2311 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 593 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statements : statement");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol) = TOKEN;(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
	}
#line 2322 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 599 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statements : statements-statement");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-1].Symbol)->getName()+" "+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+"\n"+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[-1].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());
	}
#line 2334 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 608 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statement : var_declaration");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
	}
#line 2345 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 614 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"statement : expression_statement");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 2358 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 622 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;

		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		Util::parserLog(lines,"statement : compound_statement");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 2373 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 632 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;

		Util::parserLog(lines,"statement : FOR-LPAREN-expression_statement-expression_statement-expression-RPAREN-statement");
		Util::parserLog("for("+(yyvsp[-4].Symbol)->getName()+" "+(yyvsp[-3].Symbol)->getName()+" "+

		(yyvsp[-2].Symbol)->getName()+")\n"+(yyvsp[0].Symbol)->getName());

		if((yyvsp[-4].Symbol)->getDeclarationType()=="void "){
			string err = "Variable Cannot Be Declared void ";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());}

		else{
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			AssemblyCode asmCode;asmCode.append((yyvsp[-4].Symbol)->getAssemblyCode());
			asmCode.append(string(label1)+":\n");
			asmCode.append((yyvsp[-3].Symbol)->getAssemblyCode());
			asmCode.append("\tmov ax,"+(yyvsp[-3].Symbol)->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label2)+"\n");
			asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
			asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
			asmCode.append("\tjmp "+string(label1)+"\n");
			asmCode.append(string(label2)+":\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		}
		string name3 = (yyvsp[-4].Symbol)->getName();
		string name4 = (yyvsp[-3].Symbol)->getName();
		string name5 = (yyvsp[-2].Symbol)->getName();
		(yyval.Symbol)->setName("for("+name3+name4+name5+")\n"+name5);
	}
#line 2409 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 663 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement");
		(yyval.Symbol) = TOKEN;
		Util::parserLog("if("+(yyvsp[-2].Symbol)->getName()+")\n"+(yyvsp[0].Symbol)->getName());

		if((yyvsp[-2].Symbol)->getDeclarationType()=="void "){
			string err = "Variable Cannot Be Declared void ";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		else{
		//@CODE-GEN
			AssemblyCode asmCode;asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
			char *label1=asmGen.newLabel();
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label1)+"\n");
			asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
			asmCode.append(string(label1)+":\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());

		}
		string name3 = (yyvsp[-2].Symbol)->getName();
		string name5 = (yyvsp[0].Symbol)->getName();
		(yyval.Symbol)->setName("if("+name3+")\n"+name5);
	}
#line 2440 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 689 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statement : IF-LPAREN-expression-RPAREN-statement-ELSE-statement");
		(yyval.Symbol) = TOKEN;
		Util::parserLog("if("+(yyvsp[-4].Symbol)->getName()+")\n"+(yyvsp[-2].Symbol)->getName()+"else\n"+(yyvsp[0].Symbol)->getName());
		if((yyvsp[-4].Symbol)->getDeclarationType()=="void "){
			string err = "void expression cannot be used inside if";yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else{
		//@CODE-GEN
			AssemblyCode asmCode;asmCode.append((yyvsp[-4].Symbol)->getAssemblyCode());
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			asmCode.append("\tmov ax,"+(yyvsp[-4].Symbol)->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label1)+"\n");
			asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
			asmCode.append("\tjmp "+string(label2)+"\n");
			asmCode.append(string(label1)+":\n");
			asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
			asmCode.append(string(label2)+":\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		}
		string name3 = (yyvsp[-4].Symbol)->getName(), name5 = (yyvsp[-2].Symbol)->getName(), name7 = (yyvsp[0].Symbol)->getName();
		(yyval.Symbol)->setName("if("+name3+")\n"+name5+" else \n"+name7);
	}
#line 2470 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 714 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statement : WHILE-LPAREN-expression-RPAREN-statement");
		(yyval.Symbol) = TOKEN;
		Util::parserLog("while("+(yyvsp[-2].Symbol)->getName()+")\n"+(yyvsp[0].Symbol)->getName());

		if((yyvsp[-2].Symbol)->getDeclarationType()=="void "){
			string err = "void expression cannot be used inside while";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
		}

		else{
			//@CODE-GEN
			AssemblyCode asmCode;asmCode.append("");
			char *label1=asmGen.newLabel();
			char *label2=asmGen.newLabel();
			asmCode.append(string(label1)+":\n");
			asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
			asmCode.append("\tcmp ax,0\n");
			asmCode.append("\tje "+string(label2)+"\n");
			asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
			asmCode.append("\tjmp "+string(label1)+"\n");
			asmCode.append(string(label2)+":\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		}
		(yyval.Symbol)->setName("while("+(yyvsp[-2].Symbol)->getName()+")\n"+(yyvsp[0].Symbol)->getName());
	}
#line 2503 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 742 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"statement : PRINTLN-LPAREN-ID-RPAREN-SEMICOLON");
		(yyval.Symbol) = TOKEN;
		Util::parserLog("\n ("+(yyvsp[-2].Symbol)->getName()+")");

		//@CODE-GEN
		AssemblyCode asmCode;asmCode.append("");
		if(symbolTable->findValidIdName((yyvsp[-2].Symbol)->getName())==-1){
			yyerror("Printing Undeclared Variable");
			Util::appendLogError(lines,"Printing Undeclared Variable",PARSER);
		}
		else{

			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getName()+to_string(symbolTable->findValidIdName((yyvsp[-2].Symbol)->getName())));
			asmCode.append("\n\tcall OUTDEC\n");
		}
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setName("\n("+(yyvsp[-2].Symbol)->getName()+")");
	}
#line 2527 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 761 "1605103.y" /* yacc.c:1646  */
    {
		string err = "Missing SEMICOLON";
		yyerror(err.c_str());
		Util::appendLogError(lines,err,PARSER);
	}
#line 2537 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 766 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"statement : RETURN-expression-SEMICOLON");
		Util::parserLog("return "+(yyvsp[-1].Symbol)->getName());
		if((yyvsp[-1].Symbol)->getDeclarationType()=="void "){
			string err = "function returning a void expression";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			(yyval.Symbol)->setDeclarationType("int ");
		}
		else{
			AssemblyCode asmCode;asmCode.append((yyvsp[-1].Symbol)->getAssemblyCode());
			asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmov "+asmGen.currentProcedure+"_return,ax\n");
			asmCode.append("\tjmp L_Return_"+asmGen.currentProcedure+"\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		}
		(yyval.Symbol)->setName("return "+(yyvsp[-1].Symbol)->getName()+";");
	}
#line 2561 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 785 "1605103.y" /* yacc.c:1646  */
    {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
#line 2569 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 790 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"expression_statement : SEMICOLON");
		Util::parserLog(";");
		(yyval.Symbol)->setName(";");
	}
#line 2580 "y.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 796 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"expression_statement : expression-SEMICOLON");
		Util::parserLog((yyvsp[-1].Symbol)->getName()+";");
		(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+";");
		(yyval.Symbol)->setAssemblyCode((yyvsp[-1].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[-1].Symbol)->getIdValue());
	}
#line 2593 "y.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 804 "1605103.y" /* yacc.c:1646  */
    {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
#line 2601 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 807 "1605103.y" /* yacc.c:1646  */
    {
		Util::appendLogError(lines,"Missing SEMICOLON",PARSER);
	}
#line 2609 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 811 "1605103.y" /* yacc.c:1646  */
    {
		string name = (yyvsp[0].Symbol)->getName();
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"variable : ID");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		SymbolInfo * sm = symbolTable->lookUp(name);
		if(sm==nullptr){
			string err = "Undeclared Variable: "+(yyvsp[0].Symbol)->getName();
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		else if(sm->getDeclarationType()=="int array" || sm->getDeclarationType()=="float array"){
			string err = "Found array: "+(yyvsp[0].Symbol)->getName()+" Expected Variable";
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		if(sm!=nullptr){
			(yyval.Symbol)->setDeclarationType(sm->getDeclarationType());
			(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getName()+to_string(symbolTable->findValidIdName((yyvsp[0].Symbol)->getName())));
		}
		(yyval.Symbol)->setName(name);
		(yyval.Symbol)->setType("notarray");

	}
#line 2637 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 835 "1605103.y" /* yacc.c:1646  */
    {

		Util::parserLog(lines,"variable : ID-LTHIRD-expression-RTHIRD");
		(yyval.Symbol) = TOKEN;

		Util::parserLog((yyvsp[-3].Symbol)->getName()+"["+(yyvsp[-1].Symbol)->getName()+"]");

		if(symbolTable->lookUp((yyvsp[-3].Symbol)->getName())==nullptr){
			string err = "Undeclared Variable :"+ (yyvsp[-3].Symbol)->getName();
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}

		if(DEBUG)cout<<lines<<" "<<(yyvsp[-1].Symbol)->getDeclarationType()<<endl;

		if((yyvsp[-1].Symbol)->getDeclarationType()=="float "||(yyvsp[-1].Symbol)->getDeclarationType()=="void "){
			string err = "Non-integer Array Index";
			Util::appendLogError(lines,err,PARSER);
			yyerror(err.c_str());
		}
		if(symbolTable->lookUp((yyvsp[-3].Symbol)->getName()) != nullptr){


			bool c1 = symbolTable->lookUp((yyvsp[-3].Symbol)->getName())->getDeclarationType()!="int array";
			bool c2 = symbolTable->lookUp((yyvsp[-3].Symbol)->getName())->getDeclarationType()!="float array";
			if(c1 && c2){
				string err = "Invalid Types.Expected array";
				Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());
			}
			SymbolInfo * array = symbolTable->lookUp((yyvsp[-3].Symbol)->getName());

			string decType = array->getDeclarationType();


			if(decType == "float array"){(yyvsp[-3].Symbol)->setDeclarationType("float ");}


			if(decType == "int array"){	(yyvsp[-3].Symbol)->setDeclarationType("int ");}
			(yyval.Symbol)->setDeclarationType((yyvsp[-3].Symbol)->getDeclarationType());
			AssemblyCode asmCode;
			asmCode.append("").append((yyvsp[-1].Symbol)->getAssemblyCode())
			.append("\tmov BX,"+(yyvsp[-1].Symbol)->getIdValue()+"\n")
			.append("\tadd BX,BX\n");
			(yyval.Symbol)->setIdValue((yyvsp[-3].Symbol)->getName()+to_string(symbolTable->findValidIdName((yyvsp[-3].Symbol)->getName())));
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());

		}
		string name3 = (yyvsp[-1].Symbol)->getName(),name1 = (yyvsp[-3].Symbol)->getName();
		(yyval.Symbol)->setName(name1+"["+name3+"]");
		(yyval.Symbol)->setType("array");

	}
#line 2694 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 888 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;

		Util::parserLog(lines,"expression : logic_expression");

		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());

	}
#line 2711 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 900 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;

		Util::parserLog(lines,"expression : variable-ASSIGNOP-logic_expression");
	  Util::parserLog((yyvsp[-2].Symbol)->getName()+"="+(yyvsp[0].Symbol)->getName());

		if((yyvsp[0].Symbol)->getDeclarationType()=="void "){

			string err = "Expression Cannnot Be of Type void";
			Util::appendLogError(lines,err,PARSER);
			(yyval.Symbol)->setDeclarationType("int ");yyerror(err.c_str());

		}else if(symbolTable->lookUp((yyvsp[-2].Symbol)->getName()) != nullptr) {

			if(DEBUG)cout<<lines<<" "<<symbolTable->lookUp((yyvsp[-2].Symbol)->getName())->toString()<<""<<(yyvsp[0].Symbol)->toString()<<endl;

			string decType = symbolTable->lookUp((yyvsp[-2].Symbol)->getName())->getDeclarationType();

			if(decType != (yyvsp[0].Symbol)->getDeclarationType()){
				string err = "Invalid Assignment! Assigning "+(yyvsp[0].Symbol)->getDeclarationType()+"to "+decType;
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
		}
		AssemblyCode asmCode;asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
		asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
		asmCode.append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
		if((yyvsp[-2].Symbol)->getType()=="notarray"){
			asmCode.append("\tmov "+(yyvsp[-2].Symbol)->getIdValue()+",ax\n");
		}
		else{
			asmCode.append("\tmov "+(yyvsp[-2].Symbol)->getIdValue()+"[BX],ax\n");
		}
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue((yyvsp[-2].Symbol)->getIdValue());
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+"="+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[-2].Symbol)->getDeclarationType());

	}
#line 2754 "y.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 939 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"logic_expression : rel_expression");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
		string name1 = (yyvsp[0].Symbol)->getName();
		Util::parserLog(name1);(yyval.Symbol)->setName(name1);

	}
#line 2769 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 949 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"logic_expression : rel_expression-LOGICOP-rel_expression");
		(yyval.Symbol) = TOKEN;
		if((yyvsp[-2].Symbol)->getDeclarationType()=="void "||(yyvsp[0].Symbol)->getDeclarationType()=="void "){
			(yyval.Symbol)->setDeclarationType("int ");
			string err = "Expected Relational Expression found void";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		}
		AssemblyCode asmCode;
		asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode()).append((yyvsp[0].Symbol)->getAssemblyCode());
		char *label1=asmGen.newLabel(),*label2=asmGen.newLabel(),*label3=asmGen.newLabel(),*temp=asmGen.newTemp();

		if((yyvsp[-1].Symbol)->getName()=="||"){
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n").append("\tcmp ax,0\n").append("\tjne "+string(label2)+"\n")
			.append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n").append("\tcmp ax,0\n").append("\tjne "+string(label2)+"\n")
			.append(string(label1)+":\n").append("\tmov "+string(temp)+",0\n").append("\tjmp "+string(label3)+"\n")
			.append(string(label2)+":\n").append("\tmov "+string(temp)+",1\n").append(string(label3)+":\n");
		}
		else{
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n")
			.append("\tcmp ax,0\n").append("\tje "+string(label2)+"\n").append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n")
			.append("\tcmp ax,0\n").append("\tje "+string(label2)+"\n").append(string(label1)+":\n")
			.append("\tmov "+string(temp)+",1\n").append("\tjmp "+string(label3)+"\n").append(string(label2)+":\n")
			.append("\tmov "+string(temp)+",0\n").append(string(label3)+":\n");
		}
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(temp);
		asmGen.vars.push_back(temp);

		Util::parserLog((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType("int ");
	}
#line 2806 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 982 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"rel_expression : simple_expression");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
	}
#line 2820 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 991 "1605103.y" /* yacc.c:1646  */
    {

		Util::parserLog(lines,"rel_expression : simple_expression-RELOP-simple_expression");

		(yyval.Symbol) = TOKEN;

		Util::parserLog((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());

		if((yyvsp[-2].Symbol)->getDeclarationType()=="void "||(yyvsp[0].Symbol)->getDeclarationType()=="void "){
			string err = "void expressions cannot be relationally compared";
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);(yyval.Symbol)->setDeclarationType("int ");
		}
		(yyval.Symbol)->setDeclarationType("int ");

		string name1 = (yyvsp[-2].Symbol)->getName();

		string name2 = (yyvsp[-1].Symbol)->getName();

		string name3 = (yyvsp[0].Symbol)->getName();

		(yyval.Symbol)->setName(name1+name2+name3);

		AssemblyCode asmCode;asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode());
		asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
		char *temp=asmGen.newTemp();
		char *label1=asmGen.newLabel();
		char *label2=asmGen.newLabel();
		asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
		asmCode.append("\tcmp ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
		if((yyvsp[-1].Symbol)->getName()=="<"){
			asmCode.append("\tjl "+string(label1)+"\n");

		}
		else if((yyvsp[-1].Symbol)->getName()==">"){
			asmCode.append("\tjg "+string(label1)+"\n");

		}
		else if((yyvsp[-1].Symbol)->getName()=="<="){
			asmCode.append("\tjle "+string(label1)+"\n");

		}
		else if((yyvsp[-1].Symbol)->getName()==">="){
			asmCode.append("\tjge "+string(label1)+"\n");

		}
		else if((yyvsp[-1].Symbol)->getName()=="=="){
			asmCode.append("\tje "+string(label1)+"\n");

		}
		else if((yyvsp[-1].Symbol)->getName()=="!="){
			asmCode.append("\tjne "+string(label1)+"\n");

		}
		asmCode.append("\tmov "+string(temp)+",0\n");
		asmCode.append("\tjmp "+string(label2)+"\n");
		asmCode.append(string(label1)+":\n");
		asmCode.append("\tmov "+string(temp)+",1\n");
		asmCode.append(string(label2)+":\n");
		asmGen.vars.push_back(temp);
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(temp);

	}
#line 2888 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 1055 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"simple_expression : term");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[0].Symbol)->getName());
		if(DEBUG)cout<<(yyvsp[0].Symbol)->toString()<<endl;
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
	}
#line 2903 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 1065 "1605103.y" /* yacc.c:1646  */
    {
		if(DEBUG)cout<<(yyvsp[0].Symbol)->getDeclarationType()<<endl;

		Util::parserLog(lines,"simple_expression : simple_expression-ADDOP-term");

		(yyval.Symbol) = TOKEN;

		Util::parserLog((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());

		if((yyvsp[-2].Symbol)->getDeclarationType()=="float " || (yyvsp[0].Symbol)->getDeclarationType()=="float "){
			(yyval.Symbol)->setDeclarationType("float ");
		}
		else if((yyvsp[-2].Symbol)->getDeclarationType()=="void "||(yyvsp[0].Symbol)->getDeclarationType()=="void "){
			string err = "void expression cannot be used as operands of +/-";(yyval.Symbol)->setDeclarationType("int ");
			yyerror(err.c_str());Util::appendLogError(lines,err,PARSER);
		}
		else {(yyval.Symbol)->setDeclarationType("int ");}

		AssemblyCode asmCode;
		asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());

		asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
		char *temp=asmGen.newTemp();
		if((yyvsp[-1].Symbol)->getName()=="+"){
			asmCode.append("\tadd ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
		}
		else{
			asmCode.append("\tsub ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");

		}
		asmCode.append("\tmov "+string(temp)+",ax\n");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(temp);
		asmGen.vars.push_back(temp);
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
	}
#line 2944 "y.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 1102 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"term : unary_expression");
		(yyval.Symbol) = TOKEN;
		if(DEBUG)cout<<(yyvsp[0].Symbol)->toString()<<endl;

		Util::parserLog((yyvsp[0].Symbol)->getName());
		string name  = (yyvsp[0].Symbol)->getName();
		string decType = (yyvsp[0].Symbol)->getDeclarationType();
		(yyval.Symbol)->setDeclarationType(decType);
		(yyval.Symbol)->setName(name);

		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());

	}
#line 2964 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 1117 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"term : term-MULOP-unary_expression");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[-2].Symbol)->getName()+(yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
		if((yyvsp[-2].Symbol)->getDeclarationType()=="void "|| (yyvsp[0].Symbol)->getDeclarationType()=="void "){
			string err = "void expressions cannot be used as operands of *,/";
			yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);(yyval.Symbol)->setDeclarationType("int ");

		}else if((yyvsp[-1].Symbol)->getName()=="%"){
			if((yyvsp[-2].Symbol)->getDeclarationType()!="int " ||(yyvsp[0].Symbol)->getDeclarationType()!="int "){
				string err = "Modulus(%) operator cannot have non-integer operands";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			}
			(yyval.Symbol)->setDeclarationType("int ");
			AssemblyCode asmCode;
			asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmov DX,0\n");
			asmCode.append("\tdiv BX\n");
			asmCode.append("\tmov "+string(temp)+", DX\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
			(yyval.Symbol)->setIdValue(temp);
			asmGen.vars.push_back(temp);
		}
		else if((yyvsp[-1].Symbol)->getName()=="/"){
			if((yyvsp[-2].Symbol)->getDeclarationType()=="int " && (yyvsp[0].Symbol)->getDeclarationType()=="int "){
				(yyval.Symbol)->setDeclarationType("int ");
			}
			else if((yyvsp[-2].Symbol)->getDeclarationType()=="void "||(yyvsp[0].Symbol)->getDeclarationType()=="void "){
				string err = "void expressions cannot be used as operands of *,/";Util::appendLogError(lines,err,PARSER);
				yyerror(err.c_str());(yyval.Symbol)->setDeclarationType("int ");
			}
			else {
				(yyval.Symbol)->setDeclarationType("float ");
			}
			AssemblyCode asmCode;asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
			asmCode.append("\tdiv BX\n");
			asmCode.append("\tmov "+string(temp)+", ax\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
			(yyval.Symbol)->setIdValue(temp);
			asmGen.vars.push_back(temp);

		}
		else{
			if((yyvsp[-2].Symbol)->getDeclarationType()=="float " || (yyvsp[0].Symbol)->getDeclarationType()=="float "){
				(yyval.Symbol)->setDeclarationType("float ");
			}
			else if((yyvsp[-2].Symbol)->getDeclarationType()=="void "||(yyvsp[0].Symbol)->getDeclarationType()=="void "){
				string err = "void expressions cannot be used as operands of *,/";
				Util::appendLogError(lines,err,PARSER);(yyval.Symbol)->setDeclarationType("int "); yyerror(err.c_str());
			}
			else (yyval.Symbol)->setDeclarationType("int ");

			AssemblyCode asmCode;asmCode.append((yyvsp[-2].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+(yyvsp[-2].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmov BX,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
			asmCode.append("\tmul BX\n");
			asmCode.append("\tmov "+string(temp)+", ax\n");
			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
			(yyval.Symbol)->setIdValue(temp);
			asmGen.vars.push_back(temp);

			}

		string name1 = (yyvsp[-2].Symbol)->getName();

		string name2 = (yyvsp[-1].Symbol)->getName();

		string name3 = (yyvsp[0].Symbol)->getName();

		(yyval.Symbol)->setName(name1+name2+name3);
	}
#line 3048 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 1197 "1605103.y" /* yacc.c:1646  */
    {
	(yyval.Symbol) = TOKEN;
	if((yyvsp[0].Symbol)->getDeclarationType()=="void "){
		string err = "void Unary Expression";Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
		(yyval.Symbol)->setDeclarationType("int ");
	}else {
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		AssemblyCode asmCode;
		asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
		//Since Unary Expression and we dont allow +val
		if((yyvsp[-1].Symbol)->getName()=="-"){
			asmCode.append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
			asmCode.append("\tneg ax\n");
			asmCode.append("\tmov "+(yyvsp[0].Symbol)->getIdValue()+",ax\n");
		}
		/**$<symbolinfo>$->set_ASMcode(codes);
		$<symbolinfo>$->set_idvalue($<symbolinfo>2->get_idvalue());

		 $<symbolinfo>$->setDectype($<symbolinfo>2->get_dectype());**/
	}
	Util::parserLog(lines,"unary_expression : ADDOP-unary_expression");
	(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());
	Util::parserLog((yyvsp[-1].Symbol)->getName()+(yyvsp[0].Symbol)->getName());

	}
#line 3078 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 1222 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"unary_expression : NOT-unary_expression");
		Util::parserLog("!"+(yyvsp[0].Symbol)->getName());
		if((yyvsp[0].Symbol)->getDeclarationType()=="void "){
			string err = "void Unary Expression";
			yyerror(err.c_str());
			(yyval.Symbol)->setDeclarationType("int ");
			Util::appendLogError(lines,err,PARSER);
		}else
		{
			(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
			AssemblyCode asmCode;asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
			asmCode.append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"\n");
			asmCode.append("\tNOT ax\n");
			asmCode.append("\tmov "+(yyvsp[0].Symbol)->getIdValue()+",ax\n");

			(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
			(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
		}
		(yyval.Symbol)->setName("!"+(yyvsp[0].Symbol)->getName());}
#line 3104 "y.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 1243 "1605103.y" /* yacc.c:1646  */
    {

		if(DEBUG)cout<<(yyvsp[0].Symbol)->toString()<<endl;
		(yyval.Symbol) = TOKEN;Util::parserLog(lines,"unary_expression : factor");(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
	}
#line 3117 "y.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 1252 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"factor : variable");	(yyval.Symbol) = TOKEN;Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setDeclarationType((yyvsp[0].Symbol)->getDeclarationType());
		AssemblyCode asmCode;asmCode.append((yyvsp[0].Symbol)->getAssemblyCode());
		if((yyvsp[0].Symbol)->getType()=="array"){
			char *temp=asmGen.newTemp();
			asmCode.append("\tmov ax,"+(yyvsp[0].Symbol)->getIdValue()+"[BX]\n").append("\tmov "+string(temp)+",ax\n");
			asmGen.vars.push_back(temp);(yyval.Symbol)->setIdValue(temp);
		}
		else (yyval.Symbol)->setIdValue((yyvsp[0].Symbol)->getIdValue());
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
	}
#line 3135 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 1265 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"factor : ID-LPAREN-argument_list-RPAREN");
		Util::parserLog((yyvsp[-3].Symbol)->getName()+"("+(yyvsp[-1].Symbol)->getName()+")");
		SymbolInfo* s = symbolTable->lookUp((yyvsp[-3].Symbol)->getName());
		if(s==nullptr){
			string err = "Undeclared Function";
			Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
			(yyval.Symbol)->setDeclarationType("int ");
		}
		else if(s->getFunction()==nullptr){
			string err = "Not a Function";yyerror(err.c_str());
			Util::appendLogError(lines,err,PARSER);
			(yyval.Symbol)->setDeclarationType("int ");
		}
		else {
			if(s->getFunction()->isDefined()==0){
				pair<string,int> p;
				p.first = s->getName();
				p.second = lines;
				possiblyUndefinedFunctions.push_back(p);
			}

			(yyval.Symbol)->setDeclarationType(s->getFunction()->getReturnType());

			if(DEBUG)cout<<lines<<" "<<argList.size()<<endl;

			int num = s->getFunction()->getParamCount();

			if(num!=argList.size()){
				string err = "Invalid number of arguments.Found :"+to_string(num)+" args Expected :"+to_string(argList.size())+" args";
				Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());

			}
			else{
				if(DEBUG)cout<<s->getFunction()->getReturnType()<<endl;

				vector<string>paramType = s->getFunction()->getAllParamTypes();
				vector<string>paramList = s->getFunction()->getAllParams();

				AssemblyCode asmCode;asmCode.append((yyvsp[-1].Symbol)->getAssemblyCode());
				int len = argList.size();
				for(int i=0;i<len;i++){
					if(argList[i]->getDeclarationType()!=paramType[i]){
						string err = "Expected "+Util::trim(paramType[i])+" but passed "
						+ Util::trim(argList[i]->getDeclarationType())+" as "+to_string(i)+"th parameter";
						Util::appendLogError(lines,err,PARSER);yyerror(err.c_str());
						break;
					}
					asmCode.append("\tmov ax,"+argList[i]->getIdValue()+"\n");
					asmCode.append("\tmov "+paramList[i]+",ax\n");
				}
				asmCode.append("\tcall "+(yyvsp[-3].Symbol)->getName()+"\n");
				asmCode.append("\tmov ax,"+(yyvsp[-3].Symbol)->getName()+"_return\n");
				char *temp=asmGen.newTemp();
				asmCode.append("\tmov "+string(temp)+",ax\n");
				(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
				(yyval.Symbol)->setIdValue(temp);
				asmGen.vars.push_back(temp);

			}
		}
		argList.clear();
		if(DEBUG)cout<<lines<<" "<<(yyval.Symbol)->getDeclarationType()<<endl;
		string name1 = (yyvsp[-3].Symbol)->getName(),name3 = (yyvsp[-1].Symbol)->getName();
		(yyval.Symbol)->setName(name1+"("+name3+")");
	}
#line 3207 "y.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 1332 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setDeclarationType((yyvsp[-1].Symbol)->getDeclarationType());

		Util::parserLog(lines,"factor : LPAREN-expression-RPAREN");
		(yyval.Symbol)->setName("("+(yyvsp[-1].Symbol)->getName()+")");
		Util::parserLog("("+(yyvsp[-1].Symbol)->getName()+")");
		(yyval.Symbol)->setAssemblyCode((yyvsp[-1].Symbol)->getAssemblyCode());
		(yyval.Symbol)->setIdValue((yyvsp[-1].Symbol)->getIdValue());

	}
#line 3223 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 1343 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		if(DEBUG)cout<<(yyvsp[0].Symbol)->toString()<<endl;
		Util::parserLog(lines,"factor : CONST_INT");
		(yyval.Symbol)->setDeclarationType("int ");
		Util::parserLog((yyvsp[0].Symbol)->getName());

		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("\tmov "+string(temp)+","+(yyvsp[0].Symbol)->getName()+"\n");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(string(temp));

		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		asmGen.vars.push_back(temp);

	}
#line 3244 "y.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 1359 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"factor : CONST_FLOAT");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setDeclarationType("float ");
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("\tmov "+string(temp)+","+(yyvsp[0].Symbol)->getName()+"\n");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(string(temp));
		asmGen.vars.push_back(temp);

	}
#line 3262 "y.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 1372 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"factor : variable INCOP");

		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setDeclarationType((yyvsp[-1].Symbol)->getDeclarationType());

		Util::parserLog((yyvsp[-1].Symbol)->getName()+"++");

		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("");
		if((yyvsp[-1].Symbol)->getType()=="array"){
			asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"[BX]\n");
		}
		else
		asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"\n");
		asmCode.append("\tmov "+string(temp)+",ax\n");
		if((yyvsp[-1].Symbol)->getType()=="array"){
			asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"[BX]\n");
			asmCode.append("\tinc ax\n");
			asmCode.append("\tmov "+(yyvsp[-1].Symbol)->getIdValue()+"[BX],ax\n");
		}
		else
		asmCode.append("\tinc "+(yyvsp[-1].Symbol)->getIdValue()+"\n");
		asmGen.vars.push_back(temp);

		(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+"++");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(temp);


	}
#line 3298 "y.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 1403 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"factor : variable DECOP");
		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setDeclarationType((yyvsp[-1].Symbol)->getDeclarationType());
		Util::parserLog((yyvsp[-1].Symbol)->getName()+"--");


		char *temp=asmGen.newTemp();
		AssemblyCode asmCode;asmCode.append("");
		if((yyvsp[-1].Symbol)->getType()=="array"){
			asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"[BX]\n");
		}
		else asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"\n");
		asmCode.append("\tmov "+string(temp)+",ax\n");
		if((yyvsp[-1].Symbol)->getType()=="array"){
			asmCode.append("\tmov ax,"+(yyvsp[-1].Symbol)->getIdValue()+"[BX]\n");
			asmCode.append("\tdec ax\n");
			asmCode.append("\tmov "+(yyvsp[-1].Symbol)->getIdValue()+"[BX],ax\n");
		}
		else asmCode.append("\tdec "+(yyvsp[-1].Symbol)->getIdValue()+"\n");
		asmGen.vars.push_back(temp);

		(yyval.Symbol)->setName((yyvsp[-1].Symbol)->getName()+"--");
		(yyval.Symbol)->setAssemblyCode(asmCode.getFinalCode());
		(yyval.Symbol)->setIdValue(temp);

	}
#line 3330 "y.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 1432 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"argument_list : arguments");
		(yyval.Symbol) = TOKEN;
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());
	}
#line 3342 "y.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 1439 "1605103.y" /* yacc.c:1646  */
    {
		(yyval.Symbol) = TOKEN;
		Util::parserLog(lines,"argument_list : %empty");Util::parserLog(lines,"");(yyval.Symbol)->setName("");}
#line 3350 "y.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 1444 "1605103.y" /* yacc.c:1646  */
    {

		(yyval.Symbol) = TOKEN;
		(yyval.Symbol)->setName((yyvsp[-2].Symbol)->getName()+","+(yyvsp[0].Symbol)->getName());

		Util::parserLog(lines,"arguments : arguments-COMMA-logic_expression ");
		argList.push_back((yyvsp[0].Symbol));
		Util::parserLog((yyvsp[-2].Symbol)->getName()+","+(yyvsp[0].Symbol)->getName());

		(yyval.Symbol)->setAssemblyCode((yyvsp[-2].Symbol)->getAssemblyCode()+(yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 3367 "y.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 1456 "1605103.y" /* yacc.c:1646  */
    {
		Util::parserLog(lines,"arguments : logic_expression");
		(yyval.Symbol) = TOKEN;
		argList.push_back((yyvsp[0].Symbol));
		Util::parserLog((yyvsp[0].Symbol)->getName());
		(yyval.Symbol)->setName((yyvsp[0].Symbol)->getName());

		(yyval.Symbol)->setAssemblyCode((yyvsp[0].Symbol)->getAssemblyCode());

	}
#line 3382 "y.tab.c" /* yacc.c:1646  */
    break;


#line 3386 "y.tab.c" /* yacc.c:1646  */
        default: break;
      }
    if (yychar_backup != yychar)
      YY_LAC_DISCARD ("yychar change");
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
                                        yyesa, &yyes, &yyes_capacity, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        if (yychar != YYEMPTY)
          YY_LAC_ESTABLISH;
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

  /* If the stack popping above didn't lose the initial context for the
     current lookahead token, the shift below will for sure.  */
  YY_LAC_DISCARD ("error recovery");

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

#if 1
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
  if (yyes != yyesa)
    YYSTACK_FREE (yyes);
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1467 "1605103.y" /* yacc.c:1906  */


void endingRoutine(){
	for(int i=0;i < possiblyUndefinedFunctions.size();i++){
		if(!symbolTable->lookUp(possiblyUndefinedFunctions[i].first)->getFunction()->isDefined()){
			string err = "Calling Undefined Function "+possiblyUndefinedFunctions[i].first;
			Util::appendLogError(possiblyUndefinedFunctions[i].second,err,PARSER);yyerror(err.c_str());

		}
	}
	possiblyUndefinedFunctions.clear();
}
void test(string fileName){
	asmGen = AsmCodeGenerator();
	lines = 1;
	errors = 0;
	if((fp=fopen(fileName.c_str(),"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
	}
	yyin=fp;
	cout<<fileName<<endl;
	currentFile = fileName;
	symbolTable = new SymbolTable(100);
	Util::parserLog("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n");
	Util::appendLogError("\n\n^^^^^^^^^^^Parsing "+fileName+"^^^^^^^^^^^\n\n",PARSER);
	yyparse();
	endingRoutine();
	Util::parserLog("Final SymbolTable : ");
	symbolTable->printAllScopeTables();
	if(isParsingSuccessful){
		Util::parserLog("Total Lines :"+to_string(lines));
		Util::parserLog("Total Errors :"+to_string(errors));
		cout<<"Total Lines :"<<lines<<endl;
		cout<<"Total Errors :"<<errors<<endl;
		Util::appendLogError("\nTotal Errors :"+to_string(errors)+'\n',PARSER);
	}
	else isParsingSuccessful = true;
	fclose(fp);
	Util::parserLog("\n\n^^^^^^^^^^^Finished Parsing "+fileName+"^^^^^^^^^^^\n\n");
}
bool isRedundant(string s1,string s2){
	s1 = Util::trim(s1);
	s2 = Util::trim(s2);

	if(s1 == s2)return true;

	size_t isMov1 = s1.find("mov"),isMov2 = s2.find("mov");
	if(isMov1 == string::npos || isMov2 == string::npos) return false;

	vector<string> srcDest1,srcDest2;
	Util::split(s1.substr(3,s1.size()),srcDest1,',');
	Util::split(s2.substr(3,s2.size()),srcDest2,',');

	//cout<<srcDest1[0]<<srcDest1[1]<<endl;
	//cout<<srcDest2[0]<<srcDest2[1]<<endl;
	bool c1 = Util::trim(srcDest1[0]) == Util::trim(srcDest2[1]);
	bool c2 = Util::trim(srcDest1[1]) == Util::trim(srcDest2[0]);

	if(c1 && c2) return true;

	return false;
}
void optimize(string asmFile){
	vector<string> lines;
	Util::readAllFromFile(lines,asmFile);
	int len = lines.size();

	AssemblyCode optimized;
	bool isNotRequired[len]={false};

	cout<<"Need to Optimize"<<endl;

	for(int i=0;i<len-1;i++){
		if(isRedundant(lines[i],lines[i+1])){
			cout<<i+1<<":"<<lines[i+1]<<endl;
			isNotRequired[i+1] = true;
		}

	}
	cout<<"Skipping"<<endl;
	for(int i=0;i<len;i++){
		if(isNotRequired[i]){
			cout<<i<<":"<<lines[i]<<endl;
			continue;
		}
		optimized.append(lines[i]).append("\n");

	}
	asmGen.generateFinalAsmFile(asmFile.substr(0,asmFile.size()-4)+"_opt.asm",optimized.getFinalCode());

}

int main(int argc,char *argv[])
{
	Util::clearFiles();

	int i = 1;
	while(*(argv + i)!=nullptr){
		test(argv[i]);
		i++;
	}


	return 0;
}
