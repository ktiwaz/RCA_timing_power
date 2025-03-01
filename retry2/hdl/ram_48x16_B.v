module ram_48x16_B(
	input mwr,
	input [3:0] addr,
	input [47:0] mdi,
	input clk,
	output reg [47:0] mdo
);

reg [0:47] RAM [0:15] /* synthesis ramstyle = "M9K" ram_init_file = "ram_init_b.mif" */;

always @ (posedge clk) begin
	if (mwr) RAM[addr] <= mdi;
	mdo <= RAM[addr];
end

// For TB
// initial begin
// 	$readmemb("ram_b_init.txt", RAM);
// end

endmodule
