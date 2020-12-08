`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 13:39:13
// Design Name: 
// Module Name: watch_dog
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


module watch_dog(
// fifo interface
    input sof,
    input eof,
    input valid,
    input read,
    input [15:0] addr,
    input [7:0] wdata,
    input src,//1 for ecat
    output ready,
    output reg [7:0] rdata,
// dl status interface
    output pdi_expired,
// interrupt interface
    output pdo_expired,
// sm watch dog enable
    input sm_pdo_en,
// access pdi or pdo
    input access_pdi,
    input access_pdo,
// sys interface
    input clk,
    input rst_n
    );
wire [15:0] pdo_count;
wire [15:0] pdi_count;
////////////////////////////////////////////
// Watchdog divider
////////////////////////////////////////////
wire sel_wddiv0 = valid & (addr == 16'h0400);
wire rd_wddiv0 = sel_wddiv0 & read;
wire wr_wddiv0 = sel_wddiv0 & (~read) & src;
wire [7:0] wddiv0_r;
wire [7:0] wddiv0_nxt = wdata;
gnrl_dfflr #(8,8'hc2) wddiv0_dfflr(wr_wddiv0,wddiv0_nxt,wddiv0_r,clk,rst_n);
wire sel_wddiv1 = valid & (addr == 16'h0401);
wire rd_wddiv1 = sel_wddiv0 & read;
wire wr_wddiv1 = sel_wddiv0 & (~read) & src;
wire [7:0] wddiv1_r;
wire [7:0] wddiv1_nxt;
gnrl_dfflr #(8,8'h09) wddiv1_dfflr(wr_wddiv1,wddiv1_nxt,wddiv1_r,clk,rst_n);
//////////////////////////////////////////
// Watchdog time pdi
//////////////////////////////////////////
wire sel_wdtime_pdi0 = valid & (addr == 16'h0410);
wire rd_wdtime_pdi0 = read & sel_wdtime_pdi0;
wire wr_wdtime_pdi0 = ~read & sel_wdtime_pdi0 & src;
wire [7:0] wdtime_pdi0_r;
wire [7:0] wdtime_pdi0_nxt = wdata;
gnrl_dfflr #(8,8'he8) wdtime_pdi0_dfflr(wr_wdtime_pdi0,wdtime_pdi0_nxt,wdtime_pdi0_r,clk,rst_n);
wire sel_wdtime_pdi1 = valid & (addr == 16'h0411);
wire rd_wdtime_pdi1 = read & sel_wdtime_pdi1;
wire wr_wdtime_pdi1 = ~read & sel_wdtime_pdi1 & src;
wire [7:0] wdtime_pdi1_r;
wire [7:0] wdtime_pdi1_nxt = wdata;
gnrl_dfflr #(8,8'h03) wdtime_pdi1_dfflr(wr_wdtime_pdi1,wdtime_pdi1_nxt,wdtime_pdi1_r,clk,rst_n);
////////////////////////////////////////////
// Watchdog Time process data
////////////////////////////////////////////
wire sel_wdtime_pdo0 = valid & (addr == 16'h0420);
wire rd_wdtime_pdo0 = read & sel_wdtime_pdo0;
wire wr_wdtime_pdo0 = ~read & sel_wdtime_pdo0 & src;
wire [7:0] wdtime_pdo0_r;
wire [7:0] wdtime_pdo0_nxt = wdata;
gnrl_dfflr #(8,8'he8) wdtime_pdo0_dfflr(wr_wdtime_pdo0,wdtime_pdo0_nxt,wdtime_pdo0_r,clk,rst_n);
wire sel_wdtime_pdo1 = valid & (addr == 16'h0421);
wire rd_wdtime_pdo1 = read & sel_wdtime_pdo1;
wire wr_wdtime_pdo1 = ~read & sel_wdtime_pdo1 & src;
wire [7:0] wdtime_pdo1_r;
wire [7:0] wdtime_pdo1_nxt = wdata;
gnrl_dfflr #(8,8'h03) wdtime_pdo1_dfflr(wr_wdtime_pdo1,wdtime_pdo1_nxt,wdtime_pdo1_r,clk,rst_n);
///////////////////////////////////////////////
// Watchdog Status Process Data
///////////////////////////////////////////////
wire sel_wdstat_pdo = valid & (addr == 16'h0440);
wire rd_wdstat_pdo = read & sel_wdstat_pdo;
wire wr_wdstat_pdo = ~read & sel_wdstat_pdo & (~src);
wire [7:0] wdstat_pdo_r;
wire [7:0] wdstat_pdo_nxt;
wire [7:0] wdstat_pdo_ena;
assign wdstat_pdo_ena = ((pdo_count=={wdtime_pdo1_r,wdtime_pdo0_r}) & ({wdtime_pdo1_r,wdtime_pdo0_r}!=16'd0) & sm_pdo_en) |
                        wr_wdstat_pdo;
assign wdstat_pdo_nxt = (wr_wdstat_pdo)? 8'd0:8'd1;
gnrl_dfflr #(8,8'h0) wdstat_pdo_dfflr(wdstat_pdo_ena,wdstat_pdo_nxt,wdstat_pdo_r,clk,rst_n);
///////////////////////////////////////////////
// Watchdog Counter Process Data
///////////////////////////////////////////////
wire sel_wdcount_pdo = valid & (addr == 16'h0442);
wire rd_wdcount_pdo = read & sel_wdcount_pdo;
wire wr_wdcount_pdo = ~read & sel_wdcount_pdo & src;
wire [7:0] wdcount_pdo_r;
wire [7:0] wdcount_pdo_nxt;
wire [7:0] wdcount_pdo_ena;
assign wdcount_pdo_ena = ((pdo_count=={wdtime_pdo1_r,wdtime_pdo0_r}) & ({wdtime_pdo1_r,wdtime_pdo0_r}!=16'd0) & sm_pdo_en) |
                         wr_wdcount_pdo;
assign wdcount_pdo_nxt = (wr_wdcount_pdo)? 8'd0:
                         (wdcount_pdo_r == 8'hff)? 8'hff: (wdcount_pdo_r + 1);
gnrl_dfflr #(8,8'h0) wdcount_pdo_dfflr(wdcount_pdo_ena,wdcount_pdo_nxt,wdcount_pdo_r,clk,rst_n);
/////////////////////////////////////////////////
// Watchdog Counter pdi
/////////////////////////////////////////////////
wire sel_wdcount_pdi = valid & (addr == 16'h0443);
wire rd_wdcount_pdi = read & sel_wdcount_pdi;
wire wr_wdcount_pdi = ~read & sel_wdcount_pdi & src;
wire [7:0] wdcount_pdi_r;
wire [7:0] wdcount_pdi_nxt;
wire [7:0] wdcount_pdi_ena;
assign wdcount_pdi_ena = ((pdi_count=={wdtime_pdi1_r,wdtime_pdi0_r}) & ({wdtime_pdi1_r,wdtime_pdi0_r}!=16'd0)) |
                         wr_wdcount_pdi;
assign wdcount_pdi_nxt = (wr_wdcount_pdi)? 8'd0:
                         (wdcount_pdi_r == 8'hff)? 8'hff: (wdcount_pdi_r + 1);
gnrl_dfflr #(8,8'h0) wdcount_pdi_dfflr(wdcount_pdi_ena,wdcount_pdi_nxt,wdcount_pdi_r,clk,rst_n);
//////////////////////////////////////////////////
// divide clock
//////////////////////////////////////////////////
wire [15:0] div_count_r;
wire [15:0] div_count_nxt;
assign div_count_nxt = (div_count_r == {wddiv1_r,wddiv0_r})? 16'd0: (div_count_r+1);
gnrl_dffr #(16,16'd0) div_count_dffr(div_count_nxt,div_count_r,clk,rst_n);
//////////////////////////////////////////////////
// divide counter
//////////////////////////////////////////////////
wire pdo_count_r;
wire [15:0] pdo_count_nxt;
wire [15:0] pdo_count_ena;
assign pdo_count_ena = ((div_count_r == {wddiv1_r,wddiv0_r}) & ({wdtime_pdo1_r,wdtime_pdo0_r}!=16'd0) & sm_pdo_en);
assign pdo_count_nxt = (access_pdo)? 16'd0:
                       (pdo_count_r == {wdtime_pdo1_r,wdtime_pdo0_r})? 16'd0: (pdo_count_r+1);
gnrl_dfflr #(16,16'd0) pdo_count_dfflr(pdo_count_ena,pdo_count_nxt,pdo_count_r,clk,rst_n);
assign pdo_count = pdo_count_r;
wire pdi_count_r;
wire [15:0] pdi_count_nxt;
wire [15:0] pdi_count_ena;
assign pdi_count_ena = ((div_count_r == {wddiv1_r,wddiv0_r}) & ({wdtime_pdi1_r,wdtime_pdi0_r}!=16'd0));
assign pdi_count_nxt = (access_pdi)? 16'd0:
                       (pdi_count_r == {wdtime_pdi1_r,wdtime_pdi0_r})? 16'd0: (pdi_count_r+1);
gnrl_dfflr #(16,16'd0) pdi_count_dfflr(pdi_count_ena,pdi_count_nxt,pdi_count_r,clk,rst_n);
assign pdi_count = pdi_count_r;
//////////////////////////////////////////////////
// output interface
//////////////////////////////////////////////////  
assign ready = 1'b1;
assign pdo_expired = wdstat_pdo_r[0];
wire pdi_expired_r;
wire pdi_expired_nxt;
wire pdi_expired_ena;
assign pdi_expired_ena = ((pdi_count_r == {wdtime_pdi1_r,wdtime_pdi0_r}) & ({wdtime_pdi1_r,wdtime_pdi0_r}!=0)) | access_pdi;
assign pdi_expired_nxt = (access_pdi)? 1'b0:1'b1;
gnrl_dfflr #(1,1'd0) pdi_expired_dfflr(pdi_expired_ena,pdi_expired_nxt,pdi_expired_r,clk,rst_n);
assign pdi_expired = ~pdi_expired_r;
wire [7:0] rdata_nxt;
assign rdata_nxt = ({8{rd_wddiv0}} & wddiv0_r) |
               ({8{rd_wddiv1}} & wddiv1_r) |
               ({8{rd_wdtime_pdi0}} & wdtime_pdi0_r) |
               ({8{rd_wdtime_pdi1}} & wdtime_pdi1_r) |
               ({8{rd_wdtime_pdo0}} & wdtime_pdo0_r) |
               ({8{rd_wdtime_pdo1}} & wdtime_pdo1_r) |
               ({8{rd_wdstat_pdo}}  & wdstat_pdo_r ) |
               ({8{rd_wdcount_pdo}} & wdcount_pdo_r) |
               ({8{rd_wdcount_pdi}} & wdcount_pdi_r);
gnrl_dffr #(8,8'd0) rdata_dffr(rdata_nxt,rdata,clk,rst_n);
endmodule
