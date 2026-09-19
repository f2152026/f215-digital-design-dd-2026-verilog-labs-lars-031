module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  integer    i, j, errors;
  reg        exp_gt, exp_lt, exp_eq;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #1;

        if (t_a > t_b) begin
          exp_gt = 1'b1;
          exp_lt = 1'b0;
          exp_eq = 1'b0;
        end else if (t_a < t_b) begin
          exp_gt = 1'b0;
          exp_lt = 1'b1;
          exp_eq = 1'b0;
        end else begin
          exp_gt = 1'b0;
          exp_lt = 1'b0;
          exp_eq = 1'b1;
        end

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $display("SUMMARY: %0d/%0d passed", 16 - errors, 16);
    if (errors == 0)
      $display("PASS: all 16 combinations matched expected comparator behavior");
    else
      $display("FAIL: %0d mismatch(es) detected", errors);

    $finish;
  end

  initial
    $monitor($time, " A=%b B=%b | GT=%b LT=%b EQ=%b", t_a, t_b, t_gt, t_lt, t_eq);

endmodule