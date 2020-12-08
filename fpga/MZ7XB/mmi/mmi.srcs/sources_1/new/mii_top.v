`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/04 13:06:05
// Design Name: 
// Module Name: mii_top
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


module mii_top(
// fifo interface
    input sof,
    input eof,
    input valid,
    input [15:0] addr,
    input [7:0] wdata,
    input read,
    output ready,
    output reg [7:0] rdata,
// mii interface
    output mdc,
    inout mdio,
// sys interface
    input clk,
    input rst_n
    );
    
localparam PREIDLE_S = 5'b00000;
localparam IDLE_S = 5'b00001;
localparam PREDATA_S = 5'b00010;
localparam WRITE_S = 5'b00100;
localparam READ_S = 5'b01000;
localparam BUSY_S = 5'b10000;
localparam PREIDLE_MDIO_O = 32'b0101_0000_1000_0010_0010_0001_0000_0000;
localparam PREIDLE_MDIO_T = 32'b0000_0000_0000_0000_0000_0000_0000_0000;

wire [4:0] state;
reg  [4:0] next_state;
wire ready_nxt;
  
wire mdio_o;
wire mdio_i;
wire mdio_t;
IOBUF mdio_rtl_0_mdio_iobuf
   (.I(mdio_o),
    .IO(mdio),
    .O(mdio_i),
    .T(mdio_t));
    
//////////////////////////////////////////
//MII Management Control0
//////////////////////////////////////////

wire sel_miictrl0 = valid & (addr == 16'h0510);
wire rd_miictrl0 = read & sel_miictrl0;
wire wr_miictrl0 = ~read & sel_miictrl0 & ready_nxt;
wire [7:0] miictrl0_r;
wire miipdi_r = 1'b0;
wire miiwen_r;
wire miiwen_nxt;
wire miiwen_ena = sof | wr_miictrl0;
assign miiwen_nxt = (miipdi_r) ? 1'b1:
                    (sof)? 1'b0:wdata[0];
gnrl_dfflr #(1,1'b0) miiwen_dfflr(miiwen_ena,miiwen_nxt,miiwen_r,clk,rst_n);
wire miidt_r = 1'b0;
wire [4:0] miiphyad0_r;
wire [4:0] miiphyad0_nxt;
wire miiphyad0_ena = wr_miictrl0;
assign miiphyad0_nxt = wdata[7:3];
gnrl_dfflr #(5,5'd1) miiphyad0_dfflr(miiphyad0_ena,miiphyad0_nxt,miiphyad0_r,clk,rst_n);
assign miictrl0_r = {miiphyad0_r,miidt_r,miipdi_r,miiwen_r};

//////////////////////////////////////
//MII Management Control
//////////////////////////////////////

wire sel_miictrl1 = valid & (addr == 16'h0511);
wire rd_miictrl1 = read & sel_miictrl1;
wire wr_miictrl1 = ~read & sel_miictrl1 & ready_nxt;
wire [7:0] miictrl1_r;
wire miiread_r;
wire miiread_nxt;
wire miiread_ena;
assign miiread_ena = wr_miictrl1 | (state==BUSY_S);
assign miiread_nxt = (state==BUSY_S)? 1'b0:wdata[0];
gnrl_dfflr #(1,1'b0) miiread_dfflr(miiread_ena,miiread_nxt,miiread_r,clk,rst_n);
wire miiwrite_r;
wire miiwrite_nxt;
wire miiwrite_ena;
assign miiwrite_ena = (state==BUSY_S) | (wr_miictrl1 & miiwen_r);
assign miiwrite_nxt = (state==BUSY_S)? 1'b0:wdata[1];
gnrl_dfflr #(1,1'b0) miiwrite_dfflr(miiwrite_ena,miiwrite_nxt,miiwrite_r,clk,rst_n);
wire miierror_r;
wire miierror_nxt;
wire miierror_ena;
assign miierror_ena = wr_miictrl1;
assign miierror_nxt = (wdata[1:0]==2'b11)? 1'b1:
                      (wdata[1] && (!miiwen_r))? 1'b1:1'b0;
gnrl_dfflr #(1,1'b0) miierror_dfflr(miierror_ena,miierror_nxt,miierror_r,clk,rst_n);
wire miibusy_r = (state!=IDLE_S);
assign miictrl1_r = {miibusy_r,miierror_r,4'd0,miiwrite_r,miiread_r};

///////////////////////////////////////
//Register MII PHY Address
///////////////////////////////////////
wire sel_miiphyad = valid & (addr == 16'h0512);
wire rd_miiphyad = read & sel_miiphyad;
wire wr_miiphyad = ~read & sel_miiphyad & ready_nxt;
wire [7:0] miiphyad_r;
wire [7:0] miiphyad_nxt;
assign miiphyad_nxt = wdata;
gnrl_dfflr #(8,8'h00) miiphyad_dfflr(wr_miiphyad,miiphyad_nxt,miiphyad_r,clk,rst_n);
///////////////////////////////////////////
//Register MII PHY Register Address
///////////////////////////////////////////
wire sel_miiregad = valid & (addr == 16'h0513);
wire rd_miiregad = read & sel_miiregad;
wire wr_miiregad = ~read & sel_miiregad & ready_nxt;
wire [7:0] miiregad_r;
wire [7:0] miiregad_nxt;
assign miiregad_nxt =wdata;
gnrl_dfflr #(8,8'h00) miiregad_dfflr(wr_miiregad,miiregad_nxt,miiregad_r,clk,rst_n);
//////////////////////////////////////////
//Register MII PHY Data
//////////////////////////////////////////
wire sel_miidata0 = valid & (addr == 16'h0514);
wire rd_miidata0 = read & sel_miidata0;
wire wr_miidata0 = ~read & sel_miidata0 & ready_nxt;
wire [7:0] miidata0_r;
wire [7:0] miidata0_nxt;
wire miidata0_ena;
wire cout;
assign miidata0_ena = wr_miidata0 | (state==READ_S);
assign {cout,miidata0_nxt} = (state==READ_S)? {miidata0_r,mdio_i}: wdata;
gnrl_dfflr #(8,8'h00) miidata0_dfflr(miidata0_ena,miidata0_nxt,miidata0_r,clk,rst_n);

wire sel_miidata1 = valid & (addr == 16'h0515);
wire rd_miidata1 = read & sel_miidata1;
wire wr_miidata1 = ~read & sel_miidata1 & ready_nxt;
wire [7:0] miidata1_r;
wire [7:0] miidata1_nxt;
wire miidata1_ena;
assign miidata1_ena = wr_miidata1 | (state==READ_S);
assign miidata1_nxt = (state==READ_S)? {miidata1_r[6:0],cout}:wdata;
gnrl_dfflr #(8,8'h00) miidata1_dfflr(miidata1_ena,miidata1_nxt,miidata1_r,clk,rst_n);

///////////////////////////////////////////
//state machine
///////////////////////////////////////////

gnrl_dffr #(5,PREIDLE_S) miistate_dffr(next_state,state,clk,rst_n);
wire miicnt_ena;
wire [4:0] miicnt_nxt;
wire [4:0] miicnt_r;
assign miicnt_ena = (state != IDLE_S);
assign miicnt_nxt = (state == BUSY_S)? 5'd0:
                    (state != IDLE_S)? miicnt_r+1: miicnt_r;
gnrl_dfflr #(5,5'd0) miicnt_dfflr(miicnt_ena,miicnt_nxt,miicnt_r,clk,rst_n);

always @(*)begin
case(state)
    PREIDLE_S: if (miicnt_r==5'd31) next_state = IDLE_S;
               else next_state = PREIDLE_S;
    IDLE_S: if (eof && (miiwrite_r | miiread_r)) next_state = PREDATA_S;
            else next_state = IDLE_S;
    PREDATA_S: if (miicnt_r==5'd15) begin
                    if (miiwrite_r) next_state =WRITE_S;
                    else next_state =READ_S;
                end
                else next_state = PREDATA_S;
    WRITE_S: if (miicnt_r==5'd31) next_state = BUSY_S;
             else next_state = WRITE_S;
    READ_S:  if (miicnt_r==5'd31) next_state = BUSY_S;
             else next_state = READ_S;
    BUSY_S: next_state = IDLE_S;
    default: next_state = IDLE_S;
endcase
end

////////////////////////////////////////////
//mdio
////////////////////////////////////////////

reg [31:0] mdio_o_r;
reg [31:0] mdio_t_r;
reg [31:0] mdio_o_nxt;
reg [31:0] mdio_t_nxt;

always @(*)begin
    if (state == PREIDLE_S && next_state == PREIDLE_S)begin
        mdio_o_nxt = {mdio_o_r[30:0],1'b0};
        mdio_t_nxt = {mdio_t_r[30:0],1'b1};
    end 
    else if (state==IDLE_S && next_state==IDLE_S)begin
        mdio_o_nxt = 32'd0;
        mdio_t_nxt = 32'hffff_ffff;
    end
    else if (state==IDLE_S && next_state==PREDATA_S && miiwrite_r)begin
        mdio_o_nxt = {4'b0101, miiphyad_r[4:0], miiregad_r[4:0], 2'b10, miidata1_r,miidata0_r};
        mdio_t_nxt = 32'd0;
    end
    else if (state==IDLE_S && next_state==PREDATA_S && miiread_r) begin
        mdio_o_nxt = {4'b0110, miiphyad_r[4:0], miiregad_r[4:0], 2'b10,16'd0};
        mdio_t_nxt = 32'h0000_ffff;
    end
    else if (next_state==BUSY_S | next_state==IDLE_S)begin
        mdio_o_nxt = 32'd0;
        mdio_t_nxt = 32'hffff_ffff;
    end
    else begin
        mdio_o_nxt = {mdio_o_r[30:0],1'b0};
        mdio_t_nxt = {mdio_t_r[31:0],1'b1};
    end
end
        
always @(negedge clk or negedge rst_n)begin
if (rst_n==1'b0)begin
    mdio_o_r<= PREIDLE_MDIO_O;
    mdio_t_r<= PREIDLE_MDIO_T;
end else begin
    mdio_o_r<= mdio_o_nxt;
    mdio_t_r<= mdio_t_nxt;
end
end 

assign mdio_o = mdio_o_r[31];
assign mdio_t = mdio_t_r[31];                      
assign mdc = clk;
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
//.Q  (mdc),
//.CE (1'b1),
//.D0 (1'b1),
//.D1 (1'b0),
//.R  (1'b0),
//.S  (1'b0)
//);

////////////////////////////////////////////
//fifo_interface output
////////////////////////////////////////////
assign ready_nxt = ~miibusy_r;
gnrl_dffr #(1,1'b0) ready_dffr(ready_nxt,ready,clk,rst_n);
wire [7:0] rdata_nxt;
assign rdata_nxt = ({8{sel_miictrl0}} & miictrl0_r) |
               ({8{sel_miictrl1}} & miictrl1_r) |
               ({8{sel_miiphyad}} & miiphyad_r) |
               ({8{sel_miiregad}} & miiregad_r) |
               ({8{sel_miidata0}} & miidata0_r) |
               ({8{sel_miidata1}} & miidata1_r);
gnrl_dffr #(8,8'd0) rdata_dffr(rdata_nxt,rdata,clk,rst_n);
               
endmodule
