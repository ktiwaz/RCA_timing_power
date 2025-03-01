module FA
(
	input 
		 a,
		 b,
		 Cin,
	
	output 
		 S,
		 Cout
);

	assign S = a ^ b ^ Cin;
	
	assign Cout = ((a ^ b) & Cin)|(a & b);





endmodule