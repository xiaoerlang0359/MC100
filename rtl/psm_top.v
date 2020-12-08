`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/09 22:24:28
// Design Name: 
// Module Name: psm_top
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


module psm_top #(
    parameter PORT = 0
)(
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
    input  link_up,
// dhsm interface
    output rx_valid,
    output [1:0] rx_port,
    output [15:0] rx_byte,
    output [7:0] rx_data,
    input  tx_valid,
    input  [1:0] tx_port,
    input  [15:0] tx_byte,
    input  [7:0] tx_data,
    output port_link,
    output [15:0] rx_byte_cnt_r,
// sys interface
    input clk,
    input clk2,
    input rst_n
    );
//////////////////////////////////////////
// gen rx data
//////////////////////////////////////////
wire rx_cnt_r;
wire rx_cnt_nxt;
wire rx_crc_error;
assign rx_cnt_nxt = (link_up & rx_ctl)? (rx_cnt_r+1):1'b0;
gnrl_dffr #(1,1'b0) rx_cnt_dffr(rx_cnt_nxt,rx_cnt_r,clk,rst_n);
wire [3:0] rx_data_r1;
wire [3:0] rx_data_r2;
wire [3:0] rx_data_nxt = {rxd3,rxd2,rxd1,rxd0};
gnrl_dfflr #(4,4'd0) rx_data1_dfflr(rx_ctl,rx_data_nxt,rx_data_r1,clk,rst_n);
gnrl_dfflr #(4,4'd0) rx_data2_dfflr(rx_ctl,rx_data_r1,rx_data_r2,clk,rst_n);
//////////////////////////////////////////
// rx byte count
//////////////////////////////////////////
wire [15:0] rx_byte_cnt_nxt;
assign rx_byte_cnt_nxt = (~rx_ctl)? 16'd0:
                         (rx_cnt_r==1'b1)? (rx_byte_cnt_r+1):rx_byte_cnt_r;
gnrl_dffr #(16,16'd0) rx_byte_cnt_dfflr(rx_byte_cnt_nxt,rx_byte_cnt_r,clk,rst_n);
reg  [15:0] rx_byte_r;
always @(*)begin
    if (rx_byte_cnt_r==0) rx_byte_r = 16'd0;
    else if ((rx_byte_cnt_r>0) && (rx_byte_cnt_r<8)) rx_byte_r = 16'd1;
    else if (rx_byte_cnt_r==8) rx_byte_r = 16'd2;
    else if ((rx_byte_cnt_r>8) && (rx_byte_cnt_r<14)) rx_byte_r = 16'd3;
    else if (rx_byte_cnt_r==14) rx_byte_r = 16'd4;
    else if ((rx_byte_cnt_r>14)&& (rx_byte_cnt_r<20)) rx_byte_r = 16'd5;
    else if (rx_byte_cnt_r==20) rx_byte_r = 16'd8;
    else if (rx_byte_cnt_r==21) rx_byte_r = 16'd9;
    else if ((rx_byte_cnt_r!=0)&&(~rx_ctl)&&(~rx_crc_error)) rx_byte_r = 16'hffff;
    else if ((rx_byte_cnt_r!=0)&&(~rx_ctl)&&(rx_crc_error)) rx_byte_r = 16'hfffe;
    else rx_byte_r = rx_byte_cnt_r - 16'd12;
end
///////////////////////////////////////////
// rx interface
///////////////////////////////////////////
assign rx_valid = (link_up)? (rx_cnt_r==1'b1):tx_valid;
assign rx_port = PORT;
assign rx_byte = (link_up)? rx_byte_r:tx_byte;
assign rx_data = (link_up)? {rx_data_nxt,rx_data_r1}:tx_data;
///////////////////////////////////////////
// tx interface
///////////////////////////////////////////
wire tx_valid_r;
gnrl_dffr #(1,1'b0) tx_valid_dffr(tx_valid,tx_valid_r,clk,rst_n);
wire tx_ctl_r;
gnrl_dffr #(1,1'b0) tx_ctrl_dffr((tx_valid|tx_valid_r),tx_ctl_r,clk,rst_n);
wire [7:0] tx_data_r;
gnrl_dfflr #(8,8'd0) tx_data_dfflr(tx_valid,tx_data,tx_data_r,clk,rst_n);
wire [3:0] txd_sim = (tx_valid_r)? tx_data_r[3:0]: tx_data_r[7:4];
assign txd0 = txd_sim[0];
assign txd1 = txd_sim[1];
assign txd2 = txd_sim[2];
assign txd3 = txd_sim[3];
assign port_link = link_up;
assign tx_clk=clk;
assign tx_ctl = tx_ctl_r;
//reg neg_clk;
//always @(negedge clk2)begin
//    if (tx_ctl_r)
//        neg_clk<=~clk;
//    else neg_clk<=1'b0;
//end
//assign tx_ctl = tx_ctl_r & neg_clk;

//ODDR2   
//#(
//.DDR_ALIGNMENT ("NONE"),
//.INIT (1'b0),
//.SRTYPE ("SYNC")
//)
//u1_ODDR2
//(
//.C0 (clk),
//.C1 (~clk),
//.Q  (tx_clk),
//.CE (1'b1),
//.D0 (1'b1),
//.D1 (1'b0),
//.R  (1'b0),
//.S  (1'b0)
//);
wire rx_crc_en;
wire [31:0] rx_crc_data;
wire [31:0] rx_crc_nxt;

assign rx_crc_en = rx_ctl & (rx_byte_r>1) & link_up;
CRC32_D4 rx_crc32(
    .clk(clk),
    .rst_n(rst_n),
    .data(rx_data_nxt),
    .crc_en(rx_crc_en),
    .crc_clr(~rx_crc_en),
    .crc_data(rx_crc_data),
    .crc_next(rx_crc_nxt),
    .crc_error(rx_crc_error)
);
endmodule
