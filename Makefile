CC = clang++
CFLAGS = -std=c++17 -stdlib=libc++ -Wall -O2 -g # -fsanitize=address

parser: sysy.tab.cpp sysy.tab.hpp lex.yy.cpp assembly.hpp ast_node.hpp symbols.hpp compiler.hpp
	${CC} ${CFLAGS} -o parser sysy.tab.cpp lex.yy.cpp

sysy.tab.cpp sysy.tab.hpp: sysy.y
	bison -o sysy.tab.cpp -d -v sysy.y

lex.yy.cpp: sysy.l
	flex -o lex.yy.cpp --noyywrap sysy.l

clean:
	rm -f parser sysy.tab.* lex.yy.* *.o testflex *.output out/*.s out/prog
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
