
//=======================================================
//  Module declaration
//=======================================================

// Nbits is the bus width of the adder inputs and outputs
// Signd is a parameter which is 0 for unsigned addition and 1 for 2s complement signed addition.
//	Signd only changes how the overflow bit is assigned.

module rippleCarryAdder #(parameter Nbits = 8, parameter signd = 0)(

	// Declare all inputs and outputs 
	
	
	input [Nbits-1:0] a, 
	input [Nbits-1:0] b, 
	input cin, 
	output [Nbits-1:0] sum, 
	output cout
	
	
);




//=======================================================
//  REG/WIRE declarations
//=======================================================
	wire    [Nbits:0]    c_carry;  // These wires are internal to our module


//=======================================================
//  Behavioral coding
//=======================================================

	genvar i;

	generate
		for (i = 0; i < Nbits; i = i + 1) begin : adder
			FA myfa (.a(a[i]), .b(b[i]), .Cin(c_carry[i]), .S(sum[i]), .Cout(c_carry[i+1]));
		end
		
			
	endgenerate
	
	assign c_carry[0] = cin;
	
	generate
	
		if (signd)
		
				assign cout = ((~a[Nbits-1])&(~b[Nbits-1])&sum[Nbits-1])|((a[Nbits-1])&(b[Nbits-1])&(~sum[Nbits-1]));	
				
		else
		
				assign cout = c_carry[Nbits];
	
	endgenerate
	

	
		
		


endmodule
