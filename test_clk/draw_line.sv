module draw_line #(
    parameter CORDW=10                  // Signed coordinate width
) (
    input clk,
    input rst,
    input logic start,                  // start line drawing
    input logic oe,                     // output enable
    input logic signed [CORDW-1:0] x0,
    input logic signed [CORDW-1:0] y0,
    input logic signed [CORDW-1:0] x1,
    input logic signed [CORDW-1:0] y1,
    output logic signed [CORDW-1:0] x,
    output logic signed [CORDW-1:0] y,
    output logic drawing,               // line is drawing
    output logic done                   // line complete (high for one tick)
);

    logic right, swap; // drawing direction
    logic signed [CORDW-1:0] xa; // start point
    logic signed [CORDW-1:0] ya;
    logic signed [CORDW-1:0] xb; // end point
    logic signed [CORDW-1:0] yb;
    always_comb begin
        swap = (y0 > y1); // swap points if y0 is below y1
        xa = swap ? x1 : x0;
        xb = swap ? x0 : x1;
        ya = swap ? y1 : y0;
        yb = swap ? y0 : y1;
        right = (xa < xb); // draw right to left ?
    end

    // error values
    logic signed [CORDW:0] err; // a bit wider as signed
    logic signed [CORDW:0] dx;
    logic signed [CORDW:0] dy;
    logic movx, movy; // horizontal/vertical move required
    always_comb begin
        movx = (2*err >= dy);
        movy = (2*err <= dx);
    end

    logic in_progress = 0; // calculation in progress (but only output if oe)

    assign drawing = in_progress && oe;

    enum {IDLE, INIT, DRAW} state;
    always_ff @(posedge clk) begin
        case (state)
            DRAW: begin
                if (oe) begin
                    if (x == xb && y == yb) begin
                        in_progress <= 0;
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        if (movx) begin
                            x <= right ? x + 1 : x - 1;
                            err <= err + dy;
                        end
                        if (movy) begin
                            y <= y + 1; // always down
                            err <= err + dx;
                        end
                        if (movx && movy) begin
                            x <= right ? x + 1 : x - 1;
                            y <= y + 1; // always down
                            err <= err + dy + dx;
                        end
                    end
                end
            end
            INIT: begin
                err <= dx + dy;
                x <= xa;
                y <= ya;
                in_progress <= 1;
                state <= DRAW;
            end
            default: begin // IDLE
                done <= 0;
                if (start) begin
                    dx <= right ? xb - xa : xa - xb; // dx = abs(xb - xa)
                    dy <= ya - yb; // dy = -abs(yb - ya)
                    state <= INIT;
                end
            end
        endcase
        
        if (rst) begin
            in_progress <= 0;
            done <= 0;
            state <= IDLE;
        end
    end
endmodule