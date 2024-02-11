////////////////////////////////////////////////////
//	File			: rcb_top.v
//	Author			: Igor Dorman. tracePCB.
//	Date			: 31/08/2022
//	Description		: RCB Top File.
//	Revision		: 1.0
//	Hierarchy		: rcb_top 
//	Last Update		: 07/09/2022 
////////////////////////////////////////////////////

module rcb_top(
	//System signals
    clk_100m,       		// system clock
    rst_n,      	// low active synchronous reset
	clk_100k,
	//SPI INTERFACE
	sclk,      	// SPI clock
	cs_n,     	// SPI chip select, active in low
	mosi,     	// SPI serial data from master to slave
	miso,     	// SPI serial data from slave to master
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
	right_drape_em,
	right_drape_sw,
	right_open_nc,
	right_open_no,
	right_close_nc,
	right_close_no,
	left_drape_em,
	left_drape_sw,
	left_open_nc,
	left_open_no,
	left_close_nc,
	left_close_no,
	//FPGA DRAPE Electro magnet S.W approval
	right_drape_em_open,
	left_drape_em_open,
	//FPGA Wheel Sensor status
	wheel_4_nc,
	wheel_4_no,
	wheel_3_nc,
	wheel_3_no,
	wheel_2_nc,
	wheel_2_no,
	wheel_1_nc,
	wheel_1_no,
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
	estop_btn2,
	estop_btn1,
	//Activation(Close) SSR
	estop_activation,
	diag_activation,
	estop_open,
	diagnostic_led,
	single_ended_out,
	single_ended_in,
	diff_pair_out,
	diff_pair_in,
	analog_switch_set,
	//SYNC
	sync
);
	
input 		clk_100m; 
input 		rst_n;
input		clk_100k;
//SPI Interface
input 		sclk; 
input 		cs_n;
input 		mosi; 
output 		miso;  
//FPGA Power Diagnostic
input		pow;
//FPGA DRAPE Switch and Sensors state
input		right_plunger_nc;
input		right_plunger_no;
input		left_plunger_nc;
input		left_plunger_no;
input		right_tool_ex_nc;
input		right_tool_ex_no;
input		left_tool_ex_nc;
input		left_tool_ex_no;
input		right_drape_em;
input		right_drape_sw;
input		right_open_nc;
input		right_open_no;
input		right_close_nc;
input		right_close_no;
input		left_drape_em;
input		left_drape_sw;
input		left_open_nc;
input		left_open_no;
input		left_close_nc;
input		left_close_no;
//FPGA DRAPE Electro magnet S.W approval
output		right_drape_em_open;
output		left_drape_em_open;
//FPGA Wheel Sensor status
input		wheel_4_nc;
input		wheel_4_no;
input		wheel_3_nc;
input		wheel_3_no;
input		wheel_2_nc;
input		wheel_2_no;
input		wheel_1_nc;
input		wheel_1_no;
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
//FPGA ESTOP Status
input		estop_btn2;
input		estop_btn1;
//Activation(Close) SSR
output		estop_activation;
output		diag_activation;
output		estop_open;
output[7:0]	diagnostic_led;
output[3:0]	single_ended_out;
input[3:0]	single_ended_in;
output[5:0]	diff_pair_out;
input[5:0]	diff_pair_in;

output[6:0]	analog_switch_set;
input		sync;

//WIRES
wire 		clk_100m; 
wire 		rst_n;
wire 		clk_100k;  
wire 		sclk; 
wire 		cs_n;
wire 		mosi; 
wire		miso; 
wire[31:0]	data_miso;
wire[31:0]	data_mosi;
wire		data_mosi_rdy;
wire[15:0]	addr;
wire		addr_rdy;
wire		pow;
wire[19:0]	switch_sensor_wire;
wire[7:0]	wheel_sensor_wire;
wire[31:0]	fpga_buttons_led_reg;
wire 		sync;
wire		estop_btn1;
wire		estop_btn2;
wire[7:0]	diagnostic_led;
wire[3:0]	single_ended_in;
wire[3:0]	single_ended_out;
wire[6:0]	analog_switch_set;
wire		estop_activation;
wire		diag_activation;
wire		estop_open;


//ASSIGNS
assign	switch_sensor_wire[19] = right_plunger_nc;
assign	switch_sensor_wire[18] = right_plunger_no;
assign	switch_sensor_wire[17] = left_plunger_nc;
assign	switch_sensor_wire[16] = left_plunger_no;
assign	switch_sensor_wire[15] = right_tool_ex_nc;
assign	switch_sensor_wire[14] = right_tool_ex_no;
assign	switch_sensor_wire[13] = left_tool_ex_nc;
assign	switch_sensor_wire[12] = left_tool_ex_no;
assign	switch_sensor_wire[11] = right_drape_em;
assign	switch_sensor_wire[10] = right_drape_sw;
assign	switch_sensor_wire[9] = right_open_nc;
assign	switch_sensor_wire[8] = right_open_no;
assign	switch_sensor_wire[7] = right_close_nc;
assign	switch_sensor_wire[6] = right_close_no;
assign	switch_sensor_wire[5] = left_drape_em;
assign	switch_sensor_wire[4] = left_drape_sw;
assign	switch_sensor_wire[3] = left_open_nc;
assign	switch_sensor_wire[2] = left_open_no;
assign	switch_sensor_wire[1] = left_close_nc;
assign	switch_sensor_wire[0] = left_close_no;
						
assign	wheel_sensor_wire[7:0] = {wheel_4_nc,wheel_4_no,wheel_3_nc,wheel_3_no,
								wheel_2_nc,wheel_2_no,wheel_1_nc,wheel_1_no};

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


//RCB SPI insertion  
rcb_spi rcb_spi(
    .clk_100m(clk_100m),       	
    .rst_n(rst_n),      
	.sclk(sclk),
	.cs_n(cs_n),
	.mosi(mosi),
	.miso(miso),
    .data_miso(data_miso),    
    .data_mosi(data_mosi),     
    .data_mosi_rdy(data_mosi_rdy), 
	.addr(addr),
	.addr_rdy(addr_rdy)
);

//RCB REGISRES insertion  
rcb_registers rcb_registers(
    .clk_100m(clk_100m),       	
    .rst_n(rst_n), 
	.clk_100k(clk_100k),
    .data_miso(data_miso),    
    .data_mosi(data_mosi),     
    .data_mosi_rdy(data_mosi_rdy), 
	.addr(addr),
	.addr_rdy(addr_rdy),
	.pow(pow),
	.switch_sensor_wire(switch_sensor_wire),
	.right_drape_em_open(right_drape_em_open),
	.left_drape_em_open(left_drape_em_open),
	.wheel_sensor_wire(wheel_sensor_wire),
	.fpga_buttons_led_reg(fpga_buttons_led_reg),
	.estop_btn1(estop_btn1),
	.estop_btn2(estop_btn2),
	.estop_activation(estop_activation),
	.diag_activation(diag_activation),
	.estop_open(estop_open),
	.diagnostic_led(diagnostic_led),
	.single_ended_out(single_ended_out),
	.single_ended_in(single_ended_in),
	.analog_switch_set(analog_switch_set)
);

endmodule	
			
