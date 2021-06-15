module testbench;
logic clk = 0;
logic divided_clk;

// Wrapper
clock_divider DUT(
	.clk(clk),
	.divided_clk(divided_clk)
);

always #5 clk = ~clk; // every 5ns, signal flips. => 10ns period => 100MHz

endmodule