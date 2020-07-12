#!/bin/bash

assert() {
    in=$1
    ans=$2
    cargo run $2 > out/asm.S

    riscv64-unknown-elf-gcc out/asm.S -o out/run
    spike pk out/run

    res=$?
    
    if [ $res == $ans ]; then
        echo "OK"
    else
        echo "Result: $res, Ans: $ans"
    fi
}


cd $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
mkdir -p out

assert 0 0
assert 10 10
assert 1+3 4
assert 1+3+8 12

