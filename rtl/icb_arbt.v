`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/02 13:17:37
// Design Name: 
// Module Name: icb_arbt
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


module icb_arbt(
// arbt output icb interface
    output o_icb_cmd_valid,
    input o_icb_cmd_ready,
    output o_icb_cmd_read,
    output [15:0] o_icb_cmd_addr,
    output [7:0] o_icb_cmd_wdata,
    output arbt_src, // 1 for ecat, 0 for pdi
    
    input o_icb_rsp_valid,
    output o_icb_rsp_ready,
    input o_icb_rsp_err,
// ecat icb interface
    input ecat_sof,
    input ecat_eof,
    output ecat_icb_cmd_ready,
    input ecat_icb_cmd_valid,
    input ecat_icb_cmd_read,
    input [15:0] ecat_icb_cmd_addr,
    input [7:0] ecat_icb_cmd_wdata,
    
    output ecat_icb_rsp_valid,
    input ecat_icb_rsp_ready,
    output ecat_icb_rsp_err,
// pdi icb interface
    output pdi_icb_cmd_ready,
    input pdi_icb_cmd_valid,
    input pdi_icb_cmd_read,
    input [15:0] pdi_icb_cmd_addr,
    input [7:0] pdi_icb_cmd_wdata,
    
    output pdi_icb_rsp_valid,
    input pdi_icb_rsp_ready,
    output pdi_icb_rsp_err,
// system interface
    input clk,
    input rst_n
    );
wire arbt_src_r;
wire arbt_src_nxt = (ecat_sof)? 1'b1:
                    (ecat_eof)? 1'b0:1'b1;
wire arbt_src_ena = ecat_sof | ecat_eof;
gnrl_dfflr #(1,1'b1) arbt_src_dfflr(arbt_src_ena,arbt_src_nxt,arbt_src_r,clk,rst_n);
assign arbt_src = arbt_src_r;
///////////////////////////////////////////////
// arbt output icb interface
///////////////////////////////////////////////
assign o_icb_cmd_valid = (ecat_sof)? 1'b0:
                          (arbt_src)? ecat_icb_cmd_valid:pdi_icb_cmd_valid;
assign o_icb_cmd_read = (arbt_src)? ecat_icb_cmd_read:pdi_icb_cmd_read;
assign o_icb_cmd_addr = ({16{arbt_src}} & ecat_icb_cmd_addr) |
                        ({16{~arbt_src}} & pdi_icb_cmd_addr);
assign o_icb_cmd_wdata = ({8{arbt_src}} & ecat_icb_cmd_wdata) |
                         ({8{~arbt_src}} & pdi_icb_cmd_addr);
assign o_icb_rsp_ready = (arbt_src & ecat_icb_rsp_ready) |
                         ((~arbt_src) & pdi_icb_rsp_ready);
///////////////////////////////////////////////
// ecat icb interface
/////////////////////////////////////////////// 
assign ecat_icb_cmd_ready = arbt_src & o_icb_cmd_ready;
assign ecat_icb_rsp_valid = arbt_src & o_icb_rsp_valid;
assign ecat_icb_rsp_err = arbt_src & o_icb_rsp_err;
///////////////////////////////////////////////
// pdi icb interface
///////////////////////////////////////////////
assign pdi_icb_cmd_ready = (~arbt_src) & (~ecat_sof) & o_icb_cmd_ready;
assign pdi_icb_rsp_valid = (~arbt_src) & o_icb_rsp_valid;
assign pdi_icb_rsp_err = (~arbt_src) & o_icb_rsp_err;
                        
endmodule
