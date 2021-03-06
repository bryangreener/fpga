transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST {E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST/clock_divider.sv}

vlog -sv -work work +incdir+E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST {E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST/testbench.sv}
vlog -sv -work work +incdir+E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST {E:/de0-nano/Tools/DE0_Nano_SystemBuilder/CodeGenerated/DE0_NANO/DE0_NANO_TEST/top.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top

add wave *
view structure
view signals
run -all
