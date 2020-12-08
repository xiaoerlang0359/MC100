`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/08 21:43:10
// Design Name: 
// Module Name: ffmu
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


module ffmu(
// fifo interface
    input sof,
    input eof,
    input valid,
    input [15:0] addr,
    input [7:0] wdata,
    input read,
    output ready,
    output reg [7:0] rdata,
// addr interface
    input [31:0] laddr,
    input lrd,
    input lwr,
    output [15:0] rd_paddr,
    output [15:0] wr_paddr,
    output rdaddr_hit,
    output wraddr_hit,
// sys interface
    input clk,
    input rst_n
    );
///////////////////////////////////////////
// register file
///////////////////////////////////////////
///////////////////////////////////////////
// Register Logical Start address FMMU
///////////////////////////////////////////
wire sel_fmmu_laddr0_st[15:0];
wire rd_fmmu_laddr0_st[15:0];
wire wr_fmmu_laddr0_st[15:0];
wire [7:0] fmmu_laddr0_st_r[15:0];
wire [7:0] fmmu_laddr0_st_nxt[15:0];
genvar i;
generate 
    for (i=0;i<16;i=i+1)begin: logic_start_addr0
        assign sel_fmmu_laddr0_st[i] = valid & (addr == (16'h0600 + 16*i));
        assign rd_fmmu_laddr0_st[i] = read & sel_fmmu_laddr0_st[i];
        assign wr_fmmu_laddr0_st[i] = ~read & sel_fmmu_laddr0_st[i];
        assign fmmu_laddr0_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_laddr0_st_dfflr(wr_fmmu_laddr0_st[i],fmmu_laddr0_st_nxt[i],fmmu_laddr0_st_r[i],clk,rst_n);
    end
endgenerate
wire sel_fmmu_laddr1_st[15:0];
wire rd_fmmu_laddr1_st[15:0];
wire wr_fmmu_laddr1_st[15:0];
wire [7:0] fmmu_laddr1_st_r[15:0];
wire [7:0] fmmu_laddr1_st_nxt[15:0];
generate 
    for (i=0;i<16;i=i+1)begin: logic_start_addr1
        assign sel_fmmu_laddr1_st[i] = valid & (addr == (16'h0601 + 16*i));
        assign rd_fmmu_laddr1_st[i] = read & sel_fmmu_laddr1_st[i];
        assign wr_fmmu_laddr1_st[i] = ~read & sel_fmmu_laddr1_st[i];
        assign fmmu_laddr1_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_laddr1_st_dfflr(wr_fmmu_laddr1_st[i],fmmu_laddr1_st_nxt[i],fmmu_laddr1_st_r[i],clk,rst_n);
    end
endgenerate
wire sel_fmmu_laddr2_st[15:0];
wire rd_fmmu_laddr2_st[15:0];
wire wr_fmmu_laddr2_st[15:0];
wire [7:0] fmmu_laddr2_st_r[15:0];
wire [7:0] fmmu_laddr2_st_nxt[15:0];
generate 
    for (i=0;i<16;i=i+1)begin: logic_start_addr2
        assign sel_fmmu_laddr2_st[i] = valid & (addr == (16'h0602 + 16*i));
        assign rd_fmmu_laddr2_st[i] = read & sel_fmmu_laddr2_st[i];
        assign wr_fmmu_laddr2_st[i] = ~read & sel_fmmu_laddr2_st[i];
        assign fmmu_laddr2_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_laddr2_st_dfflr(wr_fmmu_laddr2_st[i],fmmu_laddr2_st_nxt[i],fmmu_laddr2_st_r[i],clk,rst_n);
    end
endgenerate
wire sel_fmmu_laddr3_st[15:0];
wire rd_fmmu_laddr3_st[15:0];
wire wr_fmmu_laddr3_st[15:0];
wire [7:0] fmmu_laddr3_st_r[15:0];
wire [7:0] fmmu_laddr3_st_nxt[15:0];
generate 
    for (i=0;i<16;i=i+1)begin: logic_start_addr3
        assign sel_fmmu_laddr3_st[i] = valid & (addr == (16'h0603 + 16*i));
        assign rd_fmmu_laddr3_st[i] = read & sel_fmmu_laddr3_st[i];
        assign wr_fmmu_laddr3_st[i] = ~read & sel_fmmu_laddr3_st[i];
        assign fmmu_laddr3_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_laddr3_st_dfflr(wr_fmmu_laddr3_st[i],fmmu_laddr3_st_nxt[i],fmmu_laddr3_st_r[i],clk,rst_n);
    end
endgenerate
///////////////////////////////////////////
// Register Length FMMU
///////////////////////////////////////////
wire sel_fmmulen0[15:0];
wire rd_fmmulen0[15:0];
wire wr_fmmulen0[15:0];
wire [7:0] fmmulen0_r[15:0];
wire [7:0] fmmulen0_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_length0
        assign sel_fmmulen0[i] = valid & (addr == (16'h0604 + 16*i));
        assign rd_fmmulen0[i] = read & sel_fmmulen0[i];
        assign wr_fmmulen0[i] = ~read & sel_fmmulen0[i];
        assign fmmulen0_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmulen_dfflr(wr_fmmulen0[i],fmmulen0_nxt[i],fmmulen0_r[i],clk,rst_n);
    end
endgenerate
wire sel_fmmulen1[15:0];
wire rd_fmmulen1[15:0];
wire wr_fmmulen1[15:0];
wire [7:0] fmmulen1_r[15:0];
wire [7:0] fmmulen1_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_length1
        assign sel_fmmulen1[i] = valid & (addr == (16'h0605 + 16*i));
        assign rd_fmmulen1[i] = read & sel_fmmulen1[i];
        assign wr_fmmulen1[i] = ~read & sel_fmmulen1[i];
        assign fmmulen1_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmulen1_dfflr(wr_fmmulen1[i],fmmulen1_nxt[i],fmmulen1_r[i],clk,rst_n);
    end
endgenerate
//////////////////////////////////////
// Register Start bit FMMU in logical address space
//////////////////////////////////////
wire sel_fmmu_lbit_st[15:0];
wire rd_fmmu_lbit_st[15:0];
wire wr_fmmu_lbit_st[15:0];
wire [7:0] fmmu_lbit_st_r[15:0];
wire [7:0] fmmu_lbit_st_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_logic_start_bit
        assign sel_fmmu_lbit_st[i] = valid & (addr == (16'h0606 + 16*i));
        assign rd_fmmu_lbit_st[i] = read & sel_fmmu_lbit_st[i];
        assign wr_fmmu_lbit_st[i] = ~read & sel_fmmu_lbit_st[i];
        assign fmmu_lbit_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_lbit_st_dfflr(wr_fmmu_lbit_st[i],fmmu_lbit_st_nxt[i],fmmu_lbit_st_r[i],clk,rst_n);
    end
endgenerate
/////////////////////////////////////////////
// Register Stop bit FMMU in logical address space
/////////////////////////////////////////////
wire sel_fmmu_lbit_end[15:0];
wire rd_fmmu_lbit_end[15:0];
wire wr_fmmu_lbit_end[15:0];
wire [7:0] fmmu_lbit_end_r[15:0];
wire [7:0] fmmu_lbit_end_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_logic_end_bit
        assign sel_fmmu_lbit_end[i] = valid & (addr == (16'h0607 + 16*i));
        assign rd_fmmu_lbit_end[i] = read & sel_fmmu_lbit_end[i];
        assign wr_fmmu_lbit_end[i] = ~read & sel_fmmu_lbit_end[i];
        assign fmmu_lbit_end_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_lbit_end_dfflr(wr_fmmu_lbit_end[i],fmmu_lbit_end_nxt[i],fmmu_lbit_end_r[i],clk,rst_n);
    end
endgenerate
///////////////////////////////////////////
// Register Physical Start address FMMU
///////////////////////////////////////////
wire sel_fmmu_paddr0_st[15:0];
wire rd_fmmu_paddr0_st[15:0];
wire wr_fmmu_paddr0_st[15:0];
wire [7:0] fmmu_paddr0_st_r[15:0];
wire [7:0] fmmu_paddr0_st_nxt[15:0];
generate 
    for (i=0;i<16;i=i+1)begin: physical_start_addr0
        assign sel_fmmu_paddr0_st[i] = valid & (addr == (16'h0608 + 16*i));
        assign rd_fmmu_paddr0_st[i] = read & sel_fmmu_paddr0_st[i];
        assign wr_fmmu_paddr0_st[i] = ~read & sel_fmmu_paddr0_st[i];
        assign fmmu_paddr0_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_paddr0_st_dfflr(wr_fmmu_paddr0_st[i],fmmu_paddr0_st_nxt[i],fmmu_paddr0_st_r[i],clk,rst_n);
    end
endgenerate
wire sel_fmmu_paddr1_st[15:0];
wire rd_fmmu_paddr1_st[15:0];
wire wr_fmmu_paddr1_st[15:0];
wire [7:0] fmmu_paddr1_st_r[15:0];
wire [7:0] fmmu_paddr1_st_nxt[15:0];
generate 
    for (i=0;i<16;i=i+1)begin: physical_start_addr1
        assign sel_fmmu_paddr1_st[i] = valid & (addr == (16'h0609 + 16*i));
        assign rd_fmmu_paddr1_st[i] = read & sel_fmmu_paddr1_st[i];
        assign wr_fmmu_paddr1_st[i] = ~read & sel_fmmu_paddr1_st[i];
        assign fmmu_paddr1_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_paddr1_st_dfflr(wr_fmmu_paddr1_st[i],fmmu_paddr1_st_nxt[i],fmmu_paddr1_st_r[i],clk,rst_n);
    end
endgenerate
//////////////////////////////////////////
// Register Physical Start bit FMMU
//////////////////////////////////////////
wire sel_fmmu_pbit_st[15:0];
wire rd_fmmu_pbit_st[15:0];
wire wr_fmmu_pbit_st[15:0];
wire [7:0] fmmu_pbit_st_r[15:0];
wire [7:0] fmmu_pbit_st_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_physical_start_bit
        assign sel_fmmu_pbit_st[i] = valid & (addr == (16'h060a + 16*i));
        assign rd_fmmu_pbit_st[i] = read & sel_fmmu_pbit_st[i];
        assign wr_fmmu_pbit_st[i] = ~read & sel_fmmu_pbit_st[i];
        assign fmmu_pbit_st_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmu_pbit_st_dfflr(wr_fmmu_pbit_st[i],fmmu_pbit_st_nxt[i],fmmu_pbit_st_r[i],clk,rst_n);
    end
endgenerate
//////////////////////////////////////////
// Register Type FMMU
//////////////////////////////////////////
wire sel_fmmutype[15:0];
wire rd_fmmutype[15:0];
wire wr_fmmutype[15:0];
wire [7:0] fmmutype_r[15:0];
wire [7:0] fmmutype_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_type
        assign sel_fmmutype[i] = valid & (addr == (16'h060b + 16*i));
        assign rd_fmmutype[i] = read & sel_fmmutype[i];
        assign wr_fmmutype[i] = ~read & sel_fmmutype[i];
        assign fmmutype_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmutype_dfflr(wr_fmmutype[i],fmmutype_nxt[i],fmmutype_r[i],clk,rst_n);
    end
endgenerate
////////////////////////////////////////
// Register Activate FMMU
////////////////////////////////////////
wire sel_fmmuen[15:0];
wire rd_fmmuen[15:0];
wire wr_fmmuen[15:0];
wire [7:0] fmmuen_r[15:0];
wire [7:0] fmmuen_nxt[15:0];
generate
    for (i=0;i<16;i=i+1)begin: fmmu_enable
        assign sel_fmmuen[i] = valid & (addr == (16'h060c + 16*i));
        assign rd_fmmuen[i] = read & sel_fmmuen[i];
        assign wr_fmmuen[i] = ~read & sel_fmmuen[i];
        assign fmmuen_nxt[i] = wdata;
        gnrl_dfflr #(8,8'd0) fmmuen_dfflr(wr_fmmuen[i],fmmuen_nxt[i],fmmuen_r[i],clk,rst_n);
    end
endgenerate
///////////////////////////////////////
// fmmu function
///////////////////////////////////////
wire [32:0] laddr_minus_st[15:0];
wire rdaddr_hit_r[15:0];
wire wraddr_hit_r[15:0];
generate
    for (i=0;i<16;i=i+1)begin: address_hit
        assign laddr_minus_st[i] = {1'b0,laddr} - {1'b0,fmmu_laddr3_st_r[i],fmmu_laddr2_st_r[i],fmmu_laddr1_st_r[i],fmmu_laddr0_st_r[i]};
        assign rdaddr_hit_r[i] = (~laddr_minus_st[i][32]) & (laddr_minus_st[i][31:0] > {16'd0,fmmulen1_r[i],fmmulen0_r[i]}) &
                            (fmmutype_r[i][0] & lrd) & (fmmuen_r[i]);
        assign wraddr_hit_r[i] = (~laddr_minus_st[i][32]) & (laddr_minus_st[i][31:0] > {16'd0,fmmulen1_r[i],fmmulen0_r[i]}) &
                            (fmmutype_r[i][1] & lwr) & (fmmuen_r[i]);
    end
endgenerate
wire [15:0] rd_paddr_r[15:0];
wire [15:0] wr_paddr_r[15:0];
generate
    for (i=0;i<16;i=i+1)begin: calc_address
        assign rd_paddr_r[i] = {16{rdaddr_hit_r[i]}} & ({fmmu_paddr1_st_r[i],fmmu_paddr0_st_r[i]} + laddr_minus_st[i][15:0]);
        assign wr_paddr_r[i] = {16{wraddr_hit_r[i]}} & ({fmmu_paddr1_st_r[i],fmmu_paddr0_st_r[i]} + laddr_minus_st[i][15:0]);
    end
endgenerate
assign rdaddr_hit = rdaddr_hit_r[0] | rdaddr_hit_r[1] | rdaddr_hit_r[2] | rdaddr_hit_r[3] |
                    rdaddr_hit_r[4] | rdaddr_hit_r[5] | rdaddr_hit_r[6] | rdaddr_hit_r[7] |
                    rdaddr_hit_r[8] | rdaddr_hit_r[9] | rdaddr_hit_r[10] | rdaddr_hit_r[11] |
                    rdaddr_hit_r[12] | rdaddr_hit_r[13] | rdaddr_hit_r[14] | rdaddr_hit_r[15];
assign wraddr_hit = wraddr_hit_r[0] | wraddr_hit_r[1] | wraddr_hit_r[2] | wraddr_hit_r[3] |
                    wraddr_hit_r[4] | wraddr_hit_r[5] | wraddr_hit_r[6] | wraddr_hit_r[7] |
                    wraddr_hit_r[8] | wraddr_hit_r[9] | wraddr_hit_r[10] | wraddr_hit_r[11] |
                    wraddr_hit_r[12] | wraddr_hit_r[13] | wraddr_hit_r[14] | wraddr_hit_r[15];  
assign rd_paddr = rd_paddr_r[0] | rd_paddr_r[1] | rd_paddr_r[2] | rd_paddr_r[3] |    
                  rd_paddr_r[4] | rd_paddr_r[5] | rd_paddr_r[6] | rd_paddr_r[7] |  
                  rd_paddr_r[8] | rd_paddr_r[9] | rd_paddr_r[10] | rd_paddr_r[11] |               
                  rd_paddr_r[12] | rd_paddr_r[13] | rd_paddr_r[14] | rd_paddr_r[15];
assign wr_paddr = wr_paddr_r[0] | wr_paddr_r[1] | wr_paddr_r[2] | wr_paddr_r[3] |    
                  wr_paddr_r[4] | wr_paddr_r[5] | wr_paddr_r[6] | wr_paddr_r[7] |  
                  wr_paddr_r[8] | wr_paddr_r[9] | wr_paddr_r[10] | wr_paddr_r[11] |               
                  wr_paddr_r[12] | wr_paddr_r[13] | wr_paddr_r[14] | wr_paddr_r[15]; 
/////////////////////////////////////////////
// ready and rdata
/////////////////////////////////////////////
assign ready = 1'b1;
wire [7:0] rdata_r[15:0];
generate
    for (i=0;i<16;i=i+1) begin: gen_rdata
        assign rdata_r[i] = ({8{rd_fmmu_laddr0_st[i]}} & fmmu_laddr0_st_r[i]) |
                            ({8{rd_fmmu_laddr1_st[i]}} & fmmu_laddr1_st_r[i]) |
                            ({8{rd_fmmu_laddr2_st[i]}} & fmmu_laddr2_st_r[i]) |
                            ({8{rd_fmmu_laddr3_st[i]}} & fmmu_laddr3_st_r[i]) |
                            ({8{rd_fmmulen0[i]}}       & fmmulen0_r[i])       |
                            ({8{rd_fmmulen1[i]}}       & fmmulen1_r[i])       |
                            ({8{rd_fmmu_lbit_st[i]}}   & fmmu_lbit_st_r[i])   |
                            ({8{rd_fmmu_lbit_end[i]}}  & fmmu_lbit_end_r[i])  |
                            ({8{rd_fmmu_paddr0_st[i]}} & fmmu_paddr0_st_r[i]) |
                            ({8{rd_fmmu_paddr1_st[i]}} & fmmu_paddr1_st_r[i]) |
                            ({8{rd_fmmu_pbit_st[i]}}   & fmmu_pbit_st_r[i])   |
                            ({8{rd_fmmutype[i]}}       & fmmutype_r[i])       |
                            ({8{rd_fmmuen[i]}}         & fmmuen_r[i]);
    end
endgenerate
wire [7:0] rdata_nxt;
assign rdata_nxt = rdata_r[0] | rdata_r[1] | rdata_r[2] | rdata_r[3] | 
               rdata_r[4] | rdata_r[5] | rdata_r[6] | rdata_r[7] |
               rdata_r[8] | rdata_r[9] | rdata_r[10] | rdata_r[11] |
               rdata_r[12] | rdata_r[13] | rdata_r[14] | rdata_r[15];
gnrl_dffr #(8,8'd0) rdata_dffr(rdata_nxt,rdata,clk,rst_n);

endmodule
