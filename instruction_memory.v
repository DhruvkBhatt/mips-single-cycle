`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:19:49 03/14/2020 
// Design Name: 
// Module Name:    instruction_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
//instruction memory upto 32 memory address as 
//pc contains 5 bits total possible valuse 2^5=32
//mipstest.s file contains memory address
module instruction_memory(input clk, input reset, input [4:0] pc_5bits,input memRead, output [31:0] IR);

reg [31:0] Instruction_Memory[31:0];
reg tIR[31:0];
initial
//to read the data from mipstest.s
		$readmemh("mipstest.s", Instruction_Memory);
		
		
//assign tIR[31:0]=;
mux2to1_32bits m1(32'd0,Instruction_Memory[pc_5bits[4:0]],memRead,IR);
endmodule

