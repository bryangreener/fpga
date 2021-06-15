@echo off
echo CMD: iverilog -o out.tmp -g2012 -grelative-include -Y ".sv" -y %1 %2 && vvp out.tmp && del out.tmp && gtkwave sim.vcd && del sim.vcd
iverilog -o out.tmp -g2012 -grelative-include -Y ".sv" -y %1 %2 && vvp out.tmp && del out.tmp && gtkwave sim.vcd && del sim.vcd