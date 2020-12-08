`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/03 21:22:11
// Design Name: 
// Module Name: icb_split
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


module icb_split#(
    parameter SPLT_NUM = 4
)(
    input  [SPLT_NUM-1:0] i_icb_splt_indic,
// icb interface for split   
    input  i_icb_cmd_valid,
    output i_icb_cmd_ready,
    input  i_icb_cmd_read,
    input  [15:0] i_icb_cmd_addr,
    input  [7:0]  i_icb_cmd_wdata,
    
    output i_icb_rsp_valid,
    input  i_icb_rsp_ready,
    output i_icb_rsp_err,
// reg icb interface
    output reg_icb_cmd_valid,
    input  reg_icb_cmd_ready,
    output reg_icb_cmd_read,
    output [15:0] reg_icb_cmd_addr,
    output [7:0] reg_icb_cmd_wdata,
    
    input  reg_icb_rsp_valid,
    output reg_icb_rsp_ready,
    input  reg_icb_rsp_err,
// watch dog interface
    output wd_icb_cmd_valid,
    input  wd_icb_cmd_ready,
    output wd_icb_cmd_read,
    output [15:0] wd_icb_cmd_addr,
    output [7:0] wd_icb_cmd_wdata,
    
    input  wd_icb_rsp_valid,
    output wd_icb_rsp_ready,
    input  wd_icb_rsp_err,
// esi interface
    output esi_icb_cmd_valid,
    input  esi_icb_cmd_ready,
    output esi_icb_cmd_read,
    output [15:0] esi_icb_cmd_addr,
    output [7:0] esi_icb_cmd_wdata,
    
    input  esi_icb_rsp_valid,
    output esi_icb_rsp_ready,
    input  esi_icb_rsp_err,
// mii interface
    output mii_icb_cmd_valid,
    input  mii_icb_cmd_ready,
    output mii_icb_cmd_read,
    output [15:0] mii_icb_cmd_addr,
    output [7:0] mii_icb_cmd_wdata,
    
    input  mii_icb_rsp_valid,
    output mii_icb_rsp_ready,
    input  mii_icb_rsp_err, 
// fmmu interface
    output fmmu_icb_cmd_valid,
    input  fmmu_icb_cmd_ready,
    output fmmu_icb_cmd_read,
    output [15:0] fmmu_icb_cmd_addr,
    output [7:0] fmmu_icb_cmd_wdata,
    
    input  fmmu_icb_rsp_valid,
    output fmmu_icb_rsp_ready,
    input  fmmu_icb_rsp_err, 
// sm interface
    output sm_icb_cmd_valid,
    input  sm_icb_cmd_ready,
    output sm_icb_cmd_read,
    output [15:0] sm_icb_cmd_addr,
    output [7:0] sm_icb_cmd_wdata,
    
    input  sm_icb_rsp_valid,
    output sm_icb_rsp_ready,
    input  sm_icb_rsp_err, 
// dc interface
    output dc_icb_cmd_valid,
    input  dc_icb_cmd_ready,
    output dc_icb_cmd_read,
    output [15:0] dc_icb_cmd_addr,
    output [7:0] dc_icb_cmd_wdata,
    
    input  dc_icb_rsp_valid,
    output dc_icb_rsp_ready,
    input  dc_icb_rsp_err, 
// system interface
    input clk,
    input rst_n           
);
wire [SPLT_NUM-1:0] o_icb_cmd_valid;
wire [SPLT_NUM-1:0] o_icb_cmd_ready;

endmodule

module sirv_gnrl_icb_splt #(
    parameter SPLT_NUM = 4
)(
  input  [SPLT_NUM-1:0] i_icb_splt_indic,        

  input  i_icb_cmd_valid, 
  output i_icb_cmd_ready, 
  input      i_icb_cmd_read, 
  input  [15:0]   i_icb_cmd_addr, 
  input  [7:0]   i_icb_cmd_wdata, 

  output i_icb_rsp_valid, 
  input  i_icb_rsp_ready, 
  output i_icb_rsp_err,
  output [7:0] i_icb_rsp_rdata, 
  
  input  [SPLT_NUM*1-1:0]    o_bus_icb_cmd_ready, 
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_valid, 
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_read, 
  output [SPLT_NUM*16-1:0]   o_bus_icb_cmd_addr, 
  output [SPLT_NUM*8-1:0]   o_bus_icb_cmd_wdata, 

  input  [SPLT_NUM*1-1:0]  o_bus_icb_rsp_valid, 
  output [SPLT_NUM*1-1:0]  o_bus_icb_rsp_ready, 
  input  [SPLT_NUM*1-1:0]  o_bus_icb_rsp_err,
  input  [SPLT_NUM*8-1:0] o_bus_icb_rsp_rdata, 

  input  clk,  
  input  rst_n
);
integer j;
wire [SPLT_NUM-1:0] o_icb_cmd_valid;
wire [SPLT_NUM-1:0] o_icb_cmd_ready;

wire o_icb_cmd_read [SPLT_NUM-1:0];
wire [15:0] o_icb_cmd_addr [SPLT_NUM-1:0];
wire [7:0] o_icb_cmd_wdata [SPLT_NUM-1:0];

wire [SPLT_NUM-1:0] o_icb_rsp_valid;
wire [SPLT_NUM-1:0] o_icb_rsp_ready;
wire [SPLT_NUM-1:0] o_icb_rsp_err;
wire [15:0] o_icb_rsp_rdata [SPLT_NUM-1:0];

reg sel_o_icb_cmd_ready;

wire rspid_fifo_bypass;
wire rspid_fifo_wen;
wire rspid_fifo_ren;

wire [SPLT_NUM-1:0] o_icb_rsp_port_id;

wire rspid_fifo_i_valid;
wire rspid_fifo_o_valid;
wire rspid_fifo_i_ready;
wire rspid_fifo_o_ready;
wire [SPLT_NUM-1:0] rspid_fifo_rdat;
wire [SPLT_NUM-1:0] rspid_fifo_wdat;

wire rspid_fifo_full;
wire rspid_fifo_empty;
wire [SPLT_NUM-1:0] i_splt_indic_id;

wire i_icb_cmd_ready_pre;
wire i_icb_cmd_valid_pre;

wire i_icb_rsp_ready_pre;
wire i_icb_rsp_valid_pre;

genvar i;
generate
    for (i=0;i<SPLT_NUM;i=i+1)
    begin: icb_distract_gen
        assign o_icb_cmd_ready[i] = o_bus_icb_cmd_ready[(i+1)-1:i];
        assign o_bus_icb_cmd_read[(i+1)-1:i] = o_icb_cmd_valid[i];
        assign o_bus_icb_cmd_addr[(i+1)*16-1:i*16] = o_icb_cmd_addr[i];
        assign o_bus_icb_cmd_wdata[(i+1)*8-1:i*8] = o_icb_cmd_wdata[i];
        
        assign o_bus_icb_rsp_ready[(i+1)-1:i] = o_icb_rsp_ready[i];
        assign o_icb_rsp_valid[i] = o_bus_icb_rsp_valid[(i+1)-1:i];
        assign o_icb_rsp_err[i] = o_bus_icb_rsp_err[(i+1)-1:i];
        assign o_icb_rsp_rdata[i] = o_bus_icb_rsp_rdata[(i+1)*8-1:i*8];
    end
    
    always @(*) begin: sel_o_icb_cmd_ready_PROC
        sel_o_icb_cmd_ready = 1'b0;
        for (j=0;j<SPLT_NUM;j=j+1) begin
            sel_o_icb_cmd_ready = sel_o_icb_cmd_ready | (i_icb_splt_indic[j] & o_icb_cmd_ready[j]);
        end
    end
    
    assign i_icb_cmd_ready_pre = sel_o_icb_cmd_ready;
    assign i_icb_cmd_valid_pre = i_icb_cmd_valid & (~rspid_fifo_full);
    assign i_icb_cmd_ready = i_icb_cmd_ready_pre & (~rspid_fifo_full);
    assign i_splt_indic_id = i_icb_splt_indic;
    assign rspid_fifo_wen = i_icb_cmd_valid & i_icb_cmd_ready;
    assign rspid_fifo_ren = i_icb_rsp_valid & i_icb_rsp_ready;
    assign rspid_fifo_bypass = 1'b0;
    assign o_icb_rsp_port_id = rspid_fifo_empty ? {SPLT_NUM{1'b0}}:rspid_fifo_rdat;
    assign i_icb_rsp_valid = (~rspid_fifo_empty) & i_icb_rsp_valid_pre;
    assign i_icb_rsp_ready_pre = (~rspid_fifo_empty) & i_icb_rsp_ready;
    assign rspid_fifo_i_valid = rspid_fifo_wen & (~rspid_fifo_bypass);
    assign rspid_fifo_full = (~rspid_fifo_i_ready);
    assign rspid_fifo_o_ready = rspid_fifo_ren & (~rspid_fifo_bypass);
    assign rspid_fifo_empty = (~rspid_fifo_o_valid);
    
    assign rspid_fifo_wdat = i_splt_indic_id;
    sirv_gnrl_pipe_stage #(
        .CUT_READY(1'b0),
        .DP(1),
        .DW(SPLT_NUM)
    ) u_sirv_gnrl_rspid_fifo(
        .i_vld(rspid_fifo_i_valid),
        .i_rdy(rspid_fifo_i_ready),
        .i_dat(rspid_fifo_wdat),
        .o_vld(rspid_fifo_o_valid),
        .o_rdy(rspid_fifo_o_ready),
        .o_dat(rspid_fifo_rdat),
        .clk(clk),
        .rst_n(rst_n)
    );
    
    for (i=0;i<SPLT_NUM;i=i+1)
    begin:o_icb_cmd_valid_gen
        assign o_icb_cmd_valid[i] = i_icb_splt_indic[i] & i_icb_cmd_valid_pre;
        assign o_icb_cmd_read[i] = i_icb_cmd_read;
        assign o_icb_cmd_addr[i] = i_icb_cmd_addr;
        assign o_icb_cmd_wdata[i] = i_icb_cmd_wdata;
    end
    for (i=0;i<SPLT_NUM;i=i+1)
    begin:o_icb_rsp_ready_gen
        assign o_icb_rsp_ready[i] = (o_icb_rsp_port_id[i] & i_icb_rsp_ready_pre);
    end
    assign i_icb_rsp_valid_pre = |(o_icb_rsp_valid & o_icb_rsp_port_id);
    
    reg sel_i_icb_rsp_err;
    reg [7:0] sel_i_icb_rsp_rdata;
    always @(*) begin: sel_icb_rsp_PROC
        sel_i_icb_rsp_err = 1'b0;
        sel_i_icb_rsp_rdata = 8'd0;
        for (j=0;j<SPLT_NUM;j=j+1)begin
            sel_i_icb_rsp_err = sel_i_icb_rsp_err | (o_icb_rsp_port_id[j] & o_icb_rsp_err[j]);
            sel_i_icb_rsp_rdata = sel_i_icb_rsp_rdata | ({8{o_icb_rsp_port_id[j]}} & o_icb_rsp_rdata[j]);
        end
    end
    assign i_icb_rsp_err = sel_i_icb_rsp_err;
    assign i_icb_rsp_rdata = sel_i_icb_rsp_rdata;
endgenerate
endmodule