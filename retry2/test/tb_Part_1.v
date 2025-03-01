module tb_Part_1;
	reg [15:0] count;
	
	
	
	

	
	wire [7:0]     Sum;
	wire [6:0]    c_carry;
	
	wire [7:0]		a;
	wire [7:0]     b;
	
	
	reg        cin;
	wire           overflow;
	

	
	assign a[7:0] = count[15:8];
	assign b[7:0] = count[7:0];
	
	
	Part_1 UUT (.Sum(Sum),.overflow(overflow),.a(a),.b(b),.cin(cin));
					
	initial begin
	cin = 1'b0;
	
	
			//for (count2 = 0; count2 < 256; count2 = count2 + 1)
				//repeat (256)
				//begin
					for (count = 0; count < 65536; count = count + 1) begin
						#10;
						
							
						if ({overflow, Sum} != (count[15:8] + count[7:0])) begin
							$display("ERROR: a=%b b=%b sum=%b overflow=%b", count[15:8], count[7:0], Sum, overflow);
							
						end

					//count2 = count2 + 8'b00000001;
					end
					
	end
	
endmodule
	