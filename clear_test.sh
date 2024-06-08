#!/bin/bash

PARSER="./parser"
TEST_DIR="./tests"

GOAL=0
TOTAL=0

for DIR in $TEST_DIR/*; do # 遍历tests目录中的所有子目录
    if [ -d "$DIR" ]; then
        ID=$(basename "$DIR")   # 获取当前子目录的ID
        for FILE in "$DIR"/*.c; do # 遍历子目录中的.c文件
            if [ -f "$FILE" ]; then
                echo "Clearing $BASENAME"
                
                BASENAME=$(basename "$FILE" .c) # 获取文件名，不包含路径和扩展名
                rm -f "$DIR/${BASENAME}.s" "$DIR/${BASENAME}" "$DIR/${BASENAME}.myout"
            fi
        done
    fi
    # echo "Do you want to continue? [y/n]"
    # read CONTINUE
    # if [ "$CONTINUE" != "y" ]; then
    #     break
    # fi
done
