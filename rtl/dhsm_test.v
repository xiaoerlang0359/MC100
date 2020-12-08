`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/13 11:53:57
// Design Name: 
// Module Name: dhsm_test
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


module dhsm_test(
// mii interface
    input rx_clk,
    input rx_ctl,
    input rxd0,
    input rxd1,
    input rxd2,
    input rxd3,
    output tx_clk,
    output tx_ctl,
    output txd0,
    output txd1,
    output txd2,
    output txd3,
// fifo interface
    output fifo_sof,
    output fifo_eof,
    output fifo_valid,
    output fifo_read,
    output [15:0] fifo_addr,
    output [7:0] fifo_wdata,
    input  [7:0] fifo_rdata,
    input  fifo_ready,
// port ctrl interface
    input [1:0] port0_ctrl,
    input [1:0] port1_ctrl,
    output port0_link,
    output port1_link,
// fmmu interface
    output [31:0] logic_addr,
    output logic_read,
    output logic_write,
    input  [15:0] rd_paddr,
    input  [15:0] wr_paddr,
    input  rdaddr_hit,
    input  wraddr_hit,
// interrupt interface
    input  [15:0] event_req,
    input  [15:0] event_msk,
// fp address interface
    input  [15:0] fp_addr,
// dc latch interface
    output port0_latch,
    output port1_latch,
// sys interface
    input clk2,
    input clk,
    input rst_n
    );
wire rx0_valid;
wire [15:0] rx0_byte;
wire [7:0] rx0_data;
wire tx0_valid;
wire [15:0] tx0_byte;
wire [7:0] tx0_data;
wire [15:0] rx0_byte_cnt_r;
psm_top #(.PORT(0)
)psm_top_port0(
// mii interface
    .rx_clk(clk),
    .rx_ctl(rx_ctl),
    .rxd0(rxd0),
    .rxd1(rxd1),
    .rxd2(rxd2),
    .rxd3(rxd3),
    .tx_clk(tx_clk),
    .tx_ctl(tx_ctl),
    .txd0(txd0),
    .txd1(txd1),
    .txd2(txd2),
    .txd3(txd3),
    .link_up(1'b1),
// dhsm interface
    .rx_valid(rx0_valid),
    .rx_port(),
    .rx_byte(rx0_byte),
    .rx_data(rx0_data),
    .tx_valid(tx0_valid),
    .tx_port(2'd0),
    .tx_byte(tx0_byte),
    .tx_data(tx0_data),
    .port_link(port0_link),
    .rx_byte_cnt_r(rx0_byte_cnt_r),
// sys interface
    .clk2(clk2),
    .clk(clk),
    .rst_n(rst_n)
);
wire rx1_valid;//
wire [15:0] rx1_byte;//
wire [7:0] rx1_data;//
wire tx1_valid;//
wire [15:0] tx1_byte;//
wire [7:0] tx1_data;//
wire [15:0] rx1_byte_cnt_r;//

dhsm_top u_dhsm_top(
// port 0 interface
    .rx0_valid(rx0_valid),
    .rx0_byte(rx0_byte),
    .rx0_data(rx0_data),
    .rx0_byte_cnt_r(rx0_byte_cnt_r),
    .tx0_valid(tx0_valid),
    .tx0_byte(tx0_byte),
    .tx0_data(tx0_data),
    .port0_link(port0_link),
// prot 1 interface
    .rx1_valid(rx1_valid),//
    .rx1_byte(rx1_byte),//
    .rx1_data(rx1_data),//
    .rx1_byte_cnt_r(rx1_byte_cnt_r),//
    .tx1_valid(tx1_valid),//
    .tx1_byte(tx1_byte),//
    .tx1_data(tx1_data),//
    .port1_link(port1_link),//
// dc interface
    .port0_latch(port0_latch),//
    .port1_latch(port1_latch),//
// sm interface
    
// fifo interface
    .fifo_sof(fifo_sof),//
    .fifo_eof(fifo_eof),//
    .fifo_valid(fifo_valid),//
    .fifo_read(fifo_read),//
    .fifo_addr(fifo_addr),//
    .fifo_wdata(fifo_wdata),//
    .fifo_rdata(fifo_rdata),//
    .fifo_ready(fifo_ready),// 
// fmmu interface
    .logic_addr(logic_addr),//
    .logic_read(logic_read),//
    .logic_write(logic_write),//
    .rd_paddr(rd_paddr),//
    .wr_paddr(wr_paddr),//
    .rdaddr_hit(rdaddr_hit),//
    .wraddr_hit(wraddr_hit),//
// interupt interface
    .event_req(event_req),//
    .event_msk(event_msk),//
// fp address interface
    .fp_addr(fp_addr),//
// sys interface
    .clk(clk),
    .rst_n(rst_n)
);    

psm_top #(.PORT(1)
)psm_top_port1(
// mii interface
    .rx_clk(clk),
    .rx_ctl(1'b0),
    .rxd0(1'b0),
    .rxd1(1'b0),
    .rxd2(1'b0),
    .rxd3(1'b0),
    .tx_clk(),
    .tx_ctl(),
    .txd0(),
    .txd1(),
    .txd2(),
    .txd3(),
    .link_up(1'b0),
// dhsm interface
    .rx_valid(rx1_valid),
    .rx_port(),
    .rx_byte(rx1_byte),
    .rx_data(rx1_data),
    .tx_valid(tx1_valid),
    .tx_port(2'd1),
    .tx_byte(tx1_byte),
    .tx_data(tx1_data),
    .port_link(port1_link),
    .rx_byte_cnt_r(rx1_byte_cnt_r),
// sys interface
    .clk2(clk2),
    .clk(clk),
    .rst_n(rst_n)
);
endmodule
