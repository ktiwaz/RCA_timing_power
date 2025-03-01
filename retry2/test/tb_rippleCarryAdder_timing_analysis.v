
module tb_rippleCarryAdder_timing_analysis;

  // Parameters

  //Ports
  reg ADC_CLK_10;
  reg MAX10_CLK1_50;
  reg MAX10_CLK2_50;
  wire [7:0] HEX0;
  wire [7:0] HEX1;
  wire [7:0] HEX2;
  wire [7:0] HEX3;
  wire [7:0] HEX4;
  wire [7:0] HEX5;
  reg [1:0] KEY;

  rippleCarryAdder_timing_analysis  rippleCarryAdder_timing_analysis_inst (
    .MAX10_CLK1_50(MAX10_CLK1_50),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5),
    .KEY(KEY)
  );

always #5  MAX10_CLK1_50 = ! MAX10_CLK1_50;

initial begin
    KEY[0] = 1;
    MAX10_CLK1_50 = 1;
    #10;
    KEY[0] = 0;
    #10;
    KEY[0] = 1;
    #400;
    $finish();
end

initial begin
    // Dump waveform
    $dumpfile("tb_rippleCarryAdder_timing_analysis.vcd");
    $dumpvars(0, tb_rippleCarryAdder_timing_analysis);
end

endmodule