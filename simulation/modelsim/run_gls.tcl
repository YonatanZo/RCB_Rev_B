#--------------------------------------------------------------------------#
#Module name: run_gls.do
#Author		: Igor Dorman
#Date		: 07/11/2022
#Description: The script file for GLS similation of Core. 
#Version	: 1.0
#--------------------------------------------------------------------------#

#set	device			10M40DCF256I7G
set path_to_rtl		../.././source
#set path_to_gls		../../synthesis/altera/simulation/modelsim
set path_to_tb		.././testbench
set path_to_waves	.././result
set GL_FILE			"RCB_FPGA"


echo "-----------------------------------------------"	
echo "------------ GL Compilation Started -----------"	
echo "-----------------------------------------------"	

vlib work_gls
vdel -all -lib work_gls

vlib work_gls
vmap work work_gls

# Design gate-level file compilation
vlog -L max10  -L intel_mf -L intel [format %s.vo $GL_FILE]

# TestBench Compilation.
vlog -timescale "1ns / 100ps"\
+incdir+$path_to_tb+$path_to_rtl/\
	$path_to_tb/spi_interface.v\
	$path_to_tb/rcb_tests.v\
	$path_to_tb/tester_rcb.v\
	$path_to_tb/tb_gls.v	

#sdfcom $path_to_gls/[format %s_v.sdo $GL_FILE] core_top.sdo

echo "-----------------------------------------------"
echo "------------ GL Compilation Completed ---------"
echo "-----------------------------------------------"

echo "-------------------------------------------------------"
echo "-------- Gate Level Optimization  Started -------------"
echo "-------------------------------------------------------"
vopt +acc -L max10  -L intel_mf -L intel RCB_FPGA tb_gls -o core_opt 

echo "-------------------------------------------------------"
echo "------ Gate Level Optimization  Completed -------------"
echo "-------------------------------------------------------"
echo "------ Optimized Gate Level Simulation is Started -----"
echo "-------------------------------------------------------"	
vsim   work_gls.core_opt -do $path_to_waves/gls_wave.do -wlf  vsim.wlf -quiet


run -all

echo "-----------------------------------------------"
echo "------------ GL Simulation Completed ----------"
echo "-----------------------------------------------"
