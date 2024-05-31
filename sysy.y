%{
#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include "assembly.hpp"
#include "symbols.hpp"
#include "ast_node.hpp"
#include "compiler.hpp"

/* marcos */
#define PARAM_SIZE 8

/* global declarations */
char msg[512];
FILE *detail_fp;
Assembly rodata, data, bss, text;
CompileState compiler;
RuntimeStack breaks, continues;

/* define utils */
void exitFunc(int frameLine);
void handleIO(const char *func, ParamList* params);
int calculateOffsetInArray(Symbol* sym, ExpDims* dims);
void calculateOffsetInArray(Symbol* sym, ExpDims* dims, Assembly& txt);
template <typename T> std::vector<T> mergeVector(const std::vector<T>& a, const std::vector<T>& b);
void asm_init();
void asm_print(FILE *file);

void yyerror(const char *s);
int yylex(void);
%}

%union {
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
}

%token <num> Number
%token <str> Ident
%token <str> String
%token INT CONST VOID WHILE RETURN BREAK CONTINUE IF INCLUDE
%token LE GE LT GT EQUAL NE AND OR
%token ADD SUB MUL DIV NOT MOD
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET SEMICOLON COMMA ASSIGN DOT HASH ADDRESSOF

%type <num> UnaryOp NewLabel EnterFunc
%type <exp> PrimaryExp Exp ConstExp AddExp MulExp UnaryExp
%type <list> ConstInitVal ConstInitValList
%type <dims> ConstDims FuncIdentDims
%type <explist> InitVal InitValList
%type <expdims> Arr
%type <paramdef> FuncFParam
%type <paramdeflist> ParseParams FuncFParams
%type <paramlist> FuncRParams
%type <symbol> FuncName
%type <boolexp> Cond LOrExp LAndExp EqExp RelExp BoolExp AfterElse EnterWhile ExitWhile
%type <lvalue> LVal

%left ADD SUB
%left MUL DIV
%nonassoc IFX
%nonassoc ELSE

%start CompUnit

%%
CompUnit: Decl {
        fprintf(detail_fp, "Decl -> CompUnit\n");
    }
    | FuncDef {
        fprintf(detail_fp, "FuncDef -> CompUnit\n");
    }
    | ExternalDef {
        fprintf(detail_fp, "ExternalDef -> CompUnit\n");
    }
    | CompUnit Decl {
        fprintf(detail_fp, "CompUnit Decl -> CompUnit\n");
    }
    | CompUnit FuncDef {
        fprintf(detail_fp, "CompUnit FuncDef -> CompUnit\n");
    }
ExternalDef: HASH INCLUDE LT Ident DOT Ident GT {
        fprintf(detail_fp, "# include < %s . %s > -> ExternalDef\n", $4, $6);
    };
Decl: ConstDecl {
        fprintf(detail_fp, "ConstDecl -> Decl\n");
    }
    | VarDecl {
        fprintf(detail_fp, "VarDecl -> Decl\n");
    };
VarDecl: INT VarDefList SEMICOLON {fprintf(detail_fp, "int VarDefList ; -> VarDecl\n");
    };
ConstDecl: CONST INT ConstDeflist SEMICOLON {
        fprintf(detail_fp, "const int ConstDeflist ; -> ConstDecl\n");
    };
ConstDeflist: ConstDef {
        fprintf(detail_fp, "ConstDef -> ConstDeflist\n");
    }
    | ConstDeflist COMMA ConstDef {
        fprintf(detail_fp, "ConstDeflist , ConstDef -> ConstDeflist\n");
    };
ConstDef: Ident ASSIGN ConstExp {
        fprintf(detail_fp, "%s = ConstInitVal -> ConstDef\n", $1);
        if(compiler.lookup($1) != nullptr) {
            sprintf(msg, "redeclaration of '%s'", $1);
            yyerror(msg);
        } else {
            if(compiler.getLevel() == 0) {
                rodata.append("\n.align\t4\n");
                rodata.append(".type\t%s, @object\n", $1);
                rodata.append(".size\t%s, 4\n", $1);
                rodata.append("%s:\n", $1);
                rodata.append("\t.long\t%d\n",$3->value);
                Symbol *sym = new Symbol(Type::CONST, 0, compiler.getLevel(), $3->value);
                compiler.insertSymbol($1, sym);
            } else {
                compiler.updateOffset(-4);
                text.append("\tmovl\t$%d, %d(%rbp)\n", $3->value, compiler.getOffset());
                Symbol *sym = new Symbol(Type::CONST, compiler.getOffset(), compiler.getLevel(), $3->value);
                compiler.insertSymbol($1, sym);
            }
        }
    }
    | Ident ConstDims ASSIGN ConstInitVal {
        fprintf(detail_fp, "%s ConstDims = ConstInitVal -> ConstDef\n", $1);
        if(compiler.lookup($1) != nullptr) {
            sprintf(msg, "redeclaration of '%s'", $1);
            yyerror(msg);
        } else {
            std::vector<int> values;
            $4->dfsArray($2->sizes, values);
            if(compiler.getLevel() == 0) {
                rodata.append("\n.align\t4\n");
                rodata.append(".type\t%s, @object\n", $1);
                rodata.append(".size\t%s, %d\n", $1, $2->size*4);
                rodata.append("%s:\n", $1);
                for(auto x: values){
                    rodata.append("\t.long\t%d\n", x);
                }
                Symbol* sym = new Symbol(Type::CONST_ARRAY, 0, compiler.getLevel(), values, $2->sizes);
                compiler.insertSymbol($1, sym);
            } 
            else{
                compiler.updateOffset(-4 * $2->size);
                for(int i = 0; i < values.size(); i++){
                    text.append("\tmovl\t$%d, %d(%%rbp)\n", values[i], compiler.getOffset() + 4*i);
                }
                Symbol* sym = new Symbol(Type::CONST_ARRAY, compiler.getOffset(), compiler.getLevel(), values, $2->sizes);
                compiler.insertSymbol($1, sym);
            }
        }
    };
ConstDims: LBRACKET ConstExp RBRACKET {
        fprintf(detail_fp, "[ Exp ] -> ConstDims\n");
        $$ = new Dims();
        $$->size = $2->value;
        $$->sizes.push_back($2->value);
    }
    | ConstDims LBRACKET ConstExp RBRACKET {
        fprintf(detail_fp, "ConstDims [ Exp ] -> ConstDims\n");
        $$ = new Dims();
        $$->size = $1->size * $3->value;
        for(auto x: $1->sizes){
            $$->sizes.push_back(x);
        }
        $$->sizes.push_back($3->value);
    };
ConstInitVal: LBRACE RBRACE { // must a BRACED element
        fprintf(detail_fp, "{ } -> ConstInitVal\n");
        $$ = new List();
        $$->nexts.push_back(new List(0));
        $$->align = true;
    }
    | LBRACE ConstInitValList RBRACE {
        fprintf(detail_fp, "{ ConstInitValList } -> ConstInitVal\n");
        $$ = new List($2);
        $$->align = true;
    };   
ConstInitValList: ConstExp {
        fprintf(detail_fp, "ConstExp -> ConstInitValList\n");
        $$ = new List();
        $$->nexts.push_back(new List($1->value));       
    }
    | ConstInitVal {
        fprintf(detail_fp, "ConstInitVal -> ConstInitValList\n");
        $$ = new List();
        $$->nexts.push_back($1);
    }
    | ConstInitValList COMMA ConstExp {
        fprintf(detail_fp, "ConstInitValList , ConstExp -> ConstInitValList\n");
        $$ = new List($1);
        $$->nexts.push_back(new List($3->value));
    }
    | ConstInitValList COMMA ConstInitVal {
        fprintf(detail_fp, "ConstInitValList , ConstInitVal -> ConstInitValList\n");
        $$ = new List($1);
        $$->nexts.push_back(new List($3));
    };
VarDefList: VarDef {
        fprintf(detail_fp, "VarDef -> VarDefList\n");
    }
    | VarDefList COMMA VarDef {
        fprintf(detail_fp, "VarDefList , VarDef -> VarDefList\n");
    };
VarDef: Ident {
        fprintf(detail_fp, "%s -> VarDef\n", $1);
        if(compiler.getLevel() == 0) {
            data.append("\t.globl\t%s\n", $1);
            data.append("\t.data\n");
            data.append("\t.align\t4\n");
            data.append("\t.type\t%s, @object\n", $1);
            data.append("\t.size\t%s, 4\n", $1);
            data.append("\t.long\t0\n");
            Symbol *sym = new Symbol(Type::INT, 0, compiler.getLevel());
            compiler.insertSymbol($1, sym);
        } else {
            compiler.updateOffset(-4);
            text.append("\tmovl\t$0, %d(%%rbp)\n", compiler.getOffset());
            Symbol *sym = new Symbol(Type::INT, compiler.getOffset(), compiler.getLevel());
            compiler.insertSymbol($1, sym);
        }
    }
    | Ident ConstDims {
        fprintf(detail_fp, "%s ConstDims -> VarDef\n", $1);
        if(compiler.getLevel() == 0) {
            data.append("\t.globl\t%s\n", $1);
            data.append("\t.data\n");
            data.append("\t.align\t4\n");
            data.append("\t.type\t%s, @object\n", $1);
            data.append("\t.size\t%s, %d\n", $1, $2->size*4);
            data.append("%s:\n", $1);
            for(int i=0; i<$2->size; i++){
                data.append("\t.long\t0\n");
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, 0, compiler.getLevel(), $2->sizes);
            compiler.insertSymbol($1, sym);
        } else {
            compiler.updateOffset(-4 * $2->size);
            for(int i = 0; i < $2->size; i++) {
                text.append("\tmovl\t$0, %d(%%rbp)\n", compiler.getOffset() + 4*i);
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, compiler.getOffset(), compiler.getLevel(), $2->sizes);
            compiler.insertSymbol($1, sym);
        }
    }
    | Ident ASSIGN Exp {
        fprintf(detail_fp, "%s = Exp -> VarDef\n", $1);
        if(compiler.getLevel() == 0) {
            if($3->isConst) {
                data.append("\t.globl\t%s\n", $1);
                data.append("\t.data\n");
                data.append("\t.align\t4\n");
                data.append("\t.type\t%s, @object\n", $1);
                data.append("\t.size\t%s, 4\n", $1);
                data.append("%s:\n", $1);
                data.append("\t.long\t%d\n", $3->value);
                Symbol *sym = new Symbol(Type::INT, 0, compiler.getLevel());
                compiler.insertSymbol($1, sym);
            } else {
                sprintf(msg, "'%s' must be initialized by constant", $1);
                yyerror(msg);
            }
        } else {
            if($3->isConst) {
                compiler.updateOffset(-4);
                text.append("\tmovl\t$%d, %d(%%rbp)\n", $3->value, compiler.getOffset());
                Symbol *sym = new Symbol(Type::INT, compiler.getOffset(), compiler.getLevel());
                compiler.insertSymbol($1, sym);
            } else {
                Symbol *sym = new Symbol(Type::INT, $3->offset, compiler.getLevel());
                compiler.insertSymbol($1, sym);
            }
        }
    }
    | Ident ConstDims ASSIGN InitVal {
        fprintf(detail_fp, "%s ConstDims = InitVal -> VarDef\n", $1);
        if(compiler.getLevel() == 0) {
            if($4->isConst) {
                data.append("\t.globl\t%s\n", $1);
                data.append("\t.data\n");
                data.append("\t.align\t4\n");
                data.append("\t.type\t%s, @object\n", $1);
                data.append("\t.size\t%s, %d\n", $1, $2->size*4);
                data.append("%s:\n", $1);
                std::vector<bool> isConsts;
                std::vector<int> values;
                $4->dfsArray($2->sizes, isConsts, values);
                for(int i = 0; i < values.size(); i++) {
                    data.append("\t.long\t%d\n", values[i]);
                }
                Symbol *sym = new Symbol(Type::INT_ARRAY, 0, compiler.getLevel(), $2->sizes);
                compiler.insertSymbol($1, sym);
            } else {
                sprintf(msg, "'%s' must be initialized by constant", $1);
                yyerror(msg);
            }
        } else {
            std::vector<bool> isConsts;
            std::vector<int> values;
            $4->dfsArray($2->sizes, isConsts, values);
            compiler.updateOffset(-4 * $2->size);
            for(int i = 0; i < $2->size; i++) {
                if(isConsts[i]) {
                    text.append("\tmovl\t$%d, %d(%%rbp)\n", values[i], compiler.getOffset() + 4 * i);
                } else {
                    text.append("\tmovl\t%d(%%rbp), %%eax\n", values[i]);
                    text.append("\tmovl\t%%eax, %d(%%rbp)\n", compiler.getOffset() + 4 * i);
                }
            }
            Symbol *sym = new Symbol(Type::INT_ARRAY, compiler.getOffset(), compiler.getLevel(), $2->sizes);
            compiler.insertSymbol($1, sym);
        }
    };
InitVal: LBRACE RBRACE {
        fprintf(detail_fp, "{ } -> InitVal\n");
        $$ = new ExpList();
        $$->nexts.push_back(new ExpList(true, 0, 0));
        $$->isConst = true;
        $$->align = true;
    }
    | LBRACE InitValList RBRACE {
        fprintf(detail_fp, "{ InitValList } -> InitVal\n");
        $$ = new ExpList($2);
        $$->isConst = $2->isConst;
        $$->align = true;
    };
InitValList: Exp { // leaf
        fprintf(detail_fp, "Exp -> InitValList\n");
        $$ = new ExpList($1);
        $$->nexts.push_back(new ExpList($1));
    }
    | InitVal {
        fprintf(detail_fp, "InitVal -> InitValList\n");
        $$ = new ExpList();
        $$->nexts.push_back($1);
        $$->isConst = $1->isConst;
    }
    | InitValList COMMA Exp {
        fprintf(detail_fp, "InitValList , Exp -> InitValList\n");
        $$ = new ExpList($1);
        $$->nexts.push_back(new ExpList($3));
        $$->isConst = $1->isConst && $3->isConst;
    }
    | InitValList COMMA InitVal {
        fprintf(detail_fp, "InitValList , InitVal -> InitValList\n");
        $$ = new ExpList($1);
        $$->nexts.push_back($3);
        $$->isConst = $1->isConst && $3->isConst;
    };
FuncDef: FuncName EnterFunc LPAREN RPAREN Block ExitFunc {
        fprintf(detail_fp, "FuncName ( ) Block -> FuncDef\n");
        exitFunc($2);
    }
    | FuncName EnterFunc LPAREN ParseParams RPAREN Block ExitFunc {
        fprintf(detail_fp, "FuncName ( FuncFParams ) Block -> FuncDef\n");
        $1->params = $4;
        exitFunc($2);
    };
FuncName: INT Ident {
        fprintf(detail_fp, "int %s -> FuncName\n", $2);
        if(compiler.lookup($2)){
            sprintf(msg, "redeclaration of '%s'", $2);
            yyerror(msg);
        } else {
            Symbol *sym = new Symbol(Type::INT_FUNCTION, compiler.getLevel());
            compiler.insertSymbol($2, sym);
            text.append("\n\t.globl\t%s\n", $2);
            text.append("\t.type\t%s, @function\n", $2);
            text.append("%s:\n", $2);
            $$ = sym;
        }
    }
    | VOID Ident {
        fprintf(detail_fp, "int %s -> FuncName\n", $2);
        if(compiler.lookup($2)){
            sprintf(msg, "redeclaration of '%s'", $2);
            yyerror(msg);
        } else {
            Symbol *sym = new Symbol(Type::VOID_FUNCTION, compiler.getLevel());
            compiler.insertSymbol($2, sym);
            text.append("\t.globl\t%s\n", $2);
            text.append("\t.type\t%s, @function\n", $2);
            text.append("%s:\n", $2);
        }
    };
EnterFunc: {
        compiler.enterLevel();
        compiler.dumpOffset(); // offsets.push_back(offset);
        compiler.resetOffset(); // offset = 0;
        text.append("\tpushq\t%%rbp");
        text.append("\tmovq\t%%rsp, %%rbp");
        text.append("# set %%rsp here");
        $$ = text.ln();
        // make sure to write ret command
        compiler.resetReturnState();
    };
ExitFunc: { /* nothing to be done */ };
ParseParams: FuncFParams {
        // EnterFunc finished, we need to locate params on stack and add them into SYMBOLS
        $$ = $1;
        int argc = $1->argc, argo = 8; // offset
        for(int i = 0; i < argc; i++) {
            ParamDef *cur = $1->argv[i];
            argo += PARAM_SIZE;
            Symbol *sym;
            if(cur->dims.empty()) {
                sym = new Symbol(Type::INT, argo, compiler.getLevel());
            } else {
                sym = new Symbol(Type::POINTER, argo, compiler.getLevel(), cur->dims); // array as params
            }
            compiler.insertSymbol(cur->name, sym);
        }
    };
FuncFParams: FuncFParam {
        fprintf(detail_fp, "FuncFParam -> FuncFParams\n");
        $$ = new ParamDefList();
        $$->argc = 1;
        $$->argv.push_back($1);
    }
    | FuncFParams COMMA FuncFParam {
        fprintf(detail_fp, "FuncFParams , FuncFParam -> FuncFParams\n");
        $$ = $1;
        $$->argc++;
        $$->argv.push_back($3);
    };
FuncFParam: INT Ident {
        fprintf(detail_fp, "int %s -> FuncFParam\n", $2);
        $$ = new ParamDef();
        $$->name = $2;
    }
    | INT Ident FuncIdentDims {
        fprintf(detail_fp, "int %s FuncIdentDims -> FuncFParam\n", $2);
        $$ = new ParamDef();
        $$->name = $2;
        for(auto x: $3->sizes) {
            $$->dims.push_back(x);
        }
    };
FuncIdentDims: LBRACKET RBRACKET  {
        fprintf(detail_fp, "[ ] -> FuncIdentDims\n");
        $$ = new Dims();
        $$->size = 1;
        $$->sizes.push_back(-1);
    }
    | LBRACKET Exp RBRACKET {
        fprintf(detail_fp, "[ Exp ] -> FuncIdentDims\n");
        $$ = new Dims();
        if($2->isConst) {
            $$->size = 1;
            $$->sizes.push_back($2->value);
        } else {
            sprintf(msg, "variable-sized object may not be initialized");
            yyerror(msg);
        }
    }
    | FuncIdentDims LBRACKET RBRACKET {
        fprintf(detail_fp, "FuncIdentDims [ ] -> FuncIdentDims\n");
        $$ = $1;
        $$->size++;
        $$->sizes.push_back(-1);
    }
    | FuncIdentDims LBRACKET Exp RBRACKET {
        fprintf(detail_fp, "FuncIdentDims [ Exp ] -> FuncIdentDims\n");
        $$ = $1;
        if($3->isConst) {
            $$->size++;
            $$->sizes.push_back($3->value);
        } else {
            sprintf(msg, "variable-sized object may not be initialized");
            yyerror(msg);
        }
    };
Block: LBRACE RBRACE {
        fprintf(detail_fp, "{ } -> Block\n");
    }
    | LBRACE BlockItemlist RBRACE {
        fprintf(detail_fp, "{ BlockItemlist } -> Block\n");
    };
BlockItemlist: BlockItem {fprintf(detail_fp, "BlockItem -> BlockItemlist\n");}
    | BlockItemlist BlockItem {fprintf(detail_fp, "BlockItemlist BlockItem -> BlockItemlist\n");}
    ;
BlockItem: Decl {fprintf(detail_fp, "Decl -> BlockItem\n");}
    | Stmt {fprintf(detail_fp, "Stmt -> BlockItem\n");}
    ;
Stmt: IF LPAREN Cond RPAREN NewLabel EnterStmt Stmt ExitStmt %prec IFX {
        fprintf(detail_fp, "if ( Cond ) Stmt -> Stmt\n");
        text.backPatch($3->trueList, $5);
        int endLabel = text.newLabel();
        text.comment("endif");
        text.backPatch($3->falseList, endLabel);
    }
    | IF LPAREN Cond RPAREN NewLabel EnterStmt Stmt ExitStmt ELSE AfterElse NewLabel EnterStmt Stmt ExitStmt NewLabel {
        fprintf(detail_fp, "if ( Cond ) Stmt else Stmt -> Stmt\n");
        text.backPatch($3->trueList, $5);
        text.backPatch($3->falseList, $11);
        text.backPatch($10->trueList, $15);
    }
    | WHILE EnterWhile EnterStmt LPAREN Cond RPAREN ExitWhile NewLabel Stmt ExitStmt {
        fprintf(detail_fp, "while ( Cond ) Stmt -> Stmt\n");
        text.backPatch($5->trueList, $8);
        text.append("\tjmp\t.L%d\n", $2->label);
        int endWhile = text.newLabel();
        text.comment("end while");
        text.backPatch($5->falseList, $7->label);
        text.backPatch($7->trueList, endWhile);
        for(auto t: breaks.back()) {
            text.modLine(t.line - 1, "\taddq\t$%d, %%rsp\n", compiler.getOffset() - t.offset);
            text.appendLine(t.line, "%d", endWhile);
        }
        breaks.prevLevel();
        for(auto t: continues.back()) {
            text.modLine(t.line - 1, "\taddq\t$%d, %%rsp\n", compiler.getOffset() - t.offset);
            text.appendLine(t.line, "%d", $2->label);
        }
        continues.prevLevel();
    }
    | BREAK SEMICOLON {
        fprintf(detail_fp, "break ; -> Stmt\n");
        text.append("");
        text.append("\tjmp\t.L");
        breaks.push(text.ln(), compiler.getOffset());
    }
    | CONTINUE SEMICOLON {
        fprintf(detail_fp, "continue ; -> Stmt\n");
        text.append("");
        text.append("\tjmp\t.L");
        continues.push(text.ln(), compiler.getOffset());
    }
    | LVal ASSIGN Exp SEMICOLON { // assign statements
        fprintf(detail_fp, "LVal = Exp ; -> Stmt\n");
        char* varName = $1->name;
        ExpDims* dims = $1->haveDims ? $1->dims : nullptr;

        /* phase 1: parse lvalue */
        Symbol *sym = compiler.lookup(varName);
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
            text.loadReg($3, "%eax");
            if(sym->level == 0) { // on .data
                text.append("\tleaq\t%s(%%rip), %%rbx # assign int\n", varName); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            } else {
                text.append("\tmovl\t%%eax, %d(%%rbp) # assign int\n", sym->offset);
            }
        } else if(sym->type == Type::INT_ARRAY) {
            // 'offsetInArray' is %rcx
            text.loadReg($3, "%eax");
            if(sym->level == 0) { // on .data
                // [$1->text](%rip, %rcx, 4)
                text.append("\tleaq\t%s(%%rip), %%r8\n", $1);
                text.append("\tleaq\t(%%r8, %%rcx, 4), %%rbx # assign int_array\n"); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            } else { // on stack
                // %rbp + [sym->offset] + 4 * %rcx = $[sym->offset](%rbp, %rcx, 4)
                text.append("\tleaq\t%d(%%rbp, %%rcx, 4), %%rbx # assign int_array\n", sym->offset); // %rbx holds the address
                text.append("\tmovl\t%%eax, (%%rbx)\n");
            }
        } else if(sym->type == Type::POINTER) {
            // if lvalue is pointer, calculate its REAL ADDRESS
            // base address: value of [sym->offset](%rbp) -> %r9
            // final address: 0(%r9, %rcx, 4)
            text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
            text.append("\tleaq\t(%%r9, %%rcx, 4), %%rbx # assign pointer\n");
            // REAL ADDRESS is %rbx
            text.loadReg($3, "%eax");
            text.append("\tmovl\t%%eax, (%%rbx)\n");
        }
    }
    | RETURN Exp SEMICOLON {
        fprintf(detail_fp, "return Exp ; -> Stmt\n");
        text.loadReg($2, "%eax"); // save the return value in %eax
        text.append("\tleave");
        text.append("\tret");
        compiler.setReturned();
    }
    | RETURN SEMICOLON {
        fprintf(detail_fp, "return ; -> Stmt\n");
        text.append("\tleave");
        text.append("\tret");
        compiler.setReturned();
    }
    | Exp SEMICOLON {
        fprintf(detail_fp, "Exp ; -> Stmt\n");
        /* nothing to be done */
    }
    | Block {
        fprintf(detail_fp, "Block -> Stmt\n");
        /* nothing to be done */
    };
EnterStmt: { 
        compiler.enterLevel();
    };
ExitStmt: {
        compiler.exitLevel();
    };
NewLabel: {
        $$ = text.newLabel();
    };
AfterElse: {
        $$ = new BoolExp();
        text.append("\tjmp\t.L");
        $$->trueList.push_back(text.ln());
    };
EnterWhile: {
        $$ = new BoolExp();
        $$->label = text.newLabel();
        text.append("# enter while");
        breaks.nextLevel();
        continues.nextLevel();
    };
ExitWhile: {
        $$ = new BoolExp();
        $$->label = text.newLabel();
        text.append("# exit while");
        text.append("\tjmp\t.L");
        $$->trueList.push_back(text.ln());
    };
Exp: AddExp {
        fprintf(detail_fp, "AddExp -> Exp\n");
        $$ = new Exp($1);
    };
Cond: LOrExp {
        fprintf(detail_fp, "LOrExp -> Cond\n");
        $$ = $1;
    };
LVal: Ident {
        fprintf(detail_fp, "%s -> LVal\n", $1);
        $$ = new LValue();
        $$->name = $1;
        $$->haveDims = false;
    }
    | Ident Arr {
        fprintf(detail_fp, "%s Arr -> LVal\n", $1);
        $$ = new LValue();
        $$->name = $1;
        $$->haveDims = true;
        $$->dims = $2;
    };
Arr: LBRACKET Exp RBRACKET {
        fprintf(detail_fp, "[ Exp ] -> Arr\n");
        $$ = new ExpDims();
        $$->isConst = $2->isConst;
        $$->isConsts.push_back($2->isConst);
        $$->values.push_back($2->isConst ? $2->value : $2->offset);
    }
    | Arr LBRACKET Exp RBRACKET {
        fprintf(detail_fp, "Arr [ Exp ] -> Arr\n");
        $$ = new ExpDims($1);
        $$->isConst &= $3->isConst;
        $$->isConsts.push_back($3->isConst);
        $$->values.push_back($3->isConst ? $3->value : $3->offset);
    };
PrimaryExp: Ident {
        fprintf(detail_fp, "%s -> PrimaryExp\n", $1);
        $$ = new Exp();
        $$->text = $1;
        Symbol *sym = compiler.lookup($1);
        if (sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", $1);
            yyerror(msg);
        } else {
            if(sym->type == Type::CONST) {
                $$->isConst = true;
                $$->value = sym->constValue;
            } else if(sym->type == Type::INT_ARRAY || sym->type == Type::POINTER) {
                $$->isPointer = true;
                // for arrays and pointers, load REAL ADDRESS and save the offset
                compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
                if(sym->type == Type::INT_ARRAY) {
                    if(sym->level == 0) {
                        text.append("\tleaq\t%s(%%rip), %%r8\n", $1);
                        text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                    }
                    else {
                        text.append("\tleaq\t%d(%%rbp), %%r8\n", sym->offset);
                        text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                    }
                } else {
                    text.append("\tmovq\t%d(%%rbp), %%r8\n", sym->offset);
                    text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                }
                $$->offset = compiler.getOffset();
            } else if(sym->type == Type::INT || sym->type == Type::CONST) {
                text.loadReg(new Exp($1, sym->offset, 0, sym->level), "%r8d");
                $$->offset = text.saveReg("%r8d", compiler);
                $$->isConst = false;
                $$->level = 1;
            } else {
                sprintf(msg, "'%s' is not a primary expression", $1);
                yyerror(msg);
            }
        }
    }
    | Ident Arr {
        fprintf(detail_fp, "%s Arr -> PrimaryExp\n", $1);
        $$ = new Exp();
        $$->text = $1;
        Symbol *sym = compiler.lookup($1);
        if (sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", $1);
            yyerror(msg);
        } else if (sym->type != Type::INT_ARRAY && sym->type != Type::CONST_ARRAY && sym->type != Type::POINTER) {
            sprintf(msg, "subscripted value '%s' is not an array", $1);
            yyerror(msg);
        } else if(sym->sizes.size() < $2->values.size()) {
            sprintf(msg, "array need %lu dimensions, but %lu given", sym->sizes.size(), $2->values.size());
            yyerror(msg);
        } else if(sym->sizes.size() > $2->values.size()) { // load Exp as pointer
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, $2, text);

            /* phase 2: calculate REAL ADDRESS, in %rbx */
            $$->isPointer = true;
            if(sym->type == Type::INT_ARRAY || sym->type == Type::CONST_ARRAY) {
                if(sym->level == 0) { // on .data
                    text.append("\tleaq\t%s(%%rip), %%r8\n", $1);
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
            compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
            text.append("\tmovq\t%%rbx, %d(%%rbp)\n", compiler.getOffset());
            $$->offset = compiler.getOffset();
        } else {
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, $2, text);

            /* phase 2: load value from memory, result is %eax */
            $$->isConst = false;
            if(sym->type == Type::INT_ARRAY) {
                if(sym->level == 0) { // on .data
                    text.append("\tleaq\t%s(%%rip), %%r8\n", $1);
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
                int offsetInArray = calculateOffsetInArray(sym, $2);
                $$->isConst = true;
                $$->value = sym->constValues[offsetInArray];
                $$->level = sym->level;
            }

            /* phase 3: save result (%eax) */
            if(!$$->isConst) {
                $$->offset = text.saveReg("%eax", compiler);
                $$->level = 1;
            }
        }
    }
    | Number {
        fprintf(detail_fp, "%d -> PrimaryExp\n", $1);
        $$ = new Exp();
        $$->isConst = true;
        $$->value = $1;
    }
    | String {
        fprintf(detail_fp, "__base_str -> PrimaryExp\n", $1);
        $$ = new Exp();
        $$->isConst = true;
        // save the name of string
        int id = rodata.ln();
        rodata.append("__fmt_string%d:\t.string %s\n", id, $1);
        $$->text = new char[32];
        sprintf($$->text, "__fmt_string%d", id);    
    } 
    | LPAREN Exp RPAREN {
        fprintf(detail_fp, "( Exp ) -> PrimaryExp\n");
        $$ = new Exp($2);
    }
    | ADDRESSOF Ident {
        fprintf(detail_fp, "&%s -> PrimaryExp\n", $2);
        Symbol *sym = compiler.lookup($2);
        if(sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", $2);
            yyerror(msg);
        } else if(sym->type == Type::INT) {
            $$ = new Exp();
            $$->isPointer = true;
            if(sym->level == 0) {
                text.append("\tleaq\t%s(%%rip), %%r8\n", $2);
                compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                $$->offset = compiler.getOffset();
            } else {
                text.append("\tleaq\t%d(%%rbp), %%r8\n", sym->offset);
                compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                $$->offset = compiler.getOffset();
            }
        } else {
            sprintf(msg, "lvalue required as unary '&' operand");
            yyerror(msg);
        }
    }
    | ADDRESSOF Ident Arr {
        fprintf(detail_fp, "&%s Arr -> PrimaryExp\n", $2);
        Symbol *sym = compiler.lookup($2);
        if(sym == nullptr) {
            sprintf(msg, "'%s' was not declared in this scope", $2);
            yyerror(msg);
        } else if(sym->type == Type::INT_ARRAY) {
            $$ = new Exp();
            $$->isPointer = true;
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, $3, text);

            /* phase 2: save REAL ADDRESS on stack 
             * REAL ADDRESS = BaseAddress + %rcx * 4 */
            if(sym->level == 0) {
                text.append("\tleaq\t%s(%%rip), %%r9\n", $2);
                text.append("\tleaq\t(%%r9, %%rcx, 4), %%r8\n");
                compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                $$->offset = compiler.getOffset();
            } else {
                text.append("\tleaq\t%d(%%rbp, %%rcx, 4), %%r8\n", sym->offset);
                compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
                text.append("\tmovq\t%%r8, %d(%%rbp)\n", compiler.getOffset());
                $$->offset = compiler.getOffset();
            }
        } else if(sym->type == Type::POINTER) {
            $$ = new Exp();
            $$->isPointer = true;
            /* phase 1: calculate 'offsetInArray' */
            calculateOffsetInArray(sym, $3, text);

            /* phase 2: save REAL ADDRESS on stack */
            text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
            text.append("\tleaq\t(%%r9, %%rcx, 4), %%r8\n");
            compiler.updateOffset(-8); // offset -= 8; text.append("\tsubq\t$8, %%rsp\n");
            text.append("\tmovq\t%%r8, %d(%%rbp)\n",  compiler.getOffset());
            $$->offset =  compiler.getOffset();
        } else {
            sprintf(msg, "lvalue required as unary '&' operand");
            yyerror(msg);
        }
    };
UnaryExp: PrimaryExp {
        fprintf(detail_fp, "PrimaryExp -> UnaryExp\n");
        $$ = new Exp($1);
    }
    | Ident LPAREN RPAREN { // function calls: done
        fprintf(detail_fp, "%s ( ) -> UnaryExp\n", $1);
        $$ = new Exp();
        if(!compiler.isFunction($1)){
            sprintf(msg, "implicit declaration of function '%s'", $1);
            yyerror(msg);
        } else {
            text.append("\tcall\t%s\n", $1);
            // 不需要清理参数
            if(compiler.lookup($1)->type == Type::INT_FUNCTION){
                $$->isConst = false;
                $$->offset = text.saveReg("%eax", compiler);
                $$->level = compiler.getLevel();
            } else { // void function, let $$ be void
                $$->isVoid = true;
            }
        }
    }
    | Ident LPAREN FuncRParams RPAREN { // function calls: done
        fprintf(detail_fp, "%s ( FuncRParams ) -> UnaryExp\n", $1);
        $$ = new Exp();
        if(strcmp($1, "printf") == 0 || strcmp($1, "scanf") == 0){
            handleIO($1, $3);
            $$->isConst = true;
            $$->value = 0;
            $$->level = compiler.getLevel();
        } else if(!compiler.isFunction($1)) {
            sprintf(msg, "implicit declaration of function '%s'", $1);
            yyerror(msg);
        } else {
            compiler.updateParamSize($3->exp.size() * PARAM_SIZE);
            for(int i = $3->exp.size() - 1; i >= 0; i--) {
                Exp *cur = $3->exp[i];
                if (cur->isPointer) {
                    text.append("\tmovq\t%d(%%rbp), %%r8\n", cur->offset);
                    text.append("\tmovq\t%%r8, %d(%%rsp) # param %d\n", i * PARAM_SIZE, i);
                } else if(cur->isConst) {
                    text.append("\tmovq\t$%d, %d(%%rsp) # param %d\n", cur->value, i * PARAM_SIZE, i);
                } else {
                    text.append("\tmovl\t%d(%%rbp), %%r8d\n", cur->offset);
                    text.append("\tmovsxd\t%%r8d, %%r8\n");
                    text.append("\tmovq\t%%r8, %d(%%rsp) # param %d\n", i * PARAM_SIZE, i);
                }
            }
            text.append("\tcall\t%s\n", $1);
            if(compiler.lookup($1)->type == Type::INT_FUNCTION){
                $$->isConst = false;
                $$->offset = text.saveReg("%eax", compiler);
                $$->level = compiler.getLevel();
            } else {
                $$->isVoid = true;
            }
        }
    }
    | UnaryOp UnaryExp {
        fprintf(detail_fp, "UnaryOp UnaryExp -> UnaryExp\n");
        if($2->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            $2->isConst = 1;
            $2->value = 0;
        }
        switch($1) {
            case 1: // + 
                $$ = new Exp($2); break;
            case -1: // -
                $$ = new Exp();  
                if ($2->isConst) {
                    $$->isConst = true;
                    $$->value = -$2->value;
                } else {
                    text.loadReg($2, "%r8d");
                    text.append("\tnegl\t%%r8d\n");
                    $$->offset = text.saveReg("%r8d", compiler);
                    $$->level = 1;
                }
                break;
            case 0: // ! 
                $$ = new Exp(); 
                if($2->isConst) {
                    $$->isConst = true;
                    $$->value = !$2->value;
                } else {
                    text.loadReg($2, "%eax");
                    text.append("\ttestl %%eax, %%eax\n");
                    text.append("\tsete %%al\n");
                    text.append("\tmovzbl %%al, %%eax\n");
                    $$->offset = text.saveReg("%eax", compiler);
                    $$->level = 1;
                }
                break;
        }
    };
UnaryOp: ADD {
        fprintf(detail_fp, "+ -> UnaryOp\n");
        $$ = 1;
    }
    | SUB {
        fprintf(detail_fp, "- -> UnaryOp\n");
        $$ = -1;
    }
    | NOT {
        fprintf(detail_fp, "! -> UnaryOp\n");
        $$ = 0;
    };
FuncRParams: Exp { 
        fprintf(detail_fp, "Exp -> FuncRParams\n");
        $$ = new ParamList();
        $$->exp.push_back($1);
    }
    | FuncRParams COMMA Exp {
        fprintf(detail_fp, "FuncRParams , Exp -> FuncRParams\n");
        $$ = $1;
        $$->exp.push_back($3);
    };
// FuncRParamsList: COMMA Exp {fprintf(detail_fp, ", Exp -> FuncRParamsList\n");}
//     | FuncRParamsList COMMA Exp {fprintf(detail_fp, "FuncRParamsList , Exp -> FuncRParamsList\n");}
//     ;
ConstExp: AddExp {
        fprintf(detail_fp, "AddExp -> ConstExp\n");
        if(!$1->isConst) {
            sprintf(msg, "initializer element '%s' is not constant", $1->text);
            yyerror(msg);
        } else {
            $$ = new Exp($1);
        }
    };
MulExp: UnaryExp {
        fprintf(detail_fp, "UnaryExp -> MulExp\n");
        $$ = new Exp($1);
    }
    | MulExp MUL UnaryExp {
        fprintf(detail_fp, "MulExp * UnaryExp -> MulExp\n");
        if($3->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            $3->isConst = 1;
            $3->value = 0;
        }
        $$ = new Exp();
        if($1->isConst && $3->isConst) {
            $$->isConst = true;
            $$->value = $1->value * $3->value;
        } else {
            text.loadReg($1, "%r8d");
            text.loadReg($3, "%r9d");
            text.append("\timull\t%%r9d, %%r8d\n");
            $$->offset = text.saveReg("%r8d", compiler);
            $$->isConst = false;
            $$->level = 1;
        }
    }
    | MulExp DIV UnaryExp {
        fprintf(detail_fp, "MulExp / UnaryExp -> MulExp\n");        
        if($3->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            $3->isConst = 1;
            $3->value = 0;
        }
        $$ = new Exp();
        if($1->isConst && $3->isConst) {
            $$->isConst = true;
            $$->value = $1->value / $3->value;
        } else {
            text.loadReg($1, "%eax");
            text.loadReg($3, "%r9d");
            text.append("\tcltd\n");
            text.append("\tidivl\t%%r9d\n");
            $$->offset = text.saveReg("%eax", compiler);
            $$->isConst = false;
            $$->level = 1;
        }
    }
    | MulExp MOD UnaryExp {
        fprintf(detail_fp, "MulExp % UnaryExp -> MulExp\n");        
        if($3->isVoid) {
            sprintf(msg, "invalid use of void expression");
            yyerror(msg);
            $3->isConst = 1;
            $3->value = 0;
        }
        $$ = new Exp();
        if($1->isConst && $3->isConst) {
            $$->isConst = true;
            $$->value = $1->value % $3->value;
        } else {
            text.loadReg($1, "%eax");
            text.loadReg($3, "%r9d");
            text.append("\tcltd\n");
            text.append("\tidivl\t%%r9d\n");
            $$->offset = text.saveReg("%edx", compiler);
            $$->isConst = false;
            $$->level = 1;
        }
    };
AddExp: MulExp {
        fprintf(detail_fp, "MulExp -> AddExp\n");
        $$ = new Exp($1);
    }
    | AddExp ADD MulExp {
        fprintf(detail_fp, "AddExp + MulExp -> AddExp\n");
        $$ = new Exp();
        if($1->isConst && $3->isConst) {
            $$->isConst = true;
            $$->value = $1->value + $3->value;
        } else {
            text.loadReg($1, "%r8d");
            text.loadReg($3, "%r9d");
            text.append("\taddl\t%%r9d, %%r8d\n");
            $$->offset = text.saveReg("%r8d", compiler);
            $$->isConst = false;
            $$->level = 1;
        }
    }
    | AddExp SUB MulExp {
        fprintf(detail_fp, "AddExp - MulExp -> AddExp\n");
        $$ = new Exp();
        if($1->isConst && $3->isConst) {
            $$->isConst = true;
            $$->value = $1->value - $3->value;
        } else {
            text.loadReg($1, "%r8d");
            text.loadReg($3, "%r9d");
            text.append("\tsubl\t%%r9d, %%r8d\n");
            $$->offset = text.saveReg("%r8d", compiler);
            $$->isConst = false;
            $$->level = 1;
        }
    };
RelExp: NewLabel AddExp LT AddExp {
        fprintf(detail_fp, "AddExp < AddExp -> RelExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if <\n");
        text.append("\tjl\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    }
    | NewLabel AddExp LE AddExp {
        fprintf(detail_fp, "AddExp <= AddExp -> RelExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if <=\n");
        text.append("\tjle\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    }
    | NewLabel AddExp GT AddExp {
        fprintf(detail_fp, "AddExp > AddExp -> RelExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if >\n");
        text.append("\tjg\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    }
    | NewLabel AddExp GE AddExp {
        fprintf(detail_fp, "AddExp >= AddExp -> RelExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if >=\n");
        text.append("\tjge\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    };
EqExp: NewLabel AddExp {
        fprintf(detail_fp, "AddExp -> EqExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.append("\tcmpl\t$0, %%r8d # if != 0\n");
        text.append("\tjne\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    }
    | NewLabel AddExp EQUAL AddExp {
        fprintf(detail_fp, "AddExp == AddExp -> EqExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if ==\n");
        text.append("\tje\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    }
    | NewLabel AddExp NE AddExp {
        fprintf(detail_fp, "AddExp != AddExp -> EqExp\n");
        $$ = new BoolExp();
        $$->label = $1;
        text.loadReg($2, "%r8d");
        text.loadReg($4, "%r9d");
        text.append("\tcmpl\t%%r9d, %%r8d # if !=\n");
        text.append("\tjne\t.L");
        $$->trueList.push_back(text.ln());
        text.append("\tjmp\t.L");
        $$->falseList.push_back(text.ln());
    };
BoolExp: RelExp {
        fprintf(detail_fp, "RelExp -> BoolExp\n");
        $$ = $1;
    }
    | EqExp {
        fprintf(detail_fp, "EqExp -> BoolExp\n");
        $$ = $1;
    };
LAndExp: BoolExp {
        fprintf(detail_fp, "BoolExp -> LAndExp\n");
        $$ = $1;
    }
    | LAndExp AND BoolExp {
        fprintf(detail_fp, "LAndExp && BoolExp -> LAndExp\n");
        $$ = new BoolExp();
        text.backPatch($1->trueList, $3->label);
        $$->trueList = $3->trueList;
        $$->falseList = mergeVector($1->falseList, $3->falseList);
        $$->label = $1->label;
    };
LOrExp: LAndExp {
        fprintf(detail_fp, "LAndExp -> LOrExp\n");
        $$ = $1;
    }
    | LOrExp OR LAndExp {
        fprintf(detail_fp, "LOrExp || LAndExp -> LOrExp\n");
        $$ = new BoolExp();
        text.backPatch($1->falseList, $3->label);
        $$->trueList = mergeVector($1->trueList, $3->trueList);
        $$->falseList = $3->falseList;
        $$->label = $1->label;
    };
%%

/* main */
int main() {
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


/* implement utils */
void exitFunc(int frameLine) {
    text.assignFrame(frameLine, compiler);
    compiler.exitLevel();
    compiler.recoverOffset(); // offset = offsets.back(); offsets.pop_back();
    if(!compiler.isReturned()) {
        // sprintf(msg, "control reaches end of non-void function");
        // yyerror(msg);
        text.append("\tleave");
        text.append("\tret");
    }
}

void handleIO(const char *func, ParamList* params) {
    int argc = params->exp.size();
    if(argc > 6) {
        sprintf(msg, "too many arguments to function '%s'", func);
        yyerror(msg);
        return;
    }
    if(!strcmp(func, "printf")) {
        text.append("\tleaq\t%s(%%rip), %s # param %d", params->exp[0]->text, ParamRegs[0], 0);
        for(int i = 1; i < argc; i++){
            Exp* cur = params->exp[i];
            text.loadReg(cur, "%r8d");
            text.append("\tmovsxd\t%%r8d, %%r8\n");
            text.append("\tmovq\t%%r8, %s # param %d\n", ParamRegs[i], i);
        }
        text.append("\tcall\tprintf");
    } else {
        /* handle scanf */
        text.append("\tleaq\t%s(%%rip), %s # param %d", params->exp[0]->text, ParamRegs[0], 0);
        for(int i = 1; i < argc; i++){
            Exp* cur = params->exp[i];
            if(!cur->isPointer) {
                sprintf(msg, "argument of '%s' must be a pointer", i, func);
                yyerror(msg);
                return;
            }
            text.append("\tmovq\t%d(%%rbp), %s # param %d\n", cur->offset, ParamRegs[i], i);
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

template <typename T>
std::vector<T> mergeVector(const std::vector<T>& a, const std::vector<T>& b) {
    std::vector<T> res;
    for(auto x: a) res.push_back(x);
    for(auto x: b) res.push_back(x);
    std::sort(res.begin(), res.end());
    res.erase(std::unique(res.begin(), res.end()), res.end());
    return res;
}

void asm_init() {
    rodata.append(".section .rodata\n");
    data.append(".section .data\n");
    bss.append(".section .bss\n");
    text.append(".section .text\n");
}
void asm_print(FILE *file) {
    rodata.print(file);
    fprintf(file, "\n");
    data.print(file);
    fprintf(file, "\n");
    bss.print(file);
    fprintf(file, "\n");
    text.print(file);
}

void yyerror(const char *s) {
    fprintf(stderr, "ERROR: %s\n", s);
}