`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:05 03/14/2020 
// Design Name: 
// Module Name:    singleCycle 
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
module singleCycle(input clk, input reset, output [31:0] result, output [31:0] inPc1);
	//Write your code here
	//reg [31:0] outPc=32'h00000000;
	reg [31:0] outPc;
	always @(posedge clk or posedge reset)
	begin   
      if(reset)
           outPc <= 32'd0;  
     
		else
           outPc <= inPc1;  
	end  
	
	//wire decOut1b;
	////wire [31:0] inPc;
	//wire [31:0] outPc;
	//store value of in pc to outpc
	//register32bit PC(clk, reset, 1'b1, 1'b1, 32'h00000000, outPc);
	wire [31:0] pcin_pluse_4;
	//inc value of outpc
	assign pcin_pluse_4 = outPc + 32'd4; 
	//adder adder1(outPc, 32'd4, adder1Out);
	wire [31:0] IR;
	//To get the instruction which we want to execute
	instruction_memory im(clk, reset, outPc[6:2],1'b1, IR);
	
	
	
	
	/*wire [3:0] aluCtrl;
	wire [1:0] memtoreg;
	wire branch;
	wire jump;
	wire [1:0] regDest;
	wire regWrite;
	wire aluSrcB;
	controlCircuit ckt (IR[31:26],IR[5:0], aluCtrl, memtoreg, branch, jump, regDest, regWrite, aluSrcB);*/
	wire branch    ,jump      ,mem_write    ,regWrite ,aluSrcB;
	wire [ 2:0] aluCtrl;
	wire [ 1:0] memtoreg;
	wire [1:0]regDest_signal;
	//genrate the control signal based on opcode IR[31:26] & funcode IR[5:0]
	// output is aluCtrl, memtoreg, branch, jump, regDest, reg Write,aluSrcB
	controller ckt (IR,branch    ,jump      ,memtoreg,mem_write ,regDest_signal   ,regWrite , aluCtrl,aluSrcB);
	
	
	wire [4:0] rd; 
	//regtarget value from IR[16:20] for R/I type
	//regDes value from IR[11:15] for R-type
	//how to set the value of regDest
	//this might be after control signal
	mux4to1_5bits mux_rd(IR[20:16], IR[15:11],5'd31, 5'd31 ,regDest_signal[1:0], rd); 
	//to get the value of Register source
	wire [31:0] regRs;
	//to get the value of Register Target
	wire [31:0] regRt;
	wire [31:0] fresult ;//frist result [previous stage result]
	//get the value of destination add 
	//set the value of regRs from IR[25:21]
	//set the value of regRt from IR[20:16]
	//set the reg fresult value to some of register on rd value
	//registerFile RegisterFile(clk, reset, regWrite, IR[25:21], IR[20:16], rd,fresult, regRs, regRt); 
	regfile1 RegisterFile(clk,IR[25:21], IR[20:16], regRs, regRt,regWrite, rd,fresult);
	wire [31:0] signExtIn;
	
	// We perform signExtend of IR[15:0] for I-type
	signExt16to32 signExtend( IR[15:0], signExtIn); 

	wire [31:0] ALUinp;
	// what we have to select for ALUinp signExtIn or regRt in ALUinp based on aluSrcB
	mux2to1_32bits mux_alu_inp(regRt, signExtIn, aluSrcB, ALUinp); 
	wire zero;
	wire sign1 ; 
	//wire [31:0] result;
	//based on aluCtrl we perfrom operation of regRs and ALUinp and store the result in result 
	//zero and sign1 are flag that is also set according to opration
	ALU alu(regRs, ALUinp, aluCtrl, result, zero, sign1);  
	wire [31:0] muxout1 ; 
	wire [31:0] mem_read_data;
	
	//alu result
	 dmem datamem(.clk(clk),.we(mem_write),.add(result),  
 .data(regRt),  
 .rd(mem_read_data)); 
	
	//based on signl we will select 32-0's or 32-1's in muxoutl
	mux2to1_32bits muxf (32'd0,32'd1,sign1,muxout1);
	//based on memtoreg we will select adderlout ,result, muxoutl and 32'd0
	//
	
	//change
	//mux4to1_32bits muxx (pcin_pluse_4,result1, muxout1 ,32'd0, memtoreg, fresult);
	mux4to1_32bits muxx (result,regRt,pcin_pluse_4 ,32'd0, memtoreg, fresult);
	wire [31:0] PCBranch;
	wire [31:0] signExtIn_shift;
	
	assign signExtIn_shift = signExtIn<<2; 
	// we will add adder1Out and adder2Inp to get adder2Out
	//to update pc
	adder adder2(pcin_pluse_4, signExtIn_shift, PCBranch); 
	wire [31:0] PCSrc_out;
	//wire zero;
	assign PCSrc = zero & branch;
	//based on mux2Select we will select adder1Out or adder2Out in mux2Out
	//mux2Select=1 PCsrc
	mux2to1_32bits mux_2(pcin_pluse_4, PCBranch, PCSrc, PCSrc_out); 
	//based on  jump we will select mux2Out or {adder1Out[31:28],{IR[25:0],2'b00}} in inPc
	wire [31:0] inPc;
	mux2to1_32bits mux_1(PCSrc_out, {pcin_pluse_4[31:28],{IR[25:0],2'b00}}, jump, inPc);
	//assign result=rd;
	assign inPc1=inPc;
endmodule

