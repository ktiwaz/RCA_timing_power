module ram_48x16_C(
	input mwr,
	input [3:0] addr,
	input [47:0] mdi,
	input clk,
	output reg [47:0] mdo
);

reg [0:47] RAM [0:15] /* synthesis ramstyle = "M9K"*/;

always @ (posedge clk) begin
	if (mwr) RAM[addr] <= mdi;
	mdo <= RAM[addr];
end

endmodule
