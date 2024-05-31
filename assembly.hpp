#pragma once
#include <vector>
#include <string>
#include <cstdarg>
#include <cstdio>
#include "ast.hpp"

// const char *fmt1d = "fmt1d:\t.string \"%%d\"";
// const char *fmt1c = "fmt1c:\t.string \"%%c\"";
// const char *fmt1dn = "fmt1dn:\t.string \"%%d\\n\"";
// const char *fmt2dn = "fmt2dn:\t.string \"%%d %%d\\n\"";
const char ParamRegs[6][5] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};

struct Assembly
{
    void append(const char *format, ...);
    void comment(const char *message);
    void print(FILE *file);
    void alignStack(int &offset);
    int saveReg(const char *reg, int &offset);
    void loadReg(Exp *exp, const char *reg, bool loadAddress = false);

    int ln();
    void backPatch(const std::vector<int> &lines, int label);
    int newLabel();

    void modLine(int line, const char *format, ...);
    void appendLine(int line, const char *format, ...);

private:
    std::vector<std::string> code;
    int labelIndex;
    void removeBr(int line);
    void addSpacesBeforeHash(std::string &input);
} rodata, data, bss, text;

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

void Assembly::appendLine(int line, const char *format, ...)
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
    removeBr(line);
    code[line] += std::string(buffer);
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
    c += "\t\t# ";
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

void Assembly::alignStack(int &offset)
{
    int padding = (16 - abs(offset) % 16) % 16;
    if (padding == 0)
        return;
    offset -= padding;
    append("\tsubq\t$%d, %%rsp  # align stack\n", padding);
    // append("\tleaq\t(%%rbp), %%r8\n");
    // append("\tleaq\t(%%rsp), %%r9\n");
    // append("\tsubq\t%%r9, %%r8\n");
    // append("\tandq\t$16, %%r8\n");
    // append("\tmovq\t$16, %%r9\n");
    // append("\tsubq\t%%r8, %%r9\n");
    // append("\tandq\t$16, %%r9\n");
    // append("\tsubq\t%%r9, %%rsp # align stack\n");
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
            // fprintf(stderr, "%s %d %d %s\n", exp->text, exp->offset, exp->offsetInArray, reg);
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
            text.append("\tleaq\t%d(%%rbp), %s\n", exp->offset + 4 * exp->offsetInArray, reg);
        else
            text.append("\tmovl\t%d(%%rbp), %s\n", exp->offset + 4 * exp->offsetInArray, reg);
        // if (exp->isArray)
        //     append("\tleaq\t%d(%%rbp), %%rbx\n", exp->offset + 4 * exp->offsetInArray); // addr in %rbx
        // else
        //     append("\tleaq\t%d(%%rbp), %%rbx\n", exp->offset); // addr in %rbx
        // if (loadAddress)
        //     append("\tleaq\t0(%%rbx), %s\n", reg);
        // else
        //     append("\tmovl\t0(%rbx), %s\n", reg);
    }
}

void Assembly::removeBr(int line)
{
    while (code[line].back() == '\n')
        code[line].pop_back();
}

int Assembly::saveReg(const char *reg, int &offset)
{
    offset -= 4;
    text.append("\tsubq\t$4, %%rsp\n");
    text.append("\tmovl\t%s, %d(%%rbp)\n", reg, offset);
    return offset;
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

void asm_init()
{
    rodata.append(".section .rodata\n");
    data.append(".section .data\n");
    bss.append(".section .bss\n");
    text.append(".section .text\n");

    // data.append(fmt1c);
    // data.append(fmt1d);
    // data.append(fmt1dn);
    // data.append(fmt2dn);
}

void asm_print(FILE *file)
{
    rodata.print(file);
    fprintf(file, "\n");
    data.print(file);
    fprintf(file, "\n");
    bss.print(file);
    fprintf(file, "\n");
    text.print(file);
}