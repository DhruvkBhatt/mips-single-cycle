`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:19:30 03/14/2020 
// Design Name: 
// Module Name:    Ari 
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

//convert 16 bit to32 bit
module signExt16to32(input [15:0] in, output [31:0] signExtIn);
	
	mux2to1_32bits m1({16'h00000000,in[15:0]},{16'hffffffff,in[15:0]},in[15],signExtIn);
	
endmodule




//1-bit full adder
module fa (input wire i0, i1, cin, output wire sum, cout);
   wire t0, t1, t2;
   xor _i0 (sum,i0, i1, cin );
   and _i1 (t0,i0, i1);
   and _i2 (t1,i1, cin);
   and _i3 (t2,cin, i0);
   or _i4 (cout,t0, t1, t2);
endmodule

//32-bit adder 
module adder(a,b,sum);
	input [31:0] a,b;
	output [31:0]sum;
	wire cout;
	wire [31:0] q;
	fa fa1(a[0],b[0],1'b0,sum[0],q[0]);
	fa fa2(a[1],b[1],q[0],sum[1],q[1]);
	fa fa3(a[2],b[2],q[1],sum[2],q[2]);
	fa fa4(a[3],b[3],q[2],sum[3],q[3]);
	fa fa5(a[4],b[4],q[3],sum[4],q[4]);
	fa fa6(a[5],b[5],q[4],sum[5],q[5]);
	fa fa7(a[6],b[6],q[5],sum[6],q[6]);
	fa fa8(a[7],b[7],q[6],sum[7],q[7]);
	fa fa9(a[8],b[8],q[7],sum[8],q[8]);
	fa fa10(a[9],b[9],q[8],sum[9],q[9]);
	fa fa11(a[10],b[10],q[9],sum[10],q[10]);
	fa fa12(a[11],b[11],q[10],sum[11],q[11]);
	fa fa13(a[12],b[12],q[11],sum[12],q[12]);
	fa fa14(a[13],b[13],q[12],sum[13],q[13]);
	fa fa15(a[14],b[14],q[13],sum[14],q[14]);
	fa fa16(a[15],b[15],q[14],sum[15],q[15]);
	fa fa17(a[16],b[16],q[15],sum[16],q[16]);
	fa fa18(a[17],b[17],q[16],sum[17],q[17]);
	fa fa19(a[18],b[18],q[17],sum[18],q[18]);
	fa fa20(a[19],b[19],q[18],sum[19],q[19]);
	fa fa21(a[20],b[20],q[19],sum[20],q[20]);
	fa fa22(a[21],b[21],q[20],sum[21],q[21]);
	fa fa23(a[22],b[22],q[21],sum[22],q[22]);
	fa fa24(a[23],b[23],q[22],sum[23],q[23]);
	fa fa25(a[24],b[24],q[23],sum[24],q[24]);
	fa fa26(a[25],b[25],q[24],sum[25],q[25]);
	fa fa27(a[26],b[26],q[25],sum[26],q[26]);
	fa fa28(a[27],b[27],q[26],sum[27],q[27]);
	fa fa29(a[28],b[28],q[27],sum[28],q[28]);
	fa fa30(a[29],b[29],q[28],sum[29],q[29]);
	fa fa31(a[30],b[30],q[29],sum[30],q[30]);
	fa fa32(a[31],b[31],q[30],sum[31],cout);
endmodule

