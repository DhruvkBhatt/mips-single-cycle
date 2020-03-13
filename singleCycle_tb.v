`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:25:44 03/14/2020
// Design Name:   singleCycle
// Module Name:   E:/bits/ACA/assignment_2/mips_single_cycle/singleCycle_tb.v
// Project Name:  mips_single_cycle
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: singleCycle
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module singleCycle_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] result;
	wire [31:0] inPc1;

	// Instantiate the Unit Under Test (UUT)
	singleCycle uut (
		.clk(clk), 
		.reset(reset), 
		.result(result), 
		.inPc1(inPc1)
	);
	always
	#5
	clk=~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		#20;
		reset=0;
		
		// Wait 100 ns for global reset to finish
		#160;
      $finish;  
		// Add stimulus here

	end
      
endmodule

