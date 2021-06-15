module display_timing_800x600 #(
    parameter XY_BITW=16,                // bit width of horizontal/vertical screen pos
    parameter H_RES=800,                // horizontal resolution (px)
    parameter H_FP=56,                  // horizontal front porch
    parameter H_SP=120,                 // horizontal sync pulse 
    parameter H_BP=64,                  // horizontal bakc porch
    parameter H_POL=1,                  // horizontal sync polarity (0:neg, 1:pos)
    parameter V_RES=600,                // vetical resolution (px)
    parameter V_FP=37,                  // vertical front porch
    parameter V_SP=6,                   // vertical sync pulse
    parameter V_BP=23,                  // vertical back porch
    parameter V_POL=1                   // vertical sync polarity (0:neg, 1:pos)
) (
    input   clk,             // pixel clock
    input   rst,             // reset
    output  logic hsync,           // horizontal sync
    output  logic vsync,           // vertical sync
    output  logic de,              // data enable (low in blanking intervals)
    output  logic frame,           // high at start of new frame
    output  logic [XY_BITW-1:0] sx, // horizontal screen position
    output  logic [XY_BITW-1:0] sy  // vertical screen position
);
    // https://github.com/projf/projf-explore/blob/master/lib/display/display_timings_720p.sv

    // horizontal timings
    localparam H_STA    = 0;
    localparam HA_END   = H_RES - 1;        // active end
    localparam HS_STA   = H_RES + H_FP - 1; // sync pulse start (end of front porch)
    localparam HS_END   = HS_STA + H_SP;    // sync pulse end
    localparam H_END    = HS_END + H_BP;    // last pixel of back porch

    localparam V_STA    = 0;
    localparam VA_END   = V_RES - 1;        // active end
    localparam VS_STA   = V_RES + V_FP - 1; // sync pulse start (end of front porch)
    localparam VS_END   = VS_STA + V_SP;    // sync pulse end
    localparam V_END    = VS_END + V_BP;    // last pixel of back porch

    wire x_max = (sx == H_END);  // x is at end of cols
    wire y_max = (sy == V_END);  // y is at end of rows

    assign hsync = ~(sx > HS_STA && sx <= HS_END);
    assign vsync = ~(sy > VS_STA && sy <= VS_END);
    assign de = (sx <= HA_END && sy <= VA_END);
    assign frame = (sx == H_STA && sy == V_STA);

    // Iterate over each column in each row of pixels.
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sx <= 0;
            sy <= 0;
        end else begin
            sx <= x_max ? 0 : sx + 1;
            sy <= x_max ? (y_max ? 0 : sy + 1) : sy;
        end
    end
    
    /*
    // OUTPUT FOR VALIDATING DISPLAY TIMING
    always_ff @(posedge clk) begin
        if (frame) begin
            $display("display_timing: START OF FRAME");
            $display("H_BITW %0d H_STA %0d HA_END %0d HS_STA %0d HS_END %0d H_END %0d",
                XY_BITW, H_STA, HA_END, HS_STA, HS_END, H_END);
            $display("V_BITW %0d V_STA %0d VA_END %0d VS_STA %0d VS_END %0d V_END %0d",
                XY_BITW, V_STA, VA_END, VS_STA, VS_END, V_END);
        end
        $display("%0d,%0d,%0d,%0d,%0d,%0d", frame, de, hsync, vsync, sx, sy);
    end
    */
endmodule