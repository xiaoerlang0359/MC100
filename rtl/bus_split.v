`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/16 16:09:00
// Design Name: 
// Module Name: bus_split
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


module bus_split(
// fifo interface
    input fifo_sof,
    input fifo_eof,
    input fifo_valid,
    input [15:0] fifo_addr,
    input fifo_read,
    input [7:0] fifo_wdata,
    output fifo_ready,
    output [7:0] fifo_rdata,
// register file interface
    output reg_sof,
    output reg_eof,
    output reg_valid,
    output [15:0] reg_addr,
    output reg_read,
    output [7:0] reg_wdata,
    input reg_ready,
    input [7:0] reg_rdata,
// watchdog interface
    output wd_sof,
    output wd_eof,
    output wd_valid,
    output [15:0] wd_addr,
    output wd_read,
    output [7:0] wd_wdata,
    input wd_ready,
    input [7:0] wd_rdata,
// esi interface
    output esi_sof,
    output esi_eof,
    output esi_valid,
    output [15:0] esi_addr,
    output esi_read,
    output [7:0] esi_wdata,
    input esi_ready,
    input [7:0] esi_rdata,
// mii interface
    output mii_sof,
    output mii_eof,
    output mii_valid,
    output [15:0] mii_addr,
    output mii_read,
    output [7:0] mii_wdata,
    input mii_ready,
    input [7:0] mii_rdata,
// fmmu interface
    output fmmu_sof,
    output fmmu_eof,
    output fmmu_valid,
    output [15:0] fmmu_addr,
    output fmmu_read,
    output [7:0] fmmu_wdata,
    input fmmu_ready,
    input [7:0] fmmu_rdata,
// sm interface
    output sm_sof,
    output sm_eof,
    output sm_valid,
    output [15:0] sm_addr,
    output [7:0] sm_wdata,
    output sm_read,
    input sm_ready,
    input [7:0] sm_rdata,
// dc interface
    output dc_sof,
    output dc_eof,
    output dc_valid,
    output [15:0] dc_addr,
    output [7:0] dc_wdata,
    output dc_read,
    input [7:0] dc_rdata,
    input dc_ready
    );
localparam REG_UPLIMIT = 16'h0320;
localparam WD_UPLIMIT = 16'h0450;
localparam ESI_UPLIMIT = 16'h0510;
localparam MII_UPLIMIT = 16'h0530;
localparam FMMU_UPLIMIT = 16'h0700;
localparam SM_UPLIMIT = 16'h0900;
localparam DC_UPLIMIT = 16'h0fff;
// sof eof
assign reg_sof = fifo_sof;
assign reg_eof = fifo_eof;
assign wd_sof = fifo_sof;
assign wd_eof = fifo_eof;
assign esi_sof = fifo_sof;
assign esi_eof = fifo_eof;
assign mii_sof = fifo_sof;
assign mii_eof = fifo_eof;
assign fmmu_sof = fifo_sof;
assign fmmu_eof = fifo_eof;
assign sm_sof = fifo_sof;
assign sm_eof = fifo_eof;
assign dc_sof = fifo_sof;
assign dc_eof = fifo_eof;
// addr hit
wire less_than_reg = fifo_addr < REG_UPLIMIT;
wire less_than_wd = fifo_addr < WD_UPLIMIT;
wire less_than_esi = fifo_addr < ESI_UPLIMIT;
wire less_than_mii = fifo_addr < MII_UPLIMIT;
wire less_than_fmmu = fifo_addr < FMMU_UPLIMIT;
wire less_than_sm = fifo_addr < SM_UPLIMIT;
wire less_than_dc = fifo_addr < DC_UPLIMIT;
wire reg_hit = less_than_reg;
wire wd_hit = ~less_than_reg & less_than_wd;
wire esi_hit = ~less_than_wd & less_than_esi;
wire mii_hit = ~less_than_esi & less_than_mii;
wire fmmu_hit = ~less_than_mii & less_than_fmmu;
wire sm_hit = ~less_than_fmmu & less_than_sm;
wire dc_hit = ~less_than_sm & less_than_dc;
// valid
assign reg_valid = reg_hit & fifo_valid;
assign wd_valid = wd_hit & fifo_valid;
assign esi_valid = esi_hit & fifo_valid;
assign mii_valid = mii_hit & fifo_valid;
assign fmmu_valid = fmmu_hit & fifo_valid;
assign sm_valid = sm_hit & fifo_valid;
assign dc_valid = dc_hit & fifo_valid;
wire reg_valid_r;
wire wd_valid_r;
wire esi_valid_r;
wire mii_valid_r;
wire fmmu_valid_r;
wire sm_valid_r;
wire dc_valid_r;
gnrl_dffr #(1,1'b0) reg_valid_dffr(reg_valid,reg_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) wd_valid_dffr(wd_valid,wd_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) esi_valid_dffr(esi_valid,esi_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) mii_valid_dffr(mii_valid,mii_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) fmmu_valid_dffr(fmmu_valid,fmmu_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) sm_valid_dffr(sm_valid,sm_valid_r,clk,rst_n);
gnrl_dffr #(1,1'b0) dc_valid_dffr(dc_valid,dc_valid_r,clk,rst_n);
// addr
assign reg_addr = {16{reg_hit}} & fifo_addr;
assign wd_addr = {16{wd_hit}} & fifo_addr;
assign esi_addr = {16{esi_hit}} & fifo_addr;
assign mii_addr = {16{mii_hit}} & fifo_addr;
assign fmmu_addr = {16{fmmu_hit}} & fifo_addr;
assign sm_addr = {16{sm_hit}} & fifo_addr;
assign dc_addr = {16{dc_hit}} & fifo_addr;
// wdata
assign reg_wdata = fifo_wdata;
assign wd_wdata = fifo_wdata;
assign esi_wdata = fifo_wdata;
assign mii_wdata = fifo_wdata;
assign fmmu_wdata = fifo_wdata;
assign sm_wdata = fifo_wdata;
assign dc_wdata = fifo_wdata;
// read
assign reg_read = reg_hit & fifo_read;
assign wd_read  = wd_hit & fifo_read;
assign esi_read = esi_hit & fifo_read;
assign mii_read = mii_hit & fifo_read;
assign fmmu_read = fmmu_hit & fifo_read;
assign sm_read = sm_hit & fifo_read;
assign dc_read = dc_hit & fifo_read;
// ready
assign fifo_ready = (reg_valid_r & reg_ready) | (wd_valid_r & wd_ready) |
                    (esi_valid_r & esi_ready) | (mii_valid_r & mii_ready) |
                    (fmmu_valid_r & fmmu_ready) | (sm_valid_r & sm_ready) |
                    (dc_valid & dc_ready);
assign fifo_rdata = ({8{reg_valid_r}} & reg_rdata) |
                    ({8{wd_valid_r}} & wd_rdata)   |
                    ({8{esi_valid_r}} & esi_rdata) |
                    ({8{mii_valid_r}} & mii_rdata) |
                    ({8{fmmu_valid_r}} & fmmu_rdata) |
                    ({8{sm_valid_r}} & sm_rdata) | ({8{dc_valid_r}} & dc_rdata);
endmodule
