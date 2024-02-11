onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_rcb/clk_100m
add wave -noupdate /tb_rcb/clk_1m
add wave -noupdate /tb_rcb/rst_n
add wave -noupdate /tb_rcb/sclk
add wave -noupdate /tb_rcb/cs_n
add wave -noupdate /tb_rcb/mosi
add wave -noupdate /tb_rcb/miso
add wave -noupdate /tb_rcb/pow
add wave -noupdate -radix hexadecimal -childformat {{{/tb_rcb/tb/rcb_tests/miso_data[31]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[30]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[29]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[28]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[27]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[26]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[25]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[24]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[23]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[22]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[21]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[20]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[19]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[18]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[17]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[16]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[15]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[14]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[13]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[12]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[11]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[10]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[9]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[8]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[7]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[6]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[5]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[4]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[3]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[2]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[1]} -radix hexadecimal} {{/tb_rcb/tb/rcb_tests/miso_data[0]} -radix hexadecimal}} -subitemconfig {{/tb_rcb/tb/rcb_tests/miso_data[31]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[30]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[29]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[28]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[27]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[26]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[25]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[24]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[23]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[22]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[21]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[20]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[19]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[18]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[17]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[16]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[15]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[14]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[13]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[12]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[11]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[10]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[9]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[8]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[7]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[6]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[5]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[4]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[3]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[2]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[1]} {-height 15 -radix hexadecimal} {/tb_rcb/tb/rcb_tests/miso_data[0]} {-height 15 -radix hexadecimal}} /tb_rcb/tb/rcb_tests/miso_data
add wave -noupdate /tb_rcb/right_drape_em_open
add wave -noupdate /tb_rcb/left_drape_em_open
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_electromagnet_reg
add wave -noupdate /tb_rcb/dut/wheel_driver_do
add wave -noupdate /tb_rcb/dut/sp2_single_ended_1_0
add wave -noupdate /tb_rcb/dut/sp2_diff_pair_1_0
add wave -noupdate /tb_rcb/dut/sp1_single_ended_1_0
add wave -noupdate /tb_rcb/dut/sp1_diff_pair_1_0
add wave -noupdate /tb_rcb/dut/sp2_single_ended_2_3
add wave -noupdate /tb_rcb/dut/sp1_single_ended_2_3
add wave -noupdate /tb_rcb/dut/sp2_diff_pair_2_3
add wave -noupdate /tb_rcb/dut/sp2_analog_switch
add wave -noupdate /tb_rcb/dut/sp1_analog_switch
add wave -noupdate /tb_rcb/dut/sp1_diff_pair_2_3
add wave -noupdate /tb_rcb/diagnostic_led
add wave -noupdate /tb_rcb/right_plunger_nc
add wave -noupdate /tb_rcb/right_plunger_no
add wave -noupdate /tb_rcb/left_plunger_nc
add wave -noupdate /tb_rcb/left_plunger_no
add wave -noupdate /tb_rcb/right_tool_ex_nc
add wave -noupdate /tb_rcb/right_tool_ex_no
add wave -noupdate /tb_rcb/left_tool_ex_nc
add wave -noupdate /tb_rcb/left_tool_ex_no
add wave -noupdate /tb_rcb/right_drape_open_nc
add wave -noupdate /tb_rcb/right_drape_open_no
add wave -noupdate /tb_rcb/right_drape_close1_nc
add wave -noupdate /tb_rcb/right_drape_close1_no
add wave -noupdate /tb_rcb/right_drape_close2_nc
add wave -noupdate /tb_rcb/right_drape_close2_no
add wave -noupdate /tb_rcb/left_drape_open_nc
add wave -noupdate /tb_rcb/left_drape_open_no
add wave -noupdate /tb_rcb/left_drape_close1_nc
add wave -noupdate /tb_rcb/left_drape_close1_no
add wave -noupdate /tb_rcb/left_drape_close2_nc
add wave -noupdate /tb_rcb/left_drape_close2_no
add wave -noupdate /tb_rcb/right_tool_ex_led3
add wave -noupdate /tb_rcb/right_tool_ex_led2
add wave -noupdate /tb_rcb/right_tool_ex_led1
add wave -noupdate /tb_rcb/left_tool_ex_led3
add wave -noupdate /tb_rcb/left_tool_ex_led2
add wave -noupdate /tb_rcb/left_tool_ex_led1
add wave -noupdate /tb_rcb/right_plunger_led3
add wave -noupdate /tb_rcb/right_plunger_led2
add wave -noupdate /tb_rcb/right_plunger_led1
add wave -noupdate /tb_rcb/left_plunger_led3
add wave -noupdate /tb_rcb/left_plunger_led2
add wave -noupdate /tb_rcb/left_plunger_led1
add wave -noupdate /tb_rcb/diag_activation
add wave -noupdate /tb_rcb/estop_open
add wave -noupdate /tb_rcb/sync
add wave -noupdate /tb_rcb/right_drape_open_nc
add wave -noupdate /tb_rcb/estop_btn2_nc_st
add wave -noupdate /tb_rcb/estop_btn2_no_st
add wave -noupdate /tb_rcb/estop_btn1_nc_st
add wave -noupdate /tb_rcb/estop_btn1_no_st
add wave -noupdate -radix hexadecimal /tb_rcb/dut/wheel_home_sw
add wave -noupdate -radix hexadecimal /tb_rcb/dut/wheel_reverse_sw
add wave -noupdate -radix hexadecimal /tb_rcb/dut/wheel_forward_sw
add wave -noupdate -radix hexadecimal /tb_rcb/dut/wheel_driver_di
add wave -noupdate /tb_rcb/dut/wheel_driver_rst
add wave -noupdate /tb_rcb/dut/wheel_driver_abrt
add wave -noupdate /tb_rcb/dut/fan1_pwm
add wave -noupdate /tb_rcb/dut/fan2_pwm
add wave -noupdate /tb_rcb/dut/rcb_registers/pwm2_state
add wave -noupdate /tb_rcb/dut/rcb_registers/pwm2_cnt
add wave -noupdate /tb_rcb/dut/rcb_registers/pwm2_value
add wave -noupdate /tb_rcb/dut/rcb_registers/pwm1_cnt
add wave -noupdate /tb_rcb/dut/rcb_registers/pwm1_state
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_fan1_pwm
add wave -noupdate /tb_rcb/dut/rcb_registers/clk_1m_posedge
add wave -noupdate /tb_rcb/dut/rcb_registers/fan_tacho_cnt
add wave -noupdate /tb_rcb/dut/rcb_registers/fan_tacho_mes_pulse
add wave -noupdate /tb_rcb/dut/rcb_registers/fan1_tacho_posedge
add wave -noupdate /tb_rcb/dut/fan1_tacho
add wave -noupdate /tb_rcb/dut/rcb_registers/fan1_tacho_cnt
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_fan1_tacho
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_fan1_tacho_num
add wave -noupdate /tb_rcb/dut/fan2_tacho
add wave -noupdate /tb_rcb/dut/rcb_registers/fan2_tacho_posedge
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_fan2_tacho
add wave -noupdate /tb_rcb/dut/rcb_registers/fpga_fan2_tacho_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8951221840 ps} 0} {{Cursor 2} {50000000 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 333
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {7364700 ps}
