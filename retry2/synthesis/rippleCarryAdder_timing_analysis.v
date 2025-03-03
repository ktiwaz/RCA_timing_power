
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module rippleCarryAdder_timing_analysis(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire clk;
assign clk = MAX10_CLK1_50;

wire rst;
assign rst = ~KEY[0];

// From RAM
wire [47:0] a;
wire [47:0] b;

wire cin;
assign cin = 1'b1;

// Pipeline stage
wire [23:0] a_upper_d, b_upper_d;
reg  [23:0] a_upper_q, b_upper_q;
wire [23:0] sum_pipe_d;
reg  [23:0] sum_pipe_q;
wire c_carry_d;
reg  c_carry_q;
reg [3:0]  addr_pipe;

// Write address delay by 1 cycle compared to read
reg [3:0] addr_in, addr_out;

wire [47:0] sum;
wire cout;
wire [47:0] data_out;

//=======================================================
//  Structural coding
//=======================================================

ram_48x16_A u_RAM_a (
	.mwr  ( 1'b0     ),  // read-only
	.addr ( addr_in  ),
	.mdi  ( 48'd0    ), // read-only
	.clk  ( clk      ),
	.mdo  ( a        )
);

ram_48x16_B u_RAM_B (
	.mwr  ( 1'b0     ),  // read-only
	.addr ( addr_in  ),
	.mdi  ( 48'd0    ), // read-only
	.clk  ( clk      ),
	.mdo  ( b        )
);

assign a_upper_d = a[47:24];
assign b_upper_d = b[47:24];

// First stage RCA
rippleCarryAdder # (
    .Nbits(24),
    .signd(1'b0)
  )
  rippleCarryAdder_stage1 (
    .a(a[23:0]),
    .b(b[23:0]),
    .cin(cin),
    .sum(sum_pipe_d),
    .cout(c_carry_d)
  );

// Second stage RCA
  rippleCarryAdder # (
    .Nbits(24),
    .signd(1'b0)
  )
  rippleCarryAdder_stage2 (
    .a(a_upper_q),
    .b(b_upper_q),
    .cin(c_carry_q),
    .sum(sum[47:24]),
    .cout(cout)
  );

  assign sum[23:0] = sum_pipe_q;

ram_48x16_C  ram_48x16_C_inst (
    .mwr(1'b1),	 // Always write
    .addr(addr_out),
    .mdi(sum),
    .clk(clk),
    .mdo(data_out)
  );

// To prevent quartus optimizations, drive real outputs
assign HEX0[7:0] = data_out[7:0];
assign HEX1[7:0] = data_out[15:8];
assign HEX2[7:0] = data_out[23:16];
assign HEX3[7:0] = data_out[31:24];
assign HEX4[7:0] = data_out[39:32];
assign HEX5[7:0] = data_out[47:40];

// Address change logic
always @(posedge clk) begin
	if (rst) begin
		addr_in    <= 4'b0000;
		addr_pipe  <= 4'b0000;
		addr_out   <= 4'b0000;
		a_upper_q  <= 24'd0;
		b_upper_q  <= 24'd0;
		sum_pipe_q <= 24'd0;
		c_carry_q  <= 1'b0;
		
	end else begin
		addr_in   <= addr_in + 4'b0001;

		// 2 cycle delay (latency)
		addr_pipe <= addr_in;
		addr_out  <= addr_pipe;

		a_upper_q  <= a_upper_d;
		b_upper_q  <= b_upper_d;
		sum_pipe_q <= sum_pipe_d;
		c_carry_q  <= c_carry_d;

	end
end
endmodule
