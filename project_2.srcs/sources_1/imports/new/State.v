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
   input reset; //信号清零自动售货机关闭
   input clk; //时钟信号
   input cancel;  //操作取消并回到“Hello”
   input coin1;  //投币1元
   input coin10; //投币10元
   input good1;  //选择购买2.5元商品
   input good2;  //选择购买5元商品
   
   output reg hold_ind; //售货机占用指示灯
   output reg drinktk_ind; //取饮料指示灯
   output reg charge_ind; //找零指示灯
   output reg [3:0] n_state;  //当前状态
   output reg [3:0] coin_val = 0;  //已经投入的钱
   output reg [3:0] charge_val = 0; //找零的钱
    reg [3:0] next_state;  //状态机跳转的状态
    reg [31:0] count; //用于延迟的计数器
    wire clk_J,clk_M;
    reg [3:0] S0,S1,S2,S3,S4,S5,S6,S7,S8,S9;
    divider #(100_000_000) (clk,clk_J);
    divider #(2_000_000) (clk,clk_M);
    initial begin  //初始化
    hold_ind=0;
    drinktk_ind=0;
    charge_ind=0;
    coin_val=0;
    charge_val=0;
    S0=4'b0000;//Hello状态
    S1=4'b0001;  //输入1元的状态
    S2=4'b0010;  //输入2元的状态
    S3=4'b0011;  //输入3元的状态
    S4=4'b0100;  //输入4元的状态
    S5=4'b0101;  //输入5元的状态
    S6=4'b0110;  //输入10元的状态
    S7=4'b0111;  //关闭清零的状态
    S8=4'b1000;  //买完东西找钱状态
    S9=4'b1001;  //取消操作退钱状态
    n_state=4'b0111; //状态初始化
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
            charge_val<=4'b0000;//初始化找零为0
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
               charge_val<=4'b0001;  //找零0.5元
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
                charge_val<=4'b0011;//找零1.5元
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
                  charge_val<=4'b0101;//找零2.5元
                  end
                else if(good2)
                  begin
                  next_state<=S8;
                  charge_val<=4'b0000;//找零0.0元
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
                  charge_val<=4'b1111;//找零7.5元
                  end
                else if(good2)
                  begin
                  next_state<=S8;
                  charge_val<=4'b1010;//找零5.0元
                  end
                else if(cancel)
                  begin
                  charge_ind<=1;
                  next_state<=S9;
                  end
                end  
           S7: //关闭状态
             begin
             hold_ind<=0;
             drinktk_ind<=0;
             charge_ind<=0;
             next_state<=S0;
             end
             
           S8: //买完东西找钱状态
             begin
             hold_ind<=1;
             drinktk_ind<=1;
             charge_ind<=1;
             count=count+1;
             if(count>=150) begin
             next_state<=S0;end
             end
             
           S9: //取消操作退钱状态
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
