`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/23 15:53:30
// Design Name: 
// Module Name: display
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

module display(clk,n_state,coin_val,charge_val,reset,cancel,good1,good2,patt,sel);
   input clk;  //系统时钟
   input cancel;  //操作取消并回到"Hello"
   input reset;  //信号清零自动售货机关闭
   input good1;  //选择购买2.5元商品
   input good2;  //选择购买5元商品
   
   input [3:0] coin_val;
   input [3:0] charge_val;
   input [3:0] n_state;
   output reg[7:0] patt,sel;
   reg [3:0] sta;
   wire clk_M;
   parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001;
   initial begin
      sta = 4'b0000;
      patt=8'b11111111;
      sel=8'b11111111;
   end
   divider #(4_000_00) (clk,clk_M);
   
   always@(posedge clk_M)
   begin if(reset==0) begin
   case(sta)
     4'b0000:
       begin
       patt=8'b11111111;
       sel=8'b10111111;
       if(n_state==4'b0000) begin
       patt=8'b10001001;end  //2号管显示H
       else if(n_state==4'b1001&&coin_val==4'b1010) begin
       patt=8'b11111001;end  //2号管显示1
       else patt=8'b11111111;
       sta=4'b0101;
       end
     4'b0101:
       begin  
       patt=8'b11111111;
       sel=8'b11011111;
       if(n_state==4'b0000)begin
       patt=8'b10000110;end  //3号管显示E
       else if((n_state==4'b1001&&coin_val==4'b1010)||(n_state==4'b1000&&charge_val==4'b0001)||(n_state==4'b1000&&charge_val==4'b0000))begin
       patt=8'b01000000;end  //3号管显示0.
       else if((n_state==4'b1001&&coin_val==4'b0001)||(n_state==4'b1000&&charge_val==4'b0011))begin
       patt=8'b01111001;end  //3号管显示1.
       else if((n_state==4'b1001&&coin_val==4'b0010)||(n_state==4'b1000&&charge_val==4'b0101))begin
       patt=8'b00100100;end  //3号管显示2.
       else if(n_state==4'b1001&&coin_val==4'b0011)begin
       patt=8'b00110000;end  //3号管显示3.
       else if(n_state==4'b1001&&coin_val==4'b0100)begin
       patt=8'b00011001;end  //3号管显示4.
       else if((n_state==4'b1001&&coin_val==4'b0101)||(n_state==4'b1000&&charge_val==4'b1010))begin
       patt=8'b00010010;end  //3号管显示5.
       else if(n_state==4'b1000&&charge_val==4'b1111)begin
       patt=8'b01111000;end  //3号管显示7.
       else patt=8'b11111111;
       sta=4'b0111;
       end
     4'b0111:
       begin 
       patt=8'b11111111;
       sel=8'b11101111;
       if(n_state==4'b0000)begin
       patt=8'b11000111;end  //4号管显示L
       else if(((n_state==4'b1001)&&((coin_val==4'b0001)||(coin_val==4'b0010)||(coin_val==4'b0011)||(coin_val==4'b0100)||(coin_val==4'b0101)||(coin_val==4'b1010)))||(n_state==4'b1000&&charge_val==4'b0000)||(n_state==4'b1000&&charge_val==4'b1010))begin
       patt=8'b11000000;end  //4号管显示0
       else if((n_state==4'b1000)||(n_state==4'b1001)||(n_state==4'b1010)||(n_state==4'b1100))begin
       patt=8'b10010010;end  //4号管显示5
       else patt=8'b11111111;
       sta=4'b1000;
       end
     4'b1000:
       begin 
       patt=8'b11111111;
       sel=8'b11110111;
       if(n_state==4'b0000)begin
       patt=8'b11000111;end  //5号管显示L
       else if(n_state==4'b0110)begin
       patt=8'b11111001;end  //5号管显示1
       else patt=8'b11111111;
       sta=4'b1001;
       end
     4'b1001:
       begin   
       patt=8'b11111111;
       sel=8'b11111011;
       if(n_state==4'b0000||n_state==4'b0110)begin
       patt=8'b11000000;end  //6号管显示O
       else if(n_state==4'b0001)begin
       patt=8'b11111001;end  //6号管显示1
       else if(n_state==4'b0010)begin
       patt=8'b10100100;end  //6号管显示2
       else if(n_state==4'b0011)begin 
       patt=8'b10110000;end  //6号管显示3
       else if(n_state==4'b0100)begin
       patt=8'b10011001;end  //6号管显示4
       else if(n_state==4'b0101)begin
       patt=8'b10010010;end  //6号管显示5
       else patt=8'b11111111;  
       sta=4'b0000;
       end
       endcase   
       end
       else sel=8'b11111111;
       end
endmodule
