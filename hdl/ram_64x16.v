`timescale 1ns / 1ps
module ram_64x16 (
    input clk,
    input wr_en,
    input [63:0] data_in,
    output [63:0] data_out,
    input [63:0] addr_wr,
    input [63:0] addr_rd
);

reg [63:0] mem [3:0];
reg [63:0] data_out_i;

assign data_out = data_out_i;

always @(posedge clk) begin
    
    if (wr_en == 1'b1) begin
        mem[addr_wr] <= #1 data_in; // write mem
    end

    data_out_i <= #1 mem[addr_rd]; // read mem
end

endmodule