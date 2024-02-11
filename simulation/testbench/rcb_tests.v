//////////////////////////////////////////////////////////////
//	File			: rcb_tests.v
//	Author			: Igor Dorman Trace PCB.
//	Date			: 26/09/2022
//	Description		: All RCB Tests.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb <- tester_rcb <- rcb_tests
//	Last Update		: 18/10/2022 
//////////////////////////////////////////////////////////////
`timescale 1ns/10ps

module rcb_tests(
	clk_100m,
	clk_1m,
	rst_n,
	pow,
	//FPGA DRAPE Switch and Sensors state
	right_plunger_nc,
	right_plunger_no,
	left_plunger_nc,
	left_plunger_no,
	right_tool_ex_nc,
	right_tool_ex_no,
	left_tool_ex_nc,
	left_tool_ex_no,
	right_drape_sw_state,
	left_drape_sw_state,
	right_drape_em_state,
	left_drape_em_state,
	right_drape_open_nc,
	right_drape_open_no,
	right_drape_close1_nc,
	right_drape_close1_no,
	right_drape_close2_nc,
	right_drape_close2_no,
	left_drape_open_nc,
	left_drape_open_no,
	left_drape_close1_nc,
	left_drape_close1_no,
	left_drape_close2_nc,
	left_drape_close2_no,
	//FPGA DRAPE Electro magnet S.W approval
	right_drape_em_open,
	left_drape_em_open,
	//FPGA Wheel Driver
	wheel_home_sw,
	wheel_reverse_sw,
	wheel_forward_sw,
	wheel_driver_di,
	//wheel_driver_elo,
	wheel_driver_do,
	wheel_driver_rst,
	wheel_driver_abrt,
	//FPGA Wheel Sensor
	wheel_d_sens3_in2,
	wheel_d_sens3_in1,
	wheel_d_sens2_in2,
	wheel_d_sens2_in1,
	wheel_d_sens1_in2,
	wheel_d_sens1_in1,	
	wheel_c_sens3_in2,	
	wheel_c_sens3_in1,
	wheel_c_sens2_in2,
	wheel_c_sens2_in1,
	wheel_c_sens1_in2,
	wheel_c_sens1_in1,
	wheel_b_sens3_in2,
	wheel_b_sens3_in1,
	wheel_b_sens2_in2,
	wheel_b_sens2_in1,
	wheel_b_sens1_in2,
	wheel_b_sens1_in1,	
	wheel_a_sens3_in2,
	wheel_a_sens3_in1,	
	wheel_a_sens2_in2,	
	wheel_a_sens2_in1,	
	wheel_a_sens1_in2,
	wheel_a_sens1_in1,
	//FPGA Buttons LED
	right_tool_ex_led3,
	right_tool_ex_led2,
	right_tool_ex_led1,
	left_tool_ex_led3,
	left_tool_ex_led2,
	left_tool_ex_led1,
	right_plunger_led3,
	right_plunger_led2,
	right_plunger_led1,
	left_plunger_led3,
	left_plunger_led2,
	left_plunger_led1,
	//Diagnistic Leds
	diagnostic_led,
	//Spare2 IO
	sp2_single_ended_2_3,
	sp2_single_ended_1_0,
	sp2_analog_switch,
	sp2_diff_pair_2_3,
	sp2_diff_pair_1_0,
	//Spare1 IO
	sp1_single_ended_2_3,
	sp1_single_ended_1_0,
	sp1_analog_switch,
	sp1_diff_pair_2_3,
	sp1_diff_pair_1_0,

	// Wheel Rod Sensor
	wheel_rod2_out1,
	wheel_rod2_out2,
	wheel_rod1_out1,
	wheel_rod1_out2,
	//FANs
	fan1_tacho,
	fan1_pwm,
	fan2_tacho,
	fan2_pwm,
	
	/*estop_btn2_nc,
	estop_btn2_no,
	estop_btn1_nc,
	estop_btn1_no,*/
	//estop_activation,
	diag_activation,
	estop_open,
	spi_com,
	spi_addr,
	mosi_data,
	miso_data,
	tests_run,
	spi_done,
	spi_run,
	broadcast,
`ifdef ESTOP_CIRCUIT	
	teensy_activation,
	ssr_enable,
`endif		
	
	//SYNC
	sync
);

`include  "rcb_parameters.v"
`include  "tb_parameters.v"

output	clk_100m;
input	rst_n;
output	clk_1m;
output	pow;
//FPGA DRAPE Switch and Sensors state
output	right_plunger_nc;
output	right_plunger_no;
output	left_plunger_nc;
output	left_plunger_no;
output	right_tool_ex_nc;
output	right_tool_ex_no;
output	left_tool_ex_nc;
output	left_tool_ex_no;
output	right_drape_open_nc;
output	right_drape_open_no;
output	right_drape_close1_nc;
output	right_drape_close1_no;
output	right_drape_close2_nc;
output	right_drape_close2_no;
//FPGA DRAPE Switch State
output	right_drape_sw_state;
output	left_drape_sw_state;
//FPGA DRAPE Electromagnet State
output	right_drape_em_state;
output	left_drape_em_state;
output	left_drape_open_nc;
output	left_drape_open_no;
output	left_drape_close1_nc;
output	left_drape_close1_no;
output	left_drape_close2_nc;
output	left_drape_close2_no;
//FPGA DRAPE Electro magnet S.W approval
input	right_drape_em_open;
input	left_drape_em_open;
//FPGA Wheel Driver
input[3:0]	wheel_home_sw;
input[3:0]	wheel_reverse_sw;
input[3:0]	wheel_forward_sw;
input[7:0]	wheel_driver_di;
//input		wheel_driver_elo;
output[3:0]	wheel_driver_do;
input		wheel_driver_rst;
input		wheel_driver_abrt;
//FPGA Wheel Sensor
output	wheel_d_sens3_in2;
output	wheel_d_sens3_in1;
output	wheel_d_sens2_in2;
output	wheel_d_sens2_in1;
output	wheel_d_sens1_in2;
output	wheel_d_sens1_in1;
output	wheel_c_sens3_in2;
output	wheel_c_sens3_in1;
output	wheel_c_sens2_in2;
output	wheel_c_sens2_in1;
output	wheel_c_sens1_in2;
output	wheel_c_sens1_in1;
output	wheel_b_sens3_in2;
output	wheel_b_sens3_in1;
output	wheel_b_sens2_in2;
output	wheel_b_sens2_in1;
output	wheel_b_sens1_in2;
output	wheel_b_sens1_in1;
output	wheel_a_sens3_in2;
output	wheel_a_sens3_in1;
output	wheel_a_sens2_in2;
output	wheel_a_sens2_in1;
output	wheel_a_sens1_in2;
output	wheel_a_sens1_in1;
//FPGA Buttons LED
input	right_tool_ex_led3;
input	right_tool_ex_led2;
input	right_tool_ex_led1;
input	left_tool_ex_led3;
input	left_tool_ex_led2;
input	left_tool_ex_led1;
input	right_plunger_led3;
input	right_plunger_led2;
input	right_plunger_led1;
input	left_plunger_led3;
input	left_plunger_led2;
input	left_plunger_led1;
/*output	estop_btn2_nc;
output	estop_btn2_no;
output	estop_btn1_nc;
output	estop_btn1_no;*/
//input	estop_activation;
input	diag_activation;
input	estop_open;
input[7:0]	diagnostic_led;
input[1:0]	sp2_single_ended_2_3;
output[1:0]	sp2_single_ended_1_0;
input[2:0]	sp2_analog_switch;
input[1:0]	sp2_diff_pair_2_3;
output[1:0]	sp2_diff_pair_1_0;
input[1:0]	sp1_single_ended_2_3;
output[1:0]	sp1_single_ended_1_0;
input[2:0]	sp1_analog_switch;
input[1:0]	sp1_diff_pair_2_3;
output[1:0]	sp1_diff_pair_1_0;
output		wheel_rod2_out1;
output		wheel_rod2_out2;
output		wheel_rod1_out1;
output		wheel_rod1_out2;
output		fan1_tacho;
input		fan1_pwm;
output		fan2_tacho;
input		fan2_pwm;

output[7:0]		spi_com;
output[15:0]	spi_addr;
output[31:0]	mosi_data;
input[31:0]		miso_data;
output			tests_run;
input			spi_done;
output			spi_run;
input			broadcast;

`ifdef ESTOP_CIRCUIT	
	output		teensy_activation;
	input		ssr_enable;	
`endif
output		sync;

//`include  "rcb_parameters.v"

reg		clk_100m;
reg		clk_1m;
reg		pow;
//FPGA DRAPE Switch and Sensors state
reg		right_plunger_nc;
reg		right_plunger_no;
reg		left_plunger_nc;
reg		left_plunger_no;
reg		right_tool_ex_nc;
reg		right_tool_ex_no;
reg		left_tool_ex_nc;
reg		left_tool_ex_no;
reg		right_drape_em_state;
reg		right_drape_sw_state;
reg		right_drape_open_nc;
reg		right_drape_open_no;
reg		right_drape_close1_nc;
reg		right_drape_close1_no;
reg		right_drape_close2_nc;
reg		right_drape_close2_no;
reg		left_drape_em_state;
reg		left_drape_sw_state;
reg		left_drape_open_nc;
reg		left_drape_open_no;
reg		left_drape_close1_nc;
reg		left_drape_close1_no;
reg		left_drape_close2_nc;
reg		left_drape_close2_no;
//FPGA DRAPE Electro magnet S.W approval
wire	right_drape_em_open;
wire	left_drape_em_open;
//FPGA Buttons LED
wire	right_tool_ex_led3;
wire	right_tool_ex_led2;
wire	right_tool_ex_led1;
wire	left_tool_ex_led3;
wire	left_tool_ex_led2;
wire	left_tool_ex_led1;
wire	right_plunger_led3;
wire	right_plunger_led2;
wire	right_plunger_led1;
wire	left_plunger_led3;
wire	left_plunger_led2;
wire	left_plunger_led1;
wire[3:0]	wheel_home_sw;
wire[3:0]	wheel_reverse_sw;
wire[3:0]	wheel_forward_sw;
wire[7:0]	wheel_driver_di;
//wire		wheel_driver_elo;
wire		wheel_driver_rst;
wire		wheel_driver_abrt;
reg[3:0]	wheel_driver_do;

//FPGA Wheel Sensor
reg		wheel_d_sens3_in2;
reg		wheel_d_sens3_in1;
reg		wheel_d_sens2_in2;
reg		wheel_d_sens2_in1;
reg		wheel_d_sens1_in2;
reg		wheel_d_sens1_in1;
reg		wheel_c_sens3_in2;
reg		wheel_c_sens3_in1;
reg		wheel_c_sens2_in2;
reg		wheel_c_sens2_in1;
reg		wheel_c_sens1_in2;
reg		wheel_c_sens1_in1;
reg		wheel_b_sens3_in2;
reg		wheel_b_sens3_in1;
reg		wheel_b_sens2_in2;
reg		wheel_b_sens2_in1;
reg		wheel_b_sens1_in2;
reg		wheel_b_sens1_in1;
reg		wheel_a_sens3_in2;
reg		wheel_a_sens3_in1;
reg		wheel_a_sens2_in2;
reg		wheel_a_sens2_in1;
reg		wheel_a_sens1_in2;
reg		wheel_a_sens1_in1;

reg		wheel_rod2_out1;
reg		wheel_rod2_out2;
reg		wheel_rod1_out1;
reg		wheel_rod1_out2;
/*reg		estop_btn2_nc;
reg		estop_btn2_no;
reg		estop_btn1_nc;
reg		estop_btn1_no;*/
reg		fan1_tacho;
reg		fan2_tacho;
reg		fan_tacho_speed;

wire[7:0]	diagnostic_led;
wire[1:0]	sp2_single_ended_2_3;
reg[1:0]	sp2_single_ended_1_0;
wire[2:0]	sp2_analog_switch;
wire[1:0]	sp2_diff_pair_2_3;
reg[1:0]	sp2_diff_pair_1_0;
wire[1:0]	sp1_single_ended_2_3;
reg[1:0]	sp1_single_ended_1_0;
wire[2:0]	sp1_analog_switch;
wire[1:0]	sp1_diff_pair_2_3;
reg[1:0]	sp1_diff_pair_1_0;

reg[7:0]	spi_com;
reg[15:0]	spi_addr;
reg[31:0]	mosi_data;
wire[31:0]	miso_data;
reg			estop_run;
reg 		tests_run;
wire		spi_done;
reg			spi_run;

`ifdef ESTOP_CIRCUIT	
	reg		teensy_activation;
	wire	ssr_enable;	
`endif

//reg[15:0]addr_reg[0:12]; 

integer		errors_counter;			//Errors counters in all tests
integer 	errors_test;			//Errors in current test
//integer 	test_file;
//integer 	broadcast;
wire integer broadcast;	
reg[270:0]	tests;	//Name of current test	

`include "tests_list.v"
//`include  "rcb_test_plane.v"
`include  "rcb_tasks.v"

//#################### RCB TESTS RUN ############//
initial
begin
	//test_file = $fopen("../../result/rcb_report.txt"); 
	/*broadcast = 1 | test_file; //send the report text to file and to display.
	$fdisplay(broadcast,"\n**************************************************");
	$fdisplay(broadcast,"****** RCB TEST BEGIN AT %.0f ns ******",$time);
	$fdisplay(broadcast,"**************************************************");*/
	
	errors_counter = 0;
	errors_test = 0;
	spi_run = 0;
	spi_com = 0;
	spi_addr = 0;
	mosi_data = 0;
	pow <= 0;
	right_plunger_nc <= 0;
	right_plunger_no <= 1;
	left_plunger_nc <= 0;
	left_plunger_no <= 1;
	right_tool_ex_nc <= 0;
	right_tool_ex_no <= 1;
	left_tool_ex_nc <= 0;
	left_tool_ex_no <= 1;
	right_drape_em_state <= 0;
	right_drape_sw_state <= 0;
	right_drape_open_nc <= 0;
	right_drape_open_no <= 1;
	right_drape_close1_nc <= 0;
	right_drape_close1_no <= 1;
	right_drape_close2_nc <= 0;
	right_drape_close2_no <= 1;
	left_drape_em_state <= 0;
	left_drape_sw_state <= 0;
	left_drape_open_nc <= 0;
	left_drape_open_no <= 1;
	left_drape_close1_nc <= 0;
	left_drape_close1_no <= 1;
	left_drape_close2_nc <= 0;
	left_drape_close2_no <= 1;
	wheel_d_sens3_in2 <= 0;
	wheel_d_sens3_in1 <= 0;
	wheel_d_sens2_in2 <= 0;
	wheel_d_sens2_in1 <= 0;
	wheel_d_sens1_in2 <= 0;
	wheel_d_sens1_in1 <= 0;	
	wheel_c_sens3_in2 <= 0;	
	wheel_c_sens3_in1 <= 0;
	wheel_c_sens2_in2 <= 0;
	wheel_c_sens2_in1 <= 0;
	wheel_c_sens1_in2 <= 0;
	wheel_c_sens1_in1 <= 0;
	wheel_b_sens3_in2 <= 0;
	wheel_b_sens3_in1 <= 0;
	wheel_b_sens2_in2 <= 0;
	wheel_b_sens2_in1 <= 0;
	wheel_b_sens1_in2 <= 0;
	wheel_b_sens1_in1 <= 0;	
	wheel_a_sens3_in2 <= 0;
	wheel_a_sens3_in1 <= 0;	
	wheel_a_sens2_in2 <= 0;	
	wheel_a_sens2_in1 <= 0;	
	wheel_a_sens1_in2 <= 0;
	wheel_a_sens1_in1 <= 0;	
	sp2_single_ended_1_0 <= 0;
	sp2_diff_pair_1_0 <= 0;
	sp1_single_ended_1_0 <= 0;
	sp1_diff_pair_1_0 <= 0;
	wheel_rod2_out1 <= 0;
	wheel_rod2_out2 <= 1;
	wheel_rod1_out1 <= 0;
	wheel_rod1_out2 <= 1;
	/*estop_btn2_nc <= 0;
	estop_btn2_no <= 1;
	estop_btn1_nc <= 0;
	estop_btn1_no <= 1;*/
	wheel_driver_do <= 4'b0000;
	
`ifdef ESTOP_CIRCUIT	
	teensy_activation <= 1'b0;
`endif


	wait(rst_n);
	tests_run = 1;

	#10;

	Run_RCB_Tests;	

	Finish_Tests;	//Save result of test.(rcb_tasks.v)
	
	tests_run = 0;
end

//--------- clock generators ----------//	

initial  
begin:SYSTEM_CLOCK
	clk_100m	<= 1'b0;
	//#(4);
	forever #(SYSTEM_PERIOD/2) clk_100m <= ~clk_100m;
end //SYSTEM_CLOCK

initial  
begin:CLOCK_1MHz
	clk_1m	<= 1'b0;
	//#(4);
	forever #(PERIOD_1M/2) clk_1m <= ~clk_1m;
end //CLOCK_100KHz

initial  
begin:CLOCK_FAN_TACHO
	fan_tacho_speed	<= 1'b0;
	//#(4);
	forever #(FAN_TACHO_PERIOD/2) fan_tacho_speed <= ~fan_tacho_speed;
end //CLOCK_FAN_TACHO

always @*
begin	
	fan1_tacho = fan_tacho_speed;
	fan2_tacho = fan_tacho_speed;
end	



endmodule