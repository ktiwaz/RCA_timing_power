module rippleCarryAdder_pipeline_2 #(parameter Nbits = 16) (
    input clk,
    input [Nbits-1:0] a,
    input [Nbits-1:0] b,
    input             cin,
    output [Nbits-1:0] sum
);
    parameter HALF_N = Nbits / 2;

    // Internal signals
    wire [HALF_N-1:0] sum_lower, sum_upper;
    wire carry_out_stage1;
    
    reg [HALF_N-1:0] sum_lower_reg;
    reg [HALF_N-1:0] a_upper_reg, b_upper_reg;
    reg carry_reg;

    // First stage: Lower half RCA
    rippleCarryAdder #(.Nbits(HALF_N)) rca1 (
        .a(a[HALF_N-1:0]),
        .b(b[HALF_N-1:0]),
        .cin(cin),
        .sum(sum_lower),
        .overflow(carry_out_stage1)
    );

    // Pipeline registers
    always @(posedge clk) begin
        sum_lower_reg <= sum_lower;
        a_upper_reg   <= a[Nbits-1:HALF_N];
        b_upper_reg   <= b[Nbits-1:HALF_N];
        carry_reg     <= carry_out_stage1;
    end

    // Second stage: Upper half RCA
    rippleCarryAdder #(.Nbits(HALF_N)) rca2 (
        .a(a_upper_reg),
        .b(b_upper_reg),
        .cin(carry_reg),
        .sum(sum_upper),
        .overflow() // Carry out ignored
    );

    // Concatenating final sum
    assign sum = {sum_upper, sum_lower_reg};

endmodule