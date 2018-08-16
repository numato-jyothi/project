`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:48:39 06/21/2018 
// Design Name: 
// Module Name:    tfipflop 
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
module tflipflop(clk,rst,t,q,qb);
input clk,rst,t;
output q,qb;
reg q;
always@(posedge clk)
begin 
if(rst)
q =1'b0;

else
if(t==0)

#100 q = q;


else
#100 q =~q;
end
assign qb=~q;


endmodule
