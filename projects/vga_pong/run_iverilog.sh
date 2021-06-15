#!/bin/sh
# Run iverilog, then vvp, then gtkwave
while getopts t: flag
do
    case "${flag}" in
        t) testbench=${OPTARG};;
    esac
done

iverilog -o out.tmp -g2012 -grelative-include -Y ".sv" -y $PWD $testbench
vvp out.tmp
del out.tmp
gtkwave sim.vcd
del sim.vcd