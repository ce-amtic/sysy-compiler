#pragma once
#include <vector>
#include <string>
#include <cstdarg>
#include <cstdio>
#include "ast_node.hpp"
#include "compiler.hpp"

const char ParamRegs[6][5] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};

struct Assembly
{
    void append(const char *format, ...);
    void comment(const char *message);
    void print(FILE *file);
    // void alignStack(CompileState &comp);
    int saveReg(const char *reg, CompileState &comp);
    void loadReg(Exp *exp, const char *reg, bool loadAddress = false);

    int ln();
    void backPatch(const std::vector<int> &lines, int label);
    int newLabel();

    void modLine(int line, const char *format, ...);
    void assignFrame(int line, CompileState &comp);

private:
    std::vector<std::string> code;
    int labelIndex;
    void removeBr(int line);
    void addSpacesBeforeHash(std::string &input);
};

/* implements */
void Assembly::assignFrame(int line, CompileState &comp)
{
    int pof = comp.getPeakOffset();
    int alignedSize = (pof + 15) / 16 * 16;
    modLine(line, "\tsubq\t$%d, %%rsp # fixed frame size", alignedSize);
}
void Assembly::addSpacesBeforeHash(std::string &input)
{
    size_t hashPos = input.find('#');
    if (hashPos != std::string::npos)
    {
        int length = hashPos;
        for (int i = 0; i < hashPos; i++)
            if (input[i] == '\t')
                length += 3;
        int spacesToAdd = 45 - length;
        if (spacesToAdd > 0)
            input.insert(hashPos, spacesToAdd, ' ');
    }
    return;
}
void Assembly::modLine(int line, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    char buffer[512];
    memset(buffer, 0, sizeof(buffer));
    vsnprintf(buffer, 512, format, args);
    va_end(args);
    int len = strlen(buffer);
    if (buffer[len - 1] != '\n')
        buffer[len] = '\n';
    code[line] = std::string(buffer);
}
void Assembly::comment(const char *message)
{
    removeBr(ln());
    auto &c = code.back();
    c += " # ";
    c += message;
    c += "\n";
}
int Assembly::newLabel()
{
    labelIndex++;
    append(".L%d:", labelIndex);
    return labelIndex;
}
void Assembly::backPatch(const std::vector<int> &lines, int label)
{
    for (auto &l : lines)
    {
        code[l].pop_back();
        code[l] += std::to_string(label) + "\n";
    }
}
int Assembly::ln()
{
    return code.size() - 1;
}
void Assembly::loadReg(Exp *exp, const char *reg, bool loadAddress)
{
    if (exp->isConst)
    {
        append("\tmovl\t$%d, %s\n", exp->value, reg);
        return;
    }
    if (exp->level == 0) // in .data or .rodata
    {
        if (exp->isArray)
        {
            append("\tleaq\t%s(%%rip), %%rbx\n", exp->text); // base addr in %rbx
            if (loadAddress)
                append("\tleaq\t%d(%rbx), %s\n", 4 * exp->offsetInArray, reg);
            else
                append("\tmovl\t%d(%rbx), %s\n", 4 * exp->offsetInArray, reg);
        }
        else
        {
            append("\tleaq\t%s(%%rip), %%rbx\n", exp->text); // base addr in %rbx
            if (loadAddress)
                append("\tleaq\t0(%rbx), %s\n", reg);
            else
                append("\tmovl\t0(%rbx), %s\n", reg);
        }
    }
    else // in stack
    {
        if (loadAddress)
            append("\tleaq\t%d(%%rbp), %s\n", exp->offset + 4 * exp->offsetInArray, reg);
        else
            append("\tmovl\t%d(%%rbp), %s\n", exp->offset + 4 * exp->offsetInArray, reg);
    }
}
void Assembly::removeBr(int line)
{
    while (code[line].back() == '\n')
        code[line].pop_back();
}
int Assembly::saveReg(const char *reg, CompileState &comp)
{
    comp.updateOffset(-4);
    append("\tmovl\t%s, %d(%%rbp)\n", reg, comp.getOffset());
    return comp.getOffset();
}
void Assembly::append(const char *format, ...)
{
    va_list args;
    va_start(args, format);
    char buffer[512];
    memset(buffer, 0, sizeof(buffer));
    vsnprintf(buffer, 512, format, args);
    va_end(args);
    int len = strlen(buffer);
    if (buffer[len - 1] != '\n')
        buffer[len] = '\n';
    code.push_back(std::string(buffer));
}
void Assembly::print(FILE *file)
{
    for (auto &line : code)
    {
        addSpacesBeforeHash(line);
        fprintf(file, "%s", line.c_str());
    }
}
// void Assembly::alignStack(CompileState &comp)
// {
//     int padding = (16 - abs(comp.getOffset()) % 16) % 16;
//     if (padding == 0)
//         return;
//     comp.updateOffset(-padding); // offset -= padding; append("\tsubq\t$%d, %%rsp  # align stack\n", padding);

//     //  append("\tleaq\t(%%rbp), %%r8\n");
//     //  append("\tleaq\t(%%rsp), %%r9\n");
//     //  append("\tsubq\t%%r9, %%r8\n");
//     //  append("\tandq\t$16, %%r8\n");
//     //  append("\tmovq\t$16, %%r9\n");
//     //  append("\tsubq\t%%r8, %%r9\n");
//     //  append("\tandq\t$16, %%r9\n");
//     //  append("\tsubq\t%%r9, %%rsp # align stack\n");
// }