`timescale 1ns/1ps
module cordic_tb ();
    localparam WIDTH        = 5;                    // primary bit width
    localparam MAX_CYCLES   = 16;                  // max number of cycles to perform
    localparam WIDTH_CNT    = $clog2(MAX_CYCLES)+1; // counter bit width

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars(0,cordic_tb);
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
    always_comb begin
        if (cycle_count == MAX_CYCLES) $finish;
    end

    wire [WIDTH_CNT-1:0] cycle_count;
    tb_counter #(
        .WIDTH(WIDTH_CNT)
    ) cycle_counter (
        .clk(clk),
        .clk_en(1'b1),
        .rst(rst),
        .o(cycle_count)
    );

    reg init = 1;
    reg adv = 0;
    reg tic = 0;
    reg toc = 0;
    always_ff @(posedge clk) begin : poc_tic_toc
        if (adv) begin
            // This is a half clock. Tic high for one cycle.
            tic = !tic;
            // Display code here
            $display("> END");
            $display (">>>>>>>>>> CYCLE %0d <<<<<<<<<<", cycle_count);
            $display("> START");
            $display("Advance %0b", adv);
            $display("s %d, angle_in %d, angle %d, cos %d, sin %d", start, angle_in, angle, cos_out, sin_out);

        end else if (init) begin
            init <= 0;
            adv <= 1;
            // Init here
        end
        // This halves tic so toc will be high for 2 cycles
        if (tic) toc = !toc;
    end

    // Testing code here
    logic start;
    logic [31:0] cos_out, sin_out;
    logic [31:0] angle_in, angle;
    cordic _cordic (    
        .clock(clk),
        .x_start(0),
        .y_start(0),
        .angle(angle_in),
        .cosine(cos_out),
        .sine(sin_out)
    );

    always_ff @(posedge clk) begin
        case (cycle_count)
            5: begin
                start <= 1;
                angle_in <= 32'd45;
            end
            10: begin
                start <= 0;
            end
            default: begin
                start <= 0;
            end
        endcase
    end

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