`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 16:10:50
// Design Name: 
// Module Name: apb_bridge
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


module apb_bridge(
//apb interface
    input psel,
    input penable,
    input [31:0] paddr,
    input [31:0] pwdata,
    output [31:0] prdata,
    input pwrite,
    output pready,
    output pslverr,
//fifo interface
    output valid,
    output read,
    output [15:0] addr,
    output [7:0] wdata,
    input [7:0] rdata,
    input ready,
    input err,
//sys interface 
    input clk,
    input rst_n   
    );
wire [4:0] sft_op;
assign sft_op = {paddr[1:0],3'b000};
assign valid = psel;
assign read = ~pwrite;
assign addr = paddr[15:0];
assign wdata = (pwdata>>sft_op);
assign prdata = {rdata,rdata,rdata,rdata};
assign pready = ready;
assign pslverr = err;  
endmodule
