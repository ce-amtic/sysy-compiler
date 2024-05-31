/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "sysy.y"

#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include "assembly.hpp"
#include "symbols.hpp"
#include "ast.hpp"

int yylex(void);
void yyerror(const char *s);

#define PARAM_SIZE 8

char msg[512];
FILE *detail_fp;

int level;  // 0: global, 1+: local
int offset; // offset from the base pointer (rbp)
std::vector<int> offsets;
bool haveReturn = false;

struct RuntimeState {
    int line;
    int offset;
    RuntimeState() {}
    RuntimeState(int line, int offset) : line(line), offset(offset) {}
};
struct RuntimeStack {
    void push(int line, int offset) {
        states.back().push_back(RuntimeState(line, offset));
    }
    void pop() {
        states.back().pop_back();
    }
    void nextLevel() {
        states.push_back(std::vector<RuntimeState>());
    }
    void prevLevel() {
        states.pop_back();
    }
    std::vector<RuntimeState> &back() {
        return states.back();
    }
private:
    std::vector<std::vector<RuntimeState> > states;
}breaks, continues;

void handleIO(const char *func, ParamList* params) {
    int argc = params->exp.size();
    if(argc > 6) {
        sprintf(msg, "too many arguments to function '%s'", func);
        yyerror(msg);
        return;
    }
    if(!strcmp(func, "printf")) {
        text.append("\tleaq\t%s(%%rip), %s\t\t# printf", params->exp[0]->text, ParamRegs[0]);
        for(int i = 1; i < argc; i++){
            Exp* cur = params->exp[i];
            // fprintf(stderr, "arg%d: %s, offset: %d, isConst: %d, value: %d, level: %d\n", i, cur->text, cur->offset, cur->isConst, cur->value, cur->level);
            text.loadReg(cur, "%r8d");
            text.append("\tmovsxd\t%%r8d, %%r8\n");
            text.append("\tmovq\t%%r8, %s\n", ParamRegs[i]);
        }
        text.append("\tcall\tprintf");
    } else {
        /* handle scanf */
        text.append("\tleaq\t%s(%%rip), %s\t\t# scanf", params->exp[0]->text, ParamRegs[0]);
        for(int i = 1; i < argc; i++){
            Exp* cur = params->exp[i];
            if(!cur->isPointer) {
                sprintf(msg, "argument of '%s' must be a pointer", i, func);
                yyerror(msg);
                return;
            }
            text.append("\tmovq\t%d(%%rbp), %s\n", cur->offset, ParamRegs[i]);
        }
        text.append("\tcall\tscanf");
    } 
}

int calculateOffsetInArray(Symbol* sym, ExpDims* dims) {
    if(!dims->isConst) {
        sprintf(msg, "[internal error] error calculating array index");
        yyerror(msg);
        return -1;
    }
    int offsetInArray = 0;
    for(int i = 0; i < sym->sizes.size(); i++) {
        offsetInArray = offsetInArray * sym->sizes[i];
        if(i < dims->values.size()){
            offsetInArray = offsetInArray + dims->values[i];
        }
    }
    return offsetInArray;
}

void calculateOffsetInArray(Symbol* sym, ExpDims* dims, Assembly& txt) { // sym[dims...]
    if (dims != nullptr) {
        if(dims->isConst) {
            int offsetInArray =  calculateOffsetInArray(sym, dims);
            txt.append("\tmovl\t$%d, %%ecx\n", offsetInArray);
        } else {
            // generate code to calculate 'offsetInArray'
            txt.append("\tmovl\t$0, %%ecx\n"); // int of = 0;
            for(int i = 0; i < sym->sizes.size(); i++) {
                // offsetInArray = offsetInArray * sym->sizes[i] + dims->values[i];
                txt.append("\timull\t$%d, %%ecx\n", sym->sizes[i]);
                if(i < dims->values.size()){
                    if(dims->isConsts[i])
                        txt.append("\tmovl\t$%d, %%r8d\n", dims->values[i]);
                    else 
                        txt.append("\tmovl\t%d(%%rbp), %%r8d\n", dims->values[i]);
                    txt.append("\taddl\t%%r8d, %%ecx\n");
                }
            }
        }
        text.append("\tmovslq\t%%ecx, %%rcx\n");
        // 'offsetInArray' is %rcx
    } else {
        sprintf(msg, "[internal error] cannot parse array index");
        yyerror(msg);
    }
}

void enterLevel() {
    level++;
    symbols.nextLevel();
}
void exitLevel() {
    level--;
    symbols.prevLevel();
}

template <typename T>
std::vector<T> mergeVector(const std::vector<T>& a, const std::vector<T>& b) {
    std::vector<T> res;
    for(auto x: a) res.push_back(x);
    for(auto x: b) res.push_back(x);
    std::sort(res.begin(), res.end());
    res.erase(std::unique(res.begin(), res.end()), res.end());
    return res;
}

#line 214 "sysy.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_SYSY_TAB_H_INCLUDED
# define YY_YY_SYSY_TAB_H_INCLUDED
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
    Number = 258,
    Ident = 259,
    String = 260,
    INT = 261,
    CONST = 262,
    VOID = 263,
    WHILE = 264,
    RETURN = 265,
    BREAK = 266,
    CONTINUE = 267,
    IF = 268,
    INCLUDE = 269,
    LE = 270,
    GE = 271,
    LT = 272,
    GT = 273,
    EQUAL = 274,
    NE = 275,
    AND = 276,
    OR = 277,
    ADD = 278,
    SUB = 279,
    MUL = 280,
    DIV = 281,
    NOT = 282,
    MOD = 283,
    LPAREN = 284,
    RPAREN = 285,
    LBRACE = 286,
    RBRACE = 287,
    LBRACKET = 288,
    RBRACKET = 289,
    SEMICOLON = 290,
    COMMA = 291,
    ASSIGN = 292,
    DOT = 293,
    HASH = 294,
    ADDRESSOF = 295,
    IFX = 296,
    ELSE = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 145 "sysy.y"

    char* str;
    int num;
    struct Symbol* symbol;
    struct List* list;
    struct Dims* dims;
    struct Exp* exp;
    struct ExpList* explist;
    struct ExpDims* expdims;
    struct ParamDef* paramdef;
    struct ParamDefList* paramdeflist;
    struct ParamList* paramlist;
    struct BoolExp* boolexp;
    struct LValue* lvalue;

#line 325 "sysy.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYSY_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

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

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
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

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

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
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
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
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  18
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   316

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  43
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  49
/* YYNRULES -- Number of rules.  */
#define YYNRULES  115
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  211

#define YYUNDEFTOK  2
#define YYMAXUTOK   297


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
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
static const yytype_int16 yyrline[] =
{
       0,   190,   190,   193,   196,   199,   202,   205,   208,   211,
     214,   216,   219,   222,   225,   251,   281,   287,   296,   302,
     307,   312,   317,   323,   328,   331,   334,   353,   377,   407,
     448,   455,   461,   469,   475,   481,   487,   490,   494,   508,
     521,   530,   543,   559,   565,   571,   576,   584,   590,   601,
     607,   618,   621,   624,   625,   627,   628,   630,   637,   643,
     662,   668,   674,   727,   734,   740,   744,   748,   753,   759,
     762,   767,   774,   783,   787,   791,   797,   804,   812,   820,
     862,   933,   939,   949,   953,   980,  1026,  1030,  1049,  1102,
    1141,  1145,  1149,  1153,  1158,  1166,  1175,  1179,  1200,  1222,
    1244,  1248,  1263,  1278,  1292,  1306,  1320,  1334,  1347,  1361,
    1375,  1379,  1383,  1387,  1395,  1399
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "Number", "Ident", "String", "INT",
  "CONST", "VOID", "WHILE", "RETURN", "BREAK", "CONTINUE", "IF", "INCLUDE",
  "LE", "GE", "LT", "GT", "EQUAL", "NE", "AND", "OR", "ADD", "SUB", "MUL",
  "DIV", "NOT", "MOD", "LPAREN", "RPAREN", "LBRACE", "RBRACE", "LBRACKET",
  "RBRACKET", "SEMICOLON", "COMMA", "ASSIGN", "DOT", "HASH", "ADDRESSOF",
  "IFX", "ELSE", "$accept", "CompUnit", "ExternalDef", "Decl", "VarDecl",
  "ConstDecl", "ConstDeflist", "ConstDef", "ConstDims", "ConstInitVal",
  "ConstInitValList", "VarDefList", "VarDef", "InitVal", "InitValList",
  "FuncDef", "FuncName", "EnterFunc", "ExitFunc", "ParseParams",
  "FuncFParams", "FuncFParam", "FuncIdentDims", "Block", "BlockItemlist",
  "BlockItem", "Stmt", "EnterStmt", "ExitStmt", "NewLabel", "AfterElse",
  "EnterWhile", "ExitWhile", "Exp", "Cond", "LVal", "Arr", "PrimaryExp",
  "UnaryExp", "UnaryOp", "FuncRParams", "ConstExp", "MulExp", "AddExp",
  "RelExp", "EqExp", "BoolExp", "LAndExp", "LOrExp", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297
};
# endif

#define YYPACT_NINF (-194)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-77)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      37,    27,    31,    48,    70,    80,  -194,  -194,  -194,  -194,
    -194,  -194,    38,   -12,  -194,    58,  -194,    72,  -194,  -194,
    -194,    69,   276,   276,    78,  -194,   119,    99,    47,  -194,
     121,     5,  -194,    41,  -194,  -194,  -194,  -194,   276,   122,
    -194,  -194,   276,   103,   192,    68,  -194,    68,   276,   109,
     105,  -194,   276,   106,  -194,    58,   112,   152,   126,   128,
     131,  -194,   104,   276,   137,   148,   167,  -194,  -194,   276,
     276,   276,   276,   276,   146,    24,  -194,  -194,   150,  -194,
     198,   175,    90,  -194,   126,   201,  -194,  -194,   -20,   176,
     276,  -194,   137,  -194,  -194,  -194,   192,   192,  -194,  -194,
    -194,   136,  -194,   172,  -194,   203,   182,   186,    87,   119,
    -194,   210,   191,   193,   200,  -194,  -194,  -194,   142,  -194,
    -194,   195,   190,  -194,  -194,  -194,  -194,   276,  -194,   197,
    -194,   220,  -194,  -194,   147,  -194,  -194,  -194,   202,   249,
     151,  -194,  -194,   205,  -194,  -194,  -194,  -194,  -194,  -194,
     276,  -194,  -194,  -194,  -194,  -194,  -194,   261,  -194,  -194,
     204,   206,  -194,   276,   211,  -194,  -194,  -194,   221,   224,
     213,  -194,  -194,  -194,  -194,   174,  -194,  -194,  -194,  -194,
     225,   276,   276,   276,   276,   276,   276,  -194,  -194,   221,
    -194,    68,    68,    68,    68,    68,    68,     9,  -194,  -194,
       9,   214,  -194,  -194,  -194,  -194,  -194,     9,  -194,  -194,
    -194
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     0,     0,     4,     2,     9,     8,
       3,    40,    26,     0,    24,     0,    39,     0,     1,     5,
       6,     0,     0,     0,    27,    10,     0,     0,     0,    12,
       0,     0,    81,    79,    82,    90,    91,    92,     0,     0,
      86,    96,     0,     0,   100,    95,    28,    73,     0,     0,
      26,    25,     0,     0,    11,     0,     0,     0,     0,     0,
      42,    43,     0,     0,    80,     0,    84,    89,    16,     0,
       0,     0,     0,     0,     0,     0,    29,    14,     0,    13,
       0,    45,     0,    41,     0,     0,    87,    93,     0,     0,
       0,    83,    85,    97,    98,    99,   101,   102,    17,    30,
      33,     0,    32,     0,    15,     0,     0,    46,    79,     0,
      71,     0,     0,     0,     0,    51,    55,    66,     0,    53,
      56,     0,     0,    36,    41,    44,    88,     0,    77,     0,
      31,     0,    18,    21,     0,    20,     7,    47,     0,     0,
      80,    67,    64,     0,    60,    61,    69,    52,    54,    65,
       0,    37,    94,    78,    35,    34,    19,     0,    48,    49,
       0,     0,    63,     0,     0,   110,   111,   112,   114,    74,
       0,    23,    22,    50,    69,   107,    69,    69,    69,    62,
       0,     0,     0,     0,     0,     0,     0,    67,   113,   115,
      72,   104,   106,   103,   105,   108,   109,     0,    69,    68,
       0,    57,    68,    70,    59,    69,    67,     0,    68,    69,
      58
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -194,  -194,  -194,    60,  -194,  -194,  -194,   177,   230,   -98,
    -194,  -194,   232,   -74,  -194,   254,  -194,  -194,   138,  -194,
    -194,   178,  -194,   -50,  -194,   143,  -134,  -181,  -193,  -137,
    -194,  -194,  -194,   -21,    93,  -194,   -62,  -194,     8,  -194,
    -194,   -45,    32,   -22,  -194,  -194,    91,    92,  -194
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     5,     6,   116,     8,     9,    28,    29,    24,   104,
     134,    13,    14,    76,   101,    10,    11,    21,   123,    59,
      60,    61,   107,   117,   118,   119,   120,   161,   201,   163,
     205,   141,   198,   121,   164,   122,    64,    40,    41,    42,
      88,    43,    44,    47,   165,   166,   167,   168,   169
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      45,   100,    46,    74,    92,   133,   197,    77,    83,   204,
     126,    57,    32,   108,    34,   209,   127,    65,   110,   111,
     112,   113,   114,    25,    26,   207,    45,    32,    33,    34,
      45,    12,    35,    36,   124,    58,    37,    15,    38,   187,
      82,    87,    89,     1,     2,     3,   140,    35,    36,    39,
      67,    37,    16,    38,   102,    75,    99,   154,   135,   171,
       7,   200,    27,   199,    39,    19,   202,   -38,   206,   129,
      62,    22,   210,   208,    63,    23,     4,    93,    94,    95,
      18,    45,    54,    55,    17,   138,     1,     2,     3,    30,
     143,    72,    73,    32,   108,    34,   109,     2,    31,   110,
     111,   112,   113,   114,    96,    97,   152,    32,    33,    34,
     155,    48,   172,    35,    36,    49,    62,    37,   160,    38,
      63,    82,   115,    50,   -75,    56,    66,    35,    36,   170,
      39,    37,    22,    38,    86,    45,    52,    68,    22,    48,
      75,   175,    23,    78,    39,    32,   108,    34,   109,     2,
      80,   110,   111,   112,   113,   114,    81,    82,    84,   191,
     192,   193,   194,   195,   196,    35,    36,    85,   130,    37,
      90,    38,   131,    82,   147,    32,    33,    34,    91,   156,
      98,   103,    39,   157,    90,    32,    33,    34,   -76,   181,
     182,   183,   184,   185,   186,    35,    36,    72,    73,    37,
      63,    38,   105,   103,   132,    35,    36,    57,   106,    37,
     128,    38,    39,    32,    33,    34,   137,    69,    70,   139,
      71,   136,    39,    32,    33,    34,   144,   150,   145,   146,
     149,   153,    79,    35,    36,   174,   158,    37,   173,    38,
     162,   176,   177,    35,    36,   142,   178,    37,   179,    38,
      39,    75,    32,    33,    34,   190,   203,    53,    51,    20,
      39,   148,   151,   125,    32,    33,    34,   180,   188,     0,
     189,     0,    35,    36,     0,     0,    37,     0,    38,    32,
      33,    34,     0,   159,    35,    36,     0,     0,    37,    39,
      38,     0,   103,     0,     0,     0,     0,     0,     0,    35,
      36,    39,     0,    37,     0,    38,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    39
};

static const yytype_int16 yycheck[] =
{
      22,    75,    23,    48,    66,   103,   187,    52,    58,   202,
      30,     6,     3,     4,     5,   208,    36,    38,     9,    10,
      11,    12,    13,    35,    36,   206,    48,     3,     4,     5,
      52,     4,    23,    24,    84,    30,    27,     6,    29,   176,
      31,    62,    63,     6,     7,     8,   108,    23,    24,    40,
      42,    27,     4,    29,    75,    31,    32,   131,   103,   157,
       0,   198,     4,   197,    40,     5,   200,    29,   205,    90,
      29,    33,   209,   207,    33,    37,    39,    69,    70,    71,
       0,   103,    35,    36,    14,   106,     6,     7,     8,    17,
     111,    23,    24,     3,     4,     5,     6,     7,    29,     9,
      10,    11,    12,    13,    72,    73,   127,     3,     4,     5,
     131,    33,   157,    23,    24,    37,    29,    27,   139,    29,
      33,    31,    32,     4,    37,     4,     4,    23,    24,   150,
      40,    27,    33,    29,    30,   157,    37,    34,    33,    33,
      31,   163,    37,    37,    40,     3,     4,     5,     6,     7,
      38,     9,    10,    11,    12,    13,     4,    31,    30,   181,
     182,   183,   184,   185,   186,    23,    24,    36,    32,    27,
      33,    29,    36,    31,    32,     3,     4,     5,    30,    32,
      34,    31,    40,    36,    33,     3,     4,     5,    37,    15,
      16,    17,    18,    19,    20,    23,    24,    23,    24,    27,
      33,    29,     4,    31,    32,    23,    24,     6,    33,    27,
      34,    29,    40,     3,     4,     5,    34,    25,    26,    33,
      28,    18,    40,     3,     4,     5,    35,    37,    35,    29,
      35,    34,    55,    23,    24,    29,    34,    27,    34,    29,
      35,    30,    21,    23,    24,    35,    22,    27,    35,    29,
      40,    31,     3,     4,     5,    30,    42,    27,    26,     5,
      40,   118,   124,    85,     3,     4,     5,   174,   177,    -1,
     178,    -1,    23,    24,    -1,    -1,    27,    -1,    29,     3,
       4,     5,    -1,    34,    23,    24,    -1,    -1,    27,    40,
      29,    -1,    31,    -1,    -1,    -1,    -1,    -1,    -1,    23,
      24,    40,    -1,    27,    -1,    29,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    40
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     6,     7,     8,    39,    44,    45,    46,    47,    48,
      58,    59,     4,    54,    55,     6,     4,    14,     0,    46,
      58,    60,    33,    37,    51,    35,    36,     4,    49,    50,
      17,    29,     3,     4,     5,    23,    24,    27,    29,    40,
      80,    81,    82,    84,    85,    86,    76,    86,    33,    37,
       4,    55,    37,    51,    35,    36,     4,     6,    30,    62,
      63,    64,    29,    33,    79,    76,     4,    81,    34,    25,
      26,    28,    23,    24,    84,    31,    56,    84,    37,    50,
      38,     4,    31,    66,    30,    36,    30,    76,    83,    76,
      33,    30,    79,    81,    81,    81,    85,    85,    34,    32,
      56,    57,    76,    31,    52,     4,    33,    65,     4,     6,
       9,    10,    11,    12,    13,    32,    46,    66,    67,    68,
      69,    76,    78,    61,    66,    64,    30,    36,    34,    76,
      32,    36,    32,    52,    53,    84,    18,    34,    76,    33,
      79,    74,    35,    76,    35,    35,    29,    32,    68,    35,
      37,    61,    76,    34,    56,    76,    32,    36,    34,    34,
      76,    70,    35,    72,    77,    87,    88,    89,    90,    91,
      76,    52,    84,    34,    29,    86,    30,    21,    22,    35,
      77,    15,    16,    17,    18,    19,    20,    72,    89,    90,
      30,    86,    86,    86,    86,    86,    86,    70,    75,    69,
      72,    71,    69,    42,    71,    73,    72,    70,    69,    71,
      72
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    43,    44,    44,    44,    44,    44,    45,    46,    46,
      47,    48,    49,    49,    50,    50,    51,    51,    52,    52,
      53,    53,    53,    53,    54,    54,    55,    55,    55,    55,
      56,    56,    57,    57,    57,    57,    58,    58,    59,    59,
      60,    61,    62,    63,    63,    64,    64,    65,    65,    65,
      65,    66,    66,    67,    67,    68,    68,    69,    69,    69,
      69,    69,    69,    69,    69,    69,    69,    70,    71,    72,
      73,    74,    75,    76,    77,    78,    78,    79,    79,    80,
      80,    80,    80,    80,    80,    80,    81,    81,    81,    81,
      82,    82,    82,    83,    83,    84,    85,    85,    85,    85,
      86,    86,    86,    87,    87,    87,    87,    88,    88,    88,
      89,    89,    90,    90,    91,    91
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     2,     2,     7,     1,     1,
       3,     4,     1,     3,     3,     4,     3,     4,     2,     3,
       1,     1,     3,     3,     1,     3,     1,     2,     3,     4,
       2,     3,     1,     1,     3,     3,     6,     7,     2,     2,
       0,     0,     1,     1,     3,     2,     3,     2,     3,     3,
       4,     2,     3,     1,     2,     1,     1,     8,    15,    10,
       2,     2,     4,     3,     2,     2,     1,     0,     0,     0,
       0,     0,     0,     1,     1,     1,     2,     3,     4,     1,
       2,     1,     1,     3,     2,     3,     1,     3,     4,     2,
       1,     1,     1,     1,     3,     1,     1,     3,     3,     3,
       1,     3,     3,     4,     4,     4,     4,     2,     4,     4,
       1,     1,     1,     3,     1,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
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


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
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
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
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
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
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
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
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
            else
              goto append;

          append:
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

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
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
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

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
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
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
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
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
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
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
          ++yyp;
          ++yyformat;
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
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

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
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
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
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

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
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
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
| yyreduce -- do a reduction.  |
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
#line 190 "sysy.y"
               {
        fprintf(detail_fp, "Decl -> CompUnit\n");
    }
#line 1675 "sysy.tab.c"
    break;

  case 3:
#line 193 "sysy.y"
              {
        fprintf(detail_fp, "FuncDef -> CompUnit\n");
    }
#line 1683 "sysy.tab.c"
    break;

  case 4:
#line 196 "sysy.y"
                  {
        fprintf(detail_fp, "ExternalDef -> CompUnit\n");
    }
#line 1691 "sysy.tab.c"
    break;

  case 5:
#line 199 "sysy.y"
                    {
        fprintf(detail_fp, "CompUnit Decl -> CompUnit\n");
    }
#line 1699 "sysy.tab.c"
    break;

  case 6:
#line 202 "sysy.y"
                       {
        fprintf(detail_fp, "CompUnit FuncDef -> CompUnit\n");
    }
#line 1707 "sysy.tab.c"
    break;

  case 7:
#line 205 "sysy.y"
                                                {
        fprintf(detail_fp, "# include < %s . %s > -> ExternalDef\n", (yyvsp[-3].str), (yyvsp[-1].str));
    }
#line 1715 "sysy.tab.c"
    break;

  case 8:
#line 208 "sysy.y"
                {
        fprintf(detail_fp, "ConstDecl -> Decl\n");
    }
#line 1723 "sysy.tab.c"
    break;

  case 9:
#line 211 "sysy.y"
              {
        fprintf(detail_fp, "VarDecl -> Decl\n");
    }
#line 1731 "sysy.tab.c"
    break;

  case 10:
#line 214 "sysy.y"
                                  {fprintf(detail_fp, "int VarDefList ; -> VarDecl\n");
    }
#line 1738 "sysy.tab.c"
    break;

  case 11:
#line 216 "sysy.y"
                                            {
        fprintf(detail_fp, "const int ConstDeflist ; -> ConstDecl\n");
    }
#line 1746 "sysy.tab.c"
    break;

  case 12:
#line 219 "sysy.y"
                       {
        fprintf(detail_fp, "ConstDef -> ConstDeflist\n");
    }
#line 1754 "sysy.tab.c"
    break;

  case 13:
#line 222 "sysy.y"
                                  {
        fprintf(detail_fp, "ConstDeflist , ConstDef -> ConstDeflist\n");
    }
#line 1762 "sysy.tab.c"
    break;

  case 14:
#line 225 "sysy.y"
                                {
        fprintf(detail_fp, "%s = ConstInitVal -> ConstDef\n", (yyvsp[-2].str));
        if(symbols.lookup((yyvsp[-2].str), level) != nullptr) {
            sprintf(msg, "redeclaration of '%s'", (yyvsp[-2].str));
            yyerror(msg);
        } else {
            if(level == 0)
            {
                rodata.append("\n.align\t4\n");
                rodata.append(".type\t%s, @object\n", (yyvsp[-2].str));
                rodata.append(".size\t%s, 4\n", (yyvsp[-2].str));
                rodata.append("%s:\n", (yyvsp[-2].str));
                rodata.append("\t.long\t%d\n",(yyvsp[0].exp)->value);
                Symbol *sym = new Symbol(Type::CONST, 0, level, (yyvsp[0].exp)->value);
                symbols.insert((yyvsp[-2].str), sym);
            }
            else
            {
                offset -= 4;
                text.append("\tsubq\t$4, %%rsp\n");
                text.append("\tmovl\t$%d, %d(%rbp)\n", (yyvsp[0].exp)->value, offset);
                Symbol *sym = new Symbol(Type::CONST, offset, level, (yyvsp[0].exp)->value);
                symbols.insert((yyvsp[-2].str), sym);
            }
        }
    }
#line 1793 "sysy.tab.c"
    break;

  case 15:
#line 251 "sysy.y"
                                          {
        fprintf(detail_fp, "%s ConstDims = ConstInitVal -> ConstDef\n", (yyvsp[-3].str));
        if(symbols.lookup((yyvsp[-3].str), level) != nullptr) {
            sprintf(msg, "redeclaration of '%s'", (yyvsp[-3].str));
            yyerror(msg);
        } else {
            std::vector<int> values;
            (yyvsp[0].list)->dfsArray((yyvsp[-2].dims)->sizes, values);
            if(level == 0) {
                rodata.append("\n.align\t4\n");
                rodata.append(".type\t%s, @object\n", (yyvsp[-3].str));
                rodata.append(".size\t%s, %d\n", (yyvsp[-3].str), (yyvsp[-2].dims)->size*4);
                rodata.append("%s:\n", (yyvsp[-3].str));
                for(auto x: values){
                    rodata.append("\t.long\t%d\n", x);
                }
                Symbol* sym = new Symbol(Type::CONST_ARRAY, 0, level, values, (yyvsp[-2].dims)->sizes);
                symbols.insert((yyvsp[-3].str), sym);
            } 
            else{
                offset -= 4 * (yyvsp[-2].dims)->size;
                text.append("\tsubq\t$%d, %%rsp\n", 4 * (yyvsp[-2].dims)->size);
                for(int i = 0; i < values.size(); i++){
                    text.append("\tmovl\t$%d, %d(%%rbp)\n", values[i], offset + 4*i);
                }
                Symbol* sym = new Symbol(Type::CONST_ARRAY, offset, level, values, (yyvsp[-2].dims)->sizes);
                symbols.insert((yyvsp[-3].str), sym);
            }
        }
    }
#line 1828 "sysy.tab.c"
    break;

  case 16:
#line 281 "sysy.y"
                                      {
        fprintf(detail_fp, "[ Exp ] -> ConstDims\n");
        (yyval.dims) = new Dims();
        (yyval.dims)->size = (yyvsp[-1].exp)->value;
        (yyval.dims)->sizes.push_back((yyvsp[-1].exp)->value);
    }
#line 1839 "sysy.tab.c"
    break;

  case 17:
#line 287 "sysy.y"
                                           {
        fprintf(detail_fp, "ConstDims [ Exp ] -> ConstDims\n");
        (yyval.dims) = new Dims();
        (yyval.dims)->size = (yyvsp[-3].dims)->size * (yyvsp[-1].exp)->value;
        for(auto x: (yyvsp[-3].dims)->sizes){
            (yyval.dims)->sizes.push_back(x);
        }
        (yyval.dims)->sizes.push_back((yyvsp[-1].exp)->value);
    }
#line 1853 "sysy.tab.c"
    break;

  case 18:
#line 296 "sysy.y"
                            { // must a BRACED element
        fprintf(detail_fp, "{ } -> ConstInitVal\n");
        (yyval.list) = new List();
        (yyval.list)->nexts.push_back(new List(0));
        (yyval.list)->align = true;
    }
#line 1864 "sysy.tab.c"
    break;

  case 19:
#line 302 "sysy.y"
                                     {
        fprintf(detail_fp, "{ ConstInitValList } -> ConstInitVal\n");
        (yyval.list) = new List((yyvsp[-1].list));
        (yyval.list)->align = true;
    }
#line 1874 "sysy.tab.c"
    break;

  case 20:
#line 307 "sysy.y"
                           {
        fprintf(detail_fp, "ConstExp -> ConstInitValList\n");
        (yyval.list) = new List();
        (yyval.list)->nexts.push_back(new List((yyvsp[0].exp)->value));       
    }
#line 1884 "sysy.tab.c"
    break;

  case 21:
#line 312 "sysy.y"
                   {
        fprintf(detail_fp, "ConstInitVal -> ConstInitValList\n");
        (yyval.list) = new List();
        (yyval.list)->nexts.push_back((yyvsp[0].list));
    }
#line 1894 "sysy.tab.c"
    break;

  case 22:
#line 317 "sysy.y"
                                      {
        fprintf(detail_fp, "ConstInitValList , ConstExp -> ConstInitValList\n");
        (yyval.list) = new List((yyvsp[-2].list));
        (yyval.list)->nexts.push_back(new List((yyvsp[0].exp)->value));
        // fprintf(stderr, ": %d\n", $1->nexts.size());
    }
#line 1905 "sysy.tab.c"
    break;

  case 23:
#line 323 "sysy.y"
                                          {
        fprintf(detail_fp, "ConstInitValList , ConstInitVal -> ConstInitValList\n");
        (yyval.list) = new List((yyvsp[-2].list));
        (yyval.list)->nexts.push_back(new List((yyvsp[0].list)));
    }
#line 1915 "sysy.tab.c"
    break;

  case 24:
#line 328 "sysy.y"
                   {
        fprintf(detail_fp, "VarDef -> VarDefList\n");
    }
#line 1923 "sysy.tab.c"
    break;

  case 25:
#line 331 "sysy.y"
                              {
        fprintf(detail_fp, "VarDefList , VarDef -> VarDefList\n");
    }
#line 1931 "sysy.tab.c"
    break;

  case 26:
#line 334 "sysy.y"
              {
        fprintf(detail_fp, "%s -> VarDef\n", (yyvsp[0].str));
        if(level == 0) {
            data.append("\t.globl\t%s\n", (yyvsp[0].str));
            data.append("\t.data\n");
            data.append("\t.align\t4\n");
            data.append("\t.type\t%s, @object\n", (yyvsp[0].str));
            data.append("\t.size\t%s, 4\n", (yyvsp[0].str));
            data.append("\t.long\t0\n");
            Symbol *sym = new Symbol(Type::INT, 0, level);
            symbols.insert((yyvsp[0].str), sym);
        } else {
            offset -= 4;
            text.append("\tsubq\t$4, %%rsp\n");
            text.append("\tmovl\t$0, %d(%%rbp)\n", offset);
            Symbol *sym = new Symbol(Type::INT, offset, level);
            symbols.insert((yyvsp[0].str), sym);
        }
    }
#line 1955 "sysy.tab.c"
    break;

  case 27:
#line 353 "sysy.y"
                      {
        fprintf(detail_fp, "%s ConstDims -> VarDef\n", (yyvsp[-1].str));
        if(level == 0) {
            data.append("\t.globl\t%s\n", (yyvsp[-1].str));
            data.append("\t.data\n");
            data.append("\t.align\t4\n");
            data.append("\t.type\t%s, @object\n", (yyvsp[-1].str));
            data.append("\t.size\t%s, %d\n", (yyvsp[-1].str), (yyvsp[0].dims)->size*4);
            data.append("%s:\n", (yyvsp[-1].str));
            for(int i=0; i<(yyvsp[0].dims)->size; i++){
                data.append("\t.long\t0\n");
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, 0, level, (yyvsp[0].dims)->sizes);
            symbols.insert((yyvsp[-1].str), sym);
        } else {
            offset -= 4 * (yyvsp[0].dims)->size;
            text.append("\tsubq\t$%d, %%rsp\n", 4 * (yyvsp[0].dims)->size);
            for(int i = 0; i < (yyvsp[0].dims)->size; i++) {
                text.append("\tmovl\t$0, %d(%%rbp)\n", offset + 4*i);
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, offset, level, (yyvsp[0].dims)->sizes);
            symbols.insert((yyvsp[-1].str), sym);
        }
    }
#line 1984 "sysy.tab.c"
    break;

  case 28:
#line 377 "sysy.y"
                       {
        fprintf(detail_fp, "%s = Exp -> VarDef\n", (yyvsp[-2].str));
        if(level == 0) {
            if((yyvsp[0].exp)->isConst) {
                data.append("\t.globl\t%s\n", (yyvsp[-2].str));
                data.append("\t.data\n");
                data.append("\t.align\t4\n");
                data.append("\t.type\t%s, @object\n", (yyvsp[-2].str));
                data.append("\t.size\t%s, 4\n", (yyvsp[-2].str));
                data.append("%s:\n", (yyvsp[-2].str));
                data.append("\t.long\t%d\n", (yyvsp[0].exp)->value);
                Symbol *sym = new Symbol(Type::INT, 0, level);
                symbols.insert((yyvsp[-2].str), sym);
            } else {
                sprintf(msg, "'%s' must be initialized by constant", (yyvsp[-2].str));
                yyerror(msg);
            }
        } else {
            if((yyvsp[0].exp)->isConst) {
                offset -= 4;
                text.append("\tsubq\t$4, %%rsp\n");
                text.append("\tmovl\t$%d, %d(%%rbp)\n", (yyvsp[0].exp)->value, offset);
                Symbol *sym = new Symbol(Type::INT, offset, level);
                symbols.insert((yyvsp[-2].str), sym);
            } else {
                Symbol *sym = new Symbol(Type::INT, (yyvsp[0].exp)->offset, level);
                symbols.insert((yyvsp[-2].str), sym);
            }
        }
    }
#line 2019 "sysy.tab.c"
    break;

  case 29:
#line 407 "sysy.y"
                                     {
        fprintf(detail_fp, "%s ConstDims = InitVal -> VarDef\n", (yyvsp[-3].str));
        if(level == 0) {
            if((yyvsp[0].explist)->isConst) {
                data.append("\t.globl\t%s\n", (yyvsp[-3].str));
                data.append("\t.data\n");
                data.append("\t.align\t4\n");
                data.append("\t.type\t%s, @object\n", (yyvsp[-3].str));
                data.append("\t.size\t%s, %d\n", (yyvsp[-3].str), (yyvsp[-2].dims)->size*4);
                data.append("%s:\n", (yyvsp[-3].str));
                std::vector<bool> isConsts;
                std::vector<int> values;
                (yyvsp[0].explist)->dfsArray((yyvsp[-2].dims)->sizes, isConsts, values);
                for(int i = 0; i < values.size(); i++) {
                    data.append("\t.long\t%d\n", values[i]);
                }
                Symbol *sym = new Symbol(Type::INT_ARRAY, 0, level, (yyvsp[-2].dims)->sizes);
                symbols.insert((yyvsp[-3].str), sym);
            } else {
                sprintf(msg, "'%s' must be initialized by constant", (yyvsp[-3].str));
                yyerror(msg);
            }
        } else {
            std::vector<bool> isConsts;
            std::vector<int> values;
            (yyvsp[0].explist)->dfsArray((yyvsp[-2].dims)->sizes, isConsts, values);

            offset -= (yyvsp[-2].dims)->size * 4;
            text.append("\tsubq\t$%d, %%rsp\n", (yyvsp[-2].dims)->size * 4);
            for(int i = 0; i < (yyvsp[-2].dims)->size; i++) {
                if(isConsts[i]) {
                    text.append("\tmovl\t$%d, %d(%%rbp)\n", values[i], offset + 4 * i);
                } else {
                    text.append("\tmovl\t%d(%%rbp), %%eax\n", values[i]);
                    text.append("\tmovl\t%%eax, %d(%%rbp)\n", offset + 4 * i);
                }
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, offset, level, (yyvsp[-2].dims)->sizes);
            symbols.insert((yyvsp[-3].str), sym);
        }
    }
#line 2065 "sysy.tab.c"
    break;

  case 30:
#line 448 "sysy.y"
                       {
        fprintf(detail_fp, "{ } -> InitVal\n");
        (yyval.explist) = new ExpList();
        (yyval.explist)->nexts.push_back(new ExpList(true, 0, 0));
        (yyval.explist)->isConst = true;
        (yyval.explist)->align = true;
    }
#line 2077 "sysy.tab.c"
    break;

  case 31:
#line 455 "sysy.y"
                                {
        fprintf(detail_fp, "{ InitValList } -> InitVal\n");
        (yyval.explist) = new ExpList((yyvsp[-1].explist));
        (yyval.explist)->isConst = (yyvsp[-1].explist)->isConst;
        (yyval.explist)->align = true;
    }
#line 2088 "sysy.tab.c"
    break;

  case 32:
#line 461 "sysy.y"
                 { // leaf
        fprintf(detail_fp, "Exp -> InitValList\n");
        (yyval.explist) = new ExpList((yyvsp[0].exp));
        (yyval.explist)->nexts.push_back(new ExpList((yyvsp[0].exp)));
        // $$->isConst = $1->isConst;
        // $$->constValue = $1->value;
        // $$->offset = $1->offset;
    }
#line 2101 "sysy.tab.c"
    break;

  case 33:
#line 469 "sysy.y"
              {
        fprintf(detail_fp, "InitVal -> InitValList\n");
        (yyval.explist) = new ExpList();
        (yyval.explist)->nexts.push_back((yyvsp[0].explist));
        (yyval.explist)->isConst = (yyvsp[0].explist)->isConst;
    }
#line 2112 "sysy.tab.c"
    break;

  case 34:
#line 475 "sysy.y"
                            {
        fprintf(detail_fp, "InitValList , Exp -> InitValList\n");
        (yyval.explist) = new ExpList((yyvsp[-2].explist));
        (yyval.explist)->nexts.push_back(new ExpList((yyvsp[0].exp)));
        (yyval.explist)->isConst = (yyvsp[-2].explist)->isConst && (yyvsp[0].exp)->isConst;
    }
#line 2123 "sysy.tab.c"
    break;

  case 35:
#line 481 "sysy.y"
                                {
        fprintf(detail_fp, "InitValList , InitVal -> InitValList\n");
        (yyval.explist) = new ExpList((yyvsp[-2].explist));
        (yyval.explist)->nexts.push_back((yyvsp[0].explist));
        (yyval.explist)->isConst = (yyvsp[-2].explist)->isConst && (yyvsp[0].explist)->isConst;
    }
#line 2134 "sysy.tab.c"
    break;

  case 36:
#line 487 "sysy.y"
                                                         {
        fprintf(detail_fp, "FuncName ( ) Block -> FuncDef\n");
    }
#line 2142 "sysy.tab.c"
    break;

  case 37:
#line 490 "sysy.y"
                                                                  {
        fprintf(detail_fp, "FuncName ( FuncFParams ) Block -> FuncDef\n");
        (yyvsp[-6].symbol)->params = (yyvsp[-3].paramdeflist);
    }
#line 2151 "sysy.tab.c"
    break;

  case 38:
#line 494 "sysy.y"
                    {
        fprintf(detail_fp, "int %s -> FuncName\n", (yyvsp[0].str));
        if(symbols.lookup((yyvsp[0].str), level)){
            sprintf(msg, "redeclaration of '%s'", (yyvsp[0].str));
            yyerror(msg);
        } else {
            Symbol *sym = new Symbol(Type::INT_FUNCTION, level);
            symbols.insert((yyvsp[0].str), sym);
            text.append("\t.globl\t%s\n", (yyvsp[0].str));
            text.append("\t.type\t%s, @function\n", (yyvsp[0].str));
            text.append("%s:\n", (yyvsp[0].str));
            (yyval.symbol) = sym;
        }
    }
#line 2170 "sysy.tab.c"
    break;

  case 39:
#line 508 "sysy.y"
                 {
        fprintf(detail_fp, "int %s -> FuncName\n", (yyvsp[0].str));
        if(symbols.lookup((yyvsp[0].str), level)){
            sprintf(msg, "redeclaration of '%s'", (yyvsp[0].str));
            yyerror(msg);
        } else {
            Symbol *sym = new Symbol(Type::VOID_FUNCTION, level);
            symbols.insert((yyvsp[0].str), sym);
            text.append("\t.globl\t%s\n", (yyvsp[0].str));
            text.append("\t.type\t%s, @function\n", (yyvsp[0].str));
            text.append("%s:\n", (yyvsp[0].str));
        }
    }
#line 2188 "sysy.tab.c"
    break;

  case 40:
#line 521 "sysy.y"
           {
        enterLevel();
        offsets.push_back(offset);
        offset = 0;
        text.append("\tpushq\t%%rbp");
        text.append("\tmovq\t%%rsp, %%rbp");
        // make sure to write ret command
        haveReturn = false;
    }
#line 2202 "sysy.tab.c"
    break;

  case 41:
#line 530 "sysy.y"
          {
        exitLevel();
        // text.append("\taddq\t$%d, %%rsp\t\t# recover %%rsp\n", -offset);
        offset = offsets.back();
        offsets.pop_back();
        // make sure to write ret command
        if(!haveReturn) {
            // sprintf(msg, "control reaches end of non-void function");
            // yyerror(msg);
            text.append("\tleave");
            text.append("\tret\n\n");
        }
    }
#line 2220 "sysy.tab.c"
    break;

  case 42:
#line 543 "sysy.y"
                         {
        // EnterFunc finished, we need to locate params on stack and add them into SYMBOLS
        (yyval.paramdeflist) = (yyvsp[0].paramdeflist);
        int argc = (yyvsp[0].paramdeflist)->argc, argo = 8; // offset
        for(int i = 0; i < argc; i++) {
            ParamDef *cur = (yyvsp[0].paramdeflist)->argv[i];
            argo += PARAM_SIZE;
            Symbol *sym;
            if(cur->dims.empty()) {
                sym = new Symbol(Type::INT, argo, level);
            } else {
                sym = new Symbol(Type::POINTER, argo, level, cur->dims); // array as params
            }
            symbols.insert(cur->name, sym);
        }
    }
#line 2241 "sysy.tab.c"
    break;

  case 43:
#line 559 "sysy.y"
                        {
        fprintf(detail_fp, "FuncFParam -> FuncFParams\n");
        (yyval.paramdeflist) = new ParamDefList();
        (yyval.paramdeflist)->argc = 1;
        (yyval.paramdeflist)->argv.push_back((yyvsp[0].paramdef));
    }
#line 2252 "sysy.tab.c"
    break;

  case 44:
#line 565 "sysy.y"
                                   {
        fprintf(detail_fp, "FuncFParams , FuncFParam -> FuncFParams\n");
        (yyval.paramdeflist) = (yyvsp[-2].paramdeflist);
        (yyval.paramdeflist)->argc++;
        (yyval.paramdeflist)->argv.push_back((yyvsp[0].paramdef));
    }
#line 2263 "sysy.tab.c"
    break;

  case 45:
#line 571 "sysy.y"
                      {
        fprintf(detail_fp, "int %s -> FuncFParam\n", (yyvsp[0].str));
        (yyval.paramdef) = new ParamDef();
        (yyval.paramdef)->name = (yyvsp[0].str);
    }
#line 2273 "sysy.tab.c"
    break;

  case 46:
#line 576 "sysy.y"
                              {
        fprintf(detail_fp, "int %s FuncIdentDims -> FuncFParam\n", (yyvsp[-1].str));
        (yyval.paramdef) = new ParamDef();
        (yyval.paramdef)->name = (yyvsp[-1].str);
        for(auto x: (yyvsp[0].dims)->sizes) {
            (yyval.paramdef)->dims.push_back(x);
        }
    }
#line 2286 "sysy.tab.c"
    break;

  case 47:
#line 584 "sysy.y"
                                  {
        fprintf(detail_fp, "[ ] -> FuncIdentDims\n");
        (yyval.dims) = new Dims();
        (yyval.dims)->size = 1;
        (yyval.dims)->sizes.push_back(-1);
    }
#line 2297 "sysy.tab.c"
    break;

  case 48:
#line 590 "sysy.y"
                            {
        fprintf(detail_fp, "[ Exp ] -> FuncIdentDims\n");
        (yyval.dims) = new Dims();
        if((yyvsp[-1].exp)->isConst) {
            (yyval.dims)->size = 1;
            (yyval.dims)->sizes.push_back((yyvsp[-1].exp)->value);
        } else {
            sprintf(msg, "variable-sized object may not be initialized");
            yyerror(msg);
        }
    }
#line 2313 "sysy.tab.c"
    break;

  case 49:
#line 601 "sysy.y"
                                      {
        fprintf(detail_fp, "FuncIdentDims [ ] -> FuncIdentDims\n");
        (yyval.dims) = (yyvsp[-2].dims);
        (yyval.dims)->size++;
        (yyval.dims)->sizes.push_back(-1);
    }
#line 2324 "sysy.tab.c"
    break;

  case 50:
#line 607 "sysy.y"
                                          {
        fprintf(detail_fp, "FuncIdentDims [ Exp ] -> FuncIdentDims\n");
        (yyval.dims) = (yyvsp[-3].dims);
        if((yyvsp[-1].exp)->isConst) {
            (yyval.dims)->size++;
            (yyval.dims)->sizes.push_back((yyvsp[-1].exp)->value);
        } else {
            sprintf(msg, "variable-sized object may not be initialized");
            yyerror(msg);
        }
    }
#line 2340 "sysy.tab.c"
    break;

  case 51:
#line 618 "sysy.y"
                     {
        fprintf(detail_fp, "{ } -> Block\n");
    }
#line 2348 "sysy.tab.c"
    break;

  case 52:
#line 621 "sysy.y"
                                  {
        fprintf(detail_fp, "{ BlockItemlist } -> Block\n");
    }
#line 2356 "sysy.tab.c"
    break;

  case 53:
#line 624 "sysy.y"
                         {fprintf(detail_fp, "BlockItem -> BlockItemlist\n");}
#line 2362 "sysy.tab.c"
    break;

  case 54:
#line 625 "sysy.y"
                              {fprintf(detail_fp, "BlockItemlist BlockItem -> BlockItemlist\n");}
#line 2368 "sysy.tab.c"
    break;

  case 55:
#line 627 "sysy.y"
                {fprintf(detail_fp, "Decl -> BlockItem\n");}
#line 2374 "sysy.tab.c"
    break;

  case 56:
#line 628 "sysy.y"
           {fprintf(detail_fp, "Stmt -> BlockItem\n");}
#line 2380 "sysy.tab.c"
    break;

  case 57:
#line 630 "sysy.y"
                                                                       {
        fprintf(detail_fp, "if ( Cond ) Stmt -> Stmt\n");
        text.backPatch((yyvsp[-5].boolexp)->trueList, (yyvsp[-3].num));
        int endLabel = text.newLabel();
        text.comment("endif");
        text.backPatch((yyvsp[-5].boolexp)->falseList, endLabel);
    }
#line 2392 "sysy.tab.c"
    break;

  case 58:
#line 637 "sysy.y"
                                                                                                                      {
        fprintf(detail_fp, "if ( Cond ) Stmt else Stmt -> Stmt\n");
        text.backPatch((yyvsp[-12].boolexp)->trueList, (yyvsp[-10].num));
        text.backPatch((yyvsp[-12].boolexp)->falseList, (yyvsp[-4].num));
        text.backPatch((yyvsp[-5].boolexp)->trueList, (yyvsp[0].num));
    }
#line 2403 "sysy.tab.c"
    break;

  case 59:
#line 643 "sysy.y"
                                                                                     {
        fprintf(detail_fp, "while ( Cond ) Stmt -> Stmt\n");
        text.backPatch((yyvsp[-5].boolexp)->trueList, (yyvsp[-2].num));
        text.append("\tjmp\t.L%d\n", (yyvsp[-8].boolexp)->label);
        int endWhile = text.newLabel();
        text.comment("end while");
        text.backPatch((yyvsp[-5].boolexp)->falseList, (yyvsp[-3].boolexp)->label);
        text.backPatch((yyvsp[-3].boolexp)->trueList, endWhile);
        for(auto t: breaks.back()) {
            text.modLine(t.line - 1, "\taddq\t$%d, %%rsp\n", offset - t.offset);
            text.appendLine(t.line, "%d", endWhile);
        }
        breaks.prevLevel();
        for(auto t: continues.back()) {
            text.modLine(t.line - 1, "\taddq\t$%d, %%rsp\n", offset - t.offset);
            text.appendLine(t.line, "%d", (yyvsp[-8].boolexp)->label);
        }
        continues.prevLevel();
    }
#line 2427 "sysy.tab.c"
    break;

  case 60:
#line 662 "sysy.y"
                      {
        fprintf(detail_fp, "break ; -> Stmt\n");
        text.append("");
        text.append("\tjmp\t.L");
        breaks.push(text.ln(), offset);
    }
#line 2438 "sysy.tab.c"
    break;

  case 61:
#line 668 "sysy.y"
                         {
        fprintf(detail_fp, "continue ; -> Stmt\n");
        text.append("");
        text.append("\tjmp\t.L");
        continues.push(text.ln(), offset);
    }
#line 2449 "sysy.tab.c"
    break;

  case 62:
#line 674 "sysy.y"
                                { // assign statements
        fprintf(detail_fp, "LVal = Exp ; -> Stmt\n");
        char* varName = (yyvsp[-3].lvalue)->name;
        ExpDims* dims = (yyvsp[-3].lvalue)->haveDims ? (yyvsp[-3].lvalue)->dims : nullptr;

        /* phase 1: parse lvalue */
        Symbol *sym = symbols.lookup(varName, level);
        if (sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", varName);
            yyerror(msg);
        } else if(sym->type != Type::INT && sym->type != Type::INT_ARRAY && sym->type != Type::POINTER) {
            sprintf(msg, "lvalue required as left operand of assignment");
            yyerror(msg);
        }

        /* phase 2: if lvalue have dimensions, calculate 'offsetInArray' */
        if(dims != nullptr) {
            calculateOffsetInArray(sym, dims, text);
        }
        
        /* phase 3: assign rvalue to lvalue */
        if(sym->type == Type::INT) {
            text.loadReg((yyvsp[-1].exp), "%eax");
            if(sym->level == 0) { // on .data
                text.append("\tleaq\t%s(%%rip), %%rbx\t\t# assign int\n", varName); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            } else {
                text.append("\tmovl\t%%eax, %d(%%rbp)\t\t# assign int\n", sym->offset);
            }
        } else if(sym->type == Type::INT_ARRAY) {
            // 'offsetInArray' is %rcx
            text.loadReg((yyvsp[-1].exp), "%eax");
            if(sym->level == 0) { // on .data
                // [$1->text](%rip, %rcx, 4)
                text.append("\tleaq\t%s(%%rip), %%r8\n", (yyvsp[-3].lvalue));
                text.append("\tleaq\t(%%r8, %%rcx, 4), %%rbx\t\t# assign int_array\n"); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            } else { // on stack
                // %rbp + [sym->offset] + 4 * %rcx = $[sym->offset](%rbp, %rcx, 4)
                text.append("\tleaq\t%d(%%rbp, %%rcx, 4), %%rbx\t\t# assign int_array\n", sym->offset); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            }
        } else if(sym->type == Type::POINTER) {
            // if lvalue is pointer, calculate its REAL ADDRESS
            // base address: value of [sym->offset](%rbp) -> %r9
            // final address: 0(%r9, %rcx, 4)
            text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
            text.append("\tleaq\t(%%r9, %%rcx, 4), %%rbx\t\t# assign pointer\n");
            // REAL ADDRESS is %rbx
            text.loadReg((yyvsp[-1].exp), "%eax");
            text.append("\tmovl\t%%eax, (%%rbx)\n");
        }
    }
#line 2507 "sysy.tab.c"
    break;

  case 63:
#line 727 "sysy.y"
                           {
        fprintf(detail_fp, "return Exp ; -> Stmt\n");
        text.loadReg((yyvsp[-1].exp), "%eax"); // save the return value in %eax
        text.append("\tleave");
        text.append("\tret\n\n");
        haveReturn = true;
    }
#line 2519 "sysy.tab.c"
    break;

  case 64:
#line 734 "sysy.y"
                       {
        fprintf(detail_fp, "return ; -> Stmt\n");
        text.append("\tleave");
        text.append("\tret\n\n");
        haveReturn = true;
    }
#line 2530 "sysy.tab.c"
    break;

  case 65:
#line 740 "sysy.y"
                    {
        fprintf(detail_fp, "Exp ; -> Stmt\n");
        /* nothing to be done */
    }
#line 2539 "sysy.tab.c"
    break;

  case 66:
#line 744 "sysy.y"
            {
        fprintf(detail_fp, "Block -> Stmt\n");
        /* nothing to be done */
    }
#line 2548 "sysy.tab.c"
    break;

  case 67:
#line 748 "sysy.y"
           { 
        text.append("# enter block");
        enterLevel();
        offsets.push_back(offset);
    }
#line 2558 "sysy.tab.c"
    break;

  case 68:
#line 753 "sysy.y"
          {
        exitLevel();
        text.append("\taddq\t$%d, %%rsp\t\t# exiting block, restore %%rsp\n", offsets.back() - offset);
        offset = offsets.back();
        offsets.pop_back();
    }
#line 2569 "sysy.tab.c"
    break;

  case 69:
#line 759 "sysy.y"
          {
        (yyval.num) = text.newLabel();
    }
#line 2577 "sysy.tab.c"
    break;

  case 70:
#line 762 "sysy.y"
           {
        (yyval.boolexp) = new BoolExp();
        text.append("\tjmp\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
    }
#line 2587 "sysy.tab.c"
    break;

  case 71:
#line 767 "sysy.y"
            {
        (yyval.boolexp) = new BoolExp();
        (yyval.boolexp)->label = text.newLabel();
        text.append("# enter while");
        breaks.nextLevel();
        continues.nextLevel();
    }
#line 2599 "sysy.tab.c"
    break;

  case 72:
#line 774 "sysy.y"
           {
        (yyval.boolexp) = new BoolExp();
        (yyval.boolexp)->label = text.newLabel();
        text.append("# exit while");
        text.append("\taddq\t$%d, %%rsp\n", offsets.back() - offset);
        // no need to update offset [?]
        text.append("\tjmp\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
    }
#line 2613 "sysy.tab.c"
    break;

  case 73:
#line 783 "sysy.y"
            {
        fprintf(detail_fp, "AddExp -> Exp\n");
        (yyval.exp) = new Exp((yyvsp[0].exp));
    }
#line 2622 "sysy.tab.c"
    break;

  case 74:
#line 787 "sysy.y"
             {
        fprintf(detail_fp, "LOrExp -> Cond\n");
        (yyval.boolexp) = (yyvsp[0].boolexp);
    }
#line 2631 "sysy.tab.c"
    break;

  case 75:
#line 791 "sysy.y"
            {
        fprintf(detail_fp, "%s -> LVal\n", (yyvsp[0].str));
        (yyval.lvalue) = new LValue();
        (yyval.lvalue)->name = (yyvsp[0].str);
        (yyval.lvalue)->haveDims = false;
    }
#line 2642 "sysy.tab.c"
    break;

  case 76:
#line 797 "sysy.y"
                {
        fprintf(detail_fp, "%s Arr -> LVal\n", (yyvsp[-1].str));
        (yyval.lvalue) = new LValue();
        (yyval.lvalue)->name = (yyvsp[-1].str);
        (yyval.lvalue)->haveDims = true;
        (yyval.lvalue)->dims = (yyvsp[0].expdims);
    }
#line 2654 "sysy.tab.c"
    break;

  case 77:
#line 804 "sysy.y"
                           {
        fprintf(detail_fp, "[ Exp ] -> Arr\n");
        (yyval.expdims) = new ExpDims();
        (yyval.expdims)->isConst = (yyvsp[-1].exp)->isConst;
        (yyval.expdims)->isConsts.push_back((yyvsp[-1].exp)->isConst);
        (yyval.expdims)->values.push_back((yyvsp[-1].exp)->isConst ? (yyvsp[-1].exp)->value : (yyvsp[-1].exp)->offset);
        // fprintf(stderr, "       Arr: %d %d\n", $2->value, $2->isConst);
    }
#line 2667 "sysy.tab.c"
    break;

  case 78:
#line 812 "sysy.y"
                                {
        fprintf(detail_fp, "Arr [ Exp ] -> Arr\n");
        (yyval.expdims) = new ExpDims((yyvsp[-3].expdims));
        (yyval.expdims)->isConst &= (yyvsp[-1].exp)->isConst;
        (yyval.expdims)->isConsts.push_back((yyvsp[-1].exp)->isConst);
        (yyval.expdims)->values.push_back((yyvsp[-1].exp)->isConst ? (yyvsp[-1].exp)->value : (yyvsp[-1].exp)->offset);
        // fprintf(stderr, "       Arr: %d %d\n", $$->values[0], $$->values[1]);
    }
#line 2680 "sysy.tab.c"
    break;

  case 79:
#line 820 "sysy.y"
                  {
        fprintf(detail_fp, "%s -> PrimaryExp\n", (yyvsp[0].str));
        (yyval.exp) = new Exp();
        (yyval.exp)->text = (yyvsp[0].str);
        Symbol *sym = symbols.lookup((yyvsp[0].str), level);
        if (sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", (yyvsp[0].str));
            yyerror(msg);
        } else {
            if(sym->type == Type::CONST) {
                (yyval.exp)->isConst = true;
                (yyval.exp)->value = sym->constValue;
            } else if(sym->type == Type::INT_ARRAY || sym->type == Type::POINTER) {
                (yyval.exp)->isPointer = true;
                // for arrays and pointers, load REAL ADDRESS and save the offset
                offset -= 8;
                text.append("\tsubq\t$8, %%rsp\n");
                if(sym->type == Type::INT_ARRAY) {
                    if(sym->level == 0) {
                        text.append("\tleaq\t%s(%%rip), %%r8\n", (yyvsp[0].str));
                        text.append("\tmovq\t%%r8, (%%rsp)\n");
                    }
                    else {
                        text.append("\tleaq\t%d(%%rbp), %%r8\n", sym->offset);
                        text.append("\tmovq\t%%r8, (%%rsp)\n");
                    }
                } else {
                    text.append("\tmovq\t%d(%%rbp), %%r8\n", sym->offset);
                    text.append("\tmovq\t%%r8, (%%rsp)\n");
                }
                (yyval.exp)->offset = offset;
            } else if(sym->type == Type::INT || sym->type == Type::CONST) {
                text.loadReg(new Exp((yyvsp[0].str), sym->offset, 0, sym->level), "%r8d");
                (yyval.exp)->offset = text.saveReg("%r8d", offset);
                (yyval.exp)->isConst = false;
                (yyval.exp)->level = 1;
            } else {
                sprintf(msg, "'%s' is not a primary expression", (yyvsp[0].str));
                yyerror(msg);
            }
        }
    }
#line 2727 "sysy.tab.c"
    break;

  case 80:
#line 862 "sysy.y"
                {
        fprintf(detail_fp, "%s Arr -> PrimaryExp\n", (yyvsp[-1].str));
        (yyval.exp) = new Exp();
        (yyval.exp)->text = (yyvsp[-1].str);
        Symbol *sym = symbols.lookup((yyvsp[-1].str), level);
        if (sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", (yyvsp[-1].str));
            yyerror(msg);
        } else if (sym->type != Type::INT_ARRAY && sym->type != Type::CONST_ARRAY && sym->type != Type::POINTER) {
            sprintf(msg, "subscripted value '%s' is not an array", (yyvsp[-1].str));
            yyerror(msg);
        } else if(sym->sizes.size() < (yyvsp[0].expdims)->values.size()) {
            sprintf(msg, "array need %d dimensions, but %d given", sym->sizes.size(), (yyvsp[0].expdims)->values.size());
            yyerror(msg);
        } else if(sym->sizes.size() > (yyvsp[0].expdims)->values.size()) { // load Exp as pointer
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, (yyvsp[0].expdims), text);

            /* phase 2: calculate REAL ADDRESS, in %rbx */
            (yyval.exp)->isPointer = true;
            if(sym->type == Type::INT_ARRAY || sym->type == Type::CONST_ARRAY) {
                if(sym->level == 0) { // on .data
                    text.append("\tleaq\t%s(%%rip), %%r8\n", (yyvsp[-1].str));
                    text.append("\tleaq\t(%%r8, %%rcx, 4), %%rbx\n");
                } else {
                    text.append("\tleaq\t%d(%%rbp, %%rcx, 4), %%rbx\n", sym->offset);
                }
            } else if(sym->type == Type::POINTER) {
                text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
                // REAL ADDRESS is %r9
                text.append("\tleaq\t(%%r9, %%rcx, 4), %%rbx\n");
            }
            
            /* phase 3: save result (%rbx) */
            offset -= 8;
            text.append("\tsubq\t$8, %%rsp\n");
            text.append("\tmovq\t%%rbx, %d(%%rbp)\n", offset);
            (yyval.exp)->offset = offset;
        } else {
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, (yyvsp[0].expdims), text);

            /* phase 2: load value from memory, result is %eax */
            (yyval.exp)->isConst = false;
            if(sym->type == Type::INT_ARRAY) {
                if(sym->level == 0) { // on .data
                    text.append("\tleaq\t%s(%%rip), %%r8\n", (yyvsp[-1].str));
                    text.append("\tleaq\t(%%r8, %%rcx, 4), %%rbx\n");
                    text.append("\tmovl\t(%%rbx), %%eax\n");
                } else {
                    text.append("\tmovl\t%d(%%rbp, %%rcx, 4), %%eax\n", sym->offset);
                }
            } else if(sym->type == Type::POINTER) {
                text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
                // REAL ADDRESS is %r9
                text.append("\tleaq\t(%%r9, %%rcx, 4), %%rbx\n");
                text.append("\tmovl\t(%%rbx), %%eax\n");
            } else {
                int offsetInArray = calculateOffsetInArray(sym, (yyvsp[0].expdims));
                (yyval.exp)->isConst = true;
                (yyval.exp)->value = sym->constValues[offsetInArray];
                (yyval.exp)->level = sym->level;
            }

            /* phase 3: save result (%eax) */
            if(!(yyval.exp)->isConst) {
                (yyval.exp)->offset = text.saveReg("%eax", offset);
                (yyval.exp)->level = 1;
            }
        }
    }
#line 2803 "sysy.tab.c"
    break;

  case 81:
#line 933 "sysy.y"
             {
        fprintf(detail_fp, "%d -> PrimaryExp\n", (yyvsp[0].num));
        (yyval.exp) = new Exp();
        (yyval.exp)->isConst = true;
        (yyval.exp)->value = (yyvsp[0].num);
    }
#line 2814 "sysy.tab.c"
    break;

  case 82:
#line 939 "sysy.y"
             {
        fprintf(detail_fp, "__base_str -> PrimaryExp\n", (yyvsp[0].str));
        (yyval.exp) = new Exp();
        (yyval.exp)->isConst = true;
        // save the name of string
        int id = rodata.ln();
        rodata.append("__fmt_string%d:\t.string %s\n", id, (yyvsp[0].str));
        (yyval.exp)->text = new char[32];
        sprintf((yyval.exp)->text, "__fmt_string%d", id);    
    }
#line 2829 "sysy.tab.c"
    break;

  case 83:
#line 949 "sysy.y"
                        {
        fprintf(detail_fp, "( Exp ) -> PrimaryExp\n");
        (yyval.exp) = new Exp((yyvsp[-1].exp));
    }
#line 2838 "sysy.tab.c"
    break;

  case 84:
#line 953 "sysy.y"
                      {
        fprintf(detail_fp, "&%s -> PrimaryExp\n", (yyvsp[0].str));
        Symbol *sym = symbols.lookup((yyvsp[0].str), level);
        if(sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", (yyvsp[0].str));
            yyerror(msg);
        } else if(sym->type == Type::INT) {
            (yyval.exp) = new Exp();
            (yyval.exp)->isPointer = true;
            if(sym->level == 0) {
                text.append("\tleaq\t%s(%%rip), %%r8\n", (yyvsp[0].str));
                offset -= 8;
                text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", offset);
                (yyval.exp)->offset = offset;
            } else {
                text.append("\tleaq\t%d(%%rbp), %%r8\n", sym->offset);
                offset -= 8;
                text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", offset);
                (yyval.exp)->offset = offset;
            }
        } else {
            sprintf(msg, "lvalue required as unary '&' operand");
            yyerror(msg);
        }
    }
#line 2870 "sysy.tab.c"
    break;

  case 85:
#line 980 "sysy.y"
                          {
        fprintf(detail_fp, "&%s Arr -> PrimaryExp\n", (yyvsp[-1].str));
        Symbol *sym = symbols.lookup((yyvsp[-1].str), level);
        if(sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", (yyvsp[-1].str));
            yyerror(msg);
        } else if(sym->type == Type::INT_ARRAY) {
            (yyval.exp) = new Exp();
            (yyval.exp)->isPointer = true;
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, (yyvsp[0].expdims), text);

            /* phase 2: save REAL ADDRESS on stack 
             * REAL ADDRESS = BaseAddress + %rcx * 4 */
            if(sym->level == 0) {
                text.append("\tleaq\t%s(%%rip), %%r9\n", (yyvsp[-1].str));
                text.append("\tleaq\t(%%r9, %%rcx, 4), %%r8\n");
                offset -= 8;
                text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", offset);
                (yyval.exp)->offset = offset;
            } else {
                text.append("\tleaq\t%d(%%rbp, %%rcx, 4), %%r8\n", sym->offset);
                offset -= 8;
                text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", offset);
                (yyval.exp)->offset = offset;
            }
        } else if(sym->type == Type::POINTER) {
            (yyval.exp) = new Exp();
            (yyval.exp)->isPointer = true;
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, (yyvsp[0].expdims), text);

            /* phase 2: save REAL ADDRESS on stack */
            text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
            text.append("\tleaq\t(%%r9, %%rcx, 4), %%r8\n");
            offset -= 8;
            text.append("\tsubq\t$8, %%rsp\n");
            text.append("\tmovq\t%%r8, %d(%%rbp)\n", offset);
            (yyval.exp)->offset = offset;
        } else {
            sprintf(msg, "lvalue required as unary '&' operand");
            yyerror(msg);
        }
    }
#line 2921 "sysy.tab.c"
    break;

  case 86:
#line 1026 "sysy.y"
                     {
        fprintf(detail_fp, "PrimaryExp -> UnaryExp\n");
        (yyval.exp) = new Exp((yyvsp[0].exp));
    }
#line 2930 "sysy.tab.c"
    break;

  case 87:
#line 1030 "sysy.y"
                          { // function calls: done
        fprintf(detail_fp, "%s ( ) -> UnaryExp\n", (yyvsp[-2].str));
        (yyval.exp) = new Exp();
        if(!symbols.isFunction((yyvsp[-2].str), level)){
            sprintf(msg, "implicit declaration of function '%s'", (yyvsp[-2].str));
            yyerror(msg);
        } else {
            text.alignStack(offset);
            text.append("\tcall\t%s\n", (yyvsp[-2].str));
            // 不需要清理参数
            if(symbols.lookup((yyvsp[-2].str), level)->type == Type::INT_FUNCTION){
                (yyval.exp)->isConst = false;
                (yyval.exp)->offset = text.saveReg("%eax", offset);
                (yyval.exp)->level = level;
            } else { // void function, let $$ be void
                (yyval.exp)->isVoid = true;
            }
        }
    }
#line 2954 "sysy.tab.c"
    break;

  case 88:
#line 1049 "sysy.y"
                                      { // function calls: done
        fprintf(detail_fp, "%s ( FuncRParams ) -> UnaryExp\n", (yyvsp[-3].str));
        (yyval.exp) = new Exp();
        if(strcmp((yyvsp[-3].str), "printf") == 0 || strcmp((yyvsp[-3].str), "scanf") == 0){
            text.alignStack(offset);
            handleIO((yyvsp[-3].str), (yyvsp[-1].paramlist));
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = 0;
            (yyval.exp)->level = level;
        } else if(!symbols.isFunction((yyvsp[-3].str), level)) {
            sprintf(msg, "implicit declaration of function '%s'", (yyvsp[-3].str));
            yyerror(msg);
        } else {
            text.alignStack(offset);
            // pushq parameters
            offsets.push_back(offset); // save old offset
            int rsize = (yyvsp[-1].paramlist)->exp.size() * PARAM_SIZE;
            int padding = (16 - rsize % 16) % 16;
            if(padding) {
                offset -= padding;
                text.append("\tsubq\t$%d, %%rsp\t\t# padding\n", padding);
            }
            for(int i = (yyvsp[-1].paramlist)->exp.size() - 1; i >= 0; i--) {
                Exp *cur = (yyvsp[-1].paramlist)->exp[i];
                offset -= PARAM_SIZE;
                text.append("\tsubq\t$%d, %%rsp\t\t# param %d\n", PARAM_SIZE, i);
                if (cur->isPointer) {
                    text.append("\tmovq\t%d(%%rbp), %%r8\n", cur->offset);
                    text.append("\tmovq\t%%r8, (%%rsp)\n");
                } else if(cur->isConst) {
                    text.append("\tmovq\t$%d, (%%rsp)\n", cur->value);
                } else {
                    // text.append("\tmovl\t%d(%%rbp), (%%rsp)\n", cur->offset);
                    text.append("\tmovl\t%d(%%rbp), %%r8d\n", cur->offset);
                    text.append("\tmovsxd\t%%r8d, %%r8\n");
                    text.append("\tmovq\t%%r8, (%%rsp)\n");
                }
            }
            text.append("\tcall\t%s\n\n", (yyvsp[-3].str));
            // 清理参数
            text.append("\taddq\t$%d, %%rsp\n", offsets.back() - offset);
            offset = offsets.back();
            offsets.pop_back();
            // handle returned value
            if(symbols.lookup((yyvsp[-3].str), level)->type == Type::INT_FUNCTION){
                (yyval.exp)->isConst = false;
                (yyval.exp)->offset = text.saveReg("%eax", offset);
                (yyval.exp)->level = level;
            } else {
                (yyval.exp)->isVoid = true;
            }
        }
    }
#line 3012 "sysy.tab.c"
    break;

  case 89:
#line 1102 "sysy.y"
                       {
        fprintf(detail_fp, "UnaryOp UnaryExp -> UnaryExp\n");
        if((yyvsp[0].exp)->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            (yyvsp[0].exp)->isConst = 1;
            (yyvsp[0].exp)->value = 0;
        }
        switch((yyvsp[-1].num)) {
            case 1: // + 
                (yyval.exp) = new Exp((yyvsp[0].exp)); break;
            case -1: // -
                (yyval.exp) = new Exp();  
                if ((yyvsp[0].exp)->isConst) {
                    (yyval.exp)->isConst = true;
                    (yyval.exp)->value = -(yyvsp[0].exp)->value;
                } else {
                    text.loadReg((yyvsp[0].exp), "%r8d");
                    text.append("\tnegl\t%%r8d\n");
                    (yyval.exp)->offset = text.saveReg("%r8d", offset);
                    (yyval.exp)->level = 1;
                }
                break;
            case 0: // ! 
                (yyval.exp) = new Exp(); 
                if((yyvsp[0].exp)->isConst) {
                    (yyval.exp)->isConst = true;
                    (yyval.exp)->value = !(yyvsp[0].exp)->value;
                } else {
                    text.loadReg((yyvsp[0].exp), "%eax");
                    text.append("\ttestl %%eax, %%eax\n");
                    text.append("\tsete %%al\n");
                    text.append("\tmovzbl %%al, %%eax\n");
                    (yyval.exp)->offset = text.saveReg("%eax", offset);
                    (yyval.exp)->level = 1;
                }
                break;
        }
    }
#line 3056 "sysy.tab.c"
    break;

  case 90:
#line 1141 "sysy.y"
             {
        fprintf(detail_fp, "+ -> UnaryOp\n");
        (yyval.num) = 1;
    }
#line 3065 "sysy.tab.c"
    break;

  case 91:
#line 1145 "sysy.y"
          {
        fprintf(detail_fp, "- -> UnaryOp\n");
        (yyval.num) = -1;
    }
#line 3074 "sysy.tab.c"
    break;

  case 92:
#line 1149 "sysy.y"
          {
        fprintf(detail_fp, "! -> UnaryOp\n");
        (yyval.num) = 0;
    }
#line 3083 "sysy.tab.c"
    break;

  case 93:
#line 1153 "sysy.y"
                 { 
        fprintf(detail_fp, "Exp -> FuncRParams\n");
        (yyval.paramlist) = new ParamList();
        (yyval.paramlist)->exp.push_back((yyvsp[0].exp));
    }
#line 3093 "sysy.tab.c"
    break;

  case 94:
#line 1158 "sysy.y"
                            {
        fprintf(detail_fp, "FuncRParams , Exp -> FuncRParams\n");
        (yyval.paramlist) = (yyvsp[-2].paramlist);
        (yyval.paramlist)->exp.push_back((yyvsp[0].exp));
    }
#line 3103 "sysy.tab.c"
    break;

  case 95:
#line 1166 "sysy.y"
                 {
        fprintf(detail_fp, "AddExp -> ConstExp\n");
        if(!(yyvsp[0].exp)->isConst) {
            sprintf(msg, "initializer element '%s' is not constant", (yyvsp[0].exp)->text);
            yyerror(msg);
        } else {
            (yyval.exp) = new Exp((yyvsp[0].exp));
        }
    }
#line 3117 "sysy.tab.c"
    break;

  case 96:
#line 1175 "sysy.y"
                 {
        fprintf(detail_fp, "UnaryExp -> MulExp\n");
        (yyval.exp) = new Exp((yyvsp[0].exp));
    }
#line 3126 "sysy.tab.c"
    break;

  case 97:
#line 1179 "sysy.y"
                          {
        fprintf(detail_fp, "MulExp * UnaryExp -> MulExp\n");
        if((yyvsp[0].exp)->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            (yyvsp[0].exp)->isConst = 1;
            (yyvsp[0].exp)->value = 0;
        }
        (yyval.exp) = new Exp();
        if((yyvsp[-2].exp)->isConst && (yyvsp[0].exp)->isConst) {
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = (yyvsp[-2].exp)->value * (yyvsp[0].exp)->value;
        } else {
            text.loadReg((yyvsp[-2].exp), "%r8d");
            text.loadReg((yyvsp[0].exp), "%r9d");
            text.append("\timull\t%%r9d, %%r8d\n");
            (yyval.exp)->offset = text.saveReg("%r8d", offset);
            (yyval.exp)->isConst = false;
            (yyval.exp)->level = 1;
        }
    }
#line 3152 "sysy.tab.c"
    break;

  case 98:
#line 1200 "sysy.y"
                          {
        fprintf(detail_fp, "MulExp / UnaryExp -> MulExp\n");        
        if((yyvsp[0].exp)->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            (yyvsp[0].exp)->isConst = 1;
            (yyvsp[0].exp)->value = 0;
        }
        (yyval.exp) = new Exp();
        if((yyvsp[-2].exp)->isConst && (yyvsp[0].exp)->isConst) {
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = (yyvsp[-2].exp)->value / (yyvsp[0].exp)->value;
        } else {
            text.loadReg((yyvsp[-2].exp), "%eax");
            text.loadReg((yyvsp[0].exp), "%r9d");
            text.append("\tcltd\n");
            text.append("\tidivl\t%%r9d\n");
            (yyval.exp)->offset = text.saveReg("%eax", offset);
            (yyval.exp)->isConst = false;
            (yyval.exp)->level = 1;
        }
    }
#line 3179 "sysy.tab.c"
    break;

  case 99:
#line 1222 "sysy.y"
                          {
        fprintf(detail_fp, "MulExp % UnaryExp -> MulExp\n");        
        if((yyvsp[0].exp)->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            (yyvsp[0].exp)->isConst = 1;
            (yyvsp[0].exp)->value = 0;
        }
        (yyval.exp) = new Exp();
        if((yyvsp[-2].exp)->isConst && (yyvsp[0].exp)->isConst) {
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = (yyvsp[-2].exp)->value % (yyvsp[0].exp)->value;
        } else {
            text.loadReg((yyvsp[-2].exp), "%eax");
            text.loadReg((yyvsp[0].exp), "%r9d");
            text.append("\tcltd\n");
            text.append("\tidivl\t%%r9d\n");
            (yyval.exp)->offset = text.saveReg("%edx", offset);
            (yyval.exp)->isConst = false;
            (yyval.exp)->level = 1;
        }
    }
#line 3206 "sysy.tab.c"
    break;

  case 100:
#line 1244 "sysy.y"
               {
        fprintf(detail_fp, "MulExp -> AddExp\n");
        (yyval.exp) = new Exp((yyvsp[0].exp));
    }
#line 3215 "sysy.tab.c"
    break;

  case 101:
#line 1248 "sysy.y"
                        {
        fprintf(detail_fp, "AddExp + MulExp -> AddExp\n");
        (yyval.exp) = new Exp();
        if((yyvsp[-2].exp)->isConst && (yyvsp[0].exp)->isConst) {
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = (yyvsp[-2].exp)->value + (yyvsp[0].exp)->value;
        } else {
            text.loadReg((yyvsp[-2].exp), "%r8d");
            text.loadReg((yyvsp[0].exp), "%r9d");
            text.append("\taddl\t%%r9d, %%r8d\n");
            (yyval.exp)->offset = text.saveReg("%r8d", offset);
            (yyval.exp)->isConst = false;
            (yyval.exp)->level = 1;
        }
    }
#line 3235 "sysy.tab.c"
    break;

  case 102:
#line 1263 "sysy.y"
                        {
        fprintf(detail_fp, "AddExp - MulExp -> AddExp\n");
        (yyval.exp) = new Exp();
        if((yyvsp[-2].exp)->isConst && (yyvsp[0].exp)->isConst) {
            (yyval.exp)->isConst = true;
            (yyval.exp)->value = (yyvsp[-2].exp)->value - (yyvsp[0].exp)->value;
        } else {
            text.loadReg((yyvsp[-2].exp), "%r8d");
            text.loadReg((yyvsp[0].exp), "%r9d");
            text.append("\tsubl\t%%r9d, %%r8d\n");
            (yyval.exp)->offset = text.saveReg("%r8d", offset);
            (yyval.exp)->isConst = false;
            (yyval.exp)->level = 1;
        }
    }
#line 3255 "sysy.tab.c"
    break;

  case 103:
#line 1278 "sysy.y"
                                  {
        fprintf(detail_fp, "AddExp < AddExp -> RelExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if <\n");
        text.append("\tjl\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3274 "sysy.tab.c"
    break;

  case 104:
#line 1292 "sysy.y"
                                {
        fprintf(detail_fp, "AddExp <= AddExp -> RelExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if <=\n");
        text.append("\tjle\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3293 "sysy.tab.c"
    break;

  case 105:
#line 1306 "sysy.y"
                                {
        fprintf(detail_fp, "AddExp > AddExp -> RelExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if >\n");
        text.append("\tjg\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3312 "sysy.tab.c"
    break;

  case 106:
#line 1320 "sysy.y"
                                {
        fprintf(detail_fp, "AddExp >= AddExp -> RelExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if >=\n");
        text.append("\tjge\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3331 "sysy.tab.c"
    break;

  case 107:
#line 1334 "sysy.y"
                       {
        fprintf(detail_fp, "AddExp -> EqExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-1].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[0].exp), "%r8d");
        text.append("\tcmpl\t$0, %%r8d\t\t# if != 0\n");
        text.append("\tjne\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3349 "sysy.tab.c"
    break;

  case 108:
#line 1347 "sysy.y"
                                   {
        fprintf(detail_fp, "AddExp == AddExp -> EqExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if ==\n");
        text.append("\tje\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3368 "sysy.tab.c"
    break;

  case 109:
#line 1361 "sysy.y"
                                {
        fprintf(detail_fp, "AddExp != AddExp -> EqExp\n");
        (yyval.boolexp) = new BoolExp();
        // $$->label = text.newLabel();
        (yyval.boolexp)->label = (yyvsp[-3].num);
        text.alignStack(offset);
        text.loadReg((yyvsp[-2].exp), "%r8d");
        text.loadReg((yyvsp[0].exp), "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d\t\t# if !=\n");
        text.append("\tjne\t.L");
        (yyval.boolexp)->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        (yyval.boolexp)->falseList.push_back(text.ln());
    }
#line 3387 "sysy.tab.c"
    break;

  case 110:
#line 1375 "sysy.y"
                {
        fprintf(detail_fp, "RelExp -> BoolExp\n");
        (yyval.boolexp) = (yyvsp[0].boolexp);
    }
#line 3396 "sysy.tab.c"
    break;

  case 111:
#line 1379 "sysy.y"
            {
        fprintf(detail_fp, "EqExp -> BoolExp\n");
        (yyval.boolexp) = (yyvsp[0].boolexp);
    }
#line 3405 "sysy.tab.c"
    break;

  case 112:
#line 1383 "sysy.y"
                 {
        fprintf(detail_fp, "BoolExp -> LAndExp\n");
        (yyval.boolexp) = (yyvsp[0].boolexp);
    }
#line 3414 "sysy.tab.c"
    break;

  case 113:
#line 1387 "sysy.y"
                          {
        fprintf(detail_fp, "LAndExp && BoolExp -> LAndExp\n");
        (yyval.boolexp) = new BoolExp();
        text.backPatch((yyvsp[-2].boolexp)->trueList, (yyvsp[0].boolexp)->label);
        (yyval.boolexp)->trueList = (yyvsp[0].boolexp)->trueList;
        (yyval.boolexp)->falseList = mergeVector((yyvsp[-2].boolexp)->falseList, (yyvsp[0].boolexp)->falseList);
        (yyval.boolexp)->label = (yyvsp[-2].boolexp)->label;
    }
#line 3427 "sysy.tab.c"
    break;

  case 114:
#line 1395 "sysy.y"
                {
        fprintf(detail_fp, "LAndExp -> LOrExp\n");
        (yyval.boolexp) = (yyvsp[0].boolexp);
    }
#line 3436 "sysy.tab.c"
    break;

  case 115:
#line 1399 "sysy.y"
                        {
        fprintf(detail_fp, "LOrExp || LAndExp -> LOrExp\n");
        (yyval.boolexp) = new BoolExp();
        text.backPatch((yyvsp[-2].boolexp)->falseList, (yyvsp[0].boolexp)->label);
        (yyval.boolexp)->trueList = mergeVector((yyvsp[-2].boolexp)->trueList, (yyvsp[0].boolexp)->trueList);
        (yyval.boolexp)->falseList = (yyvsp[0].boolexp)->falseList;
        (yyval.boolexp)->label = (yyvsp[-2].boolexp)->label;
    }
#line 3449 "sysy.tab.c"
    break;


#line 3453 "sysy.tab.c"

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
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

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
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
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
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

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


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
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
                  yystos[+*yyssp], yyvsp);
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
#line 1407 "sysy.y"


void yyerror(const char *s)
{
    fprintf(stderr, "ERROR: %s\n", s);
}
int main()
{
    asm_init();

    detail_fp = fopen("plot/detail.txt", "w");
    yyparse();
    fclose(detail_fp);

    // FILE *fp = fopen("out/output.s", "w");
    FILE *asm_fp = stdout;
    asm_print(asm_fp);
    fclose(asm_fp);

    return 0;
}
