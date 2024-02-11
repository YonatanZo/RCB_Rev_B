/////////////////////////////////////////////////////////
//	File			: tb_rcb.v
//	Author			: IGOR DORMAN. Trace PCB
//	Date			: 26/08/2022
//	Description		: The RCB testbench file.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb
//	Last Update		: 18/10/2022 
//////////////////////////////////////////////////////////

//`include "config.v"
`timescale 1ns/10ps

module tb_rcb;

//-------------------- Registers and Wires declarations -------------//
wire 	clk_100m;
wire	clk_1m;
wire 	rst_n;
//SPI signals
wire 	sclk;			// SPI clock.
wire 	cs_n;			// SPI CS(active low)
wire 	mosi;			// SPI Master Output.
wire 	miso;			// SPI Master Input.
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
//FPGA DRAPE Electro magnet S.W approval
wire	right_drape_em_open;
wire	left_drape_em_open;
//FPGA DRAPE Sensors
wire	right_drape_close2_nc;
wire	right_drape_close2_no;
wire	right_drape_close1_nc;
wire	right_drape_close1_no;
wire	right_drape_open_nc;
wire	right_drape_open_no;
wire	left_drape_close2_nc;
wire	left_drape_close2_no;
wire	left_drape_close1_nc;
wire	left_drape_close1_no;
wire	left_drape_open_nc;
wire	left_drape_open_no;

wire[3:0]		wheel_home_sw;
wire[3:0]		wheel_reverse_sw;
wire[3:0]		wheel_forward_sw;
wire[7:0]		wheel_driver_di;
//wire			wheel_driver_elo;
wire[3:0]		wheel_driver_do;
wire			wheel_driver_rst;
wire			wheel_driver_abrt;

//FPGA Wheel Sensor
wire	wheel_d_sens3_in2;
wire	wheel_d_sens3_in1;
wire	wheel_d_sens2_in2;
wire	wheel_d_sens2_in1;
wire	wheel_d_sens1_in2;
wire	wheel_d_sens1_in1;
wire	wheel_c_sens3_in2;
wire	wheel_c_sens3_in1;
wire	wheel_c_sens2_in2;
wire	wheel_c_sens2_in1;
wire	wheel_c_sens1_in2;
wire	wheel_c_sens1_in1;
wire	wheel_b_sens3_in2;
wire	wheel_b_sens3_in1;
wire	wheel_b_sens2_in2;
wire	wheel_b_sens2_in1;
wire	wheel_b_sens1_in2;
wire	wheel_b_sens1_in1;
wire	wheel_a_sens3_in2;
wire	wheel_a_sens3_in1;
wire	wheel_a_sens2_in2;
wire	wheel_a_sens2_in1;
wire	wheel_a_sens1_in2;
wire	wheel_a_sens1_in1;
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
wire	estop_btn1_nc_st;
wire	estop_btn1_no_st;
wire	estop_btn2_nc_st;
wire	estop_btn2_no_st;
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

wire		right_spare_diff_2;
wire		right_spare_diff_1;
wire		left_spare_diff_2;
wire		left_spare_diff_1;
wire		wheel_rod2_out1;
wire		wheel_rod2_out2;
wire		wheel_rod1_out1;
wire		wheel_rod1_out2;
wire		fan1_tacho;
wire		fan1_pwm;
wire		fan2_tacho;
wire		fan2_pwm;

//wire		estop_activation;
wire		diag_activation;
wire		estop_open;
wire		sync;

//----------- SPI Instantiation --------//
rcb_top dut(
	//System
	.clk_100m(clk_100m),
	.rst_n(rst_n),
	.clk_1m(clk_1m),
	//SPI
	.sclk(sclk),
	.cs_n(cs_n),
	.mosi(mosi),
	.miso(miso),
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
	
	//FPGA DRAPE SW State
	.right_drape_sw_state(right_drape_sw_state),
	.left_drape_sw_state(left_drape_sw_state),
	//FPGA DRAPE EM State
	.right_drape_em_state(right_drape_em_state),
	.left_drape_em_state(left_drape_em_state),
	//FPGA DRAPE Electro magnet S.W approval
	.right_drape_em_open(right_drape_em_open),
	.left_drape_em_open(left_drape_em_open),
	//FPGA DRAPE Sensors
	.right_drape_close2_nc(right_drape_close2_nc),
	.right_drape_close2_no(right_drape_close2_no),
	.right_drape_close1_nc(right_drape_close1_nc),
	.right_drape_close1_no(right_drape_close1_no),
	.right_drape_open_nc(right_drape_open_nc),
	.right_drape_open_no(right_drape_open_no),
	.left_drape_close2_nc(left_drape_close2_nc),
	.left_drape_close2_no(left_drape_close2_no),
	.left_drape_close1_nc(left_drape_close1_nc),
	.left_drape_close1_no(left_drape_close1_no),
	.left_drape_open_nc(left_drape_open_nc),
	.left_drape_open_no(left_drape_open_no),
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
	//Activation(Close) SSR
	//.estop_activation(estop_activation),
	.diag_activation(diag_activation),
	.estop_open(estop_open),
	.teensy_estop_open_req(teensy_estop_open_req),
	.teensy_open_elo_req(teensy_open_elo_req),
	.miccb_estop_open_req(miccb_estop_open_req),
	.FPGA_WHEEL_STOP_ELO(FPGA_WHEEL_STOP_ELO),
	.diagnostic_led(diagnostic_led),
	
	//Spare2 IO
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
	
	//Wheel Rod Sensor
	.wheel_rod2_out1(wheel_rod2_out1),
	.wheel_rod2_out2(wheel_rod2_out2),
	.wheel_rod1_out1(wheel_rod1_out1),
	.wheel_rod1_out2(wheel_rod1_out2),
	//FANs
	.fan1_tacho(fan1_tacho),
	.fan1_pwm(fan1_pwm),
	.fan2_tacho(fan2_tacho),
	.fan2_pwm(fan2_pwm),
	
	//SYNC
	.sync(sync)
);


//---------------------- SPI Tester Instantiation ---------------------//
tester_rcb tb(
//System
	.clk_100m(clk_100m),
	.rst_n(rst_n),
	.clk_1m(clk_1m),
//SPI
	.sclk(sclk),
	.cs_n(cs_n),
	.mosi(mosi),
	.miso(miso),
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
	
	//FPGA DRAPE SW State
	.right_drape_sw_state(right_drape_sw_state),
	.left_drape_sw_state(left_drape_sw_state),
	//FPGA DRAPE EM State
	.right_drape_em_state(right_drape_em_state),
	.left_drape_em_state(left_drape_em_state),
	//FPGA DRAPE Electro magnet S.W approval
	.right_drape_em_open(right_drape_em_open),
	.left_drape_em_open(left_drape_em_open),
	//FPGA DRAPE Sensors
	.right_drape_close2_nc(right_drape_close2_nc),
	.right_drape_close2_no(right_drape_close2_no),
	.right_drape_close1_nc(right_drape_close1_nc),
	.right_drape_close1_no(right_drape_close1_no),
	.right_drape_open_nc(right_drape_open_nc),
	.right_drape_open_no(right_drape_open_no),
	.left_drape_close2_nc(left_drape_close2_nc),
	.left_drape_close2_no(left_drape_close2_no),
	.left_drape_close1_nc(left_drape_close1_nc),
	.left_drape_close1_no(left_drape_close1_no),
	.left_drape_open_nc(left_drape_open_nc),
	.left_drape_open_no(left_drape_open_no),
	
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
	//Activation(Close) SSR
	//.estop_activation(estop_activation),
	.diag_activation(diag_activation),
	.estop_open(estop_open),
	.teensy_estop_open_req(teensy_estop_open_req),
	.teensy_open_elo_req(teensy_open_elo_req),
	.miccb_estop_open_req(miccb_estop_open_req),
	.FPGA_WHEEL_STOP_ELO(FPGA_WHEEL_STOP_ELO),
	.diagnostic_led(diagnostic_led),
	
	//Spare2 IO
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
	
	// Wheel Rod Sensor
	.wheel_rod2_out1(wheel_rod2_out1),
	.wheel_rod2_out2(wheel_rod2_out2),
	.wheel_rod1_out1(wheel_rod1_out1),
	.wheel_rod1_out2(wheel_rod1_out2),
	//FANs
	.fan1_tacho(fan1_tacho),
	.fan1_pwm(fan1_pwm),
	.fan2_tacho(fan2_tacho),
	.fan2_pwm(fan2_pwm),
`ifdef ESTOP_CIRCUIT	
	.teensy_activation(teensy_activation),
	.ssr_enable(ssr_enable),
`endif	
	
	//SYNC
	.sync(sync)
);



`ifdef ESTOP_CIRCUIT
estop estop(
	//System signals
	.clk_1m(clk_1m),
    .rst_n(rst_n),      	// low active synchronous reset

	//FPGA ESTOP Status
	.estop_btn1_no(estop_btn1_no),
	.estop_btn2_no(estop_btn2_no),
	//Activation(Close) SSR
	//.estop_activation(estop_activation),
	.diag_activation(diag_activation),
	.estop_open(estop_open),
	.teensy_activation(teensy_activation),
	.ssr_enable(ssr_enable)
	);
`endif

`ifdef CREATE_VCD_FILE
	initial 
	begin
		$dumpfile("../result/rcb.vcd");
		
		$dumpvars(1,"tb");
		$dumpvars(1,"dut");
		
	end
`endif

endmodule
