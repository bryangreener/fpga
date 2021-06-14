module top (
    input clk,
    input clk_en,
    input rst,
    output vga_h_sync,
    output vga_v_sync,
    output vga_r,
    output vga_g,
    output vga_b
);

    wire c0;
    wire c1;
    wire clk_lock;

    btn_trigger _btn_trigger(.clk_en (clk_en));

    vga_pong _vga_pong(
        .clk (c0),
        .clk_en (clk_lock),
        .rst (rst),
        .vga_h_sync (vga_h_sync),
        .vga_v_sync (vga_v_sync),
        .vga_r (vga_r),
        .vga_g (vga_g),
        .vga_b (vga_b)
    );

    pll _pll (
        .areset (rst),
        .inclk0 (clk),
        .c0 (c0),
        .c1 (c1),
        .locked (clk_lock)
    );
    
endmodule

module btn_trigger (input clk_en);
endmodule