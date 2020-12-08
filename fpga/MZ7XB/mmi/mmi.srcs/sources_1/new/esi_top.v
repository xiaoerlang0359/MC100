`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 23:19:35
// Design Name: 
// Module Name: esi_top
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


module esi_top(
// fifo interface
    input sof,
    input eof,
    input valid,
    input [15:0] addr,
    input [7:0] wdata,
    input read,
    input src,// 1 for ecat, 0 for pdi
    output ready,//
    output reg [7:0] rdata,
 // event interface
    output eeprom_event,//
// register file interface eeprom reload status
    output eeplstat_out,
 // reload interface
    output reload1,
    output reload2,
    output [15:0] station_alias,
    output [15:0] pdi_control,
    output [15:0] pdi_config,
    output [15:0] pdi_ext_config,
    output [15:0] dc_pulse_len,
 // sys interface
    input clk,
    input rst_n
    );
    
localparam IDLE_S = 3'b000;
localparam RUN_S = 3'b001;
localparam EXTRA_S = 3'b010;
localparam BUSY_S = 3'b100;
 
(*mark_debug = "true"*)wire [2:0] state;
reg  [2:0] next_state;
wire ready_nxt;
/////////////////////////////////////
//Register EEPROM Configuration
/////////////////////////////////////
wire sel_eepconf = valid & (addr == 16'h0500);
wire rd_eepconf = read & sel_eepconf;
wire wr_eepconf = ~read & sel_eepconf & ready_nxt;
wire [7:0] eepconf_r;
wire [7:0] eepconf_nxt;
assign eepconf_nxt = wdata;
gnrl_dfflr #(8,8'b0) eepconf_dfflr(wr_eepconf,eepconf_nxt,eepconf_r,clk,rst_n);
//////////////////////////////////////
//Register EEPROM PDI Access State
//////////////////////////////////////
wire sel_eepstate = valid & (addr == 16'h0501);
wire rd_eepstate = read & sel_eepstate;
wire [7:0] eepstate_r = 8'd0;   
 /////////////////////////////////////
 //Register EEPROM Control
 /////////////////////////////////////
wire sel_eepcntl = valid & (addr == 16'h0502);
wire rd_eepcntl = read & sel_eepcntl;
wire wr_eepcntl = ~read & sel_eepcntl & ready_nxt;
wire [7:0] eepcntl_r;
wire eepwen_r;
wire eepwen_nxt;
wire eepwen_ena = (sof & eepwen_r) | wr_eepcntl;
assign eepwen_nxt = (sof)? 1'b0:wdata[0];
gnrl_dfflr #(1,1'b0) eepwen_dfflr(eepwen_ena,eepwen_nxt,eepwen_r,clk,rst_n);
wire eepemul_r = 1'b1;
wire eepbytes_r = 1'b1;
wire eepalg_r = 1'b0;
assign eepcntl_r = {eepalg_r,eepbytes_r,eepemul_r,4'd0,eepwen_r};
///////////////////////////////////////
//Register EEPROM Status
///////////////////////////////////////
wire sel_eepstat = valid & (addr==16'h0503);
wire rd_eepstat = read & sel_eepstat;
wire wr_eepstat = (~read & sel_eepstat) & ready_nxt;
(*mark_debug = "true"*) wire [7:0] eepstat_r;
wire [2:0] eepcmd_r;
wire [2:0] eepcmd_nxt;
wire eepcmd_ena;
assign eepcmd_ena = (wr_eepstat & src) | (state == BUSY_S);
assign eepcmd_nxt = (state == BUSY_S)? 3'b0: wdata[2:0];
gnrl_dfflr #(3,3'b100) eepcmd_dfflr(eepcmd_ena,eepcmd_nxt,eepcmd_r,clk,rst_n);
wire eepread_r = eepcmd_r[0];
wire eepwrite_r = eepcmd_r[1];
wire eepreload_r = eepcmd_r[2];
wire eepcsr_r;
wire eepcsr_nxt = wdata[3];
wire eepcsr_ena = wr_eepstat & (~src); // NOTE: add ~src
gnrl_dfflr #(1,1'b0) eepcsr_dfflr(eepcsr_ena,eepcsr_nxt,eepcsr_r,clk,rst_n);
wire eeplstat_r;
wire eeplstat_nxt;
wire eeplstat_ena;
assign eeplstat_ena = wr_eepstat;
assign eeplstat_nxt = (src)? wdata[2]:wdata[4];
gnrl_dfflr #(1,1'b1) eeplstat_dfflr(eeplstat_ena,eeplstat_nxt,eeplstat_r,clk,rst_n);
assign eeplstat_out = ~eeplstat_r;
wire eepac_r;
wire eepac_nxt = wdata[5];
wire eepac_ena = wr_eepstat &(~src);
gnrl_dfflr #(1,1'b0) eepac_dfflr(eepac_ena,eepac_nxt,eepac_r,clk,rst_n);
wire eepwrerr_r;
wire eepwrerr_nxt = wdata[6];
wire eepwrerr_ena = wr_eepstat & (~src);
gnrl_dfflr #(1,1'b0) eepwrerr_dfflr(eepwrerr_ena,eepwrerr_nxt,eepwrerr_r,clk,rst_n);
wire eepbusy_r;
assign eepbusy_r = (state != IDLE_S);
assign eepstat_r = {eepbusy_r,eepwrerr_r,eepac_r,eeplstat_r,eepcsr_r,eepcmd_r};
///////////////////////////////////////////
// Register EEPROM Address
///////////////////////////////////////////
wire sel_eepaddr0 = valid & (addr == 16'h0504);
wire rd_eepaddr0 = read & sel_eepaddr0;
wire wr_eepaddr0 = ~read & sel_eepaddr0 & ready_nxt;
(*mark_debug = "true"*) wire [7:0] eepaddr0_r;
wire [7:0] eepaddr0_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepaddr0_dfflr(wr_eepaddr0,eepaddr0_nxt,eepaddr0_r,clk,rst_n);
wire sel_eepaddr1 = valid & (addr == 16'h0505);
wire rd_eepaddr1 = read & sel_eepaddr1;
wire wr_eepaddr1 = ~read & sel_eepaddr1 & ready_nxt;
wire [7:0] eepaddr1_r;
wire [7:0] eepaddr1_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepaddr1_dfflr(wr_eepaddr1,eepaddr1_nxt,eepaddr1_r,clk,rst_n);
wire sel_eepaddr2 = valid & (addr == 16'h0506);
wire rd_eepaddr2 = read & sel_eepaddr2;
wire wr_eepaddr2 = ~read & sel_eepaddr2 & ready_nxt;
wire [7:0] eepaddr2_r;
wire [7:0] eepaddr2_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepaddr2_dfflr(wr_eepaddr2,eepaddr2_nxt,eepaddr2_r,clk,rst_n);
wire sel_eepaddr3 = valid & (addr == 16'h0507);
wire rd_eepaddr3 = read & sel_eepaddr3;
wire wr_eepaddr3 = ~read & sel_eepaddr3 & ready_nxt;
wire [7:0] eepaddr3_r;
wire [7:0] eepaddr3_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepaddr3_dfflr(wr_eepaddr3,eepaddr3_nxt,eepaddr3_r,clk,rst_n);
///////////////////////////////////////////
// Register EEPROM Data
///////////////////////////////////////////
wire sel_eepdata0 = valid & (addr == 16'h0508);
wire rd_eepdata0 = read & sel_eepdata0;
wire wr_eepdata0 = ~read & sel_eepdata0 & ready_nxt;
(*mark_debug = "true"*) wire [7:0] eepdata0_r;
wire [7:0] eepdata0_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata0_dfflr(wr_eepdata0,eepdata0_nxt,eepdata0_r,clk,rst_n);
wire sel_eepdata1 = valid & (addr == 16'h0509);
wire rd_eepdata1 = read & sel_eepdata1;
wire wr_eepdata1 = ~read & sel_eepdata1 & ready_nxt;
wire [7:0] eepdata1_r;
wire [7:0] eepdata1_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata1_dfflr(wr_eepdata1,eepdata1_nxt,eepdata1_r,clk,rst_n);
wire sel_eepdata2 = valid & (addr == 16'h050a);
wire rd_eepdata2 = read & sel_eepdata2;
wire wr_eepdata2 = ~read & sel_eepdata2 & ready_nxt;
wire [7:0] eepdata2_r;
wire [7:0] eepdata2_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata2_dfflr(wr_eepdata2,eepdata2_nxt,eepdata2_r,clk,rst_n);
wire sel_eepdata3 = valid & (addr == 16'h050b);
wire rd_eepdata3 = read & sel_eepdata3;
wire wr_eepdata3 = ~read & sel_eepdata3 & ready_nxt;
wire [7:0] eepdata3_r;
wire [7:0] eepdata3_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata3_dfflr(wr_eepdata3,eepdata3_nxt,eepdata3_r,clk,rst_n);
wire sel_eepdata4 = valid & (addr == 16'h050c);
wire rd_eepdata4 = read & sel_eepdata4;
wire wr_eepdata4 = ~read & sel_eepdata4 & ready_nxt;
wire [7:0] eepdata4_r;
wire [7:0] eepdata4_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata4_dfflr(wr_eepdata4,eepdata4_nxt,eepdata4_r,clk,rst_n);
wire sel_eepdata5 = valid & (addr == 16'h050d);
wire rd_eepdata5 = read & sel_eepdata5;
wire wr_eepdata5 = ~read & sel_eepdata5 & ready_nxt;
wire [7:0] eepdata5_r;
wire [7:0] eepdata5_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata5_dfflr(wr_eepdata5,eepdata5_nxt,eepdata5_r,clk,rst_n);
wire sel_eepdata6 = valid & (addr == 16'h050e);
wire rd_eepdata6 = read & sel_eepdata6;
wire wr_eepdata6 = ~read & sel_eepdata6 & ready_nxt;
wire [7:0] eepdata6_r;
wire [7:0] eepdata6_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata6_dfflr(wr_eepdata6,eepdata6_nxt,eepdata6_r,clk,rst_n);
wire sel_eepdata7 = valid & (addr == 16'h050f);
wire rd_eepdata7 = read & sel_eepdata7;
wire wr_eepdata7 = ~read & sel_eepdata7 & ready_nxt;
wire [7:0] eepdata7_r;
wire [7:0] eepdata7_nxt = wdata;
gnrl_dfflr #(8,8'd0) eepdata7_dfflr(wr_eepdata7,eepdata7_nxt,eepdata7_r,clk,rst_n); 
///////////////////////////////////////////
// state machine
///////////////////////////////////////////  
gnrl_dffr #(3,IDLE_S) eepsm_dffr(next_state,state,clk,rst_n);
always @(*)begin
case(state)
    IDLE_S: if (eof && (eepcmd_r!=3'b000)) next_state = RUN_S;
            else next_state = IDLE_S;
    RUN_S:  if (wr_eepstat && (~src)) begin
                if (eepreload_r) next_state = EXTRA_S;
                else next_state = BUSY_S;
            end
            else next_state = RUN_S;
    EXTRA_S:if (wr_eepstat && (~src)) next_state = BUSY_S;
            else next_state = EXTRA_S;
    BUSY_S: next_state = IDLE_S;
    default: next_state = IDLE_S;
endcase
end
//////////////////////////////////////////
// out
//////////////////////////////////////////
//assign ready = ~eepbusy_r;    //TODO: need to change for pdi interface
assign ready_nxt = (src & (~eepbusy_r)) | ((~src) & eepbusy_r);
gnrl_dffr #(1,1'b0) ready_dffr(ready_nxt,ready,clk,rst_n);
assign eeprom_event = (state!=IDLE_S);
assign reload1 = (state==RUN_S & wr_eepstat) & eepreload_r;
assign reload2 = (state==EXTRA_S & wr_eepstat) & eepreload_r;
assign pdi_control = {eepdata1_r,eepdata0_r};
assign pdi_config = {eepdata3_r,eepdata2_r};
assign dc_pulse_len = {eepdata5_r,eepdata4_r};
assign pdi_ext_config = {eepdata7_r,eepdata6_r};
assign station_alias = {eepdata1_r,eepdata0_r};
wire [7:0] rdata_nxt;
assign rdata_nxt = ({8{rd_eepconf}}  & eepconf_r)  |
               ({8{rd_eepstate}} & eepstate_r) |
               ({8{rd_eepcntl}}  & eepcntl_r)  |
               ({8{rd_eepstat}}  & eepstat_r)  |
               ({8{rd_eepaddr0}} & eepaddr0_r) |
               ({8{rd_eepaddr1}} & eepaddr1_r) |
               ({8{rd_eepaddr2}} & eepaddr2_r) |
               ({8{rd_eepaddr3}} & eepaddr3_r) |
               ({8{rd_eepdata0}} & eepdata0_r) |
               ({8{rd_eepdata1}} & eepdata1_r) |
               ({8{rd_eepdata2}} & eepdata2_r) |
               ({8{rd_eepdata3}} & eepdata3_r) |
               ({8{rd_eepdata4}} & eepdata4_r) |
               ({8{rd_eepdata5}} & eepdata5_r) |
               ({8{rd_eepdata6}} & eepdata6_r) |
               ({8{rd_eepdata7}} & eepdata7_r);               
gnrl_dffr #(8,8'd0) rdata_dffr(rdata_nxt,rdata,clk,rst_n);
               
endmodule
