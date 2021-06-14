module top_cube (
    input   clk,
    input   rst,
    output  vga_hs,
    output  vga_vs,
    output  vga_r,
    output  vga_g,
    output  vga_b
);
    // generate pixel clock
    logic clk_pix;
    logic clk_locked;

    pll _pll(
        .areset(!rst),
        .inclk0(clk),
        .c0(clk_pix),
        .locked(clk_locked)
    );

    // display timings
    localparam DT_H_RES     = 800;
    localparam DT_H_FP      = 56;
    localparam DT_H_SP      = 120;
    localparam DT_H_BP      = 64;
    localparam DT_H_POL     = 1;
    localparam DT_V_RES     = 600;
    localparam DT_V_FP      = 37;
    localparam DT_V_SP      = 6;
    localparam DT_V_BP      = 23;
    localparam DT_V_POL     = 1;
    localparam DT_H_BITW    = $clog2(DT_H_RES + DT_H_FP + DT_H_SP + DT_H_BP);
    localparam DT_V_BITW    = $clog2(DT_V_RES + DT_V_FP + DT_V_SP + DT_V_BP);
    localparam DT_BITW      = (DT_H_BITW > DT_V_BITW) ? DT_H_BITW : DT_V_BITW;

    // cube dimensions
    localparam LINE_CNT     = 12;
    localparam LINEW        = $clog2(LINE_CNT);
    localparam CUBE_WIDTH   = 10;
    localparam CUBE_HEIGHT  = 10;
    localparam CUBE_DEPTH   = 5;
    localparam CUBE_ANGLE   = 45;
    localparam CUBE_SCALE   = 1;
    localparam CUBE_COLORW  = 3;

    // framebuffer settings
    localparam FB_WIDTH     = CUBE_WIDTH + (CUBE_DEPTH + 1);
    localparam FB_HEIGHT    = CUBE_HEIGHT + (CUBE_DEPTH + 1);
    localparam POSX         = 0;    // beginning x pos
    localparam POSY         = 0;    // beginning y pos

    // Output ports
    logic _vga_hs, _vga_vs, _vga_r, _vga_g, _vga_b;
    assign vga_hs = _vga_hs;
    assign vga_vs = _vga_vs;
    assign vga_r = _vga_r;
    assign vga_g = _vga_g;
    assign vga_b = _vga_b;

    // Framebuffer ports
    logic dt_de, dt_frame;
    logic fb_we;
    logic [DT_BITW-1:0] sx, sy; // screen coordinates (current)
    logic [CUBE_COLORW-1:0] fb_color; // input color to write
    logic [DT_BITW-1:0] fb_x, fb_y; // FB coordinates
    // Write to framebuffer when drawing
    assign fb_we = drawing;
    // When not done, use draw_line x and y positions for framebuffer.
    // When done, use current display position for framebuffer.
    assign fb_x = (state == DONE) ? sx : dl_x;
    assign fb_y = (state == DONE) ? sy : dl_y;

    // Cuve and Draw Line ports
    logic [LINEW-1:0] line_id = 0; // line identifier
    logic [DT_BITW-1:0] lx0, lx1, ly0, ly1; // line coords
    logic draw_start, drawing, draw_done; // drawing signals
    logic [CUBE_COLORW-1:0] cube_color;
    
    assign fb_color = cube_color;

    // draw state machine
    enum {IDLE, INIT, DRAW, DONE} state;
    always_ff @(posedge clk_pix) begin
        if (!rst) begin
            state <= IDLE;
        end
        if (!clk_locked) begin
            state <= IDLE;
        end
        case (state)
            INIT: begin
                draw_start <= 1;
                state <= DRAW;
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
            default: begin
                if (dt_frame) state <= INIT; // IDLE
            end
        endcase
    end

    // control drawing output enable - wait 300 frames then 1 px/frame
    /*
    localparam DRAW_WAIT = 1;
    logic [$clog2(DRAW_WAIT)-1:0] cnt_draw_wait;
    logic draw_oe;
    always_ff @(posedge clk_pix) begin
        draw_oe <= 0;
        if (frame) begin
            if (cnt_draw_wait != DRAW_WAIT-1) begin
                cnt_draw_wait <= cnt_draw_wait + 1;
            end else draw_oe <= 1;
        end
    end
    */

    logic [DT_BITW-1:0] dl_x, dl_y;

    // TEMPORARY FOR TESTING
    localparam FB_PIXEL = FB_WIDTH * FB_HEIGHT;
    localparam FB_DEPTH = FB_PIXEL * CUBE_COLORW;
    localparam FB_ADDRW = $clog2(FB_DEPTH);
    
    
    // OUTPUT FOR VALIDATING RGB OUT
    // Enable framebuffer reading when state is DONE
    
    logic fb_oe;
    assign fb_oe = (state == DONE);
    always_ff @(posedge clk_pix) begin
        if (fb_oe) begin
            if (dt_frame) begin
                $display("FRAME: FB_PIXEL %0d, FB_DEPTH %0d, FB_ADDRW %0d, CUBE_COLORW %0d",
                    FB_PIXEL, FB_DEPTH, FB_ADDRW, CUBE_COLORW);
            end
            $display("%0d,%0d,%0d,%0d,%0d,%01b%01b%01b",
                    fb_x, fb_y, 
                    ((FB_HEIGHT * fb_y) * CUBE_COLORW) + (fb_x * CUBE_COLORW), 
                    _vga_hs, _vga_vs, _vga_r, _vga_g, _vga_b);
        end
    end
    
    
    display_timing_800x600 #(
        .XY_BITW(DT_BITW),
        .H_RES(DT_H_RES),
        .H_FP(DT_H_FP),
        .H_SP(DT_H_SP),
        .H_BP(DT_H_BP),
        .H_POL(DT_H_POL),
        .V_RES(DT_V_RES),
        .V_FP(DT_V_FP),
        .V_SP(DT_V_SP),
        .V_BP(DT_V_BP),
        .V_POL(DT_V_POL)
    ) _display_timing_800x600 (
        .clk(clk_pix),
        .rst(!rst),
        .sx(sx),
        .sy(sy),
        .hsync(_vga_hs),
        .vsync(_vga_vs),
        .de(dt_de),
        .frame(dt_frame)
    );

    framebuffer #(
        .XY_BITW(DT_BITW),
        .WIDTH(FB_WIDTH),
        .HEIGHT(FB_HEIGHT),
        .COLORW(CUBE_COLORW),
        .POSX(POSX),
        .POSY(POSY)
    ) _framebuffer (
        .clk(clk_pix),
        .rst(!rst),
        .we(fb_we),
        .oe(dt_de),
        .x(fb_x),
        .y(fb_y),
        .color(fb_color),
        .sx(sx),
        .sy(sy),
        .r(_vga_r),
        .g(_vga_g),
        .b(_vga_b)
    );

    get_cube #(
        .XY_BITW(DT_BITW),
        .LINEW(LINEW),
        .COLORW(CUBE_COLORW),
        .WIDTH(CUBE_WIDTH),
        .HEIGHT(CUBE_HEIGHT),
        .DEPTH(CUBE_DEPTH),
        .ADJ_DEG(CUBE_ANGLE),
        .SCALE(CUBE_SCALE)
    ) _get_cube (
        .clk(clk_pix),
        .rst(!rst),
        .line_id(line_id),
        .color(cube_color),
        .x0(lx0),
        .y0(ly0),
        .x1(lx1),
        .y1(ly1)
    );

    draw_line #(
        .XY_BITW(DT_BITW)
    ) _draw_line (
        .clk(clk_pix),
        .rst(!rst),
        .start(draw_start),
        .oe((state != 3)), // state == DONE. Cant use 'DONE' in port
        .x0(lx0),
        .y0(ly0),
        .x1(lx1),
        .y1(ly1),
        .x(dl_x),
        .y(dl_y),
        .drawing,
        .done(draw_done)
    );
endmodule