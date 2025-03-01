module tb_Part_2;
	reg [7:0] count;
	
	
	wire [7:0] raw;
	
	
	
	
	Part_2 UUT (.SW(count),.raw(raw));
					
	initial begin
	
	
	

					for (count = 0; count < 256; count = count + 1) begin
						#10;
						
							
						if (raw != (count[3:0] * count[7:4])) begin
							$display("ERROR: a=%b b=%b product=%b", count[3:0], count[7:4], raw);
							
						end

		
					end
					
	end
	
endmodule
	