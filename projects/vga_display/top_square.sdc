create_clock -name "clk_pix" -period 25.0MHz [get_ports clk_pix]
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty