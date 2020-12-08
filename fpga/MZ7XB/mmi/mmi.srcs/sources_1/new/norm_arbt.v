`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 10:48:03
// Design Name: 
// Module Name: norm_arbt
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


module norm_arbt(
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
    output pdi_err,
// fifo interface
    output sof,
    output eof,
    output valid,
    output [15:0] addr,
    output [7:0] wdata,
    output src,
    output read,
    input ready,
    input [7:0] rdata,
    input alctrl_state,
// system interface
    input clk,
    input rst_n  
    );
wire src_r;
assign sof = ecat_sof;
assign eof = ecat_eof;
wire src_ena = sof | eof;
wire src_nxt = sof;
gnrl_dfflr #(1,1'b1) arbt_src_dfflr(src_ena,src_nxt,src_r,clk,rst_n);
assign src = src_r;
///////////////////////////////////////////////////
// fifo interface
///////////////////////////////////////////////////
assign valid = (src & ecat_valid) |
               ((~src) & (~sof) & pdi_valid);
assign read = (src & ecat_read) |
              ((~src) & pdi_read);
assign addr = ({16{src}} & ecat_addr) |
              ({16{~src}} & pdi_addr);
assign wdata= ({8{src}} * ecat_wdata) |
              ({8{~src}} & pdi_wdata);
///////////////////////////////////////////////////
// ecat interface
///////////////////////////////////////////////////
assign ecat_ready = src & ready;
assign ecat_rdata = {8{src}} & rdata;
///////////////////////////////////////////////////
assign pdi_ready = (~src) & ready;
assign pdi_rdata = {8{~src}} & rdata;
assign pdi_err = 1'b0;

endmodule
