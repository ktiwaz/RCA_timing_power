
//=======================================================
//  Parametrized Pipelined Ripple Carry Adder
//=======================================================

// Nbits is the bus width of the adder inputs and outputs
// Nstages is the number of pipelined stages. Must be a power of 2. The minimum is 1.
// This does not support an overflow indication bit

module rippleCarryAdder_pipeline #(parameter Nstages = 2, parameter Nbits = 8)(

	input               clk,
	input  [Nbits-1:0]  a, 
	input  [Nbits-1:0]  b, 
	input               cin, 
	output [Nbits-1:0]  sum, 
    output              cout
	
);




//=======================================================
//  REG/WIRE declarations
//=======================================================
localparam slice_size = Nbits / Nstages;
    
wire    [Nbits - 1:0] a_d [Nstages : 0];
reg     [Nbits - 1:0] a_q [Nstages : 0];

wire    [Nbits - 1:0] b_d [Nstages : 0];
reg     [Nbits - 1:0] b_q [Nstages : 0];

wire    [Nbits - 1:0] s_d [Nstages : 0];
reg     [Nbits - 1:0] s_q [Nstages : 0];

wire c_d [Nstages : 0];
reg  c_q [Nstages : 0];


//=======================================================
//  Structural Code
//=======================================================

// Outputs
assign sum = s_q[Nstages][Nbits-1:0];
assign cout= c_q[Nstages];

// Registered inputs
assign a_d[0][Nbits-1:0] = a;
assign b_d[0][Nbits-1:0] = b;
assign c_d[0] = cin;

//=======================================================
//  Behavioral Code
//=======================================================

initial begin
    if (Nbits % Nstages != 0) $fatal("Nbits must be divisible by Nstages");
end

// Stages stages of Pipelined adder
genvar i;

generate
	for (i = 1; i <= Nstages; i = i + 1) begin : adder_pipeline

    assign s_d[i] = s_q[i-1];

    assign a_d[i] = a_q[i-1];
    assign b_d[i] = b_q[i-1];

    rippleCarryAdder #(
        .Nbits(slice_size), 
        .signd(1'b0)
        ) u_RCA1 (
        .a(a_q[i-1][i*slice_size-1:(i-1)*slice_size]),
        .b(b_q[i-1][i*slice_size-1:(i-1)*slice_size]),
        .cin(c_q[i-1]),
        .sum(s_d[i][i*slice_size-1:(i-1)*slice_size]),
        .overflow(c_d[i])
        );

    end	
			
endgenerate



// Pipeline register update block
always @(posedge clk) begin : update_regs
    integer j;
    for (j = 0; j <= Nstages; j = j + 1) begin
        a_q[j] <= a_d[j];
        b_q[j] <= b_d[j];
        s_q[j] <= s_d[j];
        c_q[j] <= c_d[j];
    end
end

endmodule
