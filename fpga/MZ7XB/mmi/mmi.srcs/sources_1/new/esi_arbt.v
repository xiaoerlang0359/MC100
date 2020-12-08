`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 19:37:42
// Design Name: 
// Module Name: esi_arbt
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


module esi_arbt(
// ecat interface
    input ecat_sof,
    input ecat_eof,
    input ecat_valid,
    input [15:0] ecat_addr,
    input [7:0] ecat_wdata,
    input ecat_read,
    output ecat_ready,
    output [7:0] ecat_rdata,
// pdi interface
    input pdi_valid,
    input [15:0] pdi_addr,
    input [7:0] pdi_wdata,
    input pdi_read,
    output pdi_ready,
    output [7:0] pdi_rdata,
// fifo interface
    output sof,
    output eof,
    output valid,
    output [15:0] addr,
    output [7:0] wdata,
    output read,
    input ready,
    input [7:0] rdata           
    );
assign ecat_ready = ready;
assign pdi_ready = ~ready;
assign ecat_rdata = rdata;
assign pdi_rdata = rdata;
assign valid = (ready)? ecat_valid: pdi_valid;
assign addr = (ready)? ecat_addr: pdi_addr;
assign wdata = (ready)? ecat_wdata: pdi_wdata;
assign read = (ready)? ecat_read: pdi_read;
assign sof = ecat_sof;
assign eof = ecat_eof;
endmodule
