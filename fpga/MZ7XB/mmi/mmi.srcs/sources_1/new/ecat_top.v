`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/16 22:46:43
// Design Name: 
// Module Name: ecat_top
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


module ecat_top(
// pdi interface
    input pdi_valid,
    input pdi_read,
    input [15:0] pdi_addr,
    input [7:0] pdi_wdata,
    output pdi_ready,
    output [7:0] pdi_rdata,
    output pdi_err,
// pdi irq interface
    output pdi_irq_assert,
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
// mdio interface
    output mdc,
    inout mdio,
// sys interface
    input clk2,
    input clk,
    input sys_clk,
    input rst_n
    );

wire pdi_irq;
wire pdi_irq_m;
gnrl_dffl #(1) pdi_irq_mdff(1'b1,pdi_irq,pdi_irq_m,sys_clk);
gnrl_dffl #(1) pdi_irq_assertdff(1'b1,pdi_irq_m,pdi_irq_assert,sys_clk);


wire ecat_fifo_sof;
wire ecat_fifo_eof;
wire ecat_fifo_valid;
wire ecat_fifo_read;
wire [15:0] ecat_fifo_addr;
wire [7:0] ecat_fifo_wdata;
wire [7:0] ecat_fifo_rdata;
wire ecat_fifo_ready;
wire [1:0] port0_ctrl;
wire [1:0] port1_ctrl;
wire port0_link;
wire port1_link;
wire [31:0] logic_addr;
wire logic_read;
wire logic_write;
wire [15:0] rd_paddr;
wire [15:0] wr_paddr;
wire rdaddr_hit;
wire wraddr_hit;
wire [15:0] event_req;
wire [15:0] event_msk;
wire [15:0] fp_addr;

dhsm_test u_dhsm_test(
// mii interface
.rx_clk(rx_clk),
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
// fifo interface
.fifo_sof(ecat_fifo_sof),
.fifo_eof(ecat_fifo_eof),
.fifo_valid(ecat_fifo_valid),
.fifo_read(ecat_fifo_read),
.fifo_addr(ecat_fifo_addr),
.fifo_wdata(ecat_fifo_wdata),
.fifo_rdata(ecat_fifo_rdata),
.fifo_ready(ecat_fifo_ready),
// port ctrl interface
.port0_ctrl(port0_ctrl),
.port1_ctrl(port1_ctrl),
.port0_link(port0_link),
.port1_link(port1_link),
// fmmu interface
.logic_addr(logic_addr),
.logic_read(logic_read),
.logic_write(logic_write),
.rd_paddr(rd_paddr),
.wr_paddr(wr_paddr),
.rdaddr_hit(rdaddr_hit),
.wraddr_hit(wraddr_hit),
// interrupt interface
.event_req(event_req),
.event_msk(event_msk),
// fp address interface
.fp_addr(fp_addr),
// dc latch interface
.port0_latch(),
.port1_latch(),
// sys interface
.clk2(clk2),
.clk(clk),
.rst_n(rst_n)
);

wire fifo_src;
wire alctrl_state;
wire fifo_sof;
wire fifo_eof;
wire fifo_valid;
wire [7:0] fifo_wdata;
wire [15:0] fifo_addr;
wire fifo_read;
wire fifo_ready;
wire [7:0] fifo_rdata;

norm_arbt u_norm_arbt(
.ecat_sof(ecat_fifo_sof),
.ecat_eof(ecat_fifo_eof),
.ecat_valid(ecat_fifo_valid),
.ecat_addr(ecat_fifo_addr),
.ecat_wdata(ecat_fifo_wdata),
.ecat_read(ecat_fifo_read),
.ecat_ready(ecat_fifo_ready),
.ecat_rdata(ecat_fifo_rdata),
// pdi interface
.pdi_valid(pdi_valid),
.pdi_addr(pdi_addr),
.pdi_wdata(pdi_wdata),
.pdi_read(pdi_read),
.pdi_ready(pdi_ready),
.pdi_rdata(pdi_rdata),
.pdi_err(pdi_err),
// fifo interface
.sof(fifo_sof),
.eof(fifo_eof),
.valid(fifo_valid),
.addr(fifo_addr),
.wdata(fifo_wdata),
.src(fifo_src),
.read(fifo_read),
.ready(fifo_ready),
.rdata(fifo_rdata),
.alctrl_state(alctrl_state),  
// system interface
.clk(clk),
.rst_n(rst_n)
);

wire reg_sof;
wire reg_eof;
wire reg_valid;
wire [7:0] reg_wdata;
wire [15:0] reg_addr;
wire reg_read;
wire reg_ready;
wire [7:0] reg_rdata;
wire wd_sof;
wire wd_eof;
wire wd_valid;
wire [7:0] wd_wdata;
wire [15:0] wd_addr;
wire wd_read;
wire wd_ready;
wire [7:0] wd_rdata;
wire esi_sof;
wire esi_eof;
wire esi_valid;
wire [7:0] esi_wdata;
wire [15:0] esi_addr;
wire esi_read;
wire esi_ready;
wire [7:0] esi_rdata;
wire mii_sof;
wire mii_eof;
wire mii_valid;
wire [7:0] mii_wdata;
wire [15:0] mii_addr;
wire mii_read;
wire mii_ready;
wire [7:0] mii_rdata;
wire fmmu_sof;
wire fmmu_eof;
wire fmmu_valid;
wire [7:0] fmmu_wdata;
wire [15:0] fmmu_addr;
wire fmmu_read;
wire fmmu_ready;
wire [7:0] fmmu_rdata;

bus_split u_bus_split( 
// fifo interface
.fifo_sof(fifo_sof),
.fifo_eof(fifo_eof),
.fifo_valid(fifo_valid),
.fifo_addr(fifo_addr),
.fifo_read(fifo_read),
.fifo_wdata(fifo_wdata),
.fifo_ready(fifo_ready),
.fifo_rdata(fifo_rdata),
// register file interface
.reg_sof(reg_sof),
.reg_eof(reg_eof),
.reg_valid(reg_valid),
.reg_addr(reg_addr),
.reg_read(reg_read),
.reg_wdata(reg_wdata),
.reg_ready(reg_ready),
.reg_rdata(reg_rdata),
// watchdog interface
.wd_sof(wd_sof),
.wd_eof(wd_eof),
.wd_valid(wd_valid),
.wd_addr(wd_addr),
.wd_read(wd_read),
.wd_wdata(wd_wdata),
.wd_ready(wd_ready),
.wd_rdata(wd_rdata),
// esi interface
.esi_sof(esi_sof),
.esi_eof(esi_eof),
.esi_valid(esi_valid),
.esi_addr(esi_addr),
.esi_read(esi_read),
.esi_wdata(esi_wdata),
.esi_ready(esi_ready),
.esi_rdata(esi_rdata),
// mii interface
.mii_sof(mii_sof),
.mii_eof(mii_eof),
.mii_valid(mii_valid),
.mii_addr(mii_addr),
.mii_read(mii_read),
.mii_wdata(mii_wdata),
.mii_ready(mii_ready),
.mii_rdata(mii_rdata),
// fmmu interface
.fmmu_sof(fmmu_sof),
.fmmu_eof(fmmu_eof),
.fmmu_valid(fmmu_valid),
.fmmu_addr(fmmu_addr),
.fmmu_read(fmmu_read),
.fmmu_wdata(fmmu_wdata),
.fmmu_ready(fmmu_ready),
.fmmu_rdata(fmmu_rdata),
// sm interface
.sm_sof(),
.sm_eof(),
.sm_valid(),
.sm_addr(),
.sm_wdata(),
.sm_read(),
.sm_ready(1'b0),
.sm_rdata(8'd0),
// dc interface
.dc_sof(),
.dc_eof(),
.dc_valid(),
.dc_addr(),
.dc_wdata(),
.dc_read(),
.dc_rdata(8'd0),
.dc_ready(1'b0)
);

wire reload1;
wire reload2;
wire [15:0] pdi_control;
wire [15:0] pdi_config;
wire [15:0] pdi_ext_config;
wire [15:0] station_alias;
wire eeplstat;
wire eeprom_event;

wire pdi_expired;
wire pdo_expired;

register_file u_register_file(
// fifo interface
.sof(reg_sof),
.eof(reg_eof),
.valid(reg_valid),
.addr(reg_addr),
.wdata(reg_wdata),
.read(reg_read),
.src(fifo_src), // 1 for ecat
.ready(reg_ready),//
.rdata(reg_rdata),
.alctrl_state(alctrl_state),
// esi reload interface
.reload1(reload1),
.reload2(reload2),
.pdi_control(pdi_control),
.pdi_config(pdi_config),
.pdi_ext_config(pdi_ext_config),
.station_alias(station_alias),
.eeplstat_in(eeplstat),
.eeprom_event(eeprom_event),
// fpaddr interface
.fp_addr(fp_addr),
.rw_offset(), //    output [15:0]
// write protect interface
.wr_reg_en(),
.wr_reg_pr(),
.wr_en(),
.wr_pr(),
// reset interface
.ecat_reset(),
.pdi_reset(),
// watchdog interface
.pdi_expired(pdi_expired),
.pdo_expired(pdo_expired),
// dc sync interface,
.dc_sync0(1'b0),
.dc_sync1(1'b0),
// port control and status interface
.port0_ctrl(port0_ctrl),
.port1_ctrl(port1_ctrl),
.port2_ctrl(),
.port3_ctrl(),
.port0_link(port0_link),
.port1_link(port1_link),
// interrupt interface
.ecat_event_msk(event_msk),
.ecat_event_req(event_req),
.pdi_irq(pdi_irq),
// sys interface
.clk(clk),
.rst_n(rst_n)    
);

watch_dog u_watch_dog(
// fifo interface
.sof(wd_sof),
.eof(wd_eof),
.valid(wd_valid),
.read(wd_read),
.addr(wd_addr),
.wdata(wd_wdata),
.src(fifo_src),//1 for ecat
.ready(wd_ready),
.rdata(wd_rdata),
// dl status interface
.pdi_expired(pdi_expired),
// interrupt interface
.pdo_expired(pdo_expired),
// sm watch dog enable
.sm_pdo_en(1'b0),
// access pdi or pdo
.access_pdi(1'b0),
.access_pdo(1'b0),
// sys interface
.clk(clk),
.rst_n(rst_n)
);

esi_top u_esi_top(
// fifo interface
.sof(esi_sof),
.eof(esi_eof),
.valid(esi_valid),
.addr(esi_addr),
.wdata(esi_wdata),
.read(esi_read),
.src(fifo_src),
.ready(esi_ready),//
.rdata(esi_rdata),
 // event interface
.eeprom_event(eeprom_event),//
// register file interface eeprom reload status
.eeplstat_out(eeplstat),
// reload interface
.reload1(reload1),
.reload2(reload2),
.station_alias(station_alias),
.pdi_control(pdi_control),
.pdi_config(pdi_config),
.pdi_ext_config(pdi_ext_config),
.dc_pulse_len(),
// sys interface
.clk(clk),
.rst_n(rst_n)
);

mii_top u_mii_top(
// fifo interface
.sof(mii_sof),
.eof(mii_eof),
.valid(mii_valid),
.addr(mii_addr),
.wdata(mii_wdata),
.read(mii_read),
.ready(mii_ready),
.rdata(mii_rdata),
// mii interface
.mdc(mdc),
.mdio(mdio),
// sys interface
.clk(clk),
.rst_n(rst_n)
);

ffmu u_fmmu(
// fifo interface
.sof(fmmu_sof),
.eof(fmmu_eof),
.valid(fmmu_valid),
.addr(fmmu_addr),
.wdata(fmmu_wdata),
.read(fmmu_read),
.ready(fmmu_ready),
.rdata(fmmu_rdata),
// addr interface
.laddr(logic_addr),
.lrd(logic_read),
.lwr(logic_write),
.rd_paddr(rd_paddr),
.wr_paddr(wr_paddr),
.rdaddr_hit(rdaddr_hit),
.wraddr_hit(wraddr_hit),
// sys interface
.clk(clk),
.rst_n(rst_n)
);
endmodule
