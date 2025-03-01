`timescale 1ns / 1ps

module tb_ripple_carry_adder;

    parameter N = 64;
    reg clk;
    reg [N-1:0] a, b;
    wire [N-1:0] sum;
    reg cin;
    
    // Instantiate the DUT (Device Under Test)
    rippleCarryAdder_pipeline_2 #(.Nbits(N)) dut (
        .clk(clk),
        .a(a),
        .b(b),
        .sum(sum),
        .cin(cin)
    );

    // Clock Generation
    always #5 clk = ~clk; // 10ns clock period

    // Test Procedure
    initial begin
        // Enable waveform dump
        $dumpfile("waveform.vcd");  // VCD file for GTKWave or ModelSim
        $dumpvars(0, tb_ripple_carry_adder); // Dump all variables

        clk = 1;
        a = 0;
        b = 0;
        cin = 0;
        // Apply test vectors
        #10 a = 64'h0000000000000001; b = 64'h0000000000000001; // 1 + 1 = 2
        #10 a = 64'h00000000FFFFFFFF; b = 64'h0000000000000001; // 2^32-1 + 1
        #10 a = 64'h0F0F0F0F0F0F0F0F; b = 64'hF0F0F0F0F0F0F0F0; // Mixed pattern
        #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'h0000000000000001; // Overflow case
        #10 a = 64'h123456789ABCDEF0; b = 64'h0FEDCBA987654321; // Random values
        #10 a = 64'hAAAAAAAAAAAAAAAA; b = 64'h5555555555555555; // Alternating bits
        
        // Wait for pipeline propagation
        #50;
        
        $finish; // End simulation
    end

endmodule
