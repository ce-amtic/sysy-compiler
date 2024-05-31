#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include "ast_node.hpp"
#include "symbols.hpp"

#define abs(x) (x > 0 ? x : -x)
#define max(x, y) (x > y ? x : y)
#define min(x, y) (x < y ? x : y)

struct CompileState
{
    int getOffset();
    void resetOffset();
    void updateOffset(int val);
    void dumpOffset();
    void recoverOffset();
    void updateParamSize(int val);
    int getPeakOffset();

    int getLevel();
    void enterLevel();
    void exitLevel();

    bool isReturned();
    void resetReturnState();
    void setReturned();

    Symbol *lookup(char *name);
    bool isFunction(char *name);
    void insertSymbol(char *name, Symbol *sym);

    CompileState() {}

private:
    int level;                         // 0: global, 1+: local
    int offset, peakOffset, paramSize; // offset from the base pointer (rbp)
    std::vector<int> offsets, peakOffsets, paramSizes;
    bool isCurrentFunctionReturned = false;

    Symbols symbols;
};

struct RuntimeState
{
    int line;
    int offset;
    RuntimeState() {}
    RuntimeState(int line, int offset) : line(line), offset(offset) {}
};
struct RuntimeStack
{
    void push(int line, int offset);
    void pop();
    void nextLevel();
    void prevLevel();
    std::vector<RuntimeState> &back();

private:
    std::vector<std::vector<RuntimeState>> states;
};

/* implements */
int CompileState::getOffset()
{
    return offset;
}
void CompileState::resetOffset()
{
    offset = 0;
    peakOffset = 0;
    paramSize = 0;
}
void CompileState::updateOffset(int val)
{
    offset += val;
    if (abs(offset) > abs(peakOffset))
        peakOffset = offset;
}
void CompileState::dumpOffset()
{
    offsets.push_back(offset);
    peakOffsets.push_back(peakOffset);
    paramSizes.push_back(paramSize);
}
void CompileState::recoverOffset()
{
    offset = offsets.back();
    peakOffset = peakOffsets.back();
    paramSize = paramSizes.back();
    offsets.pop_back();
    peakOffsets.pop_back();
    paramSizes.pop_back();
}
void CompileState::updateParamSize(int val)
{
    paramSize = max(abs(val), paramSize);
}
int CompileState::getPeakOffset()
{
    return abs(peakOffset) + paramSize;
}
int CompileState::getLevel()
{
    return level;
}
void CompileState::enterLevel()
{
    level++;
    symbols.nextLevel();
}
void CompileState::exitLevel()
{
    level--;
    symbols.prevLevel();
}
bool CompileState::isReturned()
{
    return isCurrentFunctionReturned;
}
void CompileState::resetReturnState()
{
    isCurrentFunctionReturned = false;
}
void CompileState::setReturned()
{
    isCurrentFunctionReturned = true;
}
Symbol *CompileState::lookup(char *name)
{
    return symbols.lookup(name, level);
}
bool CompileState::isFunction(char *name)
{
    return symbols.isFunction(name, level);
}
void CompileState::insertSymbol(char *name, Symbol *sym)
{
    symbols.insert(name, sym);
}

void RuntimeStack::push(int line, int offset)
{
    states.back().push_back(RuntimeState(line, offset));
}
void RuntimeStack::pop()
{
    states.back().pop_back();
}
void RuntimeStack::nextLevel()
{
    states.push_back(std::vector<RuntimeState>());
}
void RuntimeStack::prevLevel()
{
    states.pop_back();
}
std::vector<RuntimeState> &RuntimeStack::back()
{
    return states.back();
}