#!/bin/bash

PARSER="./parser"
TEST_DIR="./tests"

if [ ! -f "$PARSER" ]; then
    make clean
    make
fi
if [ ! -f "$PARSER" ]; then
    echo "cannot generate parser"
    exit 1
fi

GOAL=0
TOTAL=0

for DIR in $TEST_DIR/*; do # 遍历tests目录中的所有子目录
    if [ -d "$DIR" ]; then
        ID=$(basename "$DIR")   # 获取当前子目录的ID
        for FILE in "$DIR"/*.c; do # 遍历子目录中的.c文件
            if [ -f "$FILE" ]; then
                BASENAME=$(basename "$FILE" .c) # 获取文件名，不包含路径和扩展名
                $PARSER < "$FILE" > "$DIR/${BASENAME}.s" # 执行parser并生成.s文件
                gcc -o "$DIR/${BASENAME}" "$DIR/${BASENAME}.s" # 编译生成的.s文件为可执行文件
                
                echo "Testing $BASENAME"
                
                first_in_file=$(ls "$DIR"/*.in 2>/dev/null | head -n 1)
                if [ -n "$first_in_file" ]; then
                    "$DIR/${BASENAME}" < "$first_in_file" > "$DIR/${BASENAME}.myout"
                else
                    "$DIR/${BASENAME}" > "$DIR/${BASENAME}.myout" # 运行生成的可执行文件
                fi
                
                if [ -f "$DIR/${BASENAME}.out" ]; then
                    if diff -Z "$DIR/${BASENAME}.myout" "$DIR/${BASENAME}.out" > /dev/null; then
                        echo "-> ok"
                        GOAL=$((GOAL+1))
                    else
                        echo "-> $BASENAME failed"
                    fi
                else
                    echo "-> ok"
                    GOAL=$((GOAL+1))
                fi

                TOTAL=$((TOTAL+1))
            fi
        done
    fi
    # echo "Do you want to continue? [y/n]"
    # read CONTINUE
    # if [ "$CONTINUE" != "y" ]; then
    #     break
    # fi
done

echo ""
echo "Total: $GOAL/$TOTAL"
