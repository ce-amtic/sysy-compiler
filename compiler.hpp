#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <algorithm>
#include "ast.hpp"
#include "symbols.hpp"

struct CompileState
{
    int getOffset()
    {
        return offset;
    }
    void resetOffset()
    {
        offset = 0;
        peakOffset = 0;
        paramSize = 0;
    }
    void updateOffset(int val)
    {
        offset += val;
        if (abs(offset) > abs(peakOffset))
            peakOffset = offset;
    }
    void dumpOffset()
    {
        offsets.push_back(offset);
        peakOffsets.push_back(peakOffset);
        paramSizes.push_back(paramSize);
    }
    void recoverOffset()
    {
        offset = offsets.back();
        peakOffset = peakOffsets.back();
        paramSize = paramSizes.back();
        offsets.pop_back();
        peakOffsets.pop_back();
        paramSizes.pop_back();
    }
    void updateParamSize(int val)
    {
        paramSize = max(abs(val), paramSize);
    }
    int getPeakOffset()
    {
        return abs(peakOffset) + paramSize;
    }

    int getLevel()
    {
        return level;
    }
    void enterLevel()
    {
        level++;
        symbols.nextLevel();
    }
    void exitLevel()
    {
        level--;
        symbols.prevLevel();
    }

    bool isReturned()
    {
        return isCurrentFunctionReturned;
    }
    void resetReturnState()
    {
        isCurrentFunctionReturned = false;
    }
    void setReturned()
    {
        isCurrentFunctionReturned = true;
    }

    Symbol *lookup(char *name)
    {
        return symbols.lookup(name, level);
    }
    bool isFunction(char *name)
    {
        return symbols.isFunction(name, level);
    }
    void insertSymbol(char *name, Symbol *sym)
    {
        symbols.insert(name, sym);
    }

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
    void push(int line, int offset)
    {
        states.back().push_back(RuntimeState(line, offset));
    }
    void pop()
    {
        states.back().pop_back();
    }
    void nextLevel()
    {
        states.push_back(std::vector<RuntimeState>());
    }
    void prevLevel()
    {
        states.pop_back();
    }
    std::vector<RuntimeState> &back()
    {
        return states.back();
    }

private:
    std::vector<std::vector<RuntimeState>> states;
};