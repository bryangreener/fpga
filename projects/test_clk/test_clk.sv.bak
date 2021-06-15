module test_clk #(
    parameter d_max = 5
)(
    input clk,
    input rst,
    output [2:0] d
);
    reg [2:0] d_reg;
    wire max_d = (d_reg == d_max);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            d_reg <= 0;
        end else begin
            if (max_d) begin
                d_reg <= 0;
            end else begin
                d_reg <= d_reg + 1;
            end
        end
    end

    assign d = d_reg;

endmodule