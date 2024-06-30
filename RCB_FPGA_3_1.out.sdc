## Generated SDC file "RCB_FPGA_3_1.out.sdc"

## Copyright (C) 2023  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 22.1std.2 Build 922 07/20/2023 SC Lite Edition"

## DATE    "Thu Jun 27 10:52:15 2024"

##
## DEVICE  "10M40DCF256I7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -period 10.000 [get_ports {CLK_100M}]
    create_generated_clock -source {UART_PLL_inst|altpll_component|auto_generated|pll1|inclk[0]} -multiply_by 2 -duty_cycle 50.00 -name {UART_PLL:UART_PLL_inst|altpll:altpll_component|UART_PLL_altpll:auto_generated|wire_pll1_clk[0]} {UART_PLL_inst|altpll_component|auto_generated|pll1|clk[0]}
# create_clock -period 10.000 [get_pins {UART_PLL_inst|altpll_component|auto_generated|pll1|inclk[0]}]
# create_generated_clock -source {UART_PLL_inst|altpll_component|auto_generated|pll1|inclk[0]} -divide_by 5 -multiply_by 16 -duty_cycle 50.00 -name {UART_PLL_inst|altpll_component|auto_generated|pll1|clk[0]} {UART_PLL_inst|altpll_component|auto_generated|pll1|clk[0]}
#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

