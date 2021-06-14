module hsync_generator #(
    parameter max_x = 767,
    parameter max_y = 480,
    parameter y_h = 45, // adjust to move display horizontally
    parameter y_v = 500 // adjust to move display vertically
)(
    input clk,
    input clk_en,
    input rst,
    output vga_h_sync,
    output vga_v_sync,
    output in_display,
    output [9:0] cnt_x,
    output [8:0] cnt_y
);

    reg _in_display;
    reg [9:0] _cnt_x;
    reg [8:0] _cnt_y;

    wire cnt_x_maxed = (_cnt_x == max_x);
    //reg [width_x-1:0] inc_x = cnt_x_maxed ? '0 : (buf_cnt_x + 1);
    //reg [width_y-1:0] inc_y = cnt_x_maxed ? '0 : (buf_cnt_y + 1);

    reg vga_hs;
    reg vga_vs;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            _cnt_x <= 0;
        end
        else if (clk_en) begin
            if (cnt_x_maxed) begin
                _cnt_x <= 0;
            end else begin
                _cnt_x <= _cnt_x + 1;
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            _cnt_y <= 0;
        end else if (clk_en) begin
            if (cnt_x_maxed) begin
                _cnt_y <= _cnt_y + 1;
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            vga_hs <= y_h;
            vga_vs <= y_v;
        end else if (clk_en) begin
            vga_hs <= (_cnt_x[9:4] == y_h);
            vga_vs <= (_cnt_y == y_v);
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            _in_display <= 0;
        end else if (clk_en) begin
            if (_in_display == 0) begin
                _in_display <= (cnt_x_maxed) && (_cnt_y < max_y);
            end else begin
                _in_display <= !(_cnt_x == 639);
            end
        end
    end

    assign vga_h_sync = ~vga_hs;
    assign vga_v_sync = ~vga_vs;
    //assign in_display_area = buf_in_display_area;

    assign in_display = _in_display;
    assign cnt_x = _cnt_x;
    assign cnt_y = _cnt_y;
endmodule