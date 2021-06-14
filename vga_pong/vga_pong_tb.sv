`timescale 1ns / 1ps
module vga_pong_tb ();
	// Put dem localparams here bois
	//          |
	//        \ | /
	//         \|/
	localparam PrimaryBitWidth = 5;
	localparam Limit = 16;
	localparam InterationLimit = 4;
	localparam CycleLimit = 1024;
	
	// Clock and reset initalization shiz
	reg clk = 0;
	reg rst = 0;
	initial begin
		#10 rst = 1;
		#10 rst = 0;
	end
	always #100 clk = !clk;


	// Dis be your cycle limit counter, this will force stop the test
	// after your cycle count hits your CycleLimit
	//          |
	//        \ | /
	//         \|/	
	always_comb begin
		if (CycleCount == CycleLimit) begin
			$finish;
		end
	end
	wire [31:0] CycleCount;
	tbCounter #(
		.bit_width(32)
	) CycleCounter (
		.clk   (clk),
		.clk_en(1),
		.rst   (rst),
		.dOUT  (CycleCount)
	);


	reg init = 1;
	reg Advance = 0;
	reg Tic = 0;
	reg Toc = 0;
	always_ff @(posedge clk) begin : proc_TicTokerson
		if (Advance) begin
			// This is a half clock, Tic spends 1 cycle on, 1 cycle off
			//          |
			//        \ | /
			//         \|/	
			Tic = !Tic;
			// Dis be dat display stuff dem kids talk 'bout
			//          |
			//        \ | /
			//         \|/				
			$display("> END");						
			$display(">>>>>>>> CYCLE %0d <<<<<<<<", CycleCount);
			$display("> START");
			$display("Advance    %0b", Advance);
			$display("vga_h_sync %0h",vga_h_sync);
			$display("vga_v_sync %0h",vga_v_sync);
			$display("rgb        (%0h, %0h, %0h)", vga_r, vga_g, vga_b);

	    end
	    else if (init) begin
			init <= 0;
			Advance <= 1;
			// Put dat init stuffs her'
			//          |
			//        \ | /
			//         \|/
		end 
			// This halves Tic, so Toc will be on for 2 cycles, off for 2 cycles.
			//          |
			//        \ | /
			//         \|/
		if (Tic) begin
			Toc = !Toc;
		end
	end

	
	// Put dat shit chu wanna test here
	//          |
	//        \ | /
	//         \|/
	logic vga_h_sync;
	logic vga_v_sync;
	wire vga_r;
	wire vga_g;
	wire vga_b;
	wire in_display;

	vga_pong cntr (
		.clk (clk),
		.clk_en (Advance),
		.rst (rst),
		.vga_h_sync (vga_h_sync),
		.vga_v_sync (vga_v_sync),
		.vga_r (vga_r),
		.vga_g (vga_g),
		.vga_b (vga_b),
	);
endmodule

///////////////////////////////////////////////////////////////////////////////
////// IGNORE BELOW THIS ///// IGNORE BELOW THIS ///// IGNORE BELOW THIS //////
///////////////////////////////////////////////////////////////////////////////

// Modules used above are created below

module tbCounter #(
    parameter bit_width = 64
)(
	input clk,                   // Clock
	input clk_en,                // Clock Enable
	input rst,                   // Asynchronous reset active high -
	                               // Sets Counter Register to b'0
	output [bit_width-1:0] dOUT  // Current Counter Value
);


reg [bit_width-1:0] Count = '0;
assign dOUT = Count;
always_ff @(posedge clk or posedge rst) begin : proc_Count
	if(rst) begin
		Count <= '0;
	end 
    else if(clk_en) begin
		Count <= Count + 1'b1;
	end
end
endmodule

module tbCounterWLoad #(
    parameter bit_width = 64
)(
	input clk,                   // Clock
	input clk_en,                // Clock Enable
	input rst,                   // Asynchronous reset active high -
	                               // Sets Counter Register to b'0
    input load_en,              // Loads value dIN into Counter when;
                                  // load_en is high.
    input  [bit_width-1:0] dIN,
    output [bit_width-1:0] dOUT  // Current Counter Value

);

reg [bit_width-1:0] Count = '0;
assign dOUT = Count;
always_ff @(posedge clk or posedge rst) begin : proc_Count
	if(rst) begin
		Count <= '0;
	end 
    else if(clk_en && !load_en) begin
		Count <= Count + 1'b1;
    end 
    else if(clk_en && load_en) begin
        Count <= dIN;
	end
end
endmodule