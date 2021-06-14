create_clock -period 50.00 -name clk [get_ports clk]
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty