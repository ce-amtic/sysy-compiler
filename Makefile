CC = clang++
CFLAGS = -std=c++17 -stdlib=libc++ -Wall -O2 -g # -fsanitize=address

parser: sysy.tab.c sysy.tab.h lex.yy.c assembly.hpp ast_node.hpp symbols.hpp compiler.hpp
	${CC} ${CFLAGS} -o parser sysy.tab.c lex.yy.c

sysy.tab.c sysy.tab.h: sysy.y
	bison -d -v sysy.y

lex.yy.c: sysy.l
	flex --noyywrap sysy.l

clean:
	rm -f parser sysy.tab.* lex.yy.* *.o testflex *.output

# plot:
# 	./parser < tests/7/7-side_effect.c > ./plot/detail.txt
# 	sh ./plot/run.sh

detail.txt:
	./parser < out/test.c

plot: detail.txt
	sh ./plot/run.sh

output:
	./parser < out/test.c > out/output.s

test:
	gcc -o out/prog out/output.s
	out/prog

testin:
	gcc -o out/prog out/output.s
	out/prog < out/testcase.in
