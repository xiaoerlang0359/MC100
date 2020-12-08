`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/13 14:44:49
// Design Name: 
// Module Name: dhsm_tb
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


module dhsm_tb();
reg clk;
reg rx_ctl;
reg rst_n;
reg [3:0] rxd;
wire rxd0;
wire rxd1;
wire rxd2;
wire rxd3;
reg clk2;
assign rxd0 = rxd[0];
assign rxd1 = rxd[1];
assign rxd2 = rxd[2];
assign rxd3 = rxd[3];
initial begin
    clk<=1'b1;
    rst_n<=1'b0;
    rxd<=4'h0;
    clk2<=1'b1;
    #10 rst_n<=1'b1;
    rxd<=4'h5;
    rx_ctl<=1'b1;
    #10 rxd<=4'h5;
// sof    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'hd;
// dest mac address    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
// source mac address    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
 // eth type   
    #10 rxd<=4'h8;
    #10 rxd<=4'h8;
    
    #10 rxd<=4'h4;
    #10 rxd<=4'ha;
// ecat length   
    #10 rxd<=4'hd;
    #10 rxd<=4'h0;
// ecat type    
    #10 rxd<=4'h0;
    #10 rxd<=4'h1;
// cmd    
    #10 rxd<=4'h1;
    #10 rxd<=4'h0;
// idx    
    #10 rxd<=4'h0;
    #10 rxd<=4'h8;
// adp    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// ado    
    #10 rxd<=4'h0;
    #10 rxd<=4'h3;
    
    #10 rxd<=4'h1;
    #10 rxd<=4'h0;
// len    
    #10 rxd<=4'h2;
    #10 rxd<=4'h0;
// next    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// irq    
    #10 rxd<=4'h0;// TODO: x value
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;          
// data    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;

    #10 rxd<=4'h0;
    #10 rxd<=4'h0;    
// wkc    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// fcs    
    #10 rxd<=4'he;
    #10 rxd<=4'h4;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h1;
    
    #10 rxd<=4'he;
    #10 rxd<=4'hc;
    #10 rx_ctl<=1'b0;
////////////////////////////////////////////////////    
    #1000 rx_ctl<=1'b1;
    rxd<=4'h5;
    #10 rxd<=4'h5;
// sof    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h5;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'hd;
// dest mac address    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'hf;
// source mac address    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
 // eth type   
    #10 rxd<=4'h8;
    #10 rxd<=4'h8;
    
    #10 rxd<=4'h4;
    #10 rxd<=4'ha;
// ecat length   
    #10 rxd<=4'hd;
    #10 rxd<=4'h0;
// ecat type    
    #10 rxd<=4'h0;
    #10 rxd<=4'h1;
// cmd    
    #10 rxd<=4'h2;
    #10 rxd<=4'h0;
// idx    
    #10 rxd<=4'h0;
    #10 rxd<=4'h8;
// adp    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// ado    
    #10 rxd<=4'h2;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h0;
// len    
    #10 rxd<=4'h6;
    #10 rxd<=4'h0;
// next    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// irq    
    #10 rxd<=4'h0;// TODO: x value
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;          
// data    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h1;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h8;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// wkc    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
    
    #10 rxd<=4'h0;
    #10 rxd<=4'h0;
// fcs    
    #10 rxd<=4'h7;
    #10 rxd<=4'h7;
    
    #10 rxd<=4'h5;
    #10 rxd<=4'h1;
    
    #10 rxd<=4'h3;
    #10 rxd<=4'ha;
    
    #10 rxd<=4'hf;
    #10 rxd<=4'h5;
    #10 rx_ctl<=1'b0;
end    
always #5 clk = ~clk;
always #2.5 clk2= ~clk2;
ecat_top u_ecat_top( 
// mii interface
.rx_clk(clk),
.rx_ctl(rx_ctl),
.rxd0(rxd0),
.rxd1(rxd1),
.rxd2(rxd2),
.rxd3(rxd3),
.tx_clk(),
.tx_ctl(),
.txd0(),
.txd1(),
.txd2(),
.txd3(),
// mdio interface
.mdc(),
.mdio(),
// sys interface
.clk2(clk2),
.clk(clk),
.rst_n(rst_n)
);
endmodule
