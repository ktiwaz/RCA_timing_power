`timescale 1ns / 1ps

module tb_rippleCarryAdder_pipeline;

// Parameters
parameter Nstages = 2;
parameter Nbits = 8;

// Inputs
reg clk;
reg [Nbits-1:0] a;
reg [Nbits-1:0] b;
reg cin;

// Outputs
wire [Nbits-1:0] sum;
wire cout;

// Instantiate the Unit Under Test (UUT)
rippleCarryAdder_pipeline #( .Nstages(Nstages), .Nbits(Nbits)) uut (
    .clk(clk),
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

// Clock generation
always begin
    clk = 1'b0; #5; clk = 1'b1; #5; // 100MHz clock (10ns period)
end

// Stimulus generation
initial begin
    // Initialize inputs
    a = 8'b00000000;
    b = 8'b00000000;
    cin = 0;
    
    // Wait for global reset to finish
    #10;
    
    // Test 1: Simple addition without carry
    a = 8'b00000001; 
    b = 8'b00000001; 
    cin = 0;   // 1 + 1 = 2 (no overflow)
    
    #25;

    $display("Time=%0t | a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
    
    // Test 2: Adding with a carry-in
    a = 8'b11111111;
    b = 8'b00000001;
    cin = 1;   // 255 + 1 + 1 = 257, cout should be 1
    
    #25;

    $display("Time=%0t | a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
    
    // Test 3: Edge case with maximum values
    a = 8'b11111111;
    b = 8'b11111111;
    cin = 1;   // 255 + 255 + 1 = 511, cout should be 1
    
    #25;

    $display("Time=%0t | a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
    
    // Test 4: Random values
    a = 8'b11001100;
    b = 8'b10101010;
    cin = 0;   // 204 + 170 = 374, cout should be 0
    
    #25;

    $display("Time=%0t | a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
    
    // Test 5: Overflow condition
    a = 8'b11111111;
    b = 8'b11111111;
    cin = 0;   // 255 + 255 = 510, cout should be 1
    
    #25;

    $display("Time=%0t | a=%b b=%b cin=%b | sum=%b cout=%b", $time, a, b, cin, sum, cout);
    
    // End simulation after all tests
    $stop;
end

endmodule
