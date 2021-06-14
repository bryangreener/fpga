module display_timing_800x600_old #(
    parameter CORDW=10,                     // signed coordinate width (bits)
    parameter H_RES=800,                    // horizontal resolution (px)
    parameter H_FP=56,                      // horizontal front porch
    parameter H_SP=120,                     // horizontal sync pulse 
    parameter H_BP=64,                      // horizontal bakc porch
    parameter H_POL=1,                      // horizontal sync polarity (0:neg, 1:pos)
    parameter V_RES=600,                    // vetical resolution (px)
    parameter V_FP=37,                      // vertical front porch
    parameter V_SP=6,                       // vertical sync pulse
    parameter V_BP=23,                      // vertical back porch
    parameter V_POL=1                       // vertical sync polarity (0:neg, 1:pos)
) (
    input   wire logic clk_pix,                 // pixel clock
    input   wire logic rst,                     // reset
    output       logic hsync,                   // horizontal sync
    output       logic vsync,                   // vertical sync
    output       logic de,                      // data enable (low in blanking intervals)
    output       logic frame,                   // high at start of new frame
    output       logic signed [CORDW-1:0] sx,   // horizontal screen position
    output       logic signed [CORDW-1:0] sy    // vertical screen position
);
    // https://github.com/projf/projf-explore/blob/master/lib/display/display_timings_720p.sv

    // horizontal timings
    localparam signed H_STA     = 0 - H_FP - H_SP - H_BP;   // horizontal start
    localparam signed HS_STA    = H_STA + H_FP;             // sync start
    localparam signed HS_END    = HS_STA + H_SP;            // sync end
    localparam signed HA_STA    = 0;                        // active start
    localparam signed HA_END    = H_RES - 1;                // active end

    // vertical timings
    localparam signed V_STA     = 0 - V_FP - V_SP - V_BP;
    localparam signed VS_STA    = V_STA + V_FP;
    localparam signed VS_END    = VS_STA + V_SP;
    localparam signed VA_STA    = 0;
    localparam signed VA_END    = V_RES - 1;

    logic signed [CORDW-1:0] x, y; // screen position

    // generate horizontal and vertical sync with correct polarity
    assign hsync = H_POL ? (x > HS_STA && x <= HS_END) : ~(x > HS_STA && x <= HS_END);
    assign vsync = V_POL ? (y > VS_STA && y <= VS_END) : ~(y > VS_STA && y <= VS_END);

    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) begin
            frame <= 0;
            de <= 0;
        end else begin
            de <= (y >= VA_STA && x >= HA_STA);
            frame <= (y == V_STA && x == H_STA);
        end
    end

    // calculate horizontal and vertical screen position
    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) begin
            x <= H_STA;
            y <= V_STA;
        end else begin
            if (x == HA_END) begin // last pixel on line?
                x <= H_STA;
                y <= (y == VA_END) ? V_STA : y + 1; // last line on screen?
                //y <= (y == VA_END) ? 0 : y + 1;
            end else begin
                x <= x + 1;
            end
        end
    end

    // align screen position with sync and control signals
    always_ff @(posedge clk_pix or posedge rst) begin
        if (rst) begin
            sx <= H_STA;
            sy <= V_STA;
        end else begin
            sx <= x;
            sy <= y;
        end
    end

    //assign sx = x;
    //assign sy = y;
    // Output 0 when in blanking intervals
    //assign de = (y >= VA_STA && x >= HA_STA);
    //assign frame = (y == V_STA && x == H_STA);
endmodule