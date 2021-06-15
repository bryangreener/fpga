module top (
    input wire logic clk_pix,
    input wire logic btn_rst,
    output logic vga_hsync,
    output logic vga_vsync,
    output logic vga_r,
    output logic vga_g,
    output logic vga_b
);

    wire c0;
    wire c1;
    wire clk_locked;

    top_square _top_square (
        .clk_pix(c0),
        .clk_locked(clk_locked),
        .vga_hsync(vga_hsync),
        .vga_vsync(vga_vsync),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

    pll _pll(
        .areset(btn_rst),
        .inclk0(clk_pix),
        .c0(c0),
        .c1(),
        .locked(clk_locked)
    );

endmodule