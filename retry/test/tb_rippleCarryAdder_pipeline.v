
module tb_rippleCarryAdder_pipeline;

  // Parameters
  localparam  Nstages = 2;
  localparam  Nbits = 8;

  //Ports
  reg clk;
  reg cin;
  wire [Nbits-1:0] sum;
  wire cout;

  reg     [Nbits - 1:0] a_queue [Nstages + 1 : 0];
  reg     [Nbits - 1:0] b_queue [Nstages + 1 : 0];


  rippleCarryAdder_pipeline # (
    .Nstages(Nstages),
    .Nbits(Nbits)
  )
  rippleCarryAdder_pipeline_inst (
    .clk(clk),
    .a(a_queue[0]),
    .b(b_queue[0]),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

always #5  clk = ! clk ;

integer i;
integer j;
integer k;
integer l;
integer a_old;
integer b_old;

initial begin
    clk = 1;
    cin = 0;
    
    for (k = 0; k < 2; k=k+1) begin
      for(i = 0; i < 2; i=i+1) begin
          for (j = 0; j < 2; j=j+1) begin
              a_queue[0] = i;
              b_queue[0] = j;
              cin = k;
              #10;
          end
      end
    end
    #30
    $finish();
end

initial begin
  // Dump waveform
  $dumpfile("tb_rippleCarryAdder_pipeline.vcd");
  $dumpvars(0, tb_rippleCarryAdder_pipeline);
end

initial begin
  #30
  forever begin
    if ({cout, sum} != a_queue[Nstages+1] + b_queue[Nstages+1] + cin) begin
      $display("Error! a = %b, b = %b, cin = %b, sum = %b, cout = %b", a_queue[Nstages], b_queue[Nstages], cin, sum, cout);
    end
    #10;
  end
end

always @(posedge clk) begin
  for(l = 1; l < Nstages + 2; l = l + 1) begin
    a_queue[l] <= a_queue[l - 1];
    b_queue[l] <= b_queue[l - 1];
  end
end

endmodule