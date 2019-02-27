`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/21 08:46:39
// Design Name: 
// Module Name: start
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

module divider(clk, clk_N); //��Ƶ��
    input clk; // ϵͳʱ��
    output reg clk_N; // ��Ƶ���ʱ��
    parameter reg [63:0] N = 5000; // 1Hz��ʱ��,N=fclk/fclk_N
    reg [31:0] counter; /* ������������ͨ������ʵ�ַ�Ƶ��
                         ����������0������(N/2-1)ʱ��
                         ���ʱ�ӷ�ת������������*/
    always @(posedge clk) begin  // ʱ��������
        counter = counter + 1;
        if (counter >= (N / 2 - 1)) begin
            clk_N = ~clk_N;
            counter = 0;
        end
    end                    
endmodule


