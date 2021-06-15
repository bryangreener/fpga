module draw_line #(
    parameter XY_BITW=16    // bit width of horizontal/vertical screen pos
) (
    input   clk,                     // clock
    input   rst,                     // reset
    input   start,                   // start line drawing
    input   oe,                      // output enable
    input   [XY_BITW-1:0] x0,   // point 0 - horizontal position
    input   [XY_BITW-1:0] y0,   // point 0 - vertical position
    input   [XY_BITW-1:0] x1,
    input   [XY_BITW-1:0] y1,
    output  [XY_BITW-1:0] x,    // horizontal drawing position
    output  [XY_BITW-1:0] y,    // vertical drawing position
    output  drawing,                 // line is drawing
    output  done                     // line complete (high for one tick)
);
    // https://github.com/projf/projf-explore/blob/master/lib/graphics/draw_line.sv

    // line properties
    logic right, down, swap; // drawing direction
    logic x_done, y_done;
    logic [XY_BITW-1:0] xa, xb, ya, yb; // starting/ending point
    always_comb begin
        swap = (y0 > y1);       // swap points if y0 is below y1
        xa = x0;//swap ? x1 : x0;
        xb = x1;//swap ? x0 : x1;
        ya = y0;//swap ? y1 : y0;
        yb = y1;//swap ? y0 : y1;
        right = (xa < xb);      // drawing right to left ?
        down = (ya < yb);
    end

    always_ff @(posedge clk) begin
        //$display("draw_line: a (%0d,%0d), b (%0d,%0d), movx %0d, movy %0d, dx %0d, dy %0d, err %0d", xa, ya, xb, yb, movx, movy, dx, dy, err);
    end

    // error values
    logic movx, movy; // horizontal/vertical move required
    always_comb begin
        movx = (2*err >= dy);
        movy = (2*err >= dx);
    end

    // ACTIVE
    logic tmp_active;
    logic signed [XY_BITW-1:0] tmp_x, tmp_y;
    logic tmp_done;
    logic signed [2*XY_BITW:0] tmp_err;

    reg active;
    reg signed [XY_BITW-1:0] _x, _y;
    reg _done;
    reg signed [2*XY_BITW:0] err, dx, dy;

    wire [1:0] mov_vec = {movx, movy};
    assign x = _x;
    assign y = _y;
    assign x_done = (_x == xb);
    assign y_done = (_y == yb);
    always_comb begin
        /*
        if (movx) begin
            tmp_x = x_done ? _x : (right ? _x + 1 : _x - 1);
            tmp_err = err + dy;
        end
        if (movy) begin
            tmp_y = y_done ? _y : (down ? _y + 1 : _y - 1);
            tmp_err = err + dx;
        end
        if (movx && movy) begin
            tmp_x = x_done ? _x : (right ? _x + 1 : _x - 1);
            tmp_y = y_done ? _y : (down ? _y + 1 : _y - 1);
            tmp_err = err + dy + dx;
        end
        */

        
        tmp_x = (movx && !x_done) ? (right ? _x + 1 : _x - 1) : _x;
        tmp_y = (movy && !y_done) ? (down ? _y + 1 : _y - 1) : _y;
        case (mov_vec)
            2'b01: begin
                tmp_err = err + dy;
            end
            2'b10: begin
                tmp_err = err + dx;
            end
            2'b11: begin
                tmp_err = err + dx + dy;
            end
            default: begin
                tmp_err = err;
            end
        endcase
        
    end

    assign tmp_done = (tmp_x == xb && tmp_y == yb);
    assign done = _done;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            _x <= 0;
            _y <= 0;
            _done <= 0;
            err <= 0;
            dx <= 0;
            dy <= 0;
        end else if (active || start) begin
            _x <= start ? xa : tmp_x;
            _y <= start ? ya : tmp_y;
            _done <= _done ? 0 : (start ? 0 : tmp_done);
            err <= start ? dx + dy : tmp_err;
            dx <= right ? xb - xa : xa - xb; // dx = abs(xb-xa)
            dy <= down ? yb - ya : ya - yb; // dy = -abs(yb-ya)
        end
    end

    assign tmp_active = active && !(_done);
    assign drawing = tmp_active;
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            active <= 0;
        end else if (oe) begin
            active <= start || tmp_active;
        end
    end
endmodule