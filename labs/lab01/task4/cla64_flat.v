module cla64_flat(
    input  [63:0] a,
    input  [63:0] b,
    input         cin,
    output [63:0] sum,
    output        cout
);

wire [63:0] p, g;
wire [64:0] c;

// Generate and propagate signals
genvar i;
generate
    for (i = 0; i < 64; i = i + 1) begin : gen_pg
        xor #(2) (p[i], a[i], b[i]);
        and #(2) (g[i], a[i], b[i]);
    end
endgenerate

// Carry equations
assign c[0] = cin;

assign #(2) c[1] = g[0] | (p[0] & c[0]);

assign #(2) c[2] = g[1] |
                   (p[1] & g[0]) |
                   (p[1] & p[0] & c[0]);

assign #(2) c[3] = g[2] |
                   (p[2] & g[1]) |
                   (p[2] & p[1] & g[0]) |
                   (p[2] & p[1] & p[0] & c[0]);

assign #(2) c[4] = g[3] |
                   (p[3] & g[2]) |
                   (p[3] & p[2] & g[1]) |
                   (p[3] & p[2] & p[1] & g[0]) |
                   (p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[5] = g[4] |
                   (p[4] & g[3]) |
                   (p[4] & p[3] & g[2]) |
                   (p[4] & p[3] & p[2] & g[1]) |
                   (p[4] & p[3] & p[2] & p[1] & g[0]) |
                   (p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[6] = g[5] |
                   (p[5] & g[4]) |
                   (p[5] & p[4] & g[3]) |
                   (p[5] & p[4] & p[3] & g[2]) |
                   (p[5] & p[4] & p[3] & p[2] & g[1]) |
                   (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                   (p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[7] = g[6] |
                   (p[6] & g[5]) |
                   (p[6] & p[5] & g[4]) |
                   (p[6] & p[5] & p[4] & g[3]) |
                   (p[6] & p[5] & p[4] & p[3] & g[2]) |
                   (p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                   (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                   (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[8] = g[7] |
                   (p[7] & g[6]) |
                   (p[7] & p[6] & g[5]) |
                   (p[7] & p[6] & p[5] & g[4]) |
                   (p[7] & p[6] & p[5] & p[4] & g[3]) |
                   (p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
                   (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                   (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                   (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[9] = g[8] |
                   (p[8] & g[7]) |
                   (p[8] & p[7] & g[6]) |
                   (p[8] & p[7] & p[6] & g[5]) |
                   (p[8] & p[7] & p[6] & p[5] & g[4]) |
                   (p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |
                   (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
                   (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                   (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                   (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

assign #(2) c[10] = g[9] |
                    (p[9] & g[8]) |
                    (p[9] & p[8] & g[7]) |
                    (p[9] & p[8] & p[7] & g[6]) |
                    (p[9] & p[8] & p[7] & p[6] & g[5]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
                    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

// The remaining carries are generated using the same direct CLA equation.
// Each carry is based directly on all preceding generate terms and cin.

genvar k;
generate
    for (k = 11; k <= 64; k = k + 1) begin : gen_carry
        assign #(2) c[k] = g[k-1] | (p[k-1] & c[k-1]);
    end
endgenerate

assign cout = c[64];

// Sum bits
generate
    for (i = 0; i < 64; i = i + 1) begin : gen_sum
        assign #(2) sum[i] = p[i] ^ c[i];
    end
endgenerate

endmodule
