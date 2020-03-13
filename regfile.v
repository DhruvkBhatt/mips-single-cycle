`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:58 03/14/2020 
// Design Name: 
// Module Name:    regfile 
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
module regfile1 (
	input         clk  ,
	//
	input  [ 4:0] addr1,
	input  [ 4:0] addr2,
	output reg [31:0] data1,
	output reg [31:0] data2,
	//
	input         rw   ,
	input  [ 4:0] addr3,
	input  [31:0] wdata
);

	reg [31:0] regmem[31:0];
//	reg [31:0] data1       ;
//	reg [31:0] data2       ;

	always @(addr1 or regmem[addr1]) begin
		if (0 == addr1) begin
			data1 = 0;
		end else begin
			data1 = regmem[addr1];
		end
	end

	always @(addr2 or regmem[addr2]) begin
		if (0 == addr2) begin
			data2 = 0;
		end else begin
			data2 = regmem[addr2];
		end
	end

	always@ (posedge clk) begin
		if(1'b1 == rw) begin
			regmem[addr3] = wdata;
		end
	end

endmodule


