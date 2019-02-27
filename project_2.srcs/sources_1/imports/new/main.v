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
   input reset;//�ź������Զ��ۻ����ر�
   input clk;//ʱ���ź�
   input cancel;//����ȡ�����ص�"Hello"
   input coin1;//Ͷ��1Ԫ
   input coin10;//Ͷ��10Ԫ
   input good1;//ѡ����2.5Ԫ��Ʒ
   input good2;//ѡ����5Ԫ��Ʒ
   output  hold_ind;//�ۻ���ռ��ָʾ��
   output  drinktk_ind;//ȡ����ָʾ��
   output  charge_ind;//����ָʾ��
   output [7:0] SEG,AN;//�������ʾ����

   wire [3:0] coin_v; //�Ѿ�Ͷ���Ǯ
   wire [3:0] charge_v;//�����Ǯ
   wire [4:0] state; //״̬��������״̬
   parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001;
   State S(reset,clk,cancel,coin1,coin10,good1,good2,hold_ind,drinktk_ind,charge_ind,coin_v,charge_v,state);
   display D(clk,state,coin_v,charge_v,reset,cancel,good1,good2,SEG,AN);
      // ����ʵ��
endmodule
