`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:23:42 03/14/2020 
// Design Name: 
// Module Name:    dmem 
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
//we =1 then we write the data and when we=0 we read the data
module dmem(input clk, input we,
	input [31:0] add,
	input [31:0] data,	
	output reg [31:0] rd);
	reg [31:0] RAM[199:0];
	always @(posedge clk)
		if(we==1'b1)
			 RAM[add[31:0]] = data;
		else
			rd = RAM[add[31:2]]; // word aligned
		
	//always_ff @(posedge clk)
		//if (we) RAM[a[31:2]] <= wd;
endmodule

