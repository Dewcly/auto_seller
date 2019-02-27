`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/27 15:58:31
// Design Name: 
// Module Name: main_th
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

module main_th(); 
  reg  clk,reset,cancel,coin1,coin10,good1,good2;
  wire hold_ind,drinktk_ind,charge_ind;
  wire [7:0] SEG,AN;
  
  main main1(clk,reset,cancel,coin1,coin10,good1,good2,hold_ind,drinktk_ind,charge_ind,SEG,AN);
  always #1 clk=~clk;
  initial begin
  reset<=0;
  cancel<=0;
  coin1<=0;
  coin10<=0;
  good1<=0;
  good2<=0;
  #200 coin1<=1;
//  #200 coin1<=0;
//  #200 coin10<=1;
//  #200 coin10<=0;
  end
  
endmodule
