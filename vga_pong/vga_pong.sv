`default_nettype none
module vga_pong (
    input clk,
    input clk_en,
    input rst,
    //input quad_a,
    //input quad_b,
    output vga_h_sync,
    output vga_v_sync,
    output vga_r,
    output vga_g,
    output vga_b
);

    wire in_display;
    wire [9:0] cnt_x;
    wire [8:0] cnt_y;

    hsync_generator syncgen(
        .clk(clk),
        .clk_en(clk_en),
        .rst(rst),
        .vga_h_sync(vga_h_sync),
        .vga_v_sync(vga_v_sync),
        .in_display(in_display),
        .cnt_x(cnt_x),
        .cnt_y(cnt_y)
    );

    /*
    //////////////////////
    reg [8:0] paddle_pos;
    reg [2:0] quad_ar;
    reg [2:0] quad_br;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            quad_ar <= '0;
            quad_br <= '0;
        end
        else if (clk_en) begin
            quad_ar <= {quad_ar[1:0], quad_a};
            quad_br <= {quad_br[1:0], quad_b};
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            paddle_pos <= '0;
        end
        else if (clk_en) begin
            if (quad_ar[2] ^ quad_br[1]) begin
                if (~&paddle_pos) begin // make sure value doesnt overflow
                    paddle_pos <= paddle_pos + 1;
                end
            end
            else begin
                if (|paddle_pos) begin // make sure value doesnt underflow
                    paddle_pos <= paddle_pos - 1;
                end
            end
        end
    end

    //////////////////////
    reg [9:0] ball_x;
    reg [8:0] ball_y;
    reg ball_in_x;
    reg ball_in_y;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ball_in_x <= 0;
        end
        else if (clk_en) begin
            if (ball_in_x == 0) begin
                ball_in_x <= (cnt_x == ball_x) & ball_in_y;
            end
            else begin
                ball_in_x <= !(cnt_x == ball_x + 16);
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ball_in_y <= 0;
        end
        else if (clk_en) begin
            if (ball_in_y == 0) begin
                ball_in_y <= (cnt_y == ball_y);
            end
            else begin
                ball_in_y <= !(cnt_y == ball_y + 16);
            end
        end
    end

    wire ball = ball_in_x & ball_in_y;

    ////////////////////////////////

    wire border = (cnt_x[9:3]==0) || (cnt_x[9:3]==79) || (cnt_y[8:3]==0) || (cnt_y[8:3]==59);
    wire paddle = (cnt_x >= paddle_pos+8) && (cnt_x <= paddle_pos+120) && (cnt_y[8:4] == 27);
    wire bounce_obj = border | paddle;

    reg rst_collision;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            rst_collision <= 0;
        end
        else begin
            rst_collision <= (cnt_y == 500) & (cnt_x == 0);
        end
    end

    reg collision_x1;
    reg collision_x2;
    reg collision_y1;
    reg collision_y2;

    always_ff @(posedge clk or posedge rst) begin
        if ((rst) | (rst_collision)) begin
            collision_x1 <= 0;
            collision_y1 <= 0;
            collision_x2 <= 0;
            collision_y2 <= 0;
        end
        else if (clk_en) begin
            if (bounce_obj & (cnt_x == ball_x) & (cnt_y == ball_y + 8)) begin
                collision_x1 <= 1;
            end
            if (bounce_obj & (cnt_x == ball_x + 16) & (cnt_y == ball_y + 8)) begin
                collision_x2 <= 1;
            end
            if (bounce_obj & (cnt_x == ball_x + 8) & (cnt_y == ball_y)) begin
                collision_y1 <= 1;
            end
            if (bounce_obj & (cnt_x == ball_x + 8) & (cnt_y == ball_y + 16)) begin
                collision_y2 <= 1;
            end
        end
    end

    ////////////////////////
    wire update_ball_pos = rst_collision;
    reg ball_dir_x;
    reg ball_dir_y;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ball_x <= 0;
            ball_y <= 0;
            ball_dir_x <= 0;
            ball_dir_y <= 0;
        end
        else if (clk_en) begin
            if (~(collision_x1 & collision_x2)) begin
                ball_x <= ball_x + (ball_dir_x ? -1 : 1);
                if (collision_x2) begin
                    ball_dir_x <= 1;
                end
                else if (collision_x2) begin
                    ball_dir_x <= 0;
                end
            end
            if (~(collision_y1 & collision_y2)) begin
                ball_y <= ball_y + (ball_dir_y ? -1 : 1);
                if (collision_y2) begin
                    ball_dir_y <= 1;
                end
                else if (collision_y1) begin
                    ball_dir_y <= 0;
                end
            end
        end
    end

    //////////////////////////////
    wire r = bounce_obj | ball | (cnt_x[3] ^ cnt_y[3]);
    wire g = bounce_obj | ball;
    wire b = bounce_obj | ball;
    */

    wire r = cnt_y[3] | (cnt_x == 256);
    wire g = (cnt_x[5] ^ cnt_x[6]) | (cnt_x == 256);
    wire b = cnt_x[4] | (cnt_x == 256);

    reg _vga_r;
    reg _vga_g;
    reg _vga_b;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            _vga_r <= '0;
            _vga_g <= '0;
            _vga_b <= '0;
        end else if (clk_en) begin
            _vga_r <= r & in_display;
            _vga_g <= g & in_display;
            _vga_b <= b & in_display;
        end
    end

    assign vga_r = _vga_r;
    assign vga_g = _vga_g;
    assign vga_b = _vga_b;

endmodule