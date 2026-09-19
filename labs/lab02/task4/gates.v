module and_df(
    input a,
    input b,
    output y
);
    assign #5 y = a & b;
endmodule


module and_beh_before(
    input a,
    input b,
    output reg y
);
    always @(*) begin
        #5 y = a & b;
    end
endmodule


module and_beh_intra(
    input a,
    input b,
    output reg y
);
    always @(*) begin
        y = #5 a & b;
    end
endmodule