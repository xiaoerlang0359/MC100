set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports mdio_rtl_0_mdc]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports mdio_rtl_0_mdio_io]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports gpio2_io_o_0]

set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports clk_in1_0]
create_clock -period 40.000 -name rv_clk -waveform {0.000 20.000} -add [get_ports clk_in1_0]
set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports rx_ctl_0]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports rxd0_0]
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports rxd1_0]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports rxd2_0]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports rxd3_0]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports tx_clk_0]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports tx_ctl_0]
set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports txd0_0]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports txd1_0]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports txd2_0]
set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS33} [get_ports txd3_0]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports mdc_1]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports mdio_1]





















create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list ecat_tb_i/clk_wiz_0/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[0]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[1]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[2]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[3]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[4]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[5]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[6]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[7]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[8]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[9]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[10]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[11]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[12]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[13]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[14]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_addr[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[0]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[1]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[2]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[3]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[4]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[5]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[6]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_wdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[0]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[1]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[2]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[3]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[4]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[5]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[6]} {ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_rdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[7]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[8]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[9]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[10]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[11]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[12]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[13]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[14]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/addr[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepaddr0_r[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/rdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepstat_r[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/wdata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 3 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/state[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/state[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[0]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[1]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[2]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[3]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[4]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[5]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[6]} {ecat_tb_i/ecat_top_0/inst/u_esi_top/eepdata0_r[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_norm_arbt/pdi_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_esi_top/read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_esi_top/ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_esi_top/src]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list ecat_tb_i/ecat_top_0/inst/u_esi_top/valid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets mdc_1_OBUF]
