transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+H:/code/fpga/vga_cube/ip {H:/code/fpga/vga_cube/ip/pll.v}
vlog -vlog01compat -work work +incdir+H:/code/fpga/vga_cube/db {H:/code/fpga/vga_cube/db/pll_altpll.v}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/xd.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/linebuffer.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/draw_line.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/display_timing_800x600.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/bram_sdp.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/framebuffer.sv}
vlog -sv -work work +incdir+H:/code/fpga/vga_cube {H:/code/fpga/vga_cube/top_cube.sv}

