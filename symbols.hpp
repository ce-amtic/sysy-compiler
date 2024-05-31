#pragma once
#include <vector>
#include <map>
#include <string>
#include "ast.hpp"

enum struct Type
{
    VOID,
    INT_FUNCTION,
    VOID_FUNCTION,
    CONST,
    CONST_ARRAY,
    INT,
    INT_ARRAY,
    POINTER, // partly supported
};

struct Symbol
{
    Type type;  // type of the symbol
    int offset; // offset from %ebp
    int level;  // 0: global, 1+: local

    int constValue;               // value of the constant
    std::vector<int> constValues; // value of the constant
    std::vector<int> sizes;       // for ArrayDimensions
    ParamDefList *params;         // for FuncParams

    Symbol()
        : type(Type::VOID), offset(0), level(0), constValue(0) {}

    Symbol(Type type, int level)
        : type(type), level(level) {}

    Symbol(Type type, int offset, int level)
        : type(type), offset(offset), level(level), constValue(0) {}

    Symbol(Type type, int offset, int level, std::vector<int> sizes)
        : type(type), offset(offset), level(level), sizes(sizes) {}

    Symbol(Type type, int offset, int level, int constValue)
        : type(type), offset(offset), level(level), constValue(constValue) {}

    Symbol(Type type, int offset, int level, std::vector<int> constValues, std::vector<int> sizes)
        : type(type), offset(offset), level(level), constValues(constValues), sizes(sizes) {}

    void print()
    {
        printf("Symbol: type=%d, offset=%d, level=%d, constValue=%d\n", (int)type, offset, level, constValue);
    }
};

struct Symbols
{
    Symbol *lookup(char *name_c, int cur_level);
    bool isFunction(char *name_c, int cur_level);
    void insert(char *name_c, Symbol *symbol);

    std::vector<std::map<std::string, Symbol *>> table;

    Symbols() { table.push_back(std::map<std::string, Symbol *>()); }
    void nextLevel() { table.push_back(std::map<std::string, Symbol *>()); }
    void prevLevel() { table.pop_back(); }
};

bool Symbols::isFunction(char *name_c, int cur_level)
{
    std::string name(name_c);
    for (int i = cur_level; i >= 0; i--)
    {
        if (table[i].find(name) != table[i].end())
        {
            return table[i][name]->type == Type::INT_FUNCTION || table[i][name]->type == Type::VOID_FUNCTION;
        }
    }
    return false;
}

Symbol *Symbols::lookup(char *name_c, int cur_level)
{
    std::string name(name_c);
    for (int i = cur_level; i >= 0; i--)
    {
        if (table[i].find(name) != table[i].end())
        {
            return table[i][name];
        }
    }
    return nullptr;
}

void Symbols::insert(char *name_c, Symbol *symbol)
{
    std::string name(name_c);
    table[symbol->level][name] = symbol;
}
