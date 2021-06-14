module draw_cube (
    input clk,
    input rst,
    input logic frame,
    output logic [10:0] x0,
    output logic [10:0] y0,
    output logic [10:0] x1,
    output logic [10:0] y1,
    output logic draw_start,
    output logic drawing,
    output logic draw_done
);

    localparam LINE_CNT = 12; // 12 lines in cube wireframe
    logic [3:0] line_id; // line identifier
    logic [10:0] _x0, _y0, _x1, _y1; // line coords

    enum {IDLE, INIT, DRAW, DONE} state;
    always_ff @(posedge clk) begin
        case (state)
            INIT: begin // register coordinates
                draw_start <= 1;
                state <= DRAW;
                case (line_id)
                    4'd0: begin
                        _x0 <= 200; _y0 <= 200; _x1 <= 400; _y1 <= 200;
                    end
                    4'd1: begin
                        _x0 <= 400; _y0 <= 200; _x1 <= 400; _y1 <= 400;
                    end
                    4'd2: begin
                        _x0 <= 400; _y0 <= 400; _x1 <= 200; _y1 <= 400;
                    end
                    4'd3: begin
                        _x0 <= 200; _y0 <= 400; _x1 <= 200; _y1 <= 200;
                    end
                    4'd4: begin
                        _x0 <= 100; _y0 <= 100; _x1 <= 300; _y1 <= 100;
                    end
                    4'd5: begin
                        _x0 <= 300; _y0 <= 100; _x1 <= 300; _y1 <= 300;
                    end
                    4'd6: begin
                        _x0 <= 300; _y0 <= 300; _x1 <= 100; _y1 <= 300;
                    end
                    4'd7: begin
                        _x0 <= 100; _y0 <= 300; _x1 <= 100; _y1 <= 100;
                    end
                    4'd8: begin
                        _x0 <= 200; _y0 <= 200; _x1 <= 100; _y1 <= 100;
                    end
                    4'd9: begin
                        _x0 <= 400; _y0 <= 200; _x1 <= 300; _y1 <= 100;
                    end
                    4'd10: begin
                        _x0 <= 400; _y0 <= 400; _x1 <= 300; _y1 <= 300;
                    end
                    4'd11: begin
                        _x0 <= 200; _y0 <= 400; _x1 <= 100; _y1 <= 300;
                    end
                    default: begin // shouldnt ever trigger
                        _x0 <= 0; _y0 <= 0; _x1 <= 0; _y1 <= 0;
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

    assign x0 = _x0;
    assign y0 = _y0;
    assign x1 = _x1;
    assign y1 = _y1;

endmodule