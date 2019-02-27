`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/20 14:46:48
// Design Name: 
// Module Name: main
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
module main(clk,reset,cancel,coin1,coin10,good1,good2,hold_ind,drinktk_ind,charge_ind,SEG,AN);
   input reset;//信号清零自动售货机关闭
   input clk;//时钟信号
   input cancel;//操作取消并回到"Hello"
   input coin1;//投币1元
   input coin10;//投币10元
   input good1;//选择购买2.5元商品
   input good2;//选择购买5元商品
   output  hold_ind;//售货机占用指示灯
   output  drinktk_ind;//取饮料指示灯
   output  charge_ind;//找零指示灯
   output [7:0] SEG,AN;//数码管显示控制

   wire [3:0] coin_v; //已经投入的钱
   wire [3:0] charge_v;//找零的钱
   wire [4:0] state; //状态机所处的状态
   parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001;
   State S(reset,clk,cancel,coin1,coin10,good1,good2,hold_ind,drinktk_ind,charge_ind,coin_v,charge_v,state);
   display D(clk,state,coin_v,charge_v,reset,cancel,good1,good2,SEG,AN);
      // 功能实现
endmodule
