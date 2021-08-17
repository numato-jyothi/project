`timescale 1ns / 1ps

module simple_uart #(
  parameter clk_bit = 625
)
(
  input clk,
  input rst,
  input sw,
  
 output reg out
);

parameter [1:0] idle      =  2'b00,
                tx_start  =  2'b01,
                tx_data   =  2'b10,
                tx_stop   =  2'b11;

reg [1:0] current_state = idle;
reg [31:0] cnt = 0;
reg txd;
reg [3:0] uartin_index = 1'b0;   
wire [7:0] uart_in;

assign uart_in = "R"; 
   
always@(posedge clk, negedge rst)begin
if(rst == 1'b0)begin
  current_state<=idle;
  cnt<=0;
  out<=1'b0;
  txd<=1'b0;
end else begin

  case(current_state)
    
    idle: begin
      out <= 1'b1;
      txd <= 1'b0;
      cnt <= 0;
      if (sw == 1'b1) begin
        current_state <= tx_start;
      end else begin
        current_state <= idle;
      end
    end
    
    tx_start: begin
      out <= 1'b0;
      txd <= 1'b0;
      cnt <= 0;
      if(cnt < clk_bit-1) begin
        cnt <= cnt + 1;
        current_state <= tx_start;
      end else begin
        cnt <= 0;
        current_state <= tx_data;
      end
    end
    
    tx_data: begin
      out <= uart_in[uartin_index];
      if(cnt < clk_bit-1) begin
        cnt <= cnt + 1;
        current_state <= tx_data;
      end else begin
        cnt <= 0;
        if(uartin_index < 8) begin
          uartin_index <= uartin_index + 1'b1;
          current_state <= tx_data;
        end else begin
          current_state <= tx_stop;
          uartin_index <= 0;
        end 
      end
    end
   
    tx_stop: begin
      out <= 1'b1;
      txd <= 1'b1;
      if(cnt < clk_bit-1) begin
        cnt <= cnt + 1;
        current_state <= tx_stop;
      end else begin
        cnt <= 0;
        current_state <= idle;
      end
    end 

  endcase
  
end
end

endmodule
