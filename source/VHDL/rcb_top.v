////////////////////////////////////////////////////
//	File			: rcb_top.v
//	Author			: Igor Dorman. tracePCB.
//	Date			: 31/08/2022
//	Description		: RCB Top File.
//	Revision		: 1.0
//	Hierarchy		: rcb_top 
//	Last Update		: 18/10/2022 
////////////////////////////////////////////////////

module rcb_top(
	trig_in,
	//System signals
    clk_100m,       // system clock
	clk_1m,			//Internal FPGA from PLL
    rst_n,      	// low active synchronous reset
	//SPI INTERFACE
	sclk,      	// SPI clock
	cs_n,     	// SPI chip select, active in low
	mosi,     	// SPI serial data from master to slave
	miso,     	// SPI serial data from slave to master
	//FPGA Power Diagnostic
	pow,
	//FPGA Buttons
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

	//ESTOP
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
	//SYNC
	sync,
	estop_delay,
	left_robot_tx,
	left_robot_rx,
	right_robot_tx,
	right_robot_rx,
	fpga_spare2,
	fpga_spare3,
	fpga_spare4,
	fpga_spare5,
	fpga_spare6,
	fpga_spare7,
	fpga_spare8,
	fpga_spare9,
	fpga_spare10,
	fpga_spare11,
	fpga_spare12,
	teensy_fpga4,
	teensy_fpga5,
	fpga_spare13,
	MICCB_SPARE_IO0,
	MICCB_SPARE_IO1,
	MICCB_SPARE_IO2,
	MICCB_SPARE_IO3
	
);
	

input trig_in;
input 		clk_100m; 
input 		rst_n;
input		clk_1m;
//SPI Interface
input 		sclk; 
input 		cs_n;
input 		mosi; 
output 		miso;  
//FPGA Power Diagnostic
input		pow;
//FPGA Buttons
input		right_plunger_nc;
input		right_plunger_no;
input		left_plunger_nc;
input		left_plunger_no;
input		right_tool_ex_nc;
input		right_tool_ex_no;
input		left_tool_ex_nc;
input		left_tool_ex_no;
//FPGA DRAPE Switch State
input		right_drape_sw_state;
input		left_drape_sw_state;
//FPGA DRAPE Electromagnet State
input		right_drape_em_state;
input		left_drape_em_state;
//FPGA DRAPE Electro magnet S.W approval
output		right_drape_em_open;
output		left_drape_em_open;
//FPGA DRAPE Sensors
input		right_drape_close2_nc;
input		right_drape_close2_no;
input		right_drape_close1_nc;
input		right_drape_close1_no;
input		right_drape_open_nc;
input		right_drape_open_no;
input		left_drape_close2_nc;
input		left_drape_close2_no;
input		left_drape_close1_nc;
input		left_drape_close1_no;
input		left_drape_open_nc;
input		left_drape_open_no;

//FPGA Wheel Driver
output[3:0]	wheel_home_sw;
output[3:0]	wheel_reverse_sw;
output[3:0]	wheel_forward_sw;
output[7:0]	wheel_driver_di;
//output		wheel_driver_elo;
input[3:0]	wheel_driver_do;
output		wheel_driver_rst;
output		wheel_driver_abrt;
//FPGA Wheel Sensor
input		wheel_d_sens3_in2;
input		wheel_d_sens3_in1;
input		wheel_d_sens2_in2;
input		wheel_d_sens2_in1;
input		wheel_d_sens1_in2;
input		wheel_d_sens1_in1;
input		wheel_c_sens3_in2;
input		wheel_c_sens3_in1;
input		wheel_c_sens2_in2;
input		wheel_c_sens2_in1;
input		wheel_c_sens1_in2;
input		wheel_c_sens1_in1;
input		wheel_b_sens3_in2;
input		wheel_b_sens3_in1;
input		wheel_b_sens2_in2;
input		wheel_b_sens2_in1;
input		wheel_b_sens1_in2;
input		wheel_b_sens1_in1;
input		wheel_a_sens3_in2;
input		wheel_a_sens3_in1;
input		wheel_a_sens2_in2;
input		wheel_a_sens2_in1;
input		wheel_a_sens1_in2;
input		wheel_a_sens1_in1;
//FPGA Buttons LED
output		right_tool_ex_led3;
output		right_tool_ex_led2;
output		right_tool_ex_led1;
output		left_tool_ex_led3;
output		left_tool_ex_led2;
output		left_tool_ex_led1;
output		right_plunger_led3;
output		right_plunger_led2;
output		right_plunger_led1;
output		left_plunger_led3;
output		left_plunger_led2;
output		left_plunger_led1;

//ESTOP
//output		estop_activation;
output		diag_activation;
output		estop_open;
input		teensy_estop_open_req;
input		teensy_open_elo_req;
output		miccb_estop_open_req;
output		FPGA_WHEEL_STOP_ELO;
input		estop_status;

output[7:0]	diagnostic_led;

output[1:0]	sp2_single_ended_2_3;
input[1:0]	sp2_single_ended_1_0;
output[2:0]	sp2_analog_switch;
output[1:0]	sp2_diff_pair_2_3;
input[1:0]	sp2_diff_pair_1_0;
output[1:0]	sp1_single_ended_2_3;
input[1:0]	sp1_single_ended_1_0;
output[2:0]	sp1_analog_switch;
output[1:0]	sp1_diff_pair_2_3;
input[1:0]	sp1_diff_pair_1_0;
//Spare Left/Right 4.m.b.
output		right_spare_diff_2;
input		right_spare_diff_1;
output		left_spare_diff_2;
input		left_spare_diff_1;

input		wheel_rod2_out1;
input		wheel_rod2_out2;
input		wheel_rod1_out1;
input		wheel_rod1_out2;

input		fan1_tacho;
output		fan1_pwm;
input		fan2_tacho;
output		fan2_pwm;	

input		sync;
output		estop_delay;
output		left_robot_tx;
input		left_robot_rx;
output		right_robot_tx;
input		right_robot_rx;
input		fpga_spare2;
input		fpga_spare3;
input		fpga_spare4;
input		fpga_spare5;
input		fpga_spare6;
input		fpga_spare7;
input		fpga_spare8;
input		fpga_spare9;
input		fpga_spare10;
input		fpga_spare11;
input		fpga_spare12;
input		teensy_fpga4;
input		teensy_fpga5;
input		fpga_spare13;
input		MICCB_SPARE_IO0;
input		MICCB_SPARE_IO1;
output		MICCB_SPARE_IO2;
output		MICCB_SPARE_IO3;



//WIRES
wire 		clk_100m; 
wire 		rst_n;
wire 		clk_1m;  
wire 		sclk; 
wire 		cs_n;
wire 		mosi; 
wire		miso; 
wire[31:0]	data_miso;
wire[31:0]	data_mosi;
wire		data_mosi_rdy;
wire		data_miso_rdy;
wire[15:0]	addr;
wire		addr_rdy;
wire		pow;
wire[11:0]	drape_sensor;
wire[1:0]	drape_sw_state;
wire[1:0]	drape_em_state;
wire[23:0]	wheel_sensor;
wire[31:0]	fpga_buttons_led_reg;
wire[7:0]	fpga_buttons;
wire[3:0]	wheel_home_sw;
wire[3:0]	wheel_reverse_sw;
wire[3:0]	wheel_forward_sw;
wire[7:0]	wheel_driver_di;
//wire		wheel_driver_elo;
wire[3:0]	wheel_driver_do;
wire		wheel_driver_rst;
wire		wheel_driver_abrt;
wire 		sync;

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
//wire		estop_activation;
wire		diag_activation;
wire 		teensy_estop_open_req;
wire 		teensy_open_elo_req;
wire 		miccb_estop_open_req;
wire 		FPGA_WHEEL_STOP_ELO;
wire		estop_open;
wire		estop_status;
wire		send_miso;

//FPGA DRAPE Switch State
wire		right_drape_sw_state;
wire		left_drape_sw_state;
//FPGA DRAPE Electromagnet State
wire		right_drape_em_state;
wire		left_drape_em_state;
//FPGA DRAPE Electro magnet S.W approval
wire		right_drape_em_open;
wire		left_drape_em_open;
//FPGA DRAPE Sensors
wire		right_drape_close2_nc;
wire		right_drape_close2_no;
wire		right_drape_close1_nc;
wire		right_drape_close1_no;
wire		right_drape_open_nc;
wire		right_drape_open_no;
wire		left_drape_close2_nc;
wire		left_drape_close2_no;
wire		left_drape_close1_nc;
wire		left_drape_close1_no;
wire		left_drape_open_nc;
wire		left_drape_open_no;

wire		right_spare_diff_2;
wire		right_spare_diff_1;
wire		left_spare_diff_2;
wire		left_spare_diff_1;

wire[3:0]	wheel_rod_sensor;

reg			rst_n_syn;
reg[7:0]			rst_n_meta;
reg			estop_delay;
reg			left_robot_tx;
wire		left_robot_rx;
reg			right_robot_tx;
wire		right_robot_rx;
reg			teensy_led1;
reg			teensy_led2;
reg			teensy_led3;
wire		teensy_spare3;
wire		MICCB_SPARE_IO2;
wire		MICCB_SPARE_IO3;
//reset selector
always @(posedge clk_100m)
begin
	if (rst_n_meta!=8'hAD) 
	begin
		rst_n_meta<=rst_n_meta+ 1'b1;;
	end
	
	if (rst_n_meta==8'hAA) 
	begin
		rst_n_syn<=1'b0;
	end 
	else 
	begin
		rst_n_syn<=1'b1;
	end
	
	if(!rst_n) 
	begin
		rst_n_meta<=8'hAA;
	end
end


//ASSIGNS
assign	fpga_buttons[7] = right_plunger_nc;
assign	fpga_buttons[6] = right_plunger_no;
assign	fpga_buttons[5] = left_plunger_nc;
assign	fpga_buttons[4] = left_plunger_no;
assign	fpga_buttons[3] = right_tool_ex_nc;
assign	fpga_buttons[2] = right_tool_ex_no;
assign	fpga_buttons[1] = left_tool_ex_nc;
assign	fpga_buttons[0] = left_tool_ex_no;

assign	drape_sw_state[1] = right_drape_sw_state;
assign	drape_sw_state[0] = left_drape_sw_state;
assign	drape_em_state[1] = right_drape_em_state;
assign	drape_em_state[0] = left_drape_em_state;

assign	drape_sensor[11] = right_drape_close2_nc;
assign	drape_sensor[10] = right_drape_close2_no;
assign	drape_sensor[9] = right_drape_close1_nc;
assign	drape_sensor[8] = right_drape_close1_no;
assign	drape_sensor[7] = right_drape_open_nc;
assign	drape_sensor[6] = right_drape_open_no;
assign	drape_sensor[5] = left_drape_close2_nc;
assign	drape_sensor[4] = left_drape_close2_no;
assign	drape_sensor[3] = left_drape_close1_nc;
assign	drape_sensor[2] = left_drape_close1_no;
assign	drape_sensor[1] = left_drape_open_nc;
assign	drape_sensor[0] = left_drape_open_no;
	
assign	wheel_sensor[23:0] = {wheel_d_sens3_in2,wheel_d_sens3_in1,wheel_d_sens2_in2,
								wheel_d_sens2_in1,wheel_d_sens1_in2,wheel_d_sens1_in1,	
								wheel_c_sens3_in2,wheel_c_sens3_in1,wheel_c_sens2_in2,
								wheel_c_sens2_in1,wheel_c_sens1_in2,wheel_c_sens1_in1,
								wheel_b_sens3_in2,wheel_b_sens3_in1,wheel_b_sens2_in2,
								wheel_b_sens2_in1,wheel_b_sens1_in2,wheel_b_sens1_in1,	
								wheel_a_sens3_in2,wheel_a_sens3_in1,wheel_a_sens2_in2,	
								wheel_a_sens2_in1,wheel_a_sens1_in2,wheel_a_sens1_in1};

assign	right_tool_ex_led3 = fpga_buttons_led_reg[14];
assign 	right_tool_ex_led2 = fpga_buttons_led_reg[13];
assign 	right_tool_ex_led1 = fpga_buttons_led_reg[12];
assign 	left_tool_ex_led3 = fpga_buttons_led_reg[10];
assign 	left_tool_ex_led2 = fpga_buttons_led_reg[9];
assign 	left_tool_ex_led1 = fpga_buttons_led_reg[8];
assign 	right_plunger_led3 = fpga_buttons_led_reg[6];
assign 	right_plunger_led2 = fpga_buttons_led_reg[5];
assign 	right_plunger_led1 = fpga_buttons_led_reg[4];
assign 	left_plunger_led3 = fpga_buttons_led_reg[2];
assign 	left_plunger_led2 = fpga_buttons_led_reg[1];
assign 	left_plunger_led1 = fpga_buttons_led_reg[0];
assign	wheel_rod_sensor = {wheel_rod2_out1,wheel_rod2_out2,wheel_rod1_out1,wheel_rod1_out2};
assign	miccb_estop_open_req = teensy_estop_open_req;
assign	FPGA_WHEEL_STOP_ELO = teensy_open_elo_req;

assign	MICCB_SPARE_IO2 = 1'bz;
assign	MICCB_SPARE_IO3 = 1'bz;
assign	teensy_spare3 = 1'bz;
//why we need this? those are constents and nothing in the right side
always @*
begin
	estop_delay = 1'bz;
	left_robot_tx = 1'bz;
	right_robot_tx = 1'bz;
	teensy_led1 = 1'b0;
	teensy_led1 = 1'b1;
	teensy_led1 = 1'b0;
end


/*
always @(posedge clk_100m)
begin
	rst_n_syn <= rst_n_meta;
	rst_n_meta <= rst_n;		
end
*/

//RCB SPI insertion  
rcb_spi rcb_spi(
    .clk_100m(clk_100m),       	
    .rst_n_syn(rst_n_syn),      
	.sclk(sclk),
	.cs_n(cs_n),
	.mosi(mosi),
	.miso_t(miso),
    .data_miso(data_miso),    
    .data_mosi(data_mosi),     
    .data_mosi_rdy(data_mosi_rdy), 
	.addr(addr),
	.addr_rdy(addr_rdy),
	.data_miso_rdy(data_miso_rdy)
);

//RCB REGISRES insertion  
rcb_registers rcb_registers(
    .clk_100m(clk_100m),       	
    .rst_n_syn(rst_n_syn), 
	.clk_1m(clk_1m),
    .data_miso(data_miso),    
    .data_mosi(data_mosi),     
    .data_mosi_rdy(data_mosi_rdy), 
	.addr(addr),
	.addr_rdy(addr_rdy),
	.data_miso_rdy(data_miso_rdy),
	.pow(pow),
	.fpga_buttons(fpga_buttons),
	
	.drape_sw_state(drape_sw_state),
	.drape_em_state(drape_em_state),
	.right_drape_em_open(right_drape_em_open),
	.left_drape_em_open(left_drape_em_open),
	.drape_sensor(drape_sensor),

	.wheel_home_sw(wheel_home_sw),
	.wheel_reverse_sw(wheel_reverse_sw),
	.wheel_forward_sw(wheel_forward_sw),
	.wheel_driver_di(wheel_driver_di),
	//.wheel_driver_elo(wheel_driver_elo),
	.wheel_driver_do(wheel_driver_do),
	.wheel_driver_rst(wheel_driver_rst),
	.wheel_driver_abrt(wheel_driver_abrt),
	.wheel_sensor(wheel_sensor),
	.fpga_buttons_led_reg(fpga_buttons_led_reg),
	//.estop_activation(estop_activation),
	.diag_activation(diag_activation),
	.estop_open(estop_open),
	.estop_status(estop_status),
	.diagnostic_led(diagnostic_led),
	.sp2_single_ended_2_3(sp2_single_ended_2_3),
	.sp2_single_ended_1_0(sp2_single_ended_1_0),
	.sp2_analog_switch(sp2_analog_switch),
	.sp2_diff_pair_2_3(sp2_diff_pair_2_3),
	.sp2_diff_pair_1_0(sp2_diff_pair_1_0),
	.sp1_single_ended_2_3(sp1_single_ended_2_3),
	.sp1_single_ended_1_0(sp1_single_ended_1_0),
	.sp1_analog_switch(sp1_analog_switch),
	.sp1_diff_pair_2_3(sp1_diff_pair_2_3),
	.sp1_diff_pair_1_0(sp1_diff_pair_1_0),
	.right_spare_diff_2(right_spare_diff_2),
	.right_spare_diff_1(right_spare_diff_1),
	.left_spare_diff_2(left_spare_diff_2),
	.left_spare_diff_1(left_spare_diff_1),
	.wheel_rod_sensor(wheel_rod_sensor),
	.fan1_tacho(fan1_tacho),
	.fan1_pwm(fan1_pwm),
	.fan2_tacho(fan2_tacho),
	.fan2_pwm(fan2_pwm),
	.trig_in(trig_in)
);

endmodule	
			
