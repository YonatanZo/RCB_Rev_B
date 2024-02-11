/////////////////////////////////////////////////////////
//	File			: tester_rcb.v
//	Author			: Igor Dorman Trace PCB.
//	Date			: 26/08/2022
//	Description		: Tester for SPI RCB.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb <- tester_rcb
//	Last Update		: 18/10/2022 
//////////////////////////////////////////////////////////
`timescale 1ns/10ps

module tester_rcb(
//System 
	clk_100m,
	rst_n,
	clk_1m,
//SPI
	sclk,
	cs_n,
	mosi,
	miso,
	//FPGA Power Diagnostic
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
	
	//FPGA DRAPE SW State
	right_drape_sw_state,
	left_drape_sw_state,
	//FPGA DRAPE EM State
	right_drape_em_state,
	left_drape_em_state,
	//FPGA DRAPE Electro magnet S.W approval
	right_drape_em_open,
	left_drape_em_open,
	//FPGA DRAPE Sensors
	right_drape_close2_nc,
	right_drape_close2_no,
	right_drape_close1_nc,
	right_drape_close1_no,
	right_drape_open_nc,
	right_drape_open_no,
	left_drape_close2_nc,
	left_drape_close2_no,
	left_drape_close1_nc,
	left_drape_close1_no,
	left_drape_open_nc,
	left_drape_open_no,
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
	//FPGA ESTOP Status
	/*estop_btn1_nc,
	estop_btn1_no,
	estop_btn2_nc,
	estop_btn2_no,*/
	//Activation(Close) SSR
	//estop_activation,
	diag_activation,
	estop_open,
	teensy_estop_open_req,
	teensy_open_elo_req,
	miccb_estop_open_req,
	FPGA_WHEEL_STOP_ELO,
	estop_status,
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
	//Spare Left/Right 4.m.b.
	right_spare_diff_2,
	right_spare_diff_1,
	left_spare_diff_2,
	left_spare_diff_1,
	//Spare Left/Right 4.m.b.
	right_spare_diff_2,
	right_spare_diff_1,
	left_spare_diff_2,
	left_spare_diff_1,
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
output	rst_n;
output	clk_1m;
output	sclk;
output	cs_n;
output	mosi;
input 	miso;
//FPGA Power Diagnostic
output		pow;
//FPGA DRAPE Switch and Sensors state
output	right_plunger_nc;
output	right_plunger_no;
output	left_plunger_nc;
output	left_plunger_no;
output	right_tool_ex_nc;
output	right_tool_ex_no;
output	left_tool_ex_nc;
output	left_tool_ex_no;

//FPGA DRAPE Switch State
output	right_drape_sw_state;
output	left_drape_sw_state;
//FPGA DRAPE Electromagnet State
output	right_drape_em_state;
output	left_drape_em_state;
//FPGA DRAPE Electro magnet S.W approval
input	right_drape_em_open;
input	left_drape_em_open;
//FPGA DRAPE Sensors
output	right_drape_close2_nc;
output	right_drape_close2_no;
output	right_drape_close1_nc;
output	right_drape_close1_no;
output	right_drape_open_nc;
output	right_drape_open_no;
output	left_drape_close2_nc;
output	left_drape_close2_no;
output	left_drape_close1_nc;
output	left_drape_close1_no;
output	left_drape_open_nc;
output	left_drape_open_no;

//FPGA Wheel Driver
input[3:0]		wheel_home_sw;
input[3:0]		wheel_reverse_sw;
input[3:0]		wheel_forward_sw;
input[7:0]		wheel_driver_di;
//input			wheel_driver_elo;
output[3:0]		wheel_driver_do;
input			wheel_driver_rst;
input			wheel_driver_abrt;


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
//FPGA ESTOP Status
/*output	estop_btn1_nc;
output	estop_btn1_no;
output	estop_btn2_nc;
output	estop_btn2_no;*/
//Activation(Close) SSR
//input		estop_activation;
input		diag_activation;
input		estop_open;
output		teensy_estop_open_req;
output		teensy_open_elo_req;
input		miccb_estop_open_req;
input		FPGA_WHEEL_STOP_ELO;
output		estop_status;
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

//Spare Left/Right 4.m.b.
input		right_spare_diff_2;
output		right_spare_diff_1;
input		left_spare_diff_2;
output		left_spare_diff_1;

output		wheel_rod2_out1;
output		wheel_rod2_out2;
output		wheel_rod1_out1;
output		wheel_rod1_out2;

output		fan1_tacho;
input		fan1_pwm;
output		fan2_tacho;
input		fan2_pwm;
`ifdef ESTOP_CIRCUIT	
	output		teensy_activation;
	input		ssr_enable;	
`endif
output		sync;


//reg		clk_100m;
//reg		clk_1m;
wire 	sclk;
reg		rst_n;
wire	mosi;
wire	cs_n;
wire	miso;
//FPGA Power Diagnostic
wire	pow;
//FPGA DRAPE Switch and Sensors state
wire	right_plunger_nc;
wire	right_plunger_no;
wire	left_plunger_nc;
wire	left_plunger_no;
wire	right_tool_ex_nc;
wire	right_tool_ex_no;
wire	left_tool_ex_nc;
wire	left_tool_ex_no;
//FPGA DRAPE Switch State
wire	right_drape_sw_state;
wire	left_drape_sw_state;
//FPGA DRAPE Electromagnet State
wire	right_drape_em_state;
wire	left_drape_em_state;

wire	right_drape_open_nc;
wire	right_drape_open_no;
wire	right_drape_close1_nc;
wire	right_drape_close1_no;
wire	right_drape_close2_nc;
wire	right_drape_close2_no;
wire	left_drape_open_nc;
wire	left_drape_open_no;
wire	left_drape_close1_nc;
wire	left_drape_close1_no;
wire	left_drape_close2_nc;
wire	left_drape_close2_no;
//FPGA DRAPE Electro magnet S.W approval
wire	right_drape_em_open;
wire	left_drape_em_open;
//FPGA Wheel Driver
wire[3:0]		wheel_home_sw;
wire[3:0]		wheel_reverse_sw;
wire[3:0]		wheel_forward_sw;
wire[7:0]		wheel_driver_di;
//wire			wheel_driver_elo;
wire[3:0]		wheel_driver_do;
wire			wheel_driver_rst;
wire			wheel_driver_abrt;

//FPGA Wheel Sensor
wire		wheel_d_sens3_in2;
wire		wheel_d_sens3_in1;
wire		wheel_d_sens2_in2;
wire		wheel_d_sens2_in1;
wire		wheel_d_sens1_in2;
wire		wheel_d_sens1_in1;
wire		wheel_c_sens3_in2;
wire		wheel_c_sens3_in1;
wire		wheel_c_sens2_in2;
wire		wheel_c_sens2_in1;
wire		wheel_c_sens1_in2;
wire		wheel_c_sens1_in1;
wire		wheel_b_sens3_in2;
wire		wheel_b_sens3_in1;
wire		wheel_b_sens2_in2;
wire		wheel_b_sens2_in1;
wire		wheel_b_sens1_in2;
wire		wheel_b_sens1_in1;
wire		wheel_a_sens3_in2;
wire		wheel_a_sens3_in1;
wire		wheel_a_sens2_in2;
wire		wheel_a_sens2_in1;
wire		wheel_a_sens1_in2;
wire		wheel_a_sens1_in1;
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
//FPGA ESTOP Status
/*wire	estop_btn1_nc;
wire	estop_btn1_no;
wire	estop_btn2_nc;
wire	estop_btn2_no;*/
//Activation(Close) SSR
//wire	estop_activation;
wire	diag_activation;
wire	estop_open;
wire[7:0]	diagnostic_led;

wire[1:0]	sp2_single_ended_2_3;
wire[1:0]	sp2_single_ended_1_0;
wire[2:0]	sp2_analog_switch;
wire[1:0]	sp2_diff_pair_2_3;
wire[1:0]	sp2_diff_pair_1_0;
wire[1:0]	sp1_single_ended_2_3;
wire[1:0]	sp1_single_ended_1_0;
wire[2:0]	sp1_analog_switch;
wire[1:0]	sp1_diff_pair_2_3;
wire[1:0]	sp1_diff_pair_1_0;

wire		sync;

wire[7:0]	spi_com;
wire[15:0]	spi_addr;
wire[31:0]	mosi_data;
wire[31:0]	miso_data;
wire		run_rcb_tests;
wire		spi_done;
wire		spi_run;
integer 	test_file;
integer 	broadcast;

integer errors_counter;		//The counter off errors off the all Super I/O tests.
	
//------------ MAIN INITIAL -----------------------//
initial
begin
	test_file = $fopen ("../result/main_report.txt");	//Open Main Report File
	broadcast = 1 | test_file; //send the report text to file and to display together

	$fdisplay(broadcast,"\n************************************");
	$fdisplay(broadcast,"****** RCB TEST BEGIN AT %.0f ns ******",$time);
	$fdisplay(broadcast,"************************************");

	errors_counter <= 0;

	rst_n = 1'b0;
	#100;//500;
	rst_n = 1'b1;
	
	#1000;
	
	wait(!(1'b0 || run_rcb_tests));  //wait all tests finished	
	#1000;
	
	//Check_Errors;	
	
	$fclose (broadcast);
	
	`ifdef CREATE_VCD_FILE
		$dumpflush;
	`endif
	$stop;

end

//--------- clock generators ----------//	
/*
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
*/	
spi_interface spi_interface(
	.rst_n(rst_n),
	.sclk(sclk),
	.cs_n(cs_n),
	.mosi(mosi),
	.miso(miso),
	.spi_com(spi_com),
	.spi_addr(spi_addr),
	.mosi_data(mosi_data),
	.miso_data(miso_data),
	.spi_done(spi_done),
	.spi_run(spi_run)
);

rcb_tests rcb_tests(
	.clk_100m(clk_100m),
	.clk_1m(clk_1m),
	.rst_n(rst_n),
	//FPGA Power Diagnostic
	.pow(pow),
	//FPGA DRAPE Switch and Sensors state
	.right_plunger_nc(right_plunger_nc),
	.right_plunger_no(right_plunger_no),
	.left_plunger_nc(left_plunger_nc),
	.left_plunger_no(left_plunger_no),
	.right_tool_ex_nc(right_tool_ex_nc),
	.right_tool_ex_no(right_tool_ex_no),
	.left_tool_ex_nc(left_tool_ex_nc),
	.left_tool_ex_no(left_tool_ex_no),
	.right_drape_sw_state(right_drape_sw_state),
	.left_drape_sw_state(left_drape_sw_state),
	.right_drape_em_state(right_drape_em_state),
	.left_drape_em_state(left_drape_em_state),
	.right_drape_open_nc(right_drape_open_nc),
	.right_drape_open_no(right_drape_open_no),
	.right_drape_close1_nc(right_drape_close1_nc),
	.right_drape_close1_no(right_drape_close1_no),
	.right_drape_close2_nc(right_drape_close2_nc),
	.right_drape_close2_no(right_drape_close2_no),
	.left_drape_open_nc(left_drape_open_nc),
	.left_drape_open_no(left_drape_open_no),
	.left_drape_close1_nc(left_drape_close1_nc),
	.left_drape_close1_no(left_drape_close1_no),
	.left_drape_close2_nc(left_drape_close2_nc),
	.left_drape_close2_no(left_drape_close2_no),
	//FPGA DRAPE Electro magnet S.W approval
	.right_drape_em_open(right_drape_em_open),
	.left_drape_em_open(left_drape_em_open),
	//FPGA Buttons LED
	.right_tool_ex_led3(right_tool_ex_led3),
	.right_tool_ex_led2(right_tool_ex_led2),
	.right_tool_ex_led1(right_tool_ex_led1),
	.left_tool_ex_led3(left_tool_ex_led3),
	.left_tool_ex_led2(left_tool_ex_led2),
	.left_tool_ex_led1(left_tool_ex_led1),
	.right_plunger_led3(right_plunger_led3),
	.right_plunger_led2(right_plunger_led2),
	.right_plunger_led1(right_plunger_led1),
	.left_plunger_led3(left_plunger_led3),
	.left_plunger_led2(left_plunger_led2),
	.left_plunger_led1(left_plunger_led1),	
	//FPGA ESTOP Status
	/*.estop_btn1_nc(estop_btn1_nc),
	.estop_btn1_no(estop_btn1_no),
	.estop_btn2_nc(estop_btn2_nc),
	.estop_btn2_no(estop_btn2_no),*/
	//FPGA ESTOP Activation
	.diag_activation(diag_activation),	
	//.estop_activation(estop_activation),
	//FPGA ESTOP DIAGNOSTIC
	.estop_open(estop_open),
	//FPGA Wheel Driver	
	.wheel_home_sw(wheel_home_sw),
	.wheel_reverse_sw(wheel_reverse_sw),
	.wheel_forward_sw(wheel_forward_sw),
	.wheel_driver_di(wheel_driver_di),
	//.wheel_driver_elo(wheel_driver_elo),
	.wheel_driver_do(wheel_driver_do),
	.wheel_driver_rst(wheel_driver_rst),
	.wheel_driver_abrt(wheel_driver_abrt),
	//FPGA Wheel Sensor
	.wheel_d_sens3_in2(wheel_d_sens3_in2),
	.wheel_d_sens3_in1(wheel_d_sens3_in1),
	.wheel_d_sens2_in2(wheel_d_sens2_in2),
	.wheel_d_sens2_in1(wheel_d_sens2_in1),
	.wheel_d_sens1_in2(wheel_d_sens1_in2),
	.wheel_d_sens1_in1(wheel_d_sens1_in1),	
	.wheel_c_sens3_in2(wheel_c_sens3_in2),	
	.wheel_c_sens3_in1(wheel_c_sens3_in1),
	.wheel_c_sens2_in2(wheel_c_sens2_in2),
	.wheel_c_sens2_in1(wheel_c_sens2_in1),
	.wheel_c_sens1_in2(wheel_c_sens1_in2),
	.wheel_c_sens1_in1(wheel_c_sens1_in1),
	.wheel_b_sens3_in2(wheel_b_sens3_in2),
	.wheel_b_sens3_in1(wheel_b_sens3_in1),
	.wheel_b_sens2_in2(wheel_b_sens2_in2),
	.wheel_b_sens2_in1(wheel_b_sens2_in1),
	.wheel_b_sens1_in2(wheel_b_sens1_in2),
	.wheel_b_sens1_in1(wheel_b_sens1_in1),	
	.wheel_a_sens3_in2(wheel_a_sens3_in2),
	.wheel_a_sens3_in1(wheel_a_sens3_in1),	
	.wheel_a_sens2_in2(wheel_a_sens2_in2),	
	.wheel_a_sens2_in1(wheel_a_sens2_in1),	
	.wheel_a_sens1_in2(wheel_a_sens1_in2),
	.wheel_a_sens1_in1(wheel_a_sens1_in1),
	.diagnostic_led(diagnostic_led),
	.sp2_single_ended_2_3(sp2_single_ended_2_3),
	.sp2_single_ended_1_0(sp2_single_ended_1_0),
	.sp2_analog_switch(sp2_analog_switch),
	.sp2_diff_pair_2_3(sp2_diff_pair_2_3),
	.sp2_diff_pair_1_0(sp2_diff_pair_1_0),
	//Spare1 IO
	.sp1_single_ended_2_3(sp1_single_ended_2_3),
	.sp1_single_ended_1_0(sp1_single_ended_1_0),
	.sp1_analog_switch(sp1_analog_switch),
	.sp1_diff_pair_2_3(sp1_diff_pair_2_3),
	.sp1_diff_pair_1_0(sp1_diff_pair_1_0),
	.wheel_rod2_out1(wheel_rod2_out1),
	.wheel_rod2_out2(wheel_rod2_out2),
	.wheel_rod1_out1(wheel_rod1_out1),
	.wheel_rod1_out2(wheel_rod1_out2),
	.fan1_tacho(fan1_tacho),
	.fan1_pwm(fan1_pwm),
	.fan2_tacho(fan2_tacho),
	.fan2_pwm(fan2_pwm),
	.spi_com(spi_com),
	.spi_addr(spi_addr),
	.mosi_data(mosi_data),
	.miso_data(miso_data),
	.tests_run(run_rcb_tests),
	.spi_done(spi_done),
	.spi_run(spi_run),
	.broadcast(broadcast),
`ifdef ESTOP_CIRCUIT	
	.teensy_activation(teensy_activation),
	.ssr_enable(ssr_enable),
`endif
	.sync(sync)
);





endmodule

