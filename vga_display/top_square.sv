module top_square #(
    parameter CORDW = 10
)(
    input wire logic clk_pix,
    input logic clk_locked,
    output logic vga_hsync,
    output logic vga_vsync,
    output logic vga_r,
    output logic vga_g,
    output logic vga_b
);

    logic [CORDW-1:0] sx, sy;
    logic hsync;
    logic vsync;
    logic de;

    display_timings_640x480 _display_timings_640x480 (
        .clk_pix(clk_pix),
        .rst(!clk_locked),
        .sx(sx),
        .sy(sy),
        .hsync(hsync),
        .vsync(vsync),
        .de(de)
    );

    // 32x32 pixel square
    logic q_draw;
    always_comb q_draw = (sx < 32 && sy < 32) ? 1 : 0;

    // vga output
    always_ff @(posedge clk_pix) begin
        vga_hsync <= hsync;
        vga_vsync <= vsync;
        vga_r <= !de ? 0 : (q_draw ? 0 : 1);
        vga_g <= !de ? 0 : (q_draw ? 1 : 1);
        vga_b <= !de ? 0 : (q_draw ? 1 : 0);
    end
endmodule
