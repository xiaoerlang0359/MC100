`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/14 16:05:11
// Design Name: 
// Module Name: register_file
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


module register_file(
// fifo interface
    input sof,
    input eof,
    input valid,
    input [15:0] addr,
    input [7:0] wdata,
    input read,
    input src, // 1 for ecat
    output ready,//
    output reg [7:0] rdata,
    output alctrl_state,
// esi reload interface
    input reload1,
    input reload2,
    input [15:0] pdi_control,
    input [15:0] pdi_config,
    input [15:0] pdi_ext_config,
    input [15:0] station_alias,
    input eeplstat_in,
    input eeprom_event,
// fpaddr interface
    output [15:0] fp_addr,
    output [15:0] rw_offset,
// write protect interface
    output wr_reg_en,
    output wr_reg_pr,
    output wr_en,
    output wr_pr,
// reset interface
    output ecat_reset,
    output pdi_reset,
// watchdog interface
    input pdi_expired,
    input pdo_expired,
// dc sync interface,
    input dc_sync0,
    input dc_sync1,
// port control and status interface
    output [1:0] port0_ctrl,
    output [1:0] port1_ctrl,
    output [1:0] port2_ctrl,
    output [1:0] port3_ctrl,
    input port0_link,
    input port1_link,
//  interrupt interface for ecat
    output [15:0] ecat_event_msk,
    output [15:0] ecat_event_req,
//  interrupt interface for pdi
    output pdi_irq,
// sys interface
    input clk,
    input rst_n    
    );
////////////////////////////////////////////
////////////////////////////////////////////
// ECAT Kernel Registers
////////////////////////////////////////////
////////////////////////////////////////////

////////////////////////////////////////////
// Type register of ethercat controller
////////////////////////////////////////////
wire sel_ktype = valid & (addr == 16'h0000);
wire rd_ktype = read & sel_ktype;
wire [7:0] ktype_r = 8'h98;
////////////////////////////////////////////
// Revision of EtherCAT controller
////////////////////////////////////////////
wire sel_krev = valid & (addr == 16'h0001);
wire rd_krev = read & sel_krev;
wire [7:0] krev_r = 8'h01;
////////////////////////////////////////////
// Build register 0
////////////////////////////////////////////
wire sel_kbuild0 = valid & (addr == 16'h0002);
wire rd_kbuild0 = read & sel_kbuild0;
wire [7:0] kbuild0_r = 8'h01;
////////////////////////////////////////////
// Build register 1
////////////////////////////////////////////
wire sel_kbuild1 = valid & (addr == 16'h0003);
wire rd_kbuild1 = read & sel_kbuild1;
wire [7:0] kbuild1_r = 8'h00;
////////////////////////////////////////////
// FMMUs supported
////////////////////////////////////////////
wire sel_kfmmu = valid & (addr == 16'h0004);
wire rd_kfmmu = read & sel_kfmmu;
wire [7:0] kfmmu_r = 8'h08;
////////////////////////////////////////////
// SyncManager supported
////////////////////////////////////////////
wire sel_ksm = valid & (addr == 16'h0005);
wire rd_ksm = read & sel_ksm;
wire [7:0] ksm_r = 8'h08;
////////////////////////////////////////////
// RAM size of the ECAT module
////////////////////////////////////////////
wire sel_kram = valid & (addr == 16'h0006);
wire rd_kram = read & sel_kram;
wire [7:0] kram_r = 8'h08;
////////////////////////////////////////////
// Port descriptor register
////////////////////////////////////////////
wire sel_kport = valid & (addr == 16'h0007);
wire rd_kport = read & sel_kport;
wire [7:0] kport_r = 8'h0f;
////////////////////////////////////////////
// ECAT features supported 0
// not support fmmu bit
// not support link detection
////////////////////////////////////////////
wire sel_kfeature0 = valid & (addr == 16'h0008);
wire rd_kfeature0 = read & sel_kfeature0;
wire [7:0] kfeature0_r = 8'h8d;
/////////////////////////////////////////////
// ECAT features supported 1
// not support LRW
// not support BRW APRW FPRW
/////////////////////////////////////////////
wire sel_kfeature1 = valid & (addr == 16'h0009);
wire rd_kfeature1 = read & sel_kfeature1;
wire [7:0] kfeature1_r = 8'h07;

////////////////////////////////////////////
////////////////////////////////////////////
// Station Address
////////////////////////////////////////////
////////////////////////////////////////////

////////////////////////////////////////////
// Configured Station Address
////////////////////////////////////////////
wire sel_fpaddr0 = valid & (addr == 16'h0010);
wire rd_fpaddr0 = read & sel_fpaddr0;
wire wr_fpaddr0 = ~read & sel_fpaddr0;
wire [7:0] fpaddr0_r;
wire [7:0] fpaddr0_nxt = wdata;
gnrl_dfflr #(8,8'd0) fpaddr0_dfflr(wr_fpaddr0,fpaddr0_nxt,fpaddr0_r,clk,rst_n);
wire sel_fpaddr1 = valid & (addr == 16'h0011);
wire rd_fpaddr1 = read & sel_fpaddr1;
wire wr_fpaddr1 = ~read & sel_fpaddr1;
wire [7:0] fpaddr1_r;
wire [7:0] fpaddr1_nxt = wdata;
gnrl_dfflr #(8,8'd0) fpaddr1_dfflr(wr_fpaddr1,fpaddr1_nxt,fpaddr1_r,clk,rst_n);
////////////////////////////////////////////
// Configured Station Alias
////////////////////////////////////////////
wire sel_fpalias0 = valid & (addr == 16'h0012);
wire rd_fpalias0 = read & sel_fpalias0;
wire wr_fpalias0 = ~read & sel_fpalias0;
wire [7:0] fpalias0_r;
wire [7:0] fpalias0_nxt;
wire fpalias0_ena;
assign fpalias0_ena = wr_fpalias0 | reload2;
assign fpalias0_nxt = (wr_fpalias0)? wdata:station_alias;
gnrl_dfflr #(8,8'd0) fpalias0_dfflr(fpalias0_ena,fpalias0_nxt,fpalias0_r,clk,rst_n);
wire sel_fpalias1 = valid & (addr == 16'h0012);
wire rd_fpalias1 = read & sel_fpalias1;
wire wr_fpalias1 = ~read & sel_fpalias1;
wire [7:0] fpalias1_r;
wire [7:0] fpalias1_nxt;
wire fpalias1_ena;
assign fpalias1_ena = wr_fpalias1 | reload2;
assign fpalias1_nxt = (wr_fpalias1)? wdata:station_alias;
gnrl_dfflr #(8,8'd0) fpalias1_dfflr(fpalias1_ena,fpalias1_nxt,fpalias1_r,clk,rst_n);

//////////////////////////////////////////////
//////////////////////////////////////////////
// Write Protection
// TODO: not implement
//////////////////////////////////////////////
//////////////////////////////////////////////

//////////////////////////////////////////////
// Write Register Enable
//////////////////////////////////////////////
wire sel_wpregen = valid & (addr == 16'h0020);
wire rd_wpregen = read & sel_wpregen;
wire wr_wpregen = ~read & sel_wpregen;
wire [7:0] wpregen_r;
wire wpregen_bit_r;
wire wpregen_bit_nxt;
wire wpregen_bit_ena;
assign wpregen_bit_ena = sof | wr_wpregen;
assign wpregen_bit_nxt = (sof)? 1'b0:wdata[0];
assign wpregen_r = {7'd0,wpregen_bit_r};
gnrl_dfflr #(1,1'b0) wpregen_dfflr(wpregen_bit_ena,wpregen_bit_nxt,wpregen_bit_r,clk,rst_n);
///////////////////////////////////////////////
// Write Register Protection
///////////////////////////////////////////////
wire sel_wpregpr = valid & (addr == 16'h0021);
wire rd_wpregpr = read  & sel_wpregpr;
wire wr_wpregpr = ~read & sel_wpregpr;
wire [7:0] wpregpr_r;
wire wpregpr_bit_r;
wire wpregpr_bit_nxt = wdata[0];
assign wpregpr_r = {7'd0,wpregpr_bit_r};
gnrl_dfflr #(1,1'b0) wpregpr_dfflr(wr_wpregpr,wpregpr_bit_nxt,wpregpr_bit_r,clk,rst_n);
//////////////////////////////////////////////
// ESC Write Enable
//////////////////////////////////////////////
wire sel_wpen = valid & (addr == 16'h0030);
wire rd_wpen = read & sel_wpen;
wire wr_wpen = ~read & sel_wpen;
wire [7:0] wpen_r;
wire wpen_bit_r;
wire wpen_bit_nxt;
wire wpen_bit_ena;
assign wpen_bit_ena = sof | wr_wpen;
assign wpen_bit_nxt = (wr_wpen)? wdata[0]:1'b0;
assign wpen_r = {7'd0,wpen_bit_r};
gnrl_dfflr #(1,1'b0) wpen_dfflr(wpen_bit_ena,wpen_bit_nxt,wpen_bit_r,clk,rst_n);
///////////////////////////////////////////////
// ESC Write Protection
///////////////////////////////////////////////
wire sel_wppr = valid & (addr == 16'h0031);
wire rd_wppr = read & sel_wppr;
wire wr_wppr = ~read & sel_wppr;
wire [7:0] wppr_r;
wire wppr_bit_r;
wire wppr_bit_nxt = wdata[0];
assign wppr_r = {7'd0,wppr_r};
gnrl_dfflr #(1,1'b0) wppr_dfflr(wr_wppr,wppr_bit_nxt,wppr_bit_r,clk,rst_n);

///////////////////////////////////////////////
///////////////////////////////////////////////
// write protect interface
assign wr_reg_en = wpregen_bit_r;
assign wr_reg_pr = wpregpr_bit_r;
assign wr_en = wpen_bit_r;
assign wr_pr = wppr_bit_r;
////////////////////////////////////////////////
////////////////////////////////////////////////

////////////////////////////////////////////////
////////////////////////////////////////////////
// reset
////////////////////////////////////////////////
////////////////////////////////////////////////

///////////////////////////////////////////////
// ESC Reset ECAT
///////////////////////////////////////////////
wire sel_ecat_rst = valid & (addr == 16'h0040);
wire rd_ecat_rst = read & sel_ecat_rst;
wire wr_ecat_rst = ~read & sel_ecat_rst & src;
wire [7:0] ecat_rst_r;
wire [7:0] ecat_rst_nxt;
wire ecat_rst_ena;
assign ecat_rst_ena = wr_ecat_rst | eof;
assign ecat_rst_nxt = (eof)? 8'd0:wdata;
gnrl_dfflr #(8,8'd0) ecat_rst_dfflr(wr_ecat_rst,ecat_rst_nxt,ecat_rst_r,clk,rst_n);
///////////////////////////////////////////////
// Register ESC Reset ECAT
///////////////////////////////////////////////
wire ecat_rst_state_ena;
wire [7:0] ecat_rst_state_nxt;
wire [7:0] ecat_rst_state_r;
assign ecat_rst_state_ena = eof;
assign ecat_rst_state_nxt = (ecat_rst_r==8'h52)? 8'd1:
                            (ecat_rst_r==8'h45 && ecat_rst_state_r==8'd1)? 8'd2:8'd0;
gnrl_dfflr #(8,8'd0) ecat_rst_state_dfflr(ecat_rst_state_ena,ecat_rst_state_nxt,ecat_rst_state_r,clk,rst_n);
///////////////////////////////////////////////
// reset signal generation
///////////////////////////////////////////////
wire ecat_reset_r;
wire ecat_reset_nxt;
assign ecat_reset_nxt = eof & (ecat_rst_state_r==8'd2) & (ecat_rst_r==8'h53);
gnrl_dffr #(1,1'b0) ecat_reset_dffr(ecat_reset_nxt,ecat_reset_r,clk,rst_n);
assign ecat_reset = ecat_reset_r;  
//////////////////////////////////////////////// 
// ESC Reset PDI write
////////////////////////////////////////////////
wire sel_pdi_rst = valid & (addr == 16'h0041);
wire rd_pdi_rst = read & sel_pdi_rst;
wire wr_pdi_rst = ~read & sel_pdi_rst & (~src);
wire [7:0] pdi_rst_r;
wire [7:0] pdi_rst_nxt;
wire pdi_rst_ena;
assign pdi_rst_ena = eof | wr_pdi_rst;
assign pdi_rst_nxt = (eof)? 8'd0:wdata;
gnrl_dfflr #(8,8'd0) pdi_rst_dfflr(pdi_rst_ena,pdi_rst_nxt,pdi_rst_r,clk,rst_n);
/////////////////////////////////////////////////
// Register ESC Reset PDI read
/////////////////////////////////////////////////    
wire pdi_rst_state_ena;
wire [7:0] pdi_rst_state_nxt;
wire [7:0] pdi_rst_state_r;
assign pdi_rst_state_ena = eof;
assign pdi_rst_state_nxt = (pdi_rst_r==8'h52)? 8'd1:
                           (pdi_rst_r==8'h45 && pdi_rst_state_r==8'd1)? 8'd2:8'd0;
gnrl_dfflr #(8,8'd0) pdi_rst_state_dfflr(pdi_rst_state_ena,pdi_rst_state_nxt,pdi_rst_state_r,clk,rst_n);
/////////////////////////////////////////////////
// pdi reset signal generation
/////////////////////////////////////////////////
wire pdi_reset_r;
wire pdi_reset_nxt;
assign pdi_reset_nxt = eof & (pdi_rst_state_r==8'd2) & (pdi_rst_r==8'h53);
gnrl_dffr #(1,1'b0) pdi_reset_dffr(pdi_reset_nxt,pdi_reset_r,clk,rst_n);
assign pdi_reset = pdi_reset_r; 

/////////////////////////////////////////////////
/////////////////////////////////////////////////
// ESC DL Control
////////////////////////////////////////////////
////////////////////////////////////////////////

////////////////////////////////////////////////
// forwarding control
////////////////////////////////////////////////
wire sel_fwctrl = valid & (addr == 16'h0100);
wire rd_fwctrl = read & sel_fwctrl;
wire wr_fwctrl = ~read & sel_fwctrl;
wire [7:0] fwctrl_r;
wire fwctrl_bit_r;
wire fwctrl_bit_nxt = wdata[0];
assign fwctrl_r = {7'd0,fwctrl_bit_r};
gnrl_dfflr #(1,1'd1) fwctrl_dfflr(wr_fwctrl,fwctrl_bit_nxt,fwctrl_bit_r,clk,rst_n);
/////////////////////////////////////////////////
// loop port control
/////////////////////////////////////////////////
wire sel_portctrl = valid & (addr == 16'h0101);
wire rd_portctrl = read & sel_portctrl;
wire wr_portctrl = ~read & sel_portctrl;
wire [7:0] portctrl_r;
wire [7:0] portctrl_nxt = wdata;
gnrl_dfflr #(8,8'hf0) portctrl_dfflr(wr_portctrl,portctrl_nxt,portctrl_r,clk,rst_n);                
assign port0_ctrl = portctrl_r[1:0];
assign port1_ctrl = portctrl_r[3:2];
assign port2_ctrl = portctrl_r[5:4];
assign port3_ctrl = portctrl_r[7:6];
/////////////////////////////////////////////////
// rx fifo size
/////////////////////////////////////////////////
wire sel_fifosize = valid & (addr == 16'h0102);
wire rd_fifosize = read & sel_fifosize;
wire [7:0] fifosize_r = 8'h07;
/////////////////////////////////////////////////
// station alias
/////////////////////////////////////////////////
wire sel_aliasen = valid & (addr == 16'h0103);
wire rd_aliasen = read & sel_aliasen;
wire wr_aliasen = ~read & sel_aliasen;
wire [7:0] aliasen_r;
wire aliasen_bit_r;
wire aliasen_bit_nxt = wdata[0];
gnrl_dfflr #(1,1'b0) aliasen_dfflr(wr_aliasen,aliasen_bit_nxt,aliasen_bit_r,clk,rst_n);
assign aliasen_r = {7'd0,aliasen_bit_r};
assign fp_addr = (aliasen_bit_r)? {fpalias1_r,fpalias0_r}:{fpaddr1_r,fpaddr0_r};
/////////////////////////////////////////////////
// Physical Read/Write Offset
// RD_ADR = ADR and WR_ADR = ADR + R/W-Offset
/////////////////////////////////////////////////
wire sel_rwoffset0 = valid & (addr == 16'h0108);
wire rd_rwoffset0 = read & sel_rwoffset0;
wire wr_rwoffset0 = ~read & sel_rwoffset0;
wire [7:0] rwoffset0_r;
wire [7:0] rwoffset0_nxt = wdata;
gnrl_dfflr #(8,8'd0) rwoffset0_dfflr(wr_rwoffset0,rwoffset0_nxt,rwoffset0_r,clk,rst_n);
wire sel_rwoffset1 = valid & (addr == 16'h0109);
wire rd_rwoffset1 = read & sel_rwoffset1;
wire wr_rwoffset1 = ~read & sel_rwoffset1;
wire [7:0] rwoffset1_r;
wire [7:0] rwoffset1_nxt = wdata;
gnrl_dfflr #(8,8'd0) rwoffset1_dfflr(wr_rwoffset1,rwoffset1_nxt,rwoffset1_r,clk,rst_n);
assign rw_offset = {rwoffset1_r,rwoffset0_r};
//////////////////////////////////////////////////
//////////////////////////////////////////////////
// ESC DL Status 
// #TODO: Reading DL Status register from ECAT clears ECAT Event Request 0x0210[2]
//////////////////////////////////////////////////
//////////////////////////////////////////////////
wire sel_dlstat0 = valid & (addr == 16'h0110);
wire rd_dlstat0 = read & sel_dlstat0;
wire [7:0] dlstat0_r;
wire dlstat_eep_r;
wire dlstat_eep_nxt = eeplstat_in;
gnrl_dffr #(1,1'b0) dlstat_eep_dffr(dlstat_eep_nxt,dlstat_eep_r,clk,rst_n);
wire dlstat_pdiwd_r;
wire dlstat_pdiwd_nxt = pdi_expired;
gnrl_dffr #(1,1'b0) dlstat_pdiwd_dffr(dlstat_pdiwd_nxt,dlstat_pdiwd_r,clk,rst_n);
wire dlstat_link_dect_r = 1'b1;
wire dlstat_link_p0_r;
wire dlstat_link_p0_nxt = port0_link;
gnrl_dffr #(1,1'b0) dlstat_link_p0_dffr(dlstat_link_p0_nxt,dlstat_link_p0_r,clk,rst_n);
wire dlstat_link_p1_r;
wire dlstat_link_p1_nxt = port1_link;
gnrl_dffr #(1,1'b0) dlstat_link_p1_dffr(dlstat_link_p1_nxt,dlstat_link_p1_r,clk,rst_n);
wire dlstat_link_p2_r = 1'b0;
wire dlstat_link_p3_r = 1'b0;
assign  dlstat0_r = {dlstat_link_p3_r,dlstat_link_p2_r,dlstat_link_p1_r,dlstat_link_p0_r,
                     1'b0,dlstat_link_dect_r,dlstat_pdiwd_r,dlstat_eep_r};
wire sel_dlstat1 = valid & (addr == 16'h0111);
wire rd_dlstat1 = read & sel_dlstat1;
wire [7:0] dlstat1_r;
wire dlstat_lp0_r;
wire dlstat_lp0_nxt = (port0_ctrl==2'b11)? 1'b1:(~port0_link);
gnrl_dffr #(1,1'b0) dlstat_lp0_dffr(dlstat_lp0_nxt,dlstat_lp0_r,clk,rst_n);
wire dlstat_comp0_r = ~dlstat_lp0_r;
wire dlstat_lp1_r;
wire dlstat_lp1_nxt = (port1_ctrl==2'b11)? 1'b1:(~port1_link);
gnrl_dffr #(1,1'b0) dlstat_lp1_dffr(dlstat_lp1_nxt,dlstat_lp1_r,clk,rst_n);
wire dlstat_comp1_r = ~dlstat_lp1_r;
wire dlstat_lp2_r = 1'b1;
wire dlstat_comp2_r = 1'b0;
wire dlstat_lp3_r = 1'b1;
wire dlstat_comp3_r = 1'b0;
assign dlstat1_r = {dlstat_comp3_r,dlstat_lp3_r,dlstat_comp2_r,dlstat_lp2_r,
                    dlstat_comp1_r,dlstat_lp1_r,dlstat_comp0_r,dlstat_lp0_r};
///////////////////////////////////////////////
///////////////////////////////////////////////
// Application Layer
///////////////////////////////////////////////
///////////////////////////////////////////////

///////////////////////////////////////////////
// AL Control
// #TODO: reading al control form pdi clears al event request 0x0220[0]
///////////////////////////////////////////////
// 1 for ecat write, 0 for pdi read
wire sel_alctrl = valid & (addr==16'h0120);
wire rd_alctrl = (src)? (read & sel_alctrl):(read & sel_alctrl & (~alctrl_state));
wire wr_alctrl = ~read & sel_alctrl & src & alctrl_state;
wire [7:0] alctrl_r;
wire [7:0] alctrl_nxt = wdata;
gnrl_dfflr #(8,8'd1) alctrl_dfflr(wr_alctrl,alctrl_nxt,alctrl_r,clk,rst_n);
wire alctrl_state_r;
wire alctrl_state_nxt;
wire alctrl_state_ena;
assign alctrl_state_ena = (rd_alctrl & (~src)) | wr_alctrl;
assign alctrl_state_nxt = (wr_alctrl)? 1'b0:1'b1;
gnrl_dfflr #(1,1'b1) alctrl_state_dfflr(alctrl_state_ena,alctrl_state_nxt,alctrl_state_r,clk,rst_n);
assign alctrl_state = alctrl_state_r;
///////////////////////////////////////////////
// AL status
// #TODO: Reading AL Status from ECAT clears ECAT Event Request 0x0210[3].
///////////////////////////////////////////////
wire sel_alstat = valid & (addr==16'h0130);
wire rd_alstat = read & sel_alstat;
wire wr_alstat = ~read & sel_alstat & (~src);
wire [7:0] alstat_r;
wire [7:0] alstat_nxt = wdata;
gnrl_dfflr #(8,8'd1) alstat_dfflr(wr_alstat,alstat_nxt,alstat_r,clk,rst_n);
///////////////////////////////////////////////
// AL status code
///////////////////////////////////////////////
wire sel_alstat_code0 = valid & (addr==16'h0134);
wire rd_alstat_code0 = read & sel_alstat_code0;
wire wr_alstat_code0 = ~read & sel_alstat_code0 & (~src);
wire [7:0] alstat_code0_r;
wire [7:0] alstat_code0_nxt = wdata;
gnrl_dfflr #(8,8'd0) alstat_code0_dfflr(wr_alstat_code0,alstat_code0_nxt,alstat_code0_r,clk,rst_n);
wire sel_alstat_code1 = valid & (addr==16'h0135);
wire rd_alstat_code1 = read & sel_alstat_code1;
wire wr_alstat_code1 = ~read & sel_alstat_code1 & (~src);
wire [7:0] alstat_code1_r;
wire [7:0] alstat_code1_nxt = wdata;
gnrl_dfflr #(8,8'd0) alstat_code1_dfflr(wr_alstat_code1,alstat_code1_nxt,alstat_code1_r,clk,rst_n); 
///////////////////////////////////////////////
// RUN LED Override
///////////////////////////////////////////////
wire sel_runled = valid & (addr==16'h0138);
wire rd_runled = read & sel_runled;
wire wr_runled = ~read & sel_runled;
wire [3:0] runled_code_r;
wire [3:0] runled_code_nxt = wdata[3:0];
gnrl_dfflr #(4,4'd0) runled_code_dfflr(wr_runled,runled_code_nxt,runled_code_r,clk,rst_n);
wire runled_en_r;
wire runled_en_nxt;
wire runled_en_ena = wr_runled | wr_alstat;
assign runled_en_nxt = (wr_alstat)? 1'b0:wdata[4];
gnrl_dfflr #(1,1'b0) runled_en_dfflr(runled_en_ena,runled_en_nxt,runled_en_r,clk,rst_n);
wire [7:0] runled_r;
assign runled_r = {3'd0,runled_en_r,runled_code_r};
///////////////////////////////////////////////////
// ERR LED Override
///////////////////////////////////////////////////
wire sel_errled = valid & (addr==16'h0139);
wire rd_errled = read & sel_errled;
wire wr_errled = ~read & sel_errled;
wire [3:0] errled_code_r;
wire [3:0] errled_code_nxt = wdata[3:0];
gnrl_dfflr #(4,4'd0) errled_code_dfflr(wr_errled,errled_code_nxt,errled_code_r,clk,rst_n);
wire errled_en_r;
wire errled_en_ena = wr_errled | wr_alstat_code0;
wire errled_en_nxt = (wr_alstat_code0)? 1'b0:wdata[4];
gnrl_dfflr #(1,1'b0) errled_en_dfflr(errled_en_ena,errled_en_nxt,errled_en_r,clk,rst_n);
wire [7:0] errled_r;
assign errled_r = {3'd0,errled_en_r,errled_code_r};
////////////////////////////////////////////////////
////////////////////////////////////////////////////
// PDI / ESC Configuration
////////////////////////////////////////////////////
////////////////////////////////////////////////////

////////////////////////////////////////////////////
// pdi control
////////////////////////////////////////////////////
wire sel_pdictrl = valid & (addr==16'h0140);
wire rd_pdictrl = read & sel_pdictrl;
wire [7:0] pdictrl_r;
wire pdictrl_ena = reload1;
wire [7:0] pdictrl_nxt = 8'h80;
gnrl_dfflr #(8,8'h80) pdictrl_dfflr(pdictrl_ena,pdictrl_nxt,pdictrl_r,clk,rst_n);
/////////////////////////////////////////////////////
// ESC Configuration
// no emulation
// enalble enhanced link detection
// enable dc sync out
// enable dc latch in
/////////////////////////////////////////////////////
wire sel_escconf = valid & (addr==16'h0141);
wire rd_escconf = read & sel_pdictrl;
wire [7:0] escconf_r;
wire escconf_ena = reload1;
wire [7:0] escconf_nxt = pdi_control[15:8];
gnrl_dfflr #(8,8'hfe) escconf_dfflr(escconf_ena,escconf_nxt,escconf_r,clk,rst_n);
//////////////////////////////////////////////////////
// PDI On-chip bus configuration
//////////////////////////////////////////////////////
wire sel_pdiconf = valid & (addr==16'h0150);
wire rd_pdiconf = read & sel_pdiconf;
wire [7:0] pdiconf_r = 8'h11;
//////////////////////////////////////////////////////
// Sync/Latch[1:0] PDI Configuration
// push-pull active high
//////////////////////////////////////////////////////
wire sel_syncconf = valid & (addr==16'h0151);
wire rd_syncconf = read & sel_syncconf;
wire [7:0] syncconf_r;
wire syncconf_ena = reload1;
wire [7:0] syncconf_nxt = pdi_config[15:8];
gnrl_dfflr #(8,8'hee) syncconf_dfflr(syncconf_ena,syncconf_nxt,syncconf_r,clk,rst_n);
///////////////////////////////////////////////////////
// Register PDI On-chip bus extended Configuration
///////////////////////////////////////////////////////
wire sel_pdiext_conf0 = valid & (addr==16'h0152);
wire rd_pdiext_conf0 = read & sel_pdiext_conf0;
wire [7:0] pdiext_conf0_r;
wire pdiext_conf0_ena = reload1;
wire [7:0] pdiext_conf0_nxt = pdi_ext_config[7:0];
gnrl_dfflr #(8,8'h00) pdiext_conf0_dfflr(pdiext_conf0_ena,pdiext_conf0_nxt,pdiext_conf0_r,clk,rst_n);
wire sel_pdiext_conf1 = valid & (addr==16'h0153);
wire rd_pdiext_conf1 = read & sel_pdiext_conf1;
wire [7:0] pdiext_conf1_r;
wire pdiext_conf1_ena = reload1;
wire [7:0] pdiext_conf1_nxt = pdi_ext_config[15:8];
gnrl_dfflr #(8,8'h02) pdiext_conf1_dfflr(pdiext_conf1_ena,pdiext_conf1_nxt,pdiext_conf1_r,clk,rst_n);

////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
// Interrupts
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// ECAT Event Mask
////////////////////////////////////////////////////////
wire sel_ecat_mask0 = valid & (addr==16'h0200);
wire rd_ecat_mask0 = read & sel_ecat_mask0;
wire wr_ecat_mask0 = ~read & sel_ecat_mask0 & src;
wire [7:0] ecat_mask0_r;
wire [7:0] ecat_mask0_nxt = wdata;
gnrl_dfflr #(8,8'h00) ecat_mask0_dfflr(wr_ecat_mask0,ecat_mask0_nxt,ecat_mask0_r,clk,rst_n);
wire sel_ecat_mask1 = valid & (addr==16'h0201);
wire rd_ecat_mask1 = read & sel_ecat_mask1;
wire wr_ecat_mask1 = ~read & sel_ecat_mask1 & src;
wire [7:0] ecat_mask1_r;
wire [7:0] ecat_mask1_nxt = wdata;
gnrl_dfflr #(8,8'h00) ecat_mask1_dfflr(wr_ecat_mask1,ecat_mask1_nxt,ecat_mask1_r,clk,rst_n);
assign ecat_event_msk = {ecat_mask1_r,ecat_mask0_r};
///////////////////////////////////////////////////////
// Register PDI AL Event Mask
///////////////////////////////////////////////////////
wire sel_al_mask0 = valid & (addr==16'h0204);
wire rd_al_mask0 = read & sel_al_mask0;
wire wr_al_mask0 = ~read & sel_al_mask0 & (~src);
wire [7:0] al_mask0_r;
wire [7:0] al_mask0_nxt = wdata;
gnrl_dfflr #(8,8'h00) al_mask0_dfflr(wr_al_mask0,al_mask0_nxt,al_mask0_r,clk,rst_n);
wire sel_al_mask1 = valid & (addr==16'h0205);
wire rd_al_mask1 = read & sel_al_mask1;
wire wr_al_mask1 = ~read & sel_al_mask1 & (~src);
wire [7:0] al_mask1_r;
wire [7:0] al_mask1_nxt = wdata;
gnrl_dfflr #(8,8'h00) al_mask1_dfflr(wr_al_mask1,al_mask1_nxt,al_mask1_r,clk,rst_n);
wire sel_al_mask2 = valid & (addr==16'h0206);
wire rd_al_mask2 = read & sel_al_mask2;
wire wr_al_mask2 = ~read & sel_al_mask2 & (~src);
wire [7:0] al_mask2_r;
wire [7:0] al_mask2_nxt = wdata;
gnrl_dfflr #(8,8'h00) al_mask2_dfflr(wr_al_mask2,al_mask2_nxt,al_mask2_r,clk,rst_n);
wire sel_al_mask3 = valid & (addr==16'h0207);
wire rd_al_mask3 = read & sel_al_mask3;
wire [7:0] al_mask3_r = 8'd0;
//////////////////////////////////////////////////////
// Register ECAT Event Request
// TODO: dc latch event
// TODO: sm status event
//////////////////////////////////////////////////////
wire sel_ecat_req0 = valid & (addr==16'h0210);
wire rd_ecat_req0 = read & sel_ecat_req0;
wire sel_ecat_req1 = valid & (addr==16'h0211);
wire rd_ecat_req1 = read & sel_ecat_req1;
// DL Status event
wire [15:0] dl_status_sr;
wire [15:0] dl_status_nxt = {dlstat1_r,dlstat0_r};
wire dl_status_ena = sof;
gnrl_dfflr #(16,16'h5000) dl_status_dfflr(dl_status_ena,dl_status_nxt,dl_status_sr,clk,rst_n);
wire dl_se_ena = (sof & (|(dl_status_sr^{dlstat1_r,dlstat0_r}))) | 
                 (rd_dlstat0 & src) | (rd_dlstat1 & src);
wire dl_se_nxt = ((rd_dlstat0 & src) | (rd_dlstat1 & src))? 1'b0:1'b1;
wire dl_se_r;
gnrl_dfflr #(1,1'b0) dl_se_dfflr(dl_se_ena,dl_se_nxt,dl_se_r,clk,rst_n);
// AL Status event
wire [7:0] al_status_sr;
wire [7:0] al_status_nxt = alstat_r;
wire al_status_ena = sof;
gnrl_dfflr #(8,8'h01) al_status_sfflr(al_status_ena,al_status_nxt,al_status_sr,clk,rst_n);
wire al_se_ena = (sof & (|(al_status_sr ^ alstat_r))) | (rd_alstat &  src);
wire al_se_nxt = (rd_alstat & src)? 1'b0: 1'b1;
wire al_se_r;
gnrl_dfflr #(1,1'b0) al_se_dfflr(al_se_ena,al_se_nxt,al_se_r,clk,rst_n);
// dc latch event
wire dc_le_r = 1'b0;
// Mirrors values of each SyncManager Status
wire [7:0] mir_sm_r = 8'd0;
wire [7:0] ecat_req0_r;
wire [7:0] ecat_req1_r;
assign ecat_req0_r = {mir_sm_r[3:0],al_se_r,dl_se_r,1'b0,dc_le_r};
assign ecat_req1_r = {4'd0,mir_sm_r[7:4]};
assign ecat_event_req = {ecat_req1_r,ecat_req0_r};
//////////////////////////////////////////////////////
// Register AL Event Request
// TODO: dc latch event
// TODO: state of dc sync

//////////////////////////////////////////////////////
wire sel_alevent_req0 = valid & (addr==16'h0220);
wire rd_alevent_req0 = read & sel_alevent_req0; 
wire sel_alevent_req1 = valid & (addr==16'h0221);
wire rd_alevent_req1 = read & sel_alevent_req0;
wire sel_alevent_req2 = valid & (addr==16'h0222);
wire rd_alevent_req2 = read & sel_alevent_req0;
wire sel_alevent_req3 = valid & (addr==16'h0223);
wire rd_alevent_req3 = read & sel_alevent_req0;
// AL Control event
wire al_ce_r = ~alctrl_state;
// DC Latch event
wire dc_le_pdi_r = 1'b0;
// State of DC SYNC0
//wire st_s0_r = (syncconf_r[3])? dc_sync0:1'b0;
wire st_s0_r = 1'b0;
// State of DC SYNC1
//wire st_s1_r = (syncconf_r[7])? dc_sync1:1'b0;
wire st_s1_r = 1'b0;
// SyncManager activation register changed
wire sm_a_r = 1'b0;
// EEPROM Emulation
wire eep_e_r = eeprom_event;
// Watchdog Process Data
wire wp_d_r = pdo_expired;
// SyncManager interrupt
wire [15:0] sm_r = 16'd0;
wire [7:0] alevent_req0_r = {1'b0,wp_d_r,eep_e_r,sm_a_r,st_s1_r,st_s0_r,
                             dc_le_pdi_r,al_ce_r};
wire [7:0] alevent_req1_r = sm_r[7:0];
wire [7:0] alevent_req2_r = sm_r[15:8];
wire [7:0] alevent_req3_r = 8'd0;

assign pdi_irq = |{(alevent_req3_r & al_mask3_r),(alevent_req2_r & al_mask2_r),
                   (alevent_req1_r & al_mask1_r),(alevent_req0_r & al_mask0_r)};
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
// Error Counters
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// Register RX Error Counter Port 0~3
////////////////////////////////////////////////////////
wire sel_invalid_frame0 = valid & (addr==16'h0300);
wire rd_invalid_frame0 = read & sel_invalid_frame0;
wire [7:0] invalid_frame0_r = 8'd0;
wire sel_invalid_frame1 = valid & (addr==16'h0302);
wire rd_invalid_frame1 = read & sel_invalid_frame1;
wire [7:0] invalid_frame1_r = 8'd0;
wire sel_invalid_frame2 = valid & (addr==16'h0304);
wire rd_invalid_frame2 = read & sel_invalid_frame2;
wire [7:0] invalid_frame2_r = 8'd0;
wire sel_invalid_frame3 = valid & (addr==16'h0306);
wire rd_invalid_frame3 = read & sel_invalid_frame3;
wire [7:0] invalid_frame3_r = 8'd0;
wire sel_rx_error0 = valid & (addr==16'h0301);
wire rd_rx_error0 = read & sel_rx_error0;
wire [7:0] rx_error0_r = 8'd0;
wire sel_rx_error1 = valid & (addr==16'h0303);
wire rd_rx_error1 = read & sel_rx_error1;
wire [7:0] rx_error1_r = 8'd0;
wire sel_rx_error2 = valid & (addr==16'h0305);
wire rd_rx_error2 = read & sel_rx_error2;
wire [7:0] rx_error2_r = 8'd0;
wire sel_rx_error3 = valid & (addr==16'h0307);
wire rd_rx_error3 = read & sel_rx_error3;
wire [7:0] rx_error3_r = 8'd0;
////////////////////////////////////////////////////////
// Register Forwarded RX Error Counter Port 0~3
////////////////////////////////////////////////////////
wire sel_fwd_rxerr_count0 = valid & (addr==16'h0308);
wire rd_fwd_rxerr_count0 = read & sel_fwd_rxerr_count0;
wire [7:0] fwd_rxerr_count0_r = 8'd0;
wire sel_fwd_rxerr_count1 = valid & (addr==16'h0309);
wire rd_fwd_rxerr_count1 = read & sel_fwd_rxerr_count1;
wire [7:0] fwd_rxerr_count1_r = 8'd0;
wire sel_fwd_rxerr_count2 = valid & (addr==16'h030a);
wire rd_fwd_rxerr_count2 = read & sel_fwd_rxerr_count2;
wire [7:0] fwd_rxerr_count2_r = 8'd0;
wire sel_fwd_rxerr_count3 = valid & (addr==16'h030b);
wire rd_fwd_rxerr_count3 = read & sel_fwd_rxerr_count3;
wire [7:0] fwd_rxerr_count3_r = 8'd0;
////////////////////////////////////////////////////////
// Register ECAT Processing Unit Error Counter
////////////////////////////////////////////////////////
wire sel_unit_err = valid & (addr==16'h030c);
wire rd_unit_err = read & sel_unit_err;
wire [7:0] unit_err_r = 8'd0;
////////////////////////////////////////////////////////
// Register PDI Error Counter
////////////////////////////////////////////////////////
wire sel_pdi_err = valid & (addr==16'h030d);
wire rd_pdi_err = read & sel_pdi_err;
wire [7:0] pdi_err_r = 8'd0;
////////////////////////////////////////////////////////
// Register Lost Link Counter Port 0~3
////////////////////////////////////////////////////////
wire sel_ll_count0 = valid & (addr==16'h0310);
wire rd_ll_count0 = read & sel_ll_count0;
wire [7:0] ll_count0_r = 8'd0;
wire sel_ll_count1 = valid & (addr==16'h0311);
wire rd_ll_count1 = read & sel_ll_count1;
wire [7:0] ll_count1_r = 8'd0;
wire sel_ll_count2 = valid & (addr==16'h0312);
wire rd_ll_count2 = read & sel_ll_count2;
wire [7:0] ll_count2_r = 8'd0;
wire sel_ll_count3 = valid & (addr==16'h0313);
wire rd_ll_count3 = read & sel_ll_count3;
wire [7:0] ll_count3_r = 8'd0;
////////////////////////////////////////////////////////
// Output interface
////////////////////////////////////////////////////////
wire ready_nxt = (~read & sel_alctrl & src)? alctrl_state: 
               (read & sel_alctrl & (~src))? ~alctrl_state:1'b1;
gnrl_dffr #(1,1'b0) ready_dffr(ready_nxt,ready,clk,rst_n);               
wire [7:0] rdata_nxt;
assign rdata_nxt = ({8{rd_ktype}} & ktype_r) | ({8{rd_krev}} & krev_r) |
               ({8{rd_kbuild0}} & kbuild0_r) | ({8{rd_kbuild1}} & kbuild1_r) |
               ({8{rd_kfmmu}} & kfmmu_r) | ({8{rd_ksm}} & ksm_r) |
               ({8{rd_kram}} & kram_r) | ({8{rd_kport}} & kport_r) |
               ({8{rd_kfeature0}} & kfeature0_r) | ({8{rd_kfeature1}} & kfeature1_r) |
               ({8{rd_fpaddr0}} & fpaddr0_r) | ({8{rd_fpaddr1}} & fpaddr1_r) |
               ({8{rd_fpalias0}} & fpalias0_r) | ({8{rd_fpalias1}} & fpalias1_r) |
               ({8{rd_wpregen}} & wpregen_r) | ({8{rd_wpregpr}} & wpregpr_r) |
               ({8{rd_wpen}} & wpen_r) | ({8{rd_wppr}} & wppr_r) |
               ({8{rd_ecat_rst}} & ecat_rst_state_r) | ({8{rd_pdi_rst}} & pdi_rst_state_r) |
               ({8{rd_fwctrl}} & fwctrl_r) | ({8{rd_portctrl}} & portctrl_r) |
               ({8{rd_fifosize}} & fifosize_r) | ({8{rd_aliasen}} & aliasen_r) |
               ({8{rd_rwoffset0}} & rwoffset0_r) | ({8{rd_rwoffset1}} & rwoffset1_r) |
               ({8{rd_dlstat0}} & dlstat0_r) | ({8{rd_dlstat1}} & dlstat1_r) |
               ({8{rd_alctrl}} & alctrl_r) | ({8{rd_alstat}} & alstat_r) |
               ({8{rd_alstat_code0}} & alstat_code0_r) | ({8{rd_alstat_code1}} & alstat_code1_r) |
               ({8{rd_runled}} & runled_r) | ({8{rd_errled}} & errled_r) |
               ({8{rd_pdictrl}} & pdictrl_r) | ({8{rd_escconf}} & escconf_r) |
               ({8{rd_pdiconf}} & pdiconf_r) | ({8{rd_syncconf}} & syncconf_r) |
               ({8{rd_pdiext_conf0}} & pdiext_conf0_r) | ({8{rd_pdiext_conf1}} & pdiext_conf1_r) |
               ({8{rd_ecat_mask0}} & ecat_mask0_r) | ({8{rd_ecat_mask1}} & ecat_mask1_r) |
               ({8{rd_al_mask0}} & al_mask0_r) | ({8{rd_al_mask1}} & al_mask1_r) |
               ({8{rd_al_mask2}} & al_mask2_r) | ({8{rd_al_mask3}} & al_mask3_r) |
               ({8{rd_ecat_req0}} & ecat_req0_r) | ({8{rd_ecat_req1}} & ecat_req1_r) |
               ({8{rd_alevent_req0}} & alevent_req0_r) | ({8{rd_alevent_req1}} & alevent_req1_r) |
               ({8{rd_alevent_req2}} & alevent_req1_r) | ({8{rd_alevent_req3}} & alevent_req3_r) |
               ({8{rd_invalid_frame0}} & invalid_frame0_r) | ({8{rd_invalid_frame1}} & invalid_frame1_r) |
               ({8{rd_invalid_frame2}} & invalid_frame2_r) | ({8{rd_invalid_frame3}} & invalid_frame3_r) |
               ({8{rd_rx_error0}} & rx_error0_r) | ({8{rd_rx_error1}} & rx_error1_r) |
               ({8{rd_rx_error2}} & rx_error2_r) | ({8{rd_rx_error0}} & rx_error3_r) |
               ({8{rd_fwd_rxerr_count0}} & fwd_rxerr_count0_r) |
               ({8{rd_fwd_rxerr_count1}} & fwd_rxerr_count1_r) |
               ({8{rd_fwd_rxerr_count2}} & fwd_rxerr_count2_r) |
               ({8{rd_fwd_rxerr_count3}} & fwd_rxerr_count3_r) |
               ({8{rd_unit_err}} & unit_err_r) | ({8{rd_pdi_err}} & pdi_err_r) |
               ({8{rd_ll_count0}} & ll_count0_r) | ({8{rd_ll_count1}} & ll_count1_r) |
               ({8{rd_ll_count2}} & ll_count2_r) | ({8{rd_ll_count3}} & ll_count3_r);
gnrl_dffr #(8,8'd0) rdata_dffr(rdata_nxt,rdata,clk,rst_n);               
endmodule
