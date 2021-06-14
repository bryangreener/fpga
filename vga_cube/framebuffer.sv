module framebuffer #(
    parameter XY_BITW   = 16, // bit width of horizontal/vertical screen pos
    parameter WIDTH     = 100,
    parameter HEIGHT    = 100,
    parameter COLORW    = 3,
    parameter POSX      = 250,  // screen alignment x min position
    parameter POSY      = 250   // screen alignment y min position
) (
    input   clk,
    input   rst,
    input   we,
    input   oe,
    input   [XY_BITW-1:0] x,
    input   [XY_BITW-1:0] y,
    input   [COLORW-1:0] color,
    input   [XY_BITW-1:0] sx,          // display timing current x pos
    input   [XY_BITW-1:0] sy,          // display timing current y pos
    output  r,
    output  g,
    output  b
);
    localparam FB_PIXEL = WIDTH * HEIGHT;
    localparam FB_ADDRW = $clog2(FB_PIXEL * COLORW);
    localparam FB_DEPTH = FB_PIXEL * COLORW;

    logic [FB_ADDRW-1:0] mem [FB_DEPTH-1:0];
    logic [FB_ADDRW-1:0] read_addr, write_addr;
    logic in_x, in_y, in_sx, in_sy;
    logic _r, _g, _b;
    
    assign r = _r;
    assign g = _g;
    assign b = _b;

    always_comb begin
        read_addr = ((HEIGHT * (y-POSY)) * COLORW) + ((x-POSX) * COLORW);
        write_addr = ((HEIGHT * y) * COLORW) + (x * COLORW);
        in_x = ((x >= POSX) && (x <= POSX + WIDTH - 1));
        in_y = ((y >= POSY) && (y <= POSY + HEIGHT - 1));
        {_r, _g, _b} = (oe && in_x && in_y) ? mem[read_addr] : 0;
    end

    // Initialize memory array with 0s
    initial begin
        for (int i = 0; i < FB_DEPTH; i++) mem[i] = 0;
    end

    // If write is enabled, save color to current x,y pos
    always_ff @(posedge clk) begin
        if (we) mem[write_addr] <= color;
    end

endmodule