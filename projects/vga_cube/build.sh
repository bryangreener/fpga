#!/bin/bash
filename=$(basename -- "$2")
extension="${filename##*.}"
tb_name="${filename%.*}"
echo INPUT: $1/$2 OUTPUT: "${tb_name}".txt
iverilog.exe \
    -o tb_outputs/out.tmp \
    -g2012 \
    -grelative-include \
    -Y ".sv" \
    -Y ".v" \
    -y $1 \
    $2 \
    && vvp.exe tb_outputs/out.tmp > tb_outputs/"${tb_name}".txt