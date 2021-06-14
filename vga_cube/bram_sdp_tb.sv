`timescale 1ns/1ps
module bram_sdp_tb ();
    localparam WIDTH = 5;           // primary bit width
    localparam WIDTH_CNT = 32;      // counter bit width
    localparam MAX_CYCLES = 16;    // max number of cycles to perform

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
        .bit_width(WIDTH_CNT)
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
            $display("we %0x", we);
            $display("addr_write %0x", addr_write);
            $display("addr_read %0x", addr_read);
            $display("data_in %0x", data_in);
            $display("data_out %0x", data_out);

        end else if (init) begin
            init <= 0;
            adv <= 1;
            // Init here
        end
        // This halves tic so toc will be high for 2 cycles
        if (tic) toc = !toc;
    end

    // Testing code here
    localparam BRAM_WIDTH = 12;
    localparam BRAM_DEPTH = 8;
    localparam BRAM_INIT_F = 0;
    logic [BRAM_DEPTH-1:0] addr_write;
    logic [BRAM_DEPTH-1:0] addr_read;
    logic we;
    logic [BRAM_WIDTH-1:0] data_in;
    logic [BRAM_WIDTH-1:0] data_out;

    bram_sdp #(
        .WIDTH(BRAM_WIDTH),
        .DEPTH(BRAM_DEPTH),
        .INIT_F(BRAM_INIT_F)
    ) _bram_sdp (
        .clk_write(clk),
        .clk_read(clk),
        .*
    );

    always_ff @(posedge clk or posedge rst) begin : bram_sdp_testing
        if (rst) begin
            addr_write <= 'h0;
            addr_read <= 'h0;
            we <= 0;
            data_in <= '0;
        end else begin
            case (cycle_count)
                0: begin
                    we <= 0;
                    addr_read <= 'h0;
                    // CYCLE 1 >> READ 0: out=XXX
                end
                2: begin
                    we <= 1;
                    addr_read <= 'h0;
                    addr_write <= 'h0;
                    data_in <= 'h123;
                    // CYCLE 2 >> WRITE 0: in=0x123, READ 0: out=XXX
                end
                4: begin
                    we <= 0;
                    addr_read <= 'h0;
                    // CYCLE 3 >> READ 0: out=0x123
                end
                6: begin
                    we <= 1;
                    addr_read <= 'h0;
                    addr_write <= 'h5;
                    data_in <= 'h456;
                    // CYCLE 4 >> WRITE 5: in=0x456, READ 0: out=0x123
                end
                8: begin
                    we <= 1;
                    addr_read <= 'h0;
                    addr_write <= 'h6;
                    data_in <= 'h789;
                    // CYCLE 5 >> WRITE 6: in=0x789, READ 0: out=0x123
                end
                10: begin
                    we <= 0;
                    addr_read <= 'h5;
                    // CYCLE 6 >> READ 5: out=0x456
                end
                12: begin
                    we <= 1;
                    addr_read <= 'h6;
                    addr_write <= 'h5;
                    data_in <= 'hABC;
                    // CYCLE 7 >> WRITE 5: in=0xABC, READ 6: out=0x789
                end
                14: begin
                    we <= 0;
                    addr_read <= 'h5;
                    // CYCLE 8 >> READ 5: out=0xABC
                end
                default: begin
                    we <= 0;
                    addr_read <= 'h0;
                    // READ 0: out=0x123 forever
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