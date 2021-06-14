module get_cube #(
    parameter XY_BITW=16,
    parameter LINEW=4,
    parameter COLORW=3,
    parameter WIDTH=10,
    parameter HEIGHT=10,
    parameter DEPTH=5,
    parameter ADJ_DEG=45, // adjacent angle to hypotenuse in degrees
    parameter SCALE=1
) (
    input   clk,
    input   rst,
    input   [LINEW-1:0] line_id,
    output  [COLORW-1:0] color,
    output  [XY_BITW-1:0] x0,
    output  [XY_BITW-1:0] y0,
    output  [XY_BITW-1:0] x1,
    output  [XY_BITW-1:0] y1
);
    localparam W = WIDTH * SCALE;
    localparam H = HEIGHT * SCALE;
    localparam D = DEPTH * SCALE;

    logic [$clog2(D)-1:0] a, b;
    logic [XY_BITW-1:0] _x0, _x1, _y0, _y1;
    logic [COLORW-1:0] _color;

    assign a = D;
    assign b = D;

    assign color = _color;
    assign x0 = _x0;
    assign x1 = _x1;
    assign y0 = _y0;
    assign y1 = _y1;

    always_comb begin
        case (line_id)
            // FRONT SQUARE
            4'd0: begin // top left -> bottom left
                _x0 = 0;
                _y0 = 0;
                _x1 = 0;
                _y1 = H;
                _color = 3'b001;
            end
            4'd1: begin // bottom left -> bottom right
                _x0 = 0;
                _y0 = H;
                _x1 = W;
                _y1 = H;
                _color = 3'b010;
            end
            4'd2: begin // bottom right -> top right
                _x0 = W;
                _y0 = H;
                _x1 = W;
                _y1 = 0;
                _color = 3'b011;
            end
            4'd3: begin // top right -> top left
                _x0 = W;
                _y0 = 0;
                _x1 = 0;
                _y1 = 0;
                _color = 3'b100;
            end
            // BACK SQUARE
            4'd4: begin // top left -> bottom left
                _x0 = a;
                _y0 = b;
                _x1 = a;
                _y1 = b + H;
                _color = 3'b001;
            end
            4'd5: begin // bottom left -> bottom right
                _x0 = a;
                _y0 = b + H;
                _x1 = a + W;
                _y1 = b + H;
                _color = 3'b010;
            end
            4'd6: begin // bottom right -> top right
                _x0 = a + W;
                _y0 = b + H;
                _x1 = a + W;
                _y1 = b;
                _color = 3'b011;
            end
            4'd7: begin // top right -> top left
                _x0 = a + W;
                _y0 = b;
                _x1 = a;
                _y1 = b;
                _color = 3'b100;
            end
            // CONNECT FRONT AND BACK
            4'd8: begin // front top left -> back top left
                _x0 = 0;
                _y0 = 0;
                _x1 = a;
                _y1 = b;
                _color = 3'b001;
            end
            4'd9: begin // front bottom left -> back bottom left
                _x0 = 0;
                _y0 = H;
                _x1 = a;
                _y1 = b + H;
                _color = 3'b010;
            end
            4'd10: begin // front top right -> back top right
                _x0 = W;
                _y0 = 0;
                _x1 = a + W;
                _y1 = b;
                _color = 3'b100;
            end
            4'd11: begin // front bottom right -> back bottom right
                _x0 = W;
                _y0 = H;
                _x1 = a + W;
                _y1 = b + H;
                _color = 3'b011;
            end
            default: begin  // should never occur
                _x0 = 0;
                _y0 = 0;
                _x1 = 0;
                _y1 = 0;
                _color = 3'b111;
            end
        endcase
    end
endmodule