module draw_polygon #(
    parameter width = 800,
    parameter height = 600
)(
    input x0,
    input x1,
    input x2,
    input x3,
    input y0,
    input y1,
    input y2,
    input y3,
    output arr [0:width-1] [0:height-1]
);

    reg arr [0:width-1] [0:height-1];

endmodule

