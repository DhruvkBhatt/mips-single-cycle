`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:23:04 03/14/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(       
      input          [31:0]aluIn1,          //src1  
      input          [31:0]aluIn2,          //src2  
      input          [2:0]     alu_control,     //function sel  
      output     reg     [31:0]     aluOut,          //result       
      output zero  ,//set zero bit
		output sign1	//set sign1 bit
   );  
 always @(*)  
 begin   
      case(alu_control)  
			3'b010: aluOut = (aluIn1 + aluIn2); //ADD 20
			3'b110: aluOut = (aluIn1 - aluIn2); //SUB 22
			3'b000: aluOut = (aluIn1 & aluIn2); //AND 24
         3'b001: aluOut = (aluIn1 | aluIn2); //OR 25
			3'b111: aluOut = (aluIn1 < aluIn2)?1:0; //SLT 2A
     /* 3'b100: begin if (a<b) result = 16'd1;  
                     else result = 16'd0;  
                     end  */
      default:aluOut =aluIn1 +aluIn2; // add  
      endcase  
 end  
 assign zero = (aluOut==32'd0) ? 1'b1: 1'b0;
 assign sign1 = (aluIn1<aluIn2) ? 1'b1: 1'b0;    
endmodule  
