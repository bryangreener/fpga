module framebuffer #(
    // Horizontal Timings
    parameter h_dim = 800,  // Active Video (800 = 16us)
    parameter h_fp = 56,    // Front Porch (56 = 1.12us)
    parameter h_sp = 120,   // Sync Pulse (120 = 2.4us)
    parameter h_bp = 64,    // Back Porch (64 = 1.28us)
    parameter h_tot = h_dim + h_fp + h_sp + h_bp - 1,
    // Vertical Timings
    parameter v_dim = 600,  // Active Video (600 = 12480us)
    parameter v_fp = 37,    // Front Porch (37 = 769.6us)
    parameter v_sp = 6,     // Sync Pulse (6 = 126.8us)
    parameter v_bp = 23,    // Back Porch (23 = 478.4us)
    parameter v_tot = v_dim + v_fp + v_sp + v_bp - 1
)(
    input clk,
    input rst,
    input [10:0] x,
    input [9:0] y,
    input pixel_color,
    input pixel_write,
    output frame,   // high at start of active frame
    output line,    // high at start of active line
    output in_display,
    output vga_r,
    output vga_g,
    output vga_b,
    output vga_hs,
    output vga_vs
);

    // https://github.com/theapi/de0-nano/blob/master/vga/experiment/vga_demo.v
    //http://www.cs.columbia.edu/~sedwards/classes/2015/4840/lines.pdf
    // Internal registers for horizontal signal timing.
    reg [10:0] h_reg;
    reg h_sync;
    wire h_max = (h_reg == h_tot);

    // Internal registers for vertical signal timing.
    reg [9:0] v_reg;
    reg v_sync;
    wire v_max = (v_reg == v_tot);

    localparam signed H_STA = 0 - h_fp - h_sp - h_bp;   // horizontal start
    localparam signed HA_STA = 0;                       // active start
    localparam signed V_STA = 0 - v_fp - v_sp - v_bp;   // vertical start
    localparam signed VA_STA = 0;                       // active start

    // Control signals
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            frame <= 0;
        end

        frame <= (h_reg == H_STA && v_reg == V_STA);
        line <= (h_reg == H_STA && v_reg >= VA_STA);
    end

    // Run through line
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            h_reg <= 0;
            v_reg <= 0;
        end else if (h_max) begin
            h_reg <= 0;
            if (v_max) begin
                v_reg <= 0;
            end else begin
                v_reg <= v_reg + 1;
            end
        end else begin
            h_reg <= h_reg + 1;
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            h_sync <= 0;
            v_sync <= 0;
        end else begin
            // Generate horizontal sync signal
            if (h_reg == (h_dim + h_fp)) begin
                h_sync <= 1;
            end else if (h_reg == (h_dim + h_fp + h_sp)) begin
                h_sync <= 0;
            end

            // Generate vertical sync signal
            if (v_reg == (v_dim + v_fp)) begin
                v_sync <= 1;
            end else if (v_reg == (v_dim + v_fp + v_sp)) begin
                v_sync <= 0;
            end

        end
    end

    // Send sync signals to output, inverted since sync pulse is low.
    assign vga_hs = ~h_sync;
    assign vga_vs = ~v_sync;
    assign in_display = v_reg < v_dim && h_reg < h_dim;

    logic framebuffer [0:(h_dim*v_dim)-1]; // w * h flattened 2d array
    logic [19:0] read_address, write_address;

    assign write_address = (x * h_dim) + y;
    assign read_address = (h_reg * h_dim) + v_reg;

    logic pixel_read;
    always_ff @(posedge clk) begin
        if (pixel_write) begin
            framebuffer[write_address] <= pixel_color;
        end
        if (h_reg[0]) begin
            pixel_read <= framebuffer[read_address];
        end
    end

    
    assign vga_r = 0;//pixel_read;
    assign vga_g = pixel_read;
    assign vga_b = 0;//pixel_read;
endmodule