
// char *arg0 = params->exp[0]->text, *fmt_str = nullptr;
// fprintf(stderr, "%s %s\n", arg0, "\"%d\\n\"");
// if(!strcmp(arg0, "\"%c\"")) fmt_str = "fmt1c";
// if(!strcmp(arg0, "\"%d\"")) fmt_str = "fmt1d";
// if(!strcmp(arg0, "\"%d\\n\"")) fmt_str = "fmt1dn";
// if(!strcmp(arg0, "\"%d %d\\n\"")) fmt_str = "fmt2dn";
// assert(fmt_str != nullptr);

else if (sym->type != Type::INT_ARRAY && sym->type != Type::CONST_ARRAY && sym->type != Type::POINTER)
{
    sprintf(msg, "subscripted value '%s' is not an array", varName);
    yyerror(msg);
}

else
{
    if ($2->isConst)
    {
        int offsetInArray = 0;
        for (int i = 0; i < sym->sizes.size(); i++)
        {
            offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
        }
        text.append("\tmovl\t$%d, %%ecx\n", offsetInArray); // save offsetInArray
    }
    else
    {
        // generate code to calculate 'offsetInArray'
        text.append("\tmovl\t$0, %%r8d\n"); // int of = 0;
        for (int i = 0; i < sym->sizes.size(); i++)
        {
            // offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
            text.append("\timull\t$%d, %%r8d\n", sym->sizes[i]);
            if ($2->isConsts[i])
                text.append("\tmovl\t$%d, %%r9d\n", $2->values[i]);
            else
                text.append("\tmovl\t%d(%%rbp), %%r9d\n", $2->values[i]);
            text.append("\taddl\t%%r9d, %%r8d\n");
        }
        // offsetInArray is %r8d
        text.append("\tmovl\t%%r8d, %%ecx\n"); // save offsetInArray
    }
}

// if (sym->type == Type::POINTER) {
//     // base address: value of [sym->offset](%rbp) -> %r9
//     // final address: 0(%r9, %r8d, 4)
//     text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
//     text.append("\tmovsxd\t%%ecx, %%rcx\n");
//     text.append("\tleaq\t(%%r9, %%rcx, 4), %%rbx\t\t# pointer as lvalue\n");
// }

// } else if (sym->type == Type::POINTER) {
//     if($2->isConst) {
//         int offsetInArray = 0;
//         for(int i = 0; i < sym->sizes.size(); i++) {
//             offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
//         }
//         text.append("\tmovl\t$%d, %%r8d\n", offsetInArray);
//     } else {
//         // generate code to calculate 'offsetInArray'
//         text.append("\tmovl\t$0, %%r8d\n"); // int of = 0;
//         for(int i = 0; i < sym->sizes.size(); i++) {
//             // offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
//             text.append("\timull\t$%d, %%r8d\n", sym->sizes[i]);
//             if($2->isConsts[i])
//                 text.append("\tmovl\t$%d, %%r9d\n", $2->values[i]);
//             else
//                 text.append("\tmovl\t%d(%%rbp), %%r9d\n", $2->values[i]);
//             text.append("\taddl\t%%r9d, %%r8d\n");
//         }
//     }
//     // offsetInArray is %r8d
//     // base address: value of [sym->offset](%rbp) -> %r9
//     // final address: 0(%r9, %r8d, 4)
//     text.append("\tmovq\t%d(%%rbp), %%r9\n", sym->offset);
//     text.append("\tmovsxd\t%%r8d, %%r8\n");
//     text.append("\tmovl\t(%%r9, %%r8, 4), %%eax\t\t# pointer as rvalue\n"); // result in %eax
//     $$->offset = text.saveReg("%eax", offset);
//     $$->isConst = false;
//     $$->level = 1;
// } else {
//     if($2->isConst) {
//         int offsetInArray = 0;
//         for(int i = 0; i < sym->sizes.size(); i++) {
//             offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
//         }
//         if(sym->type == Type::CONST_ARRAY) {
//             $$->isConst = true;
//             $$->value = sym->constValues[offsetInArray];
//             $$->level = sym->level;
//         } else {
//             text.loadReg(new Exp($1, sym->offset, offsetInArray, sym->level), "%r8d");
//             $$->isConst = false;
//             $$->offset = text.saveReg("%r8d", offset);
//             $$->level = 1;
//         }
//     } else {
//         // generate code to calculate 'offsetInArray'
//         text.append("\tmovl\t$0, %%r8d\n"); // int of = 0;
//         for(int i = 0; i < sym->sizes.size(); i++) {
//             // offsetInArray = offsetInArray * sym->sizes[i] + $2->values[i];
//             text.append("\timull\t$%d, %%r8d\n", sym->sizes[i]);
//             if($2->isConsts[i])
//                 text.append("\tmovl\t$%d, %%r9d\n", $2->values[i]);
//             else
//                 text.append("\tmovl\t%d(%%rbp), %%r9d\n", $2->values[i]);
//             text.append("\taddl\t%%r9d, %%r8d\n");
//         }
//         // offsetInArray is %r8d
//         text.append("\tmovslq\t%%r8d, %%r8\n"); // change to 64bit
//         if(sym->type == Type::CONST_ARRAY) {
//             text.append("\tleaq\t%s(%%rip), %%rbx\n", $1); // base of array
//             text.append("\tmovl\t(%%rbx, %%r8, 4), %%eax\n"); // result in %eax
//         } else {
//             text.append("\tmovl\t%d(%%rbp, %%r8, 4), %%eax\n", sym->offset); // result in %eax
//         }
//         $$->offset = text.saveReg("%eax", offset);
//         $$->isConst = false;
//         $$->level = 1;
//     }
// }