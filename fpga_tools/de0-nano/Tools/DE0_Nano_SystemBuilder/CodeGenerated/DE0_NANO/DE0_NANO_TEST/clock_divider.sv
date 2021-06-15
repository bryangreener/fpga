// counter based
module clock_divider(
	input logic clk, // 100MHz
	output logic divided_clk = 0// 1Hz => 0.5s ON and 0.5s OFF
);

localparam division_value = 1000; // 1Hz?

integer counter_value = 0; // 32bit reg bus

always@ (posedge clk) // sensitivity list
begin
	if (counter_value == division_value)
		// Reset counter using blocking assignment
		counter_value = 0;
	else
		// Increment using non-blocking assignment
		counter_value <= counter_value + 1;
end

// divide clock
always @(posedge clk)
begin
	if (counter_value == division_value)
		divided_clk <= ~divided_clk; // flip signal
	else
		divided_clk <= divided_clk; // keep same
end

endmodule