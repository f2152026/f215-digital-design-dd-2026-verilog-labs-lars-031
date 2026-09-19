module tb;

    reg [3:0] a;
    reg [3:0] b;
    reg       op;
    wire [3:0] result;

    alu U_ALU (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    initial begin
        $monitor("time=%0t | op=%b | a=%d | b=%d | result=%d",
                 $time, op, a, b, result);

        // -------------------------
        // ADDITION
        // -------------------------
        op = 0;
        a = 4;
        b = 3;
        #10;

        // Change ONLY op
        op = 1;
        #10;

        // -------------------------
        // SUBTRACTION
        // -------------------------
        a = 7;
        b = 2;
        #10;

        // Change ONLY a
        a = 6;
        #10;

        // Change ONLY b
        // Expected: 6 - 1 = 5
        b = 1;
        #10;

        // Another subtraction
        // Expected: 3 - 7 = 12 (4-bit wraparound)
        a = 3;
        b = 7;
        #10;

        // -------------------------
        // Addition again
        // -------------------------
        op = 0;
        a = 5;
        b = 6;
        #10;

        // Change ONLY a
        // Expected: 2 + 6 = 8
        a = 2;
        #10;

        $finish;
    end

endmodule