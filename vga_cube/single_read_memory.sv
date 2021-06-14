module single_read_memory #(
    parameter WIDTH=8,          // Bit width of data
    parameter DEPTH=16,         // Number of words
    parameter DOUT_POLARITY=0   // Polarity of DOUT 0: active low, 1: active high
) (
    input   clk,                        // clock
    input   clk_en,                     // clock enable
    input   we,                         // write enable
    input   [ADDRW-1:0] addr_write,     // write address
    input   [WIDTH-1:0] data_write,     // write data in
    input   re,                         // read enable
    input   [ADDRW-1:0] addr_read,      // read address
    output  [WIDTH-1:0] data_read       // read data out
);
    // Bit width of addresses
    localparam ADDRW = $clog2(DEPTH);

    // Instantiate memory block as unpacked array of packed words
    reg [ADDRW-1:0] memory [DEPTH-1:0];

    // Write data_in to addr_write only when write enable (we) is high
    always_ff @(posedge clk) begin : proc_memory
        if (clk_en & we) memory[addr_write] <= data_write;
    end

    // Only output value at addr_read when read enable (re) is high
    // Based on DOUT_POLARITY, output will be active low/high.
    generate
        assign data_read = re ? memory[addr_read] : (DOUT_POLARITY ? 0 : '1);
    endgenerate

endmodule : single_read_memory