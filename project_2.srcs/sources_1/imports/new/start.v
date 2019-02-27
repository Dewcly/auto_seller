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

module divider(clk, clk_N); //分频器
    input clk; // 系统时钟
    output reg clk_N; // 分频后的时钟
    parameter reg [63:0] N = 5000; // 1Hz的时钟,N=fclk/fclk_N
    reg [31:0] counter; /* 计数器变量，通过计数实现分频。
                         当计数器从0计数到(N/2-1)时，
                         输出时钟翻转，计数器清零*/
    always @(posedge clk) begin  // 时钟上升沿
        counter = counter + 1;
        if (counter >= (N / 2 - 1)) begin
            clk_N = ~clk_N;
            counter = 0;
        end
    end                    
endmodule


