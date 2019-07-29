`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.01.2019 13:21:17
// Design Name: 
// Module Name: freq_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module freq_cal(
       input clk100,
       input clk_un,
       input reset,
       output reg fout,
       output reg valid,
       output reg slave_register0
     );
       
    reg [31:0]count = 0;
    reg [31:0]count2 = 0;
         
  always @(posedge clk100 )
    begin
      if ( reset == 1'b0 )
       begin
        count <= 0;
      end  
      else if( count <= 100000000)
      begin
        count <= count + 1;
      end
    end
    
    always @(posedge clk_un)
    begin
      if ( reset == 1'b0 )
           begin
           count2 <= 0;
          end  
      else if( count <= 100000000)
                begin
                 count2 <= count2 + 1;
      end           
      else if(count == 100000000)
       begin 
        fout <= count2;
        valid <= 1;
   end
   
end
     
  always @ (posedge clk100)  
  begin
    if (valid)
        slave_register0 <= fout;
  end
  
 endmodule