create_clock -name "clk" -period 50.0MHz [get_ports clk]
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty