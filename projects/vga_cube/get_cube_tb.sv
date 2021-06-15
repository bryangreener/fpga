`timescale 1ns/1ps
module get_cube_tb ();
    localparam WIDTH        = 5;                    // primary bit width
    localparam MAX_CYCLES   = CUBE_N_LINES;         // max number of cycles to perform
    localparam WIDTH_CNT    = $clog2(MAX_CYCLES)+1; // counter bit width

    initial begin
        $dumpfile("tb_outputs/sim.vcd");
        $dumpvars(0,get_cube_tb);
    end

    // Clock and reset initialization
    reg clk = 0;
    reg rst = 0;
    initial begin
        #10 rst = 1;
        #10 rst = 0;
    end
    always #100 clk = !clk;

    // Cycle limit counter. Will force stop the test after cycle count = cycle limit
    always_comb if (cycle_count == MAX_CYCLES) $finish;

    wire [WIDTH_CNT-1:0] cycle_count;
    tb_counter #(.WIDTH(WIDTH_CNT)) cycle_counter (.clk(clk), .clk_en(1'b1), .rst(rst), .o(cycle_count));

    reg init = 1;
    reg adv = 0;
    reg tic = 0;
    reg toc = 0;
    always_ff @(posedge clk) begin : poc_tic_toc
        if (adv) begin
            // This is a half clock. Tic high for one cycle.
            tic = !tic;
            // Display code here
            $display("line %0d: start (%0d,%0d), end (%0d,%0d)", line_id, x0, y0, x1, y1);

        end else if (init) begin
            init <= 0;
            adv <= 1;
            // Init here
        end
        // This halves tic so toc will be high for 2 cycles
        if (tic) toc = !toc;
    end

    // Testing code here
    localparam CUBE_N_LINES = 12;

    localparam CUBE_XY_BITW = 16;
    localparam CUBE_LINEW   = 4;    // $clog2 of number of lines in a cube (12)
    localparam CUBE_COLORW  = 3;
    localparam CUBE_WIDTH   = 10;
    localparam CUBE_HEIGHT  = 10;
    localparam CUBE_DEPTH   = 5;
    localparam CUBE_ADJ_DEG = 45;   // not implemented yet since no FPU
    localparam CUBE_SCALE   = 1;

    logic [CUBE_LINEW-1:0] line_id;
    logic [CUBE_COLORW-1:0] color;
    logic [CUBE_XY_BITW-1:0] x0, y0, x1, y1;

    assign line_id = cycle_count;

    get_cube #(
        .XY_BITW(CUBE_XY_BITW),
        .LINEW(CUBE_LINEW),
        .COLORW(CUBE_COLORW),
        .WIDTH(CUBE_WIDTH),
        .HEIGHT(CUBE_HEIGHT),
        .DEPTH(CUBE_DEPTH),
        .ADJ_DEG(CUBE_ADJ_DEG),
        .SCALE(CUBE_SCALE)
    ) _get_cube (
        .clk, .rst, .line_id, .color, .x0, .y0, .x1, .y1
    );



endmodule

// COUNTER MODULE CODE BELOW

module tb_counter #(
    parameter WIDTH=64
) (
    input   clk,            // clock
    input   clk_en,         // clock enable
    input   rst,            // async reset
    output  [WIDTH-1:0] o   // current counter value output
);
    reg [WIDTH-1:0] cnt = '0;
    assign o = cnt;
    always_ff @(posedge clk or posedge rst) begin : proc_count
        if (rst) begin
            cnt <= '0;
        end else if (clk_en) begin
            cnt <= cnt + 1'b1;
        end
    end
endmodule

module tb_counter_with_load #(
    parameter WIDTH=64
) (
    input   clk,            // clock
    input   clk_en,         // clock enable
    input   rst,            // async reset
    input   load_en,        // enable counter value load when high
    input   [WIDTH-1:0] i,  // value to assign to counter
    output  [WIDTH-1:0] o   // current counter value output
);
    reg [WIDTH-1:0] cnt = '0;
    assign o = cnt;
    always_ff @(posedge clk or posedge rst) begin : proc_count
        if (rst) begin
            cnt <= '0;
        end else if (clk_en) begin
            cnt <= load_en ? i : cnt + 1'b1;
        end
    end
endmodule