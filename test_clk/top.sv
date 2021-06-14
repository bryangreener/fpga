module top (
    input clk,
    input rst,
    output r,
    output g,
    output b,
    output hs,
    output vs
);

    wire c0;
    wire clk_locked;
    pll _pll(
        .areset (~rst),
        .inclk0 (clk),
        .c0 (c0),
        .locked (clk_locked)
    );

    /*
    test_clk _test_clk (
        .clk (c0),
        .rst (~rst),
        .d (d)
    );
    */

    /*
    wire in_display;
    reg [10:0] hreg;
    reg [9:0] vreg;
    display_timing _display_timing (
        .clk (c0),
        .rst (~rst),
        .in_display (in_display),
        .hreg (hreg),
        .vreg (vreg),
        .vga_hs (hs),
        .vga_vs (vs)
    );
    */

    /*
	logic [9:0] y;
    logic [10:0] x, x0, y0, x1, y1;
	logic vga_clk, vga_blank_n, vga_sync_n;
    parameter pixel_color = 1;
    logic pixel_write;
    logic done = 0;
    logic draw_start = 1;
    logic draw_oe = 1;
    logic drawing;
    logic draw_done;
    wire lx0 = 100;
    wire lx1 = 300;
    wire ly0 = 100;
    wire ly1 = 300;
    draw_line _draw_line (
        .clk (c0),
        .rst (~rst),
        .start (draw_start && ~drawing && ~draw_done),
        .oe (draw_oe && ~draw_done),
        .x0 (lx0),
        .y0 (ly0),
        .x1 (lx1),
        .y1 (ly1),
        .x (x),
        .y (y),
        .drawing (drawing),
        .done (draw_done)
    );
    */

    
    //logic [10:0] x0 = 100;
    //logic [10:0] y0 = 100;
    //logic [10:0] x1 = 300;
    //logic [10:0] y1 = 300;
    logic [10:0] x0, y0, x1, y1;
    logic [10:0] x;
    logic [10:0] y;


    logic draw_start;
    logic drawing;
    logic draw_done;

    logic cube_start, cube_drawing, cube_done;
    logic line_start, line_drawing, line_done;
    
    draw_cube _draw_cube (
        .clk (c0),
        .rst (~rst),
        .frame (frame),
        .x0 (x0),
        .y0 (y0),
        .x1 (x1),
        .y1 (y1),
        .draw_start (cube_start),
        .drawing (cube_drawing),
        .draw_done (cube_done)
    );

    /*
    localparam LINE_CNT = 12; // 12 lines in cube wireframe
    logic [3:0] line_id; // line identifier

    enum {IDLE, INIT, DRAW, DONE} state;
    always_ff @(posedge c0) begin
        case (state)
            INIT: begin // register coordinates
                draw_start <= 1;
                state <= DRAW;
                case (line_id)
                    4'd0: begin
                        x0 <= 200; y0 <= 200; x1 <= 400; y1 <= 200;
                    end
                    4'd1: begin
                        x0 <= 400; y0 <= 200; x1 <= 400; y1 <= 400;
                    end
                    4'd2: begin
                        x0 <= 400; y0 <= 400; x1 <= 200; y1 <= 400;
                    end
                    4'd3: begin
                        x0 <= 200; y0 <= 400; x1 <= 200; y1 <= 200;
                    end
                    4'd4: begin
                        x0 <= 100; y0 <= 100; x1 <= 300; y1 <= 100;
                    end
                    4'd5: begin
                        x0 <= 300; y0 <= 100; x1 <= 300; y1 <= 300;
                    end
                    4'd6: begin
                        x0 <= 300; y0 <= 300; x1 <= 100; y1 <= 300;
                    end
                    4'd7: begin
                        x0 <= 100; y0 <= 300; x1 <= 100; y1 <= 100;
                    end
                    4'd8: begin
                        x0 <= 200; y0 <= 200; x1 <= 100; y1 <= 100;
                    end
                    4'd9: begin
                        x0 <= 400; y0 <= 200; x1 <= 300; y1 <= 100;
                    end
                    4'd10: begin
                        x0 <= 400; y0 <= 400; x1 <= 300; y1 <= 300;
                    end
                    4'd11: begin
                        x0 <= 200; y0 <= 400; x1 <= 100; y1 <= 300;
                    end
                    default: begin // shouldnt ever trigger
                        x0 <= 0; y0 <= 0; x1 <= 0; y1 <= 0;
                    end
                endcase
            end
            DRAW: begin
                draw_start <= 0;
                if (draw_done) begin
                    if (line_id == LINE_CNT-1) begin
                        state <= DONE;
                    end else begin
                        line_id <= line_id + 1;
                        state <= INIT;
                    end
                end
            end
            DONE: begin
                state <= DONE;
            end
            default: begin // IDLE
                if (frame) begin
                    state <= INIT;
                end
            end
        endcase
    end
    */

    /*
    logic bresenham_start = 1;
    logic bresenham_done;
    bresenham _bresenham (
        .clk (c0),
        .rst (~rst),
        .start (draw_cube_draw_start),
        .x0 (x0),
        .y0 (y0),
        .x1 (x1),
        .y1 (y1),
        .plot (pixel_write),
        .x (x),
        .y (y),
        .done (bresenham_done)
    );
    */

    localparam DRAW_WAIT = 300;
    logic [$clog2(DRAW_WAIT)-1:0] cnt_draw_wait;
    logic draw_oe;

    always_ff @(posedge c0) begin
        draw_oe <= 0;
        if (frame) begin
            if (cnt_draw_wait != DRAW_WAIT-1) begin
                cnt_draw_wait <= cnt_draw_wait + 1;
            end else begin
                draw_oe <= 1;
            end
        end
    end

    draw_line _draw_line (
        .clk (c0),
        .rst (~rst),
        .start (line_start),
        .oe (draw_oe),
        .x0 (x0),
        .y0 (y0),
        .x1 (x1),
        .y1 (y1),
        .x (x),
        .y (y),
        .drawing (line_drawing),
        .done (line_done)
    );

    logic pixel_color = 1;
    logic pixel_write;
    logic in_display;
    logic frame, line;

    framebuffer _framebuffer (
        .clk (c0),
        .rst (~rst),
        .x (x),
        .y (y),
        .pixel_color (pixel_color),
        .pixel_write (fb_we),
        .frame (frame),
        .line (line),
        .in_display (in_display),
        .vga_r (r),
        .vga_g (g),
        .vga_b (b),
        .vga_hs (hs),
        .vga_vs (vs)
    );

    always_comb fb_we = drawing;

endmodule