`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/29 16:55:16
// Design Name: 
// Module Name: sm_channel
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
// how to manage the rsp signal for pdi interface
// how to deal with one cycle latch for sram read op
// eof need to consider wkc, need a new signal success
// deal with apb interface, the ready and valid signal 
// need to consider rdata match which valid
module sm_channel#(
    parameter OFFSET = 16'h0800
)(
// fifo interfce
    input sof,
    input eof,
    input success,
    input valid,
    input read,
    input [15:0] addr,
    input [7:0] wdata,
    input src,
    output ready,
    output [7:0] rdata,
// ecat pdu interface
    input ecat_valid,
    input ecat_read,
    input [15:0] ecat_addr,
    input [7:0] ecat_wdata,
    output reg ecat_ready,
    output [7:0] ecat_rdata,
// pdi pdu interface
    input pdi_valid,
    input pdi_read,
    input [15:0] pdi_addr,
    input [7:0] pdi_wdata,
    output reg pdi_ready,
    output [7:0] pdi_rdata,
    output reg pdi_rsp,
// dual port sram interface
    output channel_hit,
    output reg [15:0] addra,
    output reg [7:0] dina,
    output reg ena,
    output reg wea, // 1 for write 0 for read
    output reg [15:0] addrb,
    output reg enb,
    input [7:0] doutb,
// irq interface
    output smact_event,
// system interface
    input clk,
    input rst_n
    );

localparam BR_IDLE = 5'b00001;
localparam BW_IDLE = 5'b00010;
localparam MR_IDLE = 5'b00100;
localparam MW_IDLE = 5'b01000;
localparam OFF = 5'b10000;

wire smch_en_r;
////////////////////////////////////////////////
// Register physical Start Address SyncManager
////////////////////////////////////////////////
wire sel_smstart_addr0 = valid & (addr == (16'h0000 + OFFSET));
wire rd_smstart_addr0 = read & sel_smstart_addr0;
wire wr_smstart_addr0 = ~read & sel_smstart_addr0 & src & (~smch_en_r);
wire [7:0] smstart_addr0_r;
wire [7:0] smstart_addr0_nxt = wdata;
gnrl_dfflr #(8,8'd0) smstart_addr0_dfflr(wr_smstart_addr0,smstart_addr0_nxt,smstart_addr0_r,clk,rst_n);
wire sel_smstart_addr1 = valid & (addr == (16'h0001 + OFFSET));
wire rd_smstart_addr1 = read & sel_smstart_addr1;
wire wr_smstart_addr1 = ~read & sel_smstart_addr1 & src & (~smch_en_r);
wire [7:0] smstart_addr1_r;
wire [7:0] smstart_addr1_nxt = wdata;
gnrl_dfflr #(8,8'd0) smstart_addr1_dfflr(wr_smstart_addr1,smstart_addr1_nxt,smstart_addr1_r,clk,rst_n);
//////////////////////////////////////////////////
// Register Length SyncManager
//////////////////////////////////////////////////
wire sel_smlen0 = valid & (addr == (16'h0002 + OFFSET));
wire rd_smlen0 = read & sel_smlen0;
wire wr_smlen0 = ~read & sel_smlen0 & src & (~smch_en_r);
wire [7:0] smlen0_r;
wire [7:0] smlen0_nxt = wdata;
gnrl_dfflr #(8,8'd0) smlen0_dfflr(wr_smlen0,smlen0_nxt,smlen0_r,clk,rst_n);
wire sel_smlen1 = valid & (addr == (16'h0003 + OFFSET));
wire rd_smlen1 = read & sel_smlen1;
wire wr_smlen1 = ~read & sel_smlen1 & src & (~smch_en_r);
wire [7:0] smlen1_r;
wire [7:0] smlen1_nxt = wdata;
gnrl_dfflr #(8,8'd0) smlen1_dfflr(wr_smlen1,smlen1_nxt,smlen1_r,clk,rst_n);
//////////////////////////////////////////////////
// Register Control Register SyncManager
//////////////////////////////////////////////////
wire sel_smctrl = valid & (addr == (16'h0004 + OFFSET));
wire rd_smctrl = read & sel_smctrl;
wire wr_smctrl = ~read & sel_smctrl & src & (~smch_en_r);
wire [7:0] smctrl_r;
wire [7:0] smctrl_nxt = wdata;
gnrl_dfflr #(8,8'd0) smctrl_dfflr(wr_smctrl,smctrl_nxt,smctrl_r,clk,rst_n);
wire smtype_r = smctrl_r[1:0];
wire smdir_r = smctrl_r[2];
wire smirq_ecat_r = smctrl_r[4];
wire smirq_pdi_r = smctrl_r[5];
wire smwd_en_r = smctrl_r[6];
////////////////////////////////////////////////////
// Register Status Register SyncManager
////////////////////////////////////////////////////
reg smirq_write_r;
reg smirq_read_r;
reg smmb_status_r;
reg [1:0] smbuf_status_r;
wire sel_smstatus = valid & (addr == (16'h0005 + OFFSET));
wire rd_smstatus = read & sel_smstatus;
wire smstatus_r = {2'b00,smbuf_status_r,smmb_status_r,1'b0,smirq_read_r,smirq_write_r};
////////////////////////////////////////////////////
// Register Activate SyncManager
// #TODO: al event 220.4 (change set, read clr)
////////////////////////////////////////////////////
wire sel_smact = valid & (addr == (16'h0006 + OFFSET));
wire rd_smact = read & sel_smact;
wire wr_smact = ~read & sel_smact & src;
wire [7:0] smact_r;
wire [7:0] smact_nxt = wdata;
gnrl_dfflr #(8,8'd0) smact_dfflr(wr_smact,smact_nxt,smact_r,clk,rst_n);
assign smch_en_r = smact_r[0];
wire smrep_req_r = smact_r[1];
wire [7:0] smacts_r;
wire [7:0] smacts_nxt = smact_r;
wire smacts_ena = sof;
gnrl_dfflr #(8,8'd0) smacts_dfflr(smacts_ena,smacts_nxt,smacts_r,clk,rst_n);
wire smact_event_r;
wire smact_event_ena = (sof & (|(smacts_r ^ smact_r))) |
                       (rd_smact & (~src));
wire smact_event_nxt = (rd_smact & (~src))? 1'b0:1'b1;
gnrl_dfflr #(1,1'b0) smact_event_dfflr(smact_event_ena,smact_event_nxt,smact_event_r,clk,rst_n);
assign smact_event = smact_event_r;
/////////////////////////////////////////////////////
// Register PDI Control SyncManager
/////////////////////////////////////////////////////
wire sel_smpdi_ctrl = valid & (addr == (16'd0007 + OFFSET));
wire rd_smpdi_ctrl = read & sel_smpdi_ctrl;
wire wr_smpdi_ctrl = ~read & sel_smpdi_ctrl & (~src);
wire [7:0] smpdi_ctrl_r;
wire [7:0] smpdi_ctrl_nxt = wdata;
gnrl_dfflr #(8,8'd0) smpdi_ctrl_dfflr(wr_smpdi_ctrl,smpdi_ctrl_nxt,smpdi_ctrl_r,clk,rst_n);
wire smch_disable_r = smpdi_ctrl_r[0];
/////////////////////////////////////////////////////
// SY state machine
/////////////////////////////////////////////////////
wire [15:0] p_start_r[2:0];
assign p_start_r[0] = {smstart_addr1_r,smstart_addr0_r};
assign p_start_r[1] = p_start_r[0] + {smlen1_r,smlen0_r};
assign p_start_r[2] = p_start_r[1] + {smlen1_r,smlen0_r};
wire [16:0] ecat_offset = ({17{ecat_valid}} & {1'b0,ecat_addr}) - 
                           {1'b0,p_start_r[0]};
wire ecat_start = (ecat_offset==16'd0);
wire ecat_hit = (~ecat_offset[16]) & 
                (ecat_offset[15:0]<{smlen1_r,smlen0_r});
wire ecat_end = (ecat_addr==(p_start_r[1] - 1'b1));
wire [16:0] pdi_offset = ({17{pdi_valid}} & {1'b0,pdi_addr}) - 
                           {1'b0,p_start_r[0]};
wire pdi_start = (pdi_offset==17'd0);
wire pdi_hit = (~pdi_offset[16]) & 
                (pdi_offset[15:0]<{smlen1_r,smlen0_r});
wire pdi_end = (pdi_addr==(p_start_r[1] - 1'b1));
wire [4:0] state;
reg [4:0] next_state;
gnrl_dffr #(5,5'b10000) state_dffr(next_state,state,clk,rst_n);
always @(*)begin
    if (eof)begin
        if (smch_en_r && (~smch_disable_r) && (smtype_r==2'b00) && smdir_r)
            next_state = BW_IDLE;
        else if (smch_en_r && (~smch_disable_r) && (smtype_r==2'b00) && (~smdir_r))
            next_state = BR_IDLE;
        else if (smch_en_r && (~smch_disable_r) && (smtype_r==2'b10) && smdir_r)
            next_state = MW_IDLE;
        else if (smch_en_r && (~smch_disable_r) && (smtype_r==2'b10) && (~smdir_r))
            next_state = MR_IDLE;
        else next_state = OFF;
    end
    else next_state = next_state;
end

reg eact;
reg uact;
reg [1:0] buffer;
reg [1:0] user;
reg [1:0] free;
reg [1:0] next;
reg terminate;
reg [2:0] act;
always @(posedge clk or rst_n)begin
if (~rst_n)begin
    eact<=1'b0;
    uact<=1'b0;
    buffer<=2'b00;
    user<=2'b01;
    free<=2'b10;
    next<=2'b11;
    terminate<=16'd0;
    act<=3'd0;
    smirq_write_r<=1'b0;
    smirq_read_r<=1'b0;
    smmb_status_r<=1'b0;
    smbuf_status_r<=2'b11;
end
else begin
    case (state)
        BR_IDLE: if (next_state!=state) begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
            else begin
                if (pdi_valid & (~pdi_read) & pdi_hit & pdi_ready) begin
                    if (pdi_start & (~pdi_end) & (~uact))begin
                        uact<=1'b1;
                        smirq_read_r<=1'b0;
                    end
                    if (pdi_start & (~pdi_end) & (~uact))begin
                        smirq_read_r<=1'b0;
                    end
                    if (pdi_start & pdi_end & (~uact)) begin
                        smirq_read_r<=1'b0;
                        smirq_write_r<=1'b1;
                        if (next==2'b11) begin
                            next<=user;
                            user<=free;
                            free<=2'b11;
                        end
                        else begin
                            next<=user;
                            user<=next;
                        end
                        smbuf_status_r<=user;
                    end
                    if (pdi_start & pdi_end & uact) begin
                        smirq_read_r<=1'b0;
                        smirq_write_r<=1'b1;
                        if (next==2'b11) begin
                            next<=user;
                            user<=free;
                            free<=2'b11;
                        end
                        else begin
                            next<=user;
                            user<=next;
                        end
                        smbuf_status_r<=user;
                        uact<=1'b0;
                    end 
                    if ((~pdi_start) & pdi_end & uact) begin
                        smirq_write_r<=1'b1;
                        if (next==2'b11) begin
                            next<=user;
                            user<=free;
                            free<=2'b11;
                        end
                        else begin
                            next<=user;
                            user<=next;
                        end
                        smbuf_status_r<=user;
                        uact<=1'b0;
                    end                                           
                end
                if (ecat_valid & ecat_read & ecat_hit)begin
                    if (ecat_start & (~ecat_end) & (~eact))begin
                        if (next!=2'b11)begin
                            free<=buffer;
                            buffer<=next;
                            next<=2'b11;
                        end
                        eact<=1'b1;
                        smirq_write_r<=1'b0;
                    end
                    if (ecat_start & (~ecat_end) & eact)begin
                        smirq_write_r<=1'b0;
                    end
                    if (ecat_start & ecat_end & (~eact))begin
                        if (next!=2'b11)begin
                            free<=buffer;
                            buffer<=next;
                            next<=2'b11;
                        end
                        eact<=1'b1;
                        terminate<=1'b1;
                        smirq_write_r<=1'b0;
                    end
                    if (ecat_start & ecat_end & eact) begin
                        terminate<=1'b1;
                        smirq_write_r<=1'b0;
                    end
                    if ((~ecat_start) & ecat_end & eact) begin
                        terminate<=1'b1;
                    end 
                end
                if (eof) begin
                    if (success && terminate)begin
                        eact<=1'b0;
                        terminate<=1'b0;
                        smirq_read_r<=1'b1;    
                    end
                    if ((~success) && (~terminate))begin
                        eact<=1'b0;
                    end
                    if ((~success) && terminate)begin
                        eact<=1'b0;
                        terminate<=1'b0;
                    end
                    if (success && (~terminate))begin
                        // nothing need to do, we will need a second read
                    end
                end           
            end
        BW_IDLE: if (next_state!=state) begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
            else begin
                if (pdi_valid & pdi_read & pdi_hit & pdi_ready) begin
                    if (pdi_start & (~pdi_end) & (~uact))begin
                        if (next!=2'b11) begin
                            free<=user;
                            user<=next;
                            next<=2'b11;
                        end
                        uact<=1'b1;
                        smirq_write_r<=1'b0;
                    end
                    if (pdi_start & (~pdi_end) & uact) begin
                        smirq_write_r<=1'b0;
                    end
                    if (pdi_start & pdi_end & (~uact))begin
                        smirq_write_r<=1'b0;
                        smirq_read_r<=1'b1;
                    end
                    if (pdi_start & pdi_end & uact)begin
                        smirq_write_r<=1'b0;
                        smirq_read_r<=1'b1;
                        uact<=1'b0;
                    end
                    if ((~pdi_start) & pdi_end & uact)begin
                        smirq_read_r<=1'b1;
                        uact<=1'b0;
                    end
                end
                if (ecat_valid & (~ecat_read) & ecat_hit)begin
                    if (ecat_start & (~ecat_end) & (~eact))begin
                        eact<=1'b1;
                        smirq_read_r<=1'b0;
                    end
                    if (ecat_start & (~ecat_end) & eact)begin
                        smirq_read_r<=1'b0;
                    end
                    if (ecat_start & ecat_end & (~eact))begin
                        eact<=1'b1;
                        smirq_read_r<=1'b0;
                        terminate<=1'b1;
                    end
                    if (ecat_start & ecat_end & eact) begin
                        smirq_read_r<=1'b0;
                        terminate<=1'b1;
                    end
                    if ((~ecat_start) & ecat_end & eact)begin
                        terminate<=1'b1;
                    end                    
                end
                if (eof) begin
                    if (success & terminate) begin
                        eact<=1'b0;
                        terminate<=1'b0;
                        if (next==2'b11) begin
                            next<=buffer;
                            buffer<=free;
                            free<=2'b11;
                        end
                        else begin
                            next<=buffer;
                            buffer<=next;
                        end
                        smbuf_status_r<=buffer;
                        smirq_write_r<=1'b1;
                    end
                    if (success & (~terminate))begin
                    // nothing to do
                    end
                    if ((~success) & terminate)begin
                        terminate<=1'b0;
                        eact<=1'b0;
                    end
                    if ((~success) & (~terminate))begin
                        eact<=1'b0;
                    end
                end
            end
        MR_IDLE: if (next_state!=state) begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
            else begin
                if (pdi_valid & (~pdi_read) & pdi_hit & pdi_ready)begin
                    if (pdi_start & (~pdi_end) & (act==0))begin
                        act<=3'd1;
                        smirq_read_r<=1'b0;
                    end
                    if (pdi_start & pdi_end & (act==0))begin
                        act<=3'd2;
                        smirq_read_r<=1'b0;
                        smirq_write_r<=1'b1;
                        smmb_status_r<=1'b1;
                    end
                    if (~pdi_start & pdi_end & (act==1))begin
                        act<=3'd2;
                        smirq_write_r<=1'b1;
                        smmb_status_r<=1'b1;
                    end
                end
                if (ecat_valid & ecat_read & ecat_hit)begin
                    if (ecat_start & (~ecat_end) & (act==2))begin
                        smirq_write_r<=1'b0;
                        act<=3'd3;
                    end
                    if (ecat_start & ecat_end & (act==2))begin
                        act<=3'd4;
                        terminate<=1'b1;
                        smirq_write_r<=1'b0;
                    end
                    if ((~ecat_start) & ecat_end & (act==3))begin
                        act<=3'd4;
                        terminate<=1'b1;
                    end
                end
                if (eof) begin
                    if (terminate & success)begin
                        terminate<=1'b0;
                        act<=3'd0;
                        smmb_status_r<=1'b0;
                        smirq_read_r<=1'b1;
                    end
                    if (success & (~terminate))begin
                    // nothing to do
                    end
                    if ((~success) & terminate)begin
                        terminate<=1'b0;
                        act<=3'd2;
                    end
                    if ((~success) & (~terminate))begin
                        act<=3'd2;
                    end
                end
            end
        MW_IDLE: if (next_state!=state) begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
            else begin
                if (pdi_valid & pdi_read & pdi_hit & pdi_ready)begin
                    if (pdi_start & (~pdi_end) & (act==3'd3))begin
                        act<=3'd4;
                        smirq_write_r<=1'b0;
                    end
                    if (pdi_start & pdi_end & (act==3'd3))begin
                        act<=3'd0;
                        smmb_status_r<=1'b0;
                        smirq_write_r<=1'b0;
                        smirq_read_r<=1'b1;
                    end
                    if ((~pdi_start) & pdi_end & (act==3'd4))begin
                        act<=3'd0;
                        smmb_status_r<=1'b0;
                        smirq_read_r<=1'b1;
                    end
                end
                if (ecat_valid & (~ecat_read) & ecat_hit)begin
                    if (ecat_start & (~ecat_end) & (act==3'd0))begin
                        act<=3'd1;
                        smirq_read_r<=1'b0;
                    end
                    if (ecat_start & ecat_end & (act==3'd0))begin
                        act<=3'd2;
                        terminate<=1'b1;
                        smirq_read_r<=1'b0;
                    end
                    if ((~ecat_start) & ecat_end & (act==3'd1))begin
                        act<=3'd2;
                        terminate<=1'b1;
                    end
                end
                if (eof) begin
                    if (success & terminate)begin
                        terminate<=1'b0;
                        act<=3'd3;
                        smmb_status_r<=1'b1;
                        smirq_write_r<=1'b1;
                    end
                    if (success & (~terminate))begin
                    // nothing to do
                    end
                    if ((~success) & terminate)begin
                        terminate<=1'b0;
                        act<=3'd0;
                    end
                    if ((~success) & terminate)begin
                        act<=3'd0;
                    end
                end
            end
        OFF: if (next_state!=state)begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
            else begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;
            end
        default:begin
                eact<=1'b0;
                uact<=1'b0;
                buffer<=2'b00;
                user<=2'b01;
                free<=2'b10;
                next<=2'b11;
                terminate<=1'b0;
                act<=3'd0;
                smirq_write_r<=1'b0;
                smirq_read_r<=1'b0;
                smmb_status_r<=1'b0;
                smbuf_status_r<=2'b11;       
            end
    endcase                         
end
end
always @(posedge clk or negedge rst_n)begin
if (~rst_n)begin
    pdi_ready<=1'b0;
    pdi_rsp<=1'b0;
end
else begin
    pdi_ready<=1'b0;
    pdi_rsp<=1'b0;
    case (state)
        BR_IDLE:
            if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                if ((~pdi_start) & (~uact))
                    pdi_rsp<=1'b1;
                else pdi_rsp<=1'b0;
            end
            else if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                pdi_rsp<=1'b1;
            end
        BW_IDLE:
            if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                if ((~pdi_start) & (~uact))
                    pdi_rsp<=1'b1;
                else pdi_rsp<=1'b0;
            end
            else if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                pdi_rsp<=1'b1;
            end
        MR_IDLE:
            if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                if (pdi_start & (act!=0))
                    pdi_rsp<=1'b1;
                else if ((~pdi_start) & (act!=1))
                    pdi_rsp<=1'b1;
                else pdi_rsp<=1'b0;
            end
            else if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                pdi_rsp<=1'b1;
            end
        MW_IDLE:
            if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                if (pdi_start & (act!=3))
                    pdi_rsp<=1'b1;
                else if ((~pdi_start) & (act!=4))
                    pdi_rsp<=1'b1;
                else pdi_rsp<=1'b0;
            end
            else if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
                pdi_ready<=1'b1;
                pdi_rsp<=1'b1;
            end
        default: begin
            pdi_ready<=1'b0;
            pdi_rsp<=1'b0;
        end
    endcase
end 
end

always @(*)begin
case (state)
    BR_IDLE: 
        if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
            addra=pdi_offset + p_start_r[user];
            dina=pdi_wdata;
            if ((~pdi_start) & (~uact))
                ena=1'b0;
            else ena=1'b1;
            wea=1'b1;
        end
        else begin
            addra = 16'd0;
            dina = 8'd0;
            ena = 1'b0;
            wea = 1'b1;
        end
    BW_IDLE:
        if (ecat_valid & (~ecat_read) & ecat_hit)begin
            addra = ecat_offset + p_start_r[buffer];
            dina = ecat_wdata;
            if ((~ecat_start) & (~eact))
                ena = 1'b0;
            else ena = 1'b1;
            wea = 1'b1;
        end
        else begin
            addra = 16'd0;
            dina = 8'd0;
            ena = 1'b0;
            wea = 1'b1;
        end
    MR_IDLE:
        if (pdi_valid & (~pdi_read) & pdi_hit & (~pdi_ready))begin
            addra = pdi_addr;
            dina = pdi_wdata;
            if (pdi_start & (act!=0))
                ena = 1'b0;
            else if ((~pdi_start) & (act!=1))
                ena = 1'b0;
            else ena = 1'b1;
            wea = 1'b1;
        end
        else begin
            addra = 16'd0;
            dina = 8'd0;
            ena = 1'b0;
            wea = 1'b1;    
        end
    MW_IDLE:
        if (ecat_valid & (~ecat_read) & ecat_hit)begin
            addra = ecat_addr;
            dina = ecat_wdata;
            if (ecat_start & (act!=1'b0))
                ena = 1'b0;
            else if ((~ecat_start) & (act!=1'b1))
                ena = 1'b0;
            else ena = 1'b1;
            wea = 1'b1;
        end
        else begin
            addra = 16'd0;
            dina = 8'd0;
            ena = 1'b0;
            wea = 1'b1;
        end
    default: begin
        addra = 16'd0;
        dina = 8'd0;
        ena = 1'b0;
        wea = 1'b1;
    end           
endcase
end

always @(*)begin
case (state)
    BR_IDLE:
        if (ecat_valid & ecat_read & ecat_hit)begin
            if (ecat_start & (next!=2'b11) & (~eact))
                addrb = p_start_r[next] + ecat_offset;
            else addrb = p_start_r[buffer] + ecat_offset;
            if ((~ecat_start) & (~eact))
                enb = 1'b0;
            else enb = 1'b1;
        end
        else begin
            addrb = 16'd0;
            enb = 1'b0;
        end
    BW_IDLE:
        if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
            if (pdi_start & (next!=2'b11) & (~eact))
                addrb = p_start_r[next] + pdi_offset;
            else addrb = p_start_r[user] + pdi_offset;
            if ((~pdi_start) & (~uact))
                enb = 1'b0;
            else enb = 1'b1;
        end
        else begin
            addrb = 16'd0;
            enb = 1'b0;
        end
    MR_IDLE:
        if (ecat_valid & ecat_read & ecat_hit)begin
            addrb = ecat_addr;
            if (ecat_start & (act!=2))
                enb = 1'b0;
            else if ((~ecat_start) & (act!=3))
                enb = 1'b0;
            else enb = 1'b1;
        end
        else begin
            addrb = 16'd0;
            enb = 1'b0;
        end
    MW_IDLE:
        if (pdi_valid & pdi_read & pdi_hit & (~pdi_ready))begin
            addrb = pdi_addr;
            if (pdi_start & (act!=3))
                enb = 1'b0;
            else if ((~pdi_start) & (act!=4))
                enb = 1'b0;
        end
        else begin
            addrb = 16'd0;
            enb = 1'b0;
        end
    default: 
        begin
            addrb = 16'd0;
            enb = 1'b0;
        end
endcase
end

always @(*)begin
case(state)
    BR_IDLE: 
        if (ecat_valid & ecat_read & ecat_hit)begin
            if ((~ecat_start) & (~eact))
                ecat_ready = 1'b0;
            else ecat_ready = 1'b1;
        end
        else ecat_ready = 1'b0;
    BW_IDLE:
        if (ecat_valid & (~ecat_read) & ecat_hit)begin
            if ((~ecat_start) & (~eact))
                ecat_ready = 1'b0;
            else ecat_ready = 1'b1;
        end
        else ecat_ready = 1'b0;
    MR_IDLE:
        if (ecat_valid & ecat_read & ecat_hit) begin
            if (ecat_start & (act!=2))
                ecat_ready = 1'b0;
            else if ((~ecat_start) & (act!=3))
                ecat_ready = 1'b0;
            else ecat_ready = 1'b1;
        end
        else ecat_ready = 1'b0;
    MW_IDLE:
        if (ecat_valid & (~ecat_read) & ecat_hit) begin
            if (ecat_start & (act!=0))
                ecat_ready = 1'b0;
            else if ((~ecat_start) & (act!=1))
                ecat_ready = 1'b0;
            else ecat_ready = 1'b1;
        end
        else ecat_ready = 1'b0;
    default: ecat_ready = 1'b0;
endcase
end
endmodule
