`timescale 1ns/1ps
module framebuffer_tb ();
    localparam WIDTH = 5;           // primary bit width
    localparam WIDTH_CNT = 32;      // counter bit width
    localparam MAX_CYCLES = 20;    // max number of cycles to perform

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
            $display("we: %0b, x: %0d, y: %0d, color: %3b", we, x, y, color);
            $display("mem addr: %0d", out_read_addr);
            $display("rgb (%1b, %1b, %1b)", r, g, b);

        end else if (init) begin
            init <= 0;
            adv <= 1;
            // Init here
        end
        // This halves tic so toc will be high for 2 cycles
        if (tic) toc = !toc;
    end

    // Testing code here
    localparam T_CORDW = 10;
    localparam T_WIDTH = 10;
    localparam T_HEIGHT = 10;
    localparam T_COLORW = 3;
    logic we;
    logic [T_CORDW-1:0] x, y;
    logic [T_COLORW-1:0] color;
    localparam T_ADDRW = $clog2(T_WIDTH*T_HEIGHT);
    logic r, g, b;

    framebuffer #(
        .CORDW(T_CORDW),
        .WIDTH(T_WIDTH),
        .HEIGHT(T_HEIGHT),
        .COLORW(T_COLORW)
    ) _framebuffer (
        .clk(clk),
        .rst(rst),
        .we(we),
        .x(x),
        .y(y),
        .color(color),
        .r(r),
        .g(g),
        .b(b)
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            we <= 0;
            x <= 0;
            y <= 0;
            color <= '0;
        end else begin
            case (cycle_count)
                0: begin
                    we <= 1;
                    x <= 0;
                    y <= 0;
                    color <= 0;
                end
                1: begin
                    we <= 1;
                    x <= 1;
                    y <= 1;
                    color <= 3'b001;
                end
                2: begin
                    we <= 1;
                    x <= 2;
                    y <= 2;
                    color <= 3'b010;
                end
                3: begin
                    we <= 1;
                    x <= 3;
                    y <= 3;
                    color <= 3'b011;
                end
                4: begin
                    we <= 1;
                    x <= 4;
                    y <= 4;
                    color <= 3'b100;
                end
                5: begin
                    we <= 1;
                    x <= 5;
                    y <= 5;
                    color <= 3'b101;
                end
                6: begin
                    we <= 1;
                    x <= 6;
                    y <= 6;
                    color <= 3'b110;
                end
                7: begin
                    we <= 0;
                    x <= 0;
                    y <= 0;
                    color <= 0;
                end
                8: begin
                    we <= 0;
                    x <= 1;
                    y <= 0;
                    color <= 0;
                end
                9: begin
                    we <= 0;
                    x <= 1;
                    y <= 1;
                    color <= 0;
                end
                10: begin
                    we <= 0;
                    x <= 2;
                    y <= 2;
                    color <= 0;
                end
                11: begin
                    we <= 0;
                    x <= 3;
                    y <= 3;
                    color <= 0;
                end
                12: begin
                    we <= 0;
                    x <= 4;
                    y <= 4;
                    color <= 0;
                end
                13: begin
                    we <= 0;
                    x <= 5;
                    y <= 5;
                    color <= 0;
                end
                14: begin
                    we <= 0;
                    x <= 6;
                    y <= 6;
                    color <= 0;
                end
                default: begin
                    we <= 0;
                    x <= 0;
                    y <= 0;
                    color <= 0;
                end
            endcase
        end
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