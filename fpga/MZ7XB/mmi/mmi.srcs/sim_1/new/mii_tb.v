`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 22:21:23
// Design Name: 
// Module Name: mii_tb
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


module mii_tb();
reg sof;
reg eof;
reg valid;
reg [15:0] addr;
reg [7:0] wdata;
reg read;
wire ready;
wire [7:0] rdata;
wire mdc;
wire mdio;
reg clk;
reg rst_n;
initial begin
    sof <= 0;
    eof <= 0;
    rst_n <= 0;
    clk <= 0;
    valid <= 0;
    addr <= 0;
    wdata <= 0;
    read <= 0;
    #10 rst_n<=1;
    @(posedge ready)
    #5 valid<=1;
    addr<= 16'h0510;
    wdata<=8'b0000_1001;
    #10 addr <=16'h0511;
    wdata<=8'b0000_0010;
    #10 
    addr<= 16'h0512;
    wdata<=8'b1000_0001;
    #10 addr<=16'h0513;
    wdata<=8'b0000_0001;
    #10 addr<=16'h0514;
    wdata<=8'b0000_0000;
    #10 addr<=16'h0515;
    wdata<=8'b0010_0001;
    #10 valid=0;
    #10 eof=1;
    #10 eof=0;
end
always #5 clk<=~clk;

mii_top u_mii_top(
// fifo interface
    .sof(sof),
    .eof(eof),
    .valid(valid),
    .addr(addr),
    .wdata(wdata),
    .read(read),
    .ready(ready),
    .rdata(rdata),
// mii interface
    .mdc(mdc),
    .mdio(mdio),
// sys interface
    .clk(clk),
    .rst_n(rst_n)
);
endmodule
