### Quick Start

Put your source code in `out/test.c`.

```
make
make output
make test
```

Use `make plot` to generate Abstract Syntax Tree for your source code. `plot/tree.py` is a helpful script that generates an AST using a production reduction stream.

Use `test.sh` to automatically run tests.

### Known Bugs

- The parsing method for high-dimensional array initialization lists is not completely consistent with GCC. (For example GCC parse `int a[2][3][4]={{1}, {2}};` into `[0][0][0]=1, [0][0][4]=2`, my compiler `[0][0][0]=1, [0][1][0]=2` however.)
