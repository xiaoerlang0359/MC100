`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 13:29:53
// Design Name: 
// Module Name: gnrl_dffs
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


module gnrl_dfflr #(
    parameter DW = 32,
    parameter RV = {DW{1'b0}}
)(
    input lden,
    input [DW-1:0] dnxt,
    output [DW-1:0] qout,
    
    input clk,
    input rst_n
    );
reg [DW-1:0] qout_r;
always @(posedge clk or negedge rst_n)
begin: DFFLRS_RPOC
    if (rst_n == 1'b0)
        qout_r <= RV;
    else if (lden == 1'b1)
        qout_r <= dnxt;
end

assign qout = qout_r;

endmodule



module gnrl_dffl #(
    parameter DW=32
)(
    input lden,
    input [DW-1:0] dnxt,
    output [DW-1:0] qout,
    input clk
 );
 reg [DW-1:0] qout_r;
 
 always @(posedge clk)
 begin : DFFL_PROC
    if (lden == 1'b1)
        qout_r <= dnxt;
 end
 
 assign qout = qout_r;
 endmodule
 
 
 module gnrl_dffr #(
    parameter DW = 32,
    parameter RV = {DW{1'b0}}
 ) (
    input [DW-1:0] dnxt,
    output [DW-1:0] qout,
    
    input clk,
    input rst_n
);

reg [DW-1:0] qout_r;

always @(posedge clk or negedge rst_n)
begin: DFFRS_PROC
    if (rst_n==1'b0)
        qout_r <= RV;
    else
        qout_r <= dnxt;
end

assign qout = qout_r;

endmodule
