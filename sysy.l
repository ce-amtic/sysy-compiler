%option noyywrap
%{

#include <stdio.h>
#include <stdlib.h>
#include "sysy.tab.hpp"

#define DEBUG 0

int lnNum = 1, colNum = 1;

const char* INTCONST = "IntConst";
const char* IDENT = "Ident";
const char* KEYWORD = "KWD";
const char* OPERATOR = "OPR";
const char* DELIMITER = "DEL";

void printline(char *text, int len, int type) {
    const char* typestr;
    switch(type) {
        case 0: typestr = IDENT; break;
        case 1: typestr = INTCONST; break;
        case 2: typestr = KEYWORD; break;
        case 3: typestr = OPERATOR; break;
        case 4: typestr = DELIMITER; break;
    }
    if(DEBUG) fprintf(stderr, "%-20s %-5d %-10s (%d,%d)\n", text, lnNum, typestr, colNum, colNum+len);
}
void delimiter(char* yytext) {
    int len = strlen(yytext);
    printline(yytext, len, 4);
    colNum += len;
}
void operators(char* yytext) {
    int len = strlen(yytext);
    printline(yytext, len, 3);
    colNum += len;
}
void keywords(char* yytext) {
    int len = strlen(yytext);
    printline(yytext, len, 2);
    colNum += len;
}
void constant(char* yytext) {
    int len = strlen(yytext);
    printline(yytext, len, 1);
    colNum += len;
}
void identifier(char* yytext) {
    int len = strlen(yytext);
    printline(yytext, len, 0);
    colNum += len;
}
void error(char* yytext) {
    int len = strlen(yytext);
    colNum += len;
    if(DEBUG) fprintf(stderr, "ERROR: CANNOT INTERPRET %s\n", yytext);
}
%}

IDENT [a-zA-Z_][a-zA-Z0-9_]*

%x IN_COMMENT

%%
"include" {keywords(yytext); return INCLUDE;}
"const" {keywords(yytext); return CONST;}
"int" {keywords(yytext); return INT;}
"void" {keywords(yytext); return VOID;}
"if" {keywords(yytext); return IF;}
"else" {keywords(yytext); return ELSE;}
"while" {keywords(yytext); return WHILE;}
"break" {keywords(yytext); return BREAK;}
"continue" {keywords(yytext); return CONTINUE;}
"return" {keywords(yytext); return RETURN;}
"=" {operators(yytext); return ASSIGN;}
"==" {operators(yytext); return EQUAL;}
"!=" {operators(yytext); return NE;}
"<" {operators(yytext); return LT;}
">" {operators(yytext); return GT;}
"<=" {operators(yytext); return LE;}
">=" {operators(yytext); return GE;}
"+" {operators(yytext); return ADD;}
"-" {operators(yytext); return SUB;}
"*" {operators(yytext); return MUL;}
"/" {operators(yytext); return DIV;}
"%" {operators(yytext); return MOD;}
"&" {operators(yytext); return ADDRESSOF;}
"|" {operators(yytext); return yytext[0];}
"!" {operators(yytext); return NOT;}
"&&" {operators(yytext); return AND;}
"||" {operators(yytext); return OR;}
"(" {delimiter(yytext); return LPAREN;}
")" {delimiter(yytext); return RPAREN;}
"{" {delimiter(yytext); return LBRACE;}
"}" {delimiter(yytext); return RBRACE;}
";" {delimiter(yytext); return SEMICOLON;}
"," {delimiter(yytext); return COMMA;}
"[" {delimiter(yytext); return LBRACKET;}
"]" {delimiter(yytext); return RBRACKET;}
"#" {delimiter(yytext); return HASH;}
"." {delimiter(yytext); return DOT;}
" " {colNum += 1;}
\t {colNum += 1;}
\n {lnNum += 1; colNum = 1;}

"//".* {}
"/*" {BEGIN(IN_COMMENT);}
<IN_COMMENT>\n {lnNum += 1; colNum = 1;}
<IN_COMMENT>. {colNum += 1;}
<IN_COMMENT>"*/" {BEGIN(INITIAL);} 

[-+]*0[bB][01]+ {constant(yytext); yylval.num = atoi(yytext); return Number;}
[-+]*0[0-7]+ {constant(yytext); yylval.num = atoi(yytext); return Number;}
[-+]*[1-9][0-9]* {constant(yytext); yylval.num = atoi(yytext); return Number;}
[-+]*0[xX][0-9a-fA-F]+ {constant(yytext); yylval.num = atoi(yytext); return Number;}
[-+]*0 {constant(yytext); yylval.num = atoi(yytext); return Number;}
\"([^\\"]|\\.)*\" {constant(yytext); yylval.str = strdup(yytext); return String;}

{IDENT} {identifier(yytext); yylval.str = strdup(yytext); return Ident;}

[0-9a-zA-Z]+ {error(yytext); return *yytext;}

. {
    if(DEBUG) fprintf(stderr, "LEXER CANNOT RECOGNIZE %s\n", yytext); 
    colNum += 1;
} 
%%
