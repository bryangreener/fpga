module bram_sdp #(
    parameter WIDTH=8,
    parameter DEPTH=512,
    parameter INIT_F=""
) (
    input   wire    logic clk_write,
    input   wire    logic clk_read,
    input   wire    logic we,
    input   wire    logic [ADDRW-1:0] addr_write,
    input   wire    logic [ADDRW-1:0] addr_read,
    input   wire    logic [WIDTH-1:0] data_in,
    output          logic [WIDTH-1:0] data_out
);
    // https://github.com/projf/projf-explore/blob/master/lib/memory/xc7/bram_sdp.sv
    localparam ADDRW = $clog2(DEPTH);

    logic [WIDTH-1:0] memory [DEPTH];

    initial begin
        if (INIT_F != 0) begin
            $display("Creating bram from init file '%s'.", INIT_F);
            $readmem(INIT_F, memory);
        end
    end

    always_ff @(posedge clk_write) begin
        if (we) begin
            memory[addr_write] <= data_in;
        end
    end

    always_ff @(posedge clk_read) begin
        data_out <= memory[addr_read];
    end
endmodule