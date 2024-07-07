#pragma once
#include <assert.h>
#include <map>
#include <string>
#include <vector>

struct List {
  int value;
  std::vector<List *> nexts;
  bool align;

  List() { align = false; }
  List(const List &obj)
      : value(obj.value), nexts(obj.nexts), align(obj.align) {}
  List(const List *obj) : List(*obj) {}
  List(int value) : value(value) { align = false; }

  void dfsArray(std::vector<int> &dims, std::vector<int> &values) {
    __dfsArray(this, dims, values);
  }

private:
  void __dfsArray(List *u, std::vector<int> &dims, std::vector<int> &values,
                  int depth = 0) {
    int curSize = 1, nextSize = 1;
    for (int i = depth; i < dims.size(); i++) {
      curSize *= dims[i];
      if (i > depth)
        nextSize *= dims[i];
    }
    if (u->nexts.empty())
      values.push_back(u->value);
    for (auto x : u->nexts) {
      while (x->align && values.size() % nextSize)
        values.push_back(0);
      __dfsArray(x, dims, values, depth + 1);
    }
    while (u->align && values.size() % curSize)
      values.push_back(0);
    return;
  }
};

struct Dims {
  int size;
  std::vector<int> sizes;

  Dims() {}
  Dims(const Dims &obj) : size(obj.size), sizes(obj.sizes) {}
  Dims(const Dims *obj) : Dims(*obj) {}
};

/*
 Exp: 表达式类，即算术计算式，变量引用或者函数调用
 当函数调用不返回数值时，视为void Exp，这是特殊情况

 其余情况下，表达式一定可以在运行时求值，也就是实值表达式
 当各算子都是常量时，视为const Exp，其值可以编译时计算，存放在value里面

 non-const Exp 有两种情况：在栈上(offset) 或为 全局变量(next, offset)
 对于全局变量来说，需要暂时将它放在栈上作为一个临时变量，方便读，也就是记录offset
 而且还需要记录它的名字，即 text，这样方便写回
*/
struct Exp {
  char *text;
  bool isArray;
  bool isConst;
  bool isVoid;    // for void function calls
  bool isPointer; // passing array as parameter

  /* store the value of Exp */
  int offset; // offset from %ebp (only for non-constExp)
  int value;  // value (only for constExp)
  int offsetInArray;
  int level;

  Exp() { text = nullptr, isArray = isConst = isVoid = isPointer = false; }
  Exp(const Exp &obj)
      : text(obj.text), isArray(obj.isArray), isConst(obj.isConst),
        isVoid(obj.isVoid), isPointer(obj.isPointer), offset(obj.offset),
        value(obj.value), offsetInArray(obj.offsetInArray), level(obj.level) {}
  Exp(const Exp *obj) : Exp(*obj) {}
  Exp(char *text, int offset, int offsetInArray, int level)
      : text(text), offset(offset), offsetInArray(offsetInArray), level(level) {
    isArray = isConst = isVoid = isPointer = false;
  }
};

struct ExpList {
  Exp *exp; // == value in List{}
  std::vector<ExpList *> nexts;
  bool align;

  bool isConst;
  int constValue;
  int offset;

  ExpList() { align = false; }
  ExpList(const ExpList &obj)
      : exp(obj.exp), nexts(obj.nexts), align(obj.align), isConst(obj.isConst),
        constValue(obj.constValue), offset(obj.offset) {}
  ExpList(const ExpList *obj) : ExpList(*obj) {}
  ExpList(bool isConst, int value, int offset)
      : isConst(isConst), constValue(value), offset(offset) {
    align = false;
  }
  ExpList(Exp *exp)
      : exp(exp), isConst(exp->isConst), constValue(exp->value),
        offset(exp->offset) {
    align = false;
  }

  void dfsArray(std::vector<int> &dims, std::vector<bool> &isConsts,
                std::vector<int> &values) {
    __dfsArray(this, dims, isConsts, values);
  }

private:
  void __dfsArray(ExpList *u, std::vector<int> &dims,
                  std::vector<bool> &isConsts, std::vector<int> &values,
                  int depth = 0) {
    int curSize = 1, nextSize = 1;
    for (int i = depth; i < dims.size(); i++) {
      curSize *= dims[i];
      if (i > depth)
        nextSize *= dims[i];
    }
    if (u->nexts.empty()) {
      isConsts.push_back(u->isConst);
      values.push_back(u->isConst ? u->constValue : u->offset);
    }
    for (auto x : u->nexts) {
      while (x->align && values.size() % nextSize) {
        isConsts.push_back(true);
        values.push_back(0);
      }
      __dfsArray(x, dims, isConsts, values, depth + 1);
    }
    while (u->align && values.size() % curSize) {
      isConsts.push_back(true);
      values.push_back(0);
    }
    return;
  }
};

struct ExpDims {
  bool isConst;
  std::vector<bool> isConsts;
  std::vector<int>
      values; // for constExp: size = realValue, for non-constExp: size = offset

  ExpDims() {}
  ExpDims(const ExpDims &obj)
      : isConst(obj.isConst), isConsts(obj.isConsts), values(obj.values) {}
  ExpDims(const ExpDims *obj) : ExpDims(*obj) {}
};

struct ParamDef // must be INT
{
  char *name;
  std::vector<int> dims; // =x: [x]  =-1: []
};

struct ParamDefList {
  int argc;
  std::vector<ParamDef *> argv;
};

struct ParamList {
  std::vector<Exp *> exp;
};

struct BoolExp // expressions of logistic compution
{
  int label;
  std::vector<int> trueList, falseList;
};

struct LValue {
  char *name;
  bool haveDims;
  ExpDims *dims;
};