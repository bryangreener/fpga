module bresenham (
    input clk,
    input rst,
    input start,
    input [10:0] x0,
    input [10:0] y0,
    input [10:0] x1,
    input [10:0] y1,
    output plot,
    output [10:0] x,
    output [10:0] y,
    output done
);
    logic signed [11:0] dx, dy, err, e2;
    logic right, down;

    typedef enum logic {IDLE, RUN} state_t;
    state_t state;
    always_ff @(posedge clk) begin
        done <= 0;
        plot <= 0;
        if (rst) begin
            state <= IDLE;
        end else case (state)
            IDLE:
                if (start) begin
                    dx = x1 - x0; // BLOCKING
                    right = dx >= 0;
                    if (~right) begin
                        dx = -dx;
                    end
                    dy = y1 - y0;
                    down = dy >= 0;
                    if (down) begin
                        dy = -dy;
                    end
                    err = dx + dy;
                    x <= x0;
                    y <= y0;
                    plot <= 1;
                    state <= RUN;
                end
            RUN:
                if (x == x1 && y == y1) begin
                    done <= 1;
                    state <= IDLE;
                end else begin
                    plot <= 1;
                    e2 = err << 1;
                    if (e2 > dy) begin
                        err = err + dy;
                        if (right) begin
                            x <= x + 10'd 1;
                        end else begin
                            x <= x - 10'd 1;
                        end
                    end

                    if (e2 < dx) begin
                        err = err + dx;
                        if (down) begin
                            y <= y + 10'd 1;
                        end else begin
                            y <= y - 10'd 1;
                        end
                    end
                end
            default:
                state <= IDLE;
        endcase
    end
endmodule