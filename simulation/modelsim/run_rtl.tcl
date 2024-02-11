#-----------------------------------------------------------------------#
#Module name: run_all.tcl
#Author		: Igor Dorman Trace PCB.
#Date		: 27/09/2022
#Description: The script file for RTL similation of RCB FPGA
#Version	: 1.0
#Last Update: 06/10/2022 
#------------------------------------------------------------------------#

 
set path_to_rtl		../../source
set path_to_tb		.././testbench
set path_to_waves	.././result
set path_to_vcd		.././result
set string_arg1		"noopt"

if {$argc == 0} {
	set 1 "opt"
}

puts "-----------------------------------------------"	
puts "------------ RTL Compilation Started ----------"	
puts "-----------------------------------------------"	

vlib work
vdel -lib work -all 

vlib work
vmap work work

# DUT Compilation.
vlog -timescale "1ns / 100ps"\
+define+RTL_SIM\
+incdir+$path_to_rtl/\
	$path_to_rtl/rcb_spi.v\
	$path_to_rtl/rcb_registers.v\
	$path_to_rtl/rcb_top.v
	
# TestBench Compilation.
vlog -timescale "1ns / 100ps"\
+incdir+$path_to_tb+$path_to_rtl/\
	$path_to_tb/spi_interface.v\
	$path_to_tb/rcb_tests.v\
	$path_to_tb/tester_rcb.v\
	$path_to_tb/tb_rcb.v

puts "-----------------------------------------------"
puts "------------ RTL Compilation Completed --------"
puts "-----------------------------------------------"

onbreak {resume}

#Optimization + Simulation
if {[string equal $1 $string_arg1]} {
	puts "-------- RTL Simulation Started ---------------"
	puts "-----------------------------------------------"	

	vsim -noopt work.tb_rcb\	
	do $path_to_waves/wave.do -wlf  vsim.wlf -quiet
	
} else {
	
	puts "-----------------------------------------------"
	puts "-------- RTL Optimization  Started ------------"
	puts "-----------------------------------------------"
	vopt +acc rcb_top tb_rcb -o rcb_opt
	puts "-----------------------------------------------"
	puts "------ RTL Optimization  Completed ------------"
	puts "-----------------------------------------------"
	puts "-------- RTL Simulation Started ---------------"
	puts "-----------------------------------------------"	

	vsim  work.rcb_opt
	do $path_to_waves/wave.do -wlf  vsim.wlf -quiet
}

run -all

#Translations a .vcd file into a .wlf file that can be displayed in ModelSim
#vcd2wlf ../result/rcb.vcd rcb.wlf
#vsim -view rcb.wlf; add wave -r /*

puts "-----------------------------------------------"
puts "------------ RTL Simulation Completed ---------"
puts "-----------------------------------------------"

