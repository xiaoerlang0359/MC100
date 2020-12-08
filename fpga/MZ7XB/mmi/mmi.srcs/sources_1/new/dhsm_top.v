`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/10 21:03:31
// Design Name: 
// Module Name: dhsm_top
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


module dhsm_top(
// port 0 interface
    input  rx0_valid,
    input  [15:0] rx0_byte,
    input  [7:0] rx0_data,
    input  [15:0] rx0_byte_cnt_r,
    output tx0_valid,
    output [15:0] tx0_byte,
    output [7:0] tx0_data,
    input port0_link,
// prot 1 interface
    input  rx1_valid,//
    input  [15:0] rx1_byte,//
    input  [7:0] rx1_data,//
    input  [15:0] rx1_byte_cnt_r,
    output reg tx1_valid,//
    output reg [15:0] tx1_byte,//
    output reg [7:0] tx1_data,//
    input  port1_link,//
// dc interface
    output reg port0_latch,//
    output reg port1_latch,//
// sm interface
    
// fifo interface
    output reg fifo_sof,//
    output reg fifo_eof,//
    output fifo_valid,//
    output fifo_read,//
    output [15:0] fifo_addr,//
    output [7:0] fifo_wdata,//
    input  [7:0] fifo_rdata,//
    input  fifo_ready,// 
// fmmu interface
    output reg [31:0] logic_addr,//
    output logic_read,//
    output logic_write,//
    input  [15:0] rd_paddr,//
    input  [15:0] wr_paddr,//
    input  rdaddr_hit,//
    input  wraddr_hit,//
// interupt interface
    input [15:0] event_req,//
    input [15:0] event_msk,//
// fp address interface
    input [15:0] fp_addr,//
// sys interface
    input clk,
    input rst_n
    );
parameter STATE_WIDTH = 24;
localparam ETH  = 24'b0000_0000_0000_0000_0000_0001;
localparam ECAT = 24'b0000_0000_0000_0000_0000_0010;
localparam EIP  = 24'b0000_0000_0000_0000_0000_0100;
localparam ECMD = 24'b0000_0000_0000_0000_0000_1000;
localparam EIDX = 24'b0000_0000_0000_0000_0001_0000;
localparam EADL = 24'b0000_0000_0000_0000_0010_0000;
localparam EADH = 24'b0000_0000_0000_0000_0100_0000;
localparam EDAL = 24'b0000_0000_0000_0000_1000_0000;
localparam EDAH = 24'b0000_0000_0000_0001_0000_0000;
localparam ELEL = 24'b0000_0000_0000_0010_0000_0000;
localparam ELEH = 24'b0000_0000_0000_0100_0000_0000;
localparam EIRL = 24'b0000_0000_0000_1000_0000_0000;
localparam EIRH = 24'b0000_0000_0001_0000_0000_0000;
localparam EWKL = 24'b0000_0000_0010_0000_0000_0000;
localparam EDTI = 24'b0000_0000_0100_0000_0000_0000;
localparam EDTA = 24'b0000_0000_1000_0000_0000_0000;
localparam FCS4 = 24'b0000_0001_0000_0000_0000_0000;
localparam EPAD = 24'b0000_0010_0000_0000_0000_0000;
localparam SYPR = 24'b0000_0100_0000_0000_0000_0000;
localparam SYPW = 24'b0000_1000_0000_0000_0000_0000;
localparam EWKH = 24'b0001_0000_0000_0000_0000_0000;
localparam FCS1 = 24'b0010_0000_0000_0000_0000_0000;
localparam FCS2 = 24'b0100_0000_0000_0000_0000_0000;
localparam FCS3 = 24'b1000_0000_0000_0000_0000_0000;

localparam APRD = 8'h01;
localparam FPRD = 8'h04;
localparam BRD  = 8'h07;
localparam LRD  = 8'h0a;
localparam APWR = 8'h02;
localparam FPWR = 8'h05;
localparam BWR  = 8'h08;
localparam LWR  = 8'h0b;
localparam APRW = 8'h03;
localparam FPRW = 8'h06;
localparam BRW  = 8'h09;
localparam LRW  = 8'h0c;
localparam ARMW = 8'h0d;
localparam FRMW = 8'h0e;

/////////////////////////////////////////////////
// state machine
/////////////////////////////////////////////////
wire [STATE_WIDTH-1:0] state;
reg  [STATE_WIDTH-1:0] next_state;
gnrl_dffr #(STATE_WIDTH,0) state_dfflr(next_state,state,clk,rst_n);
reg [7:0] etype1;
reg [15:0] len;
reg [7:0] cmd;
reg [7:0] idx;
reg [15:0] paddr;
reg [31:0] laddr;
reg [15:0] raddr;
reg [15:0] pdu_len;
reg [15:0] byte_count;
reg addr_cout;
reg next;
reg read_wkc;
reg write_wkc;
reg read_valid;
reg write_valid;
reg pad_valid;
reg crc_en;
reg crc_clr;
wire b_cmd;
wire ap_cmd;
wire fp_cmd;
wire l_cmd;
wire b_ena;
wire ap_ena;
wire fp_ena;
wire l_ena;
wire ena;
wire read_cmd;
wire write_cmd;
wire [31:0] crc_data;
wire [31:0] crc_next;
wire crc_error;
assign b_cmd = (cmd==BRD) | (cmd==BWR) | (cmd==BRW);
assign ap_cmd = (cmd==APRD) | (cmd==APWR) | (cmd==APRW);
assign fp_cmd = (cmd==FPRD) | (cmd==FPWR) | (cmd==FPRW);
assign l_cmd = (cmd==LRD) | (cmd==LWR) | (cmd==LRW);
assign ap_ena = ap_cmd & (paddr==16'd0);
assign fp_ena = fp_cmd & (paddr==fp_addr);//
assign l_ena = l_cmd;
assign ena = ap_ena | fp_ena | l_ena | b_cmd | (cmd==ARMW) | (cmd==FRMW);
assign read_cmd = (cmd==BRD) | (cmd==APRD) | (cmd==LRD) | (cmd==LRW) | 
                  ((cmd==ARMW)&(paddr==16'd0)) | ((cmd==FRMW)&(paddr==fp_addr));
assign write_cmd= (cmd==BWR) | (cmd==APWR) | (cmd==LWR) | (cmd==LRW) |
                  ((cmd==ARMW)&(paddr!=16'd0)) | ((cmd==FRMW)&(paddr!=fp_addr));
always @(posedge clk or negedge rst_n)begin
if (rst_n==1'b0) begin
    tx1_valid <= 1'b0;
    tx1_byte <= 16'd0;
    tx1_data <= 8'd0;
    etype1 <= 8'd0;
    port0_latch <= 1'b0;
    port1_latch <= 1'b0;
    fifo_sof<=1'b0;
    fifo_eof<=1'b0;
    len<=16'd0;
    pdu_len<=16'd0;
    cmd<=8'd0;
    idx<=8'd0;
    paddr<=16'd0;
    raddr<=16'd0;
    laddr<=32'd0;
    addr_cout<=1'b0;
    next<=1'b0;
    read_wkc<=1'b0;
    write_wkc<=1'b0;
    read_valid<=1'b0;
    write_valid<=1'b0;
    pad_valid<=1'b0;
    crc_en<=1'b0;
    crc_clr<=1'b0;
    logic_addr<=32'd0;
    byte_count<=16'd0;
end
else begin
    tx1_valid <= 1'b0;
    port0_latch <= 1'b0;
    port1_latch <= 1'b0;
    fifo_sof<=1'b0;
    fifo_eof<=1'b0;
    case (state)
        ETH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                if (rx0_byte==16'd0) port0_latch<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if (rx0_byte==16'd1) crc_clr<=1'b1;
                if (rx0_byte==16'd2) crc_clr<=1'b0;
//              if (rx0_byte==16'd2) tx1_data<=8'h02;
//              if (rx0_byte==16'd3) tx1_data<=8'h00;
                crc_en<=1'b1;
                if (rx0_byte>16'd9) crc_en<=1'b0; 
                if (rx0_byte==16'd4) tx1_data<= rx0_data | 8'h02;
//              if (rx0_byte_cnt_r==16'd15) tx1_data<=8'h01;
//              if (rx0_byte_cnt_r==16'd16) tx1_data<=8'h05;
//              if (rx0_byte_cnt_r==16'd17) tx1_data<=8'h01;
//              if (rx0_byte_cnt_r==16'd18) tx1_data<=8'h00;
//              if (rx0_byte_cnt_r==18'd19) tx1_data<=8'h00;
                if (rx0_byte==16'd8) etype1<=rx0_data;
                if (rx0_byte>16'd9) tx1_valid<=1'b0;
                byte_count<=16'd0;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                crc_en<=1'b0;
            end
        EIP:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (rx0_byte==32) etype1<=rx0_data;
                if (rx0_byte<10) tx1_byte<=16'hfffe;
                if ((rx0_byte==36) || (rx0_byte==37)) tx1_data<=8'd0;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1; 
                crc_en<=1'b0;
            end       
        ECAT:if (rx0_valid)begin
                fifo_sof<=1'b1;
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if (rx0_byte<16'd10) tx1_byte <= 16'hfffe;
                if (rx0_byte==16'd10) len<=rx0_data;
                if (rx0_byte==16'd11 && ((rx0_data & 8'hf0)==8'h10)) len <= len | ({rx0_data,8'd0} & 16'h0f00);
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        ECMD:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                cmd<=rx0_data;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EIDX:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                idx<=rx0_data;
                crc_en<=1'b1;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1; 
            end              
        EADL:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                paddr<= {8'd0,rx0_data};
                laddr<= {24'd0,rx0_data};
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (cmd==BRD || cmd==BWR || cmd==BRW || cmd==APRD || cmd==APWR || cmd==APRW || cmd==ARMW)
                    {addr_cout,tx1_data[7:0]} <= {1'b0,rx0_data} + 9'd1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EADH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                crc_en<=1'b1;
                paddr<= (paddr | {rx0_data,8'd0});
                laddr<=laddr | {16'd0,rx0_data,8'd0};
                byte_count<=byte_count + 1;
                if (cmd==BRD || cmd==BWR || cmd==BRW || cmd==APRD || cmd==APWR || cmd==APRW || cmd==ARMW)
                    tx1_data <= rx0_data + addr_cout;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EDAL:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                crc_en<=1'b1;
                raddr<={8'd0,rx0_data};
                laddr<={8'd0,rx0_data,16'd0} | laddr;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin 
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EDAH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                raddr<=raddr | {rx0_data,8'd0};
                laddr<=laddr | {rx0_data,24'd0};
                crc_en<=1'b1;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        ELEL:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                pdu_len<={8'd0,rx0_data};
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end 
        ELEH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                pdu_len<=pdu_len | {(rx0_data & 8'h0f),8'd0};
                next<=((rx0_data & 8'h80)==8'h80);
                crc_en<=1'b1;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1; 
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EIRL:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data | (event_msk[7:0] & event_req[7:0]);
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1; 
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                crc_en<=1'b0;
            end
        EIRH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data | (event_msk[15:8] & event_req[15:8]);
                read_wkc<=read_cmd & ena;
                write_wkc<=write_cmd & ena;
                pdu_len<=pdu_len-1; 
                logic_addr<= laddr;
                crc_en<=1'b1;
                read_valid<=1'b0;
                write_valid<=1'b0;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1; 
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                crc_en<=1'b0;
            end 
        EDTI:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data;
                pdu_len<=pdu_len-1;
                byte_count<=byte_count + 1;
                crc_en<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
//        EDTA:if (rx0_valid)begin
//                fifo_valid <= write_cmd & (((~l_cmd)&ena) | (l_cmd & wraddr_hit));
//                write_valid <= write_cmd & (((~l_cmd)&ena) | (l_cmd & wraddr_hit));
//                fifo_addr<=({16{l_cmd}} & rd_paddr) | ({16{~l_cmd}} & raddr);
//                fifo_read<=1'b0;
//                fifo_wdata<=rx0_data;
//                crc_en<=1'b1;
//                raddr<=raddr+1;
//                logic_addr<=logic_addr+1;
//                pdu_len<=pdu_len-1;
//                tx1_valid<=1'b1;
//                tx1_byte<=rx0_byte;
//                if (cmd==BRD) tx1_data<=fifo_rdata | rx0_data;
//                else if (read_cmd) tx1_data<=fifo_rdata;
//                else tx1_data<=rx0_data;
//                if (read_valid) read_wkc<=read_wkc & fifo_ready;
//                else read_wkc<=read_wkc | 1'b1;
//                byte_count<=byte_count + 1;
//                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
//                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
//            end
//            else begin
//                fifo_valid <= read_cmd & (((~l_cmd)&ena) | (l_cmd & rdaddr_hit));
//                read_valid <= read_cmd & (((~l_cmd)&ena) | (l_cmd & rdaddr_hit));
//                fifo_addr<=({16{l_cmd}} & rd_paddr) | ({16{~l_cmd}} & raddr);
//                fifo_read<=1'b1;
//                crc_en<=1'b0;
//                if (write_valid) write_wkc<=write_wkc & fifo_ready;
//                else write_wkc = write_wkc & 1'b1;
//                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
//            end 
        EDTA:if (rx0_valid)begin
                crc_en<=1'b1;
                raddr<=raddr+1;
                logic_addr<=logic_addr+1;
                pdu_len<=pdu_len-1;
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                if (cmd==BRD) tx1_data<=fifo_rdata | rx0_data;
                else if (read_cmd) tx1_data<=fifo_rdata;
                else tx1_data<=rx0_data;
                if (fifo_valid) write_wkc<=write_wkc & fifo_ready;
                else write_wkc<=write_wkc & 1'b1;
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (fifo_valid) read_wkc<=read_wkc & fifo_ready;
                else read_wkc = read_wkc & 1'b1;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end 
        EWKL:if (rx0_valid)begin
                crc_en<=1'b1;
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                if (read_cmd & write_cmd) begin
                    if (read_wkc & write_wkc) {addr_cout,tx1_data}<={1'b0,rx0_data}+9'd3;
                    else if (read_wkc) {addr_cout,tx1_data}<={1'b0,rx0_data} + 9'd1;
                    else if (write_wkc) {addr_cout,tx1_data}<={1'b0,rx0_data} + 9'd2;
                end
                else if (read_cmd & read_wkc & ena) {addr_cout,tx1_data}<={1'b0,rx0_data} + 9'd1; // TODO: need to deal with logic cmd in many slaves
                else if (write_cmd & write_wkc & ena) {addr_cout,tx1_data}<={1'b0,rx0_data} + 9'd1;
                else {addr_cout,tx1_data}<={1'b0,rx0_data};
                byte_count<=byte_count + 1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end
        EWKH:if (rx0_valid)begin
                tx1_valid<=1'b1;
                tx1_byte<=rx0_byte;
                tx1_data<=rx0_data + addr_cout;
                byte_count<=byte_count + 1;
                pad_valid<=1'b0;
                crc_en<=1'b1;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe)) tx1_byte <= 16'hfffe;
            end
            else begin
                crc_en<=1'b0;
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
            end 
        EPAD:if (pad_valid)begin
                tx1_valid<=1'b1;
                tx1_data<=8'd0;
                pad_valid<=1'b0;
                crc_en<=1'b1;
                byte_count<=byte_count+1;
                if (rx0_byte==16'hfffe) tx1_byte<=16'hfffe; 
            end 
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                pad_valid<=1'b1;
                crc_en<=1'b0;
            end
        FCS1:if (pad_valid)begin
                tx1_valid<=1'b1; 
                tx1_data<={~crc_data[24],~crc_data[25],~crc_data[26],~crc_data[27],
                           ~crc_data[28],~crc_data[29],~crc_data[30],~crc_data[31]};
                pad_valid<=1'b0;
                crc_en<=1'b0;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if (rx0_byte==16'hfffe) tx1_byte <= 16'hfffe;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                pad_valid<=1'b1;
                crc_en<=1'b0;
            end
        FCS2:if (pad_valid)begin
                tx1_valid<=1'b1; 
                tx1_data<={~crc_data[16],~crc_data[17],~crc_data[18],~crc_data[19],
                           ~crc_data[20],~crc_data[21],~crc_data[22],~crc_data[23]};    
                pad_valid<=1'b0;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if (rx0_byte==16'hfffe) tx1_byte <= 16'hfffe;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1;
                pad_valid<=1'b1;
            end
        FCS3:if (pad_valid)begin
                tx1_valid<=1'b1; 
                tx1_data<={~crc_data[8],~crc_data[9],~crc_data[10],~crc_data[11],
                           ~crc_data[12],~crc_data[13],~crc_data[14],~crc_data[15]};   
                pad_valid<=1'b0; 
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
                if (rx0_byte==16'hfffe) tx1_byte <= 16'hfffe;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1; 
                pad_valid<=1'b1;
            end
        FCS4: if (pad_valid)begin
                tx1_valid<=1'b1;
                if (rx0_byte == 16'hfffe) tx1_byte<= 16'hfffe;
                else begin
                    tx1_byte<=16'hffff;
                    fifo_eof<=1'b1;
                end
                tx1_data<={~crc_data[0],~crc_data[1],~crc_data[2],~crc_data[3],
                           ~crc_data[4],~crc_data[5],~crc_data[6],~crc_data[7]};
                pad_valid<=1'b0;
                if (rx1_valid && (rx1_byte==16'd0)) port1_latch<=1'b1;
            end
            else begin
                if (rx1_valid && rx1_byte==16'd0) port1_latch<=1'b1; 
                pad_valid<=1'b1;
            end      
    endcase
end
end 

assign fifo_valid = ((read_cmd & (((~l_cmd)&ena) | (l_cmd & rdaddr_hit)) & (~rx0_valid))|
                    (write_cmd & (((~l_cmd)&ena) | (l_cmd & wraddr_hit)) & rx0_valid)) & 
                    (state==EDTA);
assign fifo_addr  = ({16{l_cmd}} & rd_paddr) | ({16{~l_cmd}} & raddr);
assign fifo_read  = ~rx0_valid;
assign fifo_wdata = rx0_data;

always @(*)begin
case (state)
    ETH:if (rx0_valid &&(rx0_byte==9) && (rx0_data==8'ha4) && (etype1==8'h88)) next_state = ECAT;
        else if (rx0_valid && (rx0_byte==9) && (rx0_data==8'h00) && (etype1==8'h08)) next_state = EIP;
        else next_state = ETH;
    EIP:if (rx0_valid && (rx0_byte<10)) next_state = ETH;
        else if (rx0_valid && ((rx0_byte==16'hffff)||(rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid && (rx0_byte==16'd10) && (rx0_data!=8'h45)) next_state = ETH;
        else if (rx0_valid && (rx0_byte==16'd19) && (rx0_data!=8'h11)) next_state = ETH;
//       else if (rx0_valid && (rx0_byte==16'd32) && (rx0_data!=8'h88)) next_state = ETH;
        else if (rx0_valid && (rx0_byte==16'd33) && ((rx0_data!=8'ha4)|(etype1!=8'h88))) next_state = ETH;
        else if (rx0_valid && (rx0_byte==16'h37)) next_state = ECAT;
        else next_state = EIP;
    ECAT:if (rx0_valid && (rx0_byte<10)) next_state = ETH;
        else if (rx0_valid && (rx0_byte==16'd11) && ((rx0_data & 8'hf0)==8'h10)) next_state = ECMD;
        else if (rx0_valid && (rx0_byte==16'd11) && ((rx0_data & 8'hf0)!=8'h10)) next_state = ETH;
        else if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else next_state = ECAT;
    ECMD:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EIDX;
        else next_state = ECMD;
    EIDX:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EADL;
        else next_state = EIDX;
    EADL:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EADH;
        else next_state = EADL;
    EADH:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EDAL;
        else next_state = EADH;
    EDAL:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EDAH;
        else next_state = EDAL;
    EDAH:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = ELEL;
        else next_state = EDAH;
    ELEL:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = ELEH;
        else next_state = ELEL;
    ELEH:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EIRL;
        else next_state = ELEH;
    EIRL:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EIRH;
        else next_state = EIRL;
    EIRH:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid && pdu_len==16'd0) next_state = EWKL;
        else if (rx0_valid && ena) next_state = EDTA;
        else if (rx0_valid && (~ena)) next_state = EDTI;
        else next_state = EIRH;
    EDTI:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid && pdu_len==16'd0) next_state = EWKL;
        else next_state = EDTI;
    EDTA:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid && pdu_len==16'd0) next_state = EWKL;
        else next_state = EDTA;
    EWKL:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid) next_state = EWKH;
        else next_state = EWKL;
    EWKH:if (rx0_valid &&((rx0_byte==16'hffff) || (rx0_byte==16'hfffe))) next_state = ETH;
        else if (rx0_valid && next) next_state = ECMD;
        else if (rx0_valid && (~next) && (byte_count>=45)) next_state = FCS1;
        else if (rx0_valid && (~next) && (byte_count<45)) next_state = EPAD;
        else next_state = EWKH;
    EPAD:if (rx0_byte==16'hfffe) next_state = ETH; // NOTE: delete pad valid
        else if (pad_valid && byte_count==45) next_state = FCS1;
        else next_state = EPAD;    
    FCS1:if (rx0_byte==16'hfffe) next_state = ETH;
        else if (pad_valid) next_state = FCS2;
        else next_state = FCS1;
    FCS2:if (rx0_byte==16'hfffe) next_state = ETH;
        else if (pad_valid) next_state = FCS3;
        else next_state = FCS2;
    FCS3:if (rx0_byte==16'hfffe) next_state = ETH;
        else if (pad_valid) next_state = FCS4;
        else next_state = FCS3; 
    FCS4:if (pad_valid) next_state = ETH;
        else next_state = FCS4; 
    default: next_state = ETH;
endcase
end 
///////////////////////////////////////////////////
// tx crc calculation
/////////////////////////////////////////////////// 
crc_d8 u_crc_d8(
    .clk(clk),
    .rst_n(rst_n),
    .data(tx1_data),
    .crc_en(crc_en),
    .crc_clr(crc_clr),
    .crc_data(crc_data),
    .crc_next(crc_next),
    .crc_error(crc_error)
    );
////////////////////////////////////////////////////
// ffmu interface
////////////////////////////////////////////////////
assign logic_read = l_cmd & read_cmd;
assign logic_write = l_cmd & write_cmd;
assign tx0_valid = rx1_valid;
assign tx0_byte = rx1_byte;
assign tx0_data = rx1_data;
endmodule
