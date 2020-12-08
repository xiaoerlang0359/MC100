# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xc7z020clg400-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/fpgawork/mmi/mmi.cache/wt [current_project]
set_property parent.project_path D:/fpgawork/mmi/mmi.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths d:/fpgawork/mmi/mmi.srcs/sources_1/new [current_project]
update_ip_catalog
set_property ip_output_repo d:/fpgawork/mmi/mmi.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib D:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/hdl/ecat_tb_wrapper.v
add_files D:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ecat_tb.bd
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_processing_system7_0_0/ecat_tb_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_gpio_0_0/ecat_tb_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_gpio_0_0/ecat_tb_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_gpio_0_0/ecat_tb_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_xbar_1/ecat_tb_xbar_1_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_rst_ps7_0_25M_0/ecat_tb_rst_ps7_0_25M_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_rst_ps7_0_25M_0/ecat_tb_rst_ps7_0_25M_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_rst_ps7_0_25M_0/ecat_tb_rst_ps7_0_25M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_clk_wiz_0_0/ecat_tb_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_clk_wiz_0_0/ecat_tb_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_clk_wiz_0_0/ecat_tb_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_proc_sys_reset_0_0/ecat_tb_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_proc_sys_reset_0_0/ecat_tb_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_proc_sys_reset_0_0/ecat_tb_proc_sys_reset_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_ethernetlite_0_0/ecat_tb_axi_ethernetlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_ethernetlite_0_0/ecat_tb_axi_ethernetlite_0_0.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_ethernetlite_0_0/ecat_tb_axi_ethernetlite_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_ethernetlite_0_0/ecat_tb_axi_ethernetlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_apb_bridge_0_0/ecat_tb_axi_apb_bridge_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_axi_protocol_convert_0_1/ecat_tb_axi_protocol_convert_0_1_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_ila_0_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_ila_0_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_ila_0_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_ila_0_0/ecat_tb_ila_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_pc_2/ecat_tb_auto_pc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_pc_0/ecat_tb_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_pc_1/ecat_tb_auto_pc_1_ooc.xdc]
set_property used_in_synthesis false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_cc_0/ecat_tb_auto_cc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_cc_0/ecat_tb_auto_cc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ip/ecat_tb_auto_cc_0/ecat_tb_auto_cc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all D:/fpgawork/mmi/mmi.srcs/sources_1/bd/ecat_tb/ecat_tb_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/fpgawork/mmi/mmi.srcs/constrs_1/new/test.xdc
set_property used_in_implementation false [get_files D:/fpgawork/mmi/mmi.srcs/constrs_1/new/test.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top ecat_tb_wrapper -part xc7z020clg400-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef ecat_tb_wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file ecat_tb_wrapper_utilization_synth.rpt -pb ecat_tb_wrapper_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
