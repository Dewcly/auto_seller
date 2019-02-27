`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/21 08:47:00
// Design Name: 
// Module Name: State
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

module State(reset,clk,cancel,coin1,coin10,good1,good2,hold_ind,drinktk_ind,charge_ind,coin_val,charge_val,n_state);
   input reset; //�ź������Զ��ۻ����ر�
   input clk; //ʱ���ź�
   input cancel;  //����ȡ�����ص���Hello��
   input coin1;  //Ͷ��1Ԫ
   input coin10; //Ͷ��10Ԫ
   input good1;  //ѡ����2.5Ԫ��Ʒ
   input good2;  //ѡ����5Ԫ��Ʒ
   
   output reg hold_ind; //�ۻ���ռ��ָʾ��
   output reg drinktk_ind; //ȡ����ָʾ��
   output reg charge_ind; //����ָʾ��
   output reg [3:0] n_state;  //��ǰ״̬
   output reg [3:0] coin_val = 0;  //�Ѿ�Ͷ���Ǯ
   output reg [3:0] charge_val = 0; //�����Ǯ
    reg [3:0] next_state;  //״̬����ת��״̬
    reg [31:0] count; //�����ӳٵļ�����
    wire clk_J,clk_M;
    reg [3:0] S0,S1,S2,S3,S4,S5,S6,S7,S8,S9;
    divider #(100_000_000) (clk,clk_J);
    divider #(2_000_000) (clk,clk_M);
    initial begin  //��ʼ��
    hold_ind=0;
    drinktk_ind=0;
    charge_ind=0;
    coin_val=0;
    charge_val=0;
    S0=4'b0000;//Hello״̬
    S1=4'b0001;  //����1Ԫ��״̬
    S2=4'b0010;  //����2Ԫ��״̬
    S3=4'b0011;  //����3Ԫ��״̬
    S4=4'b0100;  //����4Ԫ��״̬
    S5=4'b0101;  //����5Ԫ��״̬
    S6=4'b0110;  //����10Ԫ��״̬
    S7=4'b0111;  //�ر������״̬
    S8=4'b1000;  //���궫����Ǯ״̬
    S9=4'b1001;  //ȡ��������Ǯ״̬
    n_state=4'b0111; //״̬��ʼ��
    next_state=4'b0000;
    end
    always @(posedge clk_J or negedge reset) begin
    if(reset==1)
    n_state=4'b0111;
    else
    n_state=next_state;
    end
    
    always @(posedge clk_M)
    begin
     case(n_state)
       S0:
          begin
          count=0;
          coin_val<=0;
          if(!reset) begin
            hold_ind<=0;
            drinktk_ind<=0;
            charge_ind<=0;
            charge_val<=4'b0000;//��ʼ������Ϊ0
            if(coin1)
              begin
              next_state<=S1;
              end
            else if(coin10)
               begin
               next_state<=S6;;
               end
          end
          end
               
        S1:
           begin
             hold_ind<=1;
             drinktk_ind<=0;
             charge_ind<=0;
             coin_val=4'b0001;
             if(coin1)
               begin
               next_state<=S2;     
               end
             else if(cancel)
               begin
               charge_ind<=1;
               next_state<=S9;
               end
             end
     
        S2:
           begin
             hold_ind<=1;
             drinktk_ind<=0;
             charge_ind<=0;
             coin_val<=4'b0010;
             if(coin1)
               begin
               next_state<=S3;
               end
             else if(cancel)
               begin
               next_state<=S9;
               end
           end
          
         S3:
           begin
             hold_ind<=1;
             drinktk_ind<=0;
             charge_ind<=0;
             coin_val<=4'b0011;
             if(coin1)
               begin
               next_state<=S4;
               end
             else if(good1)
               begin
               next_state<=S8;
               charge_val<=4'b0001;  //����0.5Ԫ
               end
             else if(cancel)
               begin
               next_state<=S9;
               end
           end
           
                     
          S4:
            begin
              hold_ind<=1;
              drinktk_ind<=0;
              charge_ind<=0;
              coin_val=4'b0100;
              if(coin1)
                begin
                next_state<=S5; 
                end
              else if(good1)
                begin
                next_state<=S8;
                charge_val<=4'b0011;//����1.5Ԫ
                end
              else if(cancel)
                begin
                next_state<=S9;
                end
              end
            
            S5:
              begin
                hold_ind<=1;
                drinktk_ind<=0;
                charge_ind<=0;
                coin_val=4'b0101;
                if(good1)
                  begin
                  next_state<=S8;
                  charge_val<=4'b0101;//����2.5Ԫ
                  end
                else if(good2)
                  begin
                  next_state<=S8;
                  charge_val<=4'b0000;//����0.0Ԫ
                  end
                else if(cancel)
                  begin
                  next_state<=S9;
                  end
                end

            S6:
              begin
                hold_ind<=1;
                drinktk_ind<=0;
                charge_ind<=0;
                coin_val<=4'b1010;
                if(good1)
                  begin
                  next_state<=S8;
                  charge_val<=4'b1111;//����7.5Ԫ
                  end
                else if(good2)
                  begin
                  next_state<=S8;
                  charge_val<=4'b1010;//����5.0Ԫ
                  end
                else if(cancel)
                  begin
                  charge_ind<=1;
                  next_state<=S9;
                  end
                end  
           S7: //�ر�״̬
             begin
             hold_ind<=0;
             drinktk_ind<=0;
             charge_ind<=0;
             next_state<=S0;
             end
             
           S8: //���궫����Ǯ״̬
             begin
             hold_ind<=1;
             drinktk_ind<=1;
             charge_ind<=1;
             count=count+1;
             if(count>=150) begin
             next_state<=S0;end
             end
             
           S9: //ȡ��������Ǯ״̬
             begin
              hold_ind<=1;
              drinktk_ind<=0;
              charge_ind<=1;
              count=count+1;
              if(count>=150) begin
              next_state<=S0;end
              end
            endcase
           end      
endmodule
