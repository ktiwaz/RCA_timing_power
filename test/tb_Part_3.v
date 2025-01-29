module tb_Part_3;

	localparam NBITS = 8;
	localparam SIGND = 1;
	reg [(2*NBITS)-1:0] count;
	wire [NBITS-1:0] a, b;
	reg cin;
	wire [NBITS-1:0] sum;
	wire overflow;
	
	
	Part_3 #(NBITS, SIGND) UUT (.a(a), .b(b), .cin(cin), .sum(sum), .overflow(overflow));
	
	
	assign a[NBITS-1:0] = count[(2*NBITS-1):NBITS];
	assign b[NBITS-1:0] = count[NBITS-1:0];
	
	
	initial begin
	
		cin = 1'b0;
	
	
		for (count = 0; count < (2**(2*NBITS)); count = count + 1) begin
		
		#10;
		
		
			if (~SIGND) begin
						
							
				if ({overflow, sum} != (count[(2*NBITS-1):NBITS] + count[NBITS-1:0]))
		
					$display("ERROR: a= %b b= %b sum= %b overflow= %b", count[(2*NBITS-1):NBITS], count[NBITS-1:0], sum, overflow);
		
				else
		
					$display("NO ERROR: a=%b b=%b sum=%b overflow=%b", count[(2*NBITS-1):NBITS], count[NBITS-1:0], sum, overflow);
		
			end
			
		
			else begin
		
				if ({overflow, sum} != ($signed(count[(2*NBITS-1):NBITS]) + $signed(count[NBITS-1:0])))
		
					$display("ERROR: a= %b b= %b sum= %b overflow= %b", count[(2*NBITS-1):NBITS], count[NBITS-1:0], sum, overflow);
		
				else
		
				$display("NO ERROR: a=%b b=%b sum=%b overflow=%b", count[(2*NBITS-1):NBITS], count[NBITS-1:0], sum, overflow);
		
			end
			
		end
							
	
					
	end
	
endmodule