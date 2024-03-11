
module rcb_registers(
	//System signals
    clk_100m,       		// system clock
    rst_n_syn,      	// low active synchronous reset
	clk_1m, 
	//Internal signls
    data_miso,		// data for transmission to SPI master
    data_mosi,		// received data from SPI master
    data_mosi_rdy,	// when 1, received data is valid
	addr,			// received data from SPI master
	addr_rdy,		// when 1, received address is valid
	data_miso_rdy,
	//FPGA Power Diagnostic
	pow,
	//FPGA BUTTONS
	fpga_buttons,
	//FPGA DRAPE Switch and Sensors state
	drape_sw_state,
	drape_em_state,
	drape_sensor,
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
	wheel_sensor,
	//FPGA Buttons LED
	fpga_buttons_led_reg,

	//Activation(Close) SSR
	//estop_activation,
	diag_activation,
	estop_open,
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
	//Wheel Rod Sensor
	wheel_rod_sensor,
	//FANs
	fan1_tacho,
	fan1_pwm,
	fan2_tacho,
	fan2_pwm

);
	
`include  "rcb_parameters.v"	
	
input 		clk_100m; 
input 		rst_n_syn; 
input		clk_1m; 
output[31:0]data_miso;
input[31:0]	data_mosi;
input		data_mosi_rdy;
input[15:0]	addr;
input		addr_rdy;
input		data_miso_rdy;
input		pow;
input[7:0]	fpga_buttons;
input[1:0]	drape_sw_state;
input[1:0]	drape_em_state;
input[11:0]	drape_sensor;
output		right_drape_em_open;
output		left_drape_em_open;
output[3:0]	wheel_home_sw;
output[3:0]	wheel_reverse_sw;
output[3:0]	wheel_forward_sw;
output[7:0]	wheel_driver_di;
input[3:0]	wheel_driver_do;
output		wheel_driver_rst;
output		wheel_driver_abrt;
input[23:0]	wheel_sensor;
output[31:0]fpga_buttons_led_reg;
output		diag_activation;
output		estop_open;
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
output		right_spare_diff_2;
input		right_spare_diff_1;
output		left_spare_diff_2;
input		left_spare_diff_1;
input[3:0]	wheel_rod_sensor;

input		fan1_tacho;
output		fan1_pwm;
input		fan2_tacho;
output		fan2_pwm;

reg[31:0] 	fpga_ver_reg;
reg[31:0] 	fpga_rev_data_reg;
reg[31:0] 	fpga_pow_reg;
reg			pow_meta;
reg			pow_sticky;
reg[31:0] 	fpga_buttons_reg;
reg[31:0] 	fpga_buttons_meta;
reg[31:0] 	fpga_drape_sw_state_reg;
reg[31:0] 	fpga_drape_sw_state_meta;
reg[31:0] 	fpga_drape_em_state_reg;
reg[31:0] 	fpga_drape_em_state_meta;
reg[31:0] 	fpga_drape_sensor_reg;
reg[31:0] 	fpga_drape_sensor_meta;
reg[31:0] 	fpga_electromagnet_reg;

wire[3:0]	wheel_home_sw;
wire[3:0]	wheel_reverse_sw;
wire[3:0]	wheel_forward_sw;
wire		wheel_driver_rst;
wire		wheel_driver_abrt;
reg[31:0]	fpga_wheel_driver_abrt_reg;
reg[31:0]	fpga_wheel_driver_out;
reg[31:0]	fpga_wheel_driver_do_reg;
reg[31:0]	fpga_wheel_driver_do_meta;
reg[31:0] 	fpga_wheel_sensor_reg;
reg[31:0] 	fpga_wheel_sensor_meta;
reg[31:0] 	fpga_buttons_led_reg;
reg[31:0]	fpga_estop_activation_reg;
reg[31:0]	fpga_estop_diagnostic_reg;	//Set to 0xABCD for Closing Estop in Diagnostic mode
											//( along with bit 31 in ESTOP Activation register.
reg[31:0]	fpga_estop_open_reg;
reg[31:0]	fpga_diagnostic_led_reg;
reg[31:0]	fpga_spare_4mb_reg;
reg[31:0]	fpga_wheel_rod_reg;
reg[31:0]	data_miso;
wire[7:0]	diagnostic_led;

//reg			estop_activation;
reg[32:0]	estop_activation_cnt;
reg			estop_activation_rst;
wire		estop_activation_rst_posedge;
reg			estop_activation_reg;
reg			start_activation;
wire		clk_1m_posedge;
reg			clk_1m_reg;


wire[31:0]	fpga_spare_io_reg;
reg[1:0]	sp2_single_ended_2_3;
wire[1:0]	sp2_single_ended_1_0;
reg[2:0]	sp2_analog_switch;
reg[1:0]	sp2_diff_pair_2_3;
wire[1:0]	sp2_diff_pair_1_0;
reg[1:0]	sp1_single_ended_2_3;
wire[1:0]	sp1_single_ended_1_0;		
reg[2:0]	sp1_analog_switch;
reg[1:0]	sp1_diff_pair_2_3;
wire[1:0]	sp1_diff_pair_1_0;
reg[7:0]	spare_in_reg;
reg[7:0]	spare_in_meta;
reg			right_spare_diff_2;
reg			left_spare_diff_2;
reg[1:0]	in_4mb_spare_reg;
reg[1:0]	in_4mb_spare_meta;
wire[31:0]	fpga_4mb_spare_reg;
reg[31:0]	fpga_wheel_rod_sensor_reg;
reg[31:0]	fpga_wheel_rod_sensor_meta;
reg[31:0]	fpga_fan1_pwm;
reg[31:0]	fpga_fan2_pwm;
reg			fan1_pwm;
reg			fan2_pwm;
reg[9:0]	pwm1_cnt;
reg[9:0]	pwm1_value;
reg[9:0]	pwm2_cnt;
reg[9:0]	pwm2_value;
reg[15:0]	fpga_fan1_tacho;
reg[7:0]	fpga_fan1_tacho_num;
reg			fan1_tacho_meta;
reg			fan1_tacho_sync;
reg			fan1_tacho_inv;
reg[15:0]	fan1_tacho_cnt;
reg[15:0]	fpga_fan2_tacho;
reg[7:0]	fpga_fan2_tacho_num;
reg			fan2_tacho_meta;
reg			fan2_tacho_sync;
reg			fan2_tacho_inv;
reg[15:0]	fan2_tacho_cnt;
reg[25:0]	fan_tacho_cnt;
reg			fan_tacho_mes_pulse;
wire		fan1_tacho_posedge;
wire		fan2_tacho_posedge;


assign diag_activation = fpga_estop_activation_reg[31] & (fpga_estop_diagnostic_reg[15:0] == ESTOP_DIAG_ACTIV);
assign estop_open = fpga_estop_open_reg[0];	
assign diagnostic_led = fpga_diagnostic_led_reg[7:0];

assign wheel_home_sw = fpga_wheel_driver_out[19:16];
assign wheel_reverse_sw = fpga_wheel_driver_out[15:12];
assign wheel_forward_sw = fpga_wheel_driver_out[11:8];
assign wheel_driver_di = fpga_wheel_driver_out[7:0];

assign wheel_driver_rst = fpga_wheel_driver_abrt_reg[1];
assign wheel_driver_abrt = fpga_wheel_driver_abrt_reg[0];

assign right_drape_em_open = fpga_electromagnet_reg[8];
assign left_drape_em_open = fpga_electromagnet_reg[0];							
assign fpga_spare_io_reg = {10'b0,sp2_single_ended_2_3,spare_in_reg[7:6],sp2_analog_switch,sp2_diff_pair_2_3,
							spare_in_reg[5:4],sp1_single_ended_2_3,spare_in_reg[3:2],sp1_analog_switch,
							sp1_diff_pair_2_3,spare_in_reg[1:0]};							
assign fpga_4mb_spare_reg = {28'b0,right_spare_diff_2,in_4mb_spare_reg[1],left_spare_diff_2,in_4mb_spare_reg[0]};							

always @(posedge clk_100m, negedge rst_n_syn)
	if(!rst_n_syn)
	begin
		fpga_ver_reg <= {16'b0,FPGA_MAJOR_VER,FPGA_REV};
		fpga_rev_data_reg <= {FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR};
		fpga_pow_reg <= 32'b0;
		fpga_buttons_reg <= 32'b0;
		fpga_buttons_meta <= 32'b0;
		fpga_wheel_driver_do_reg <= 32'b0;
		fpga_wheel_driver_do_meta <= 32'b0;
		fpga_drape_sw_state_reg <= 32'b0;
		fpga_drape_sw_state_meta <= 32'b0;
		fpga_drape_em_state_reg <= 32'b0;
		fpga_drape_em_state_meta <= 32'b0;		
		fpga_drape_sensor_reg <= 32'b0;
		fpga_drape_sensor_meta <= 32'b0;
		fpga_wheel_sensor_reg <= 32'b0;
		fpga_wheel_sensor_meta <= 32'b0;
		spare_in_reg <= 7'b0;
		spare_in_meta <= 7'b0;
		in_4mb_spare_reg <= 2'b0;
		in_4mb_spare_meta <= 2'b0;
		fpga_wheel_rod_sensor_reg <= 32'b0;
		fpga_wheel_rod_sensor_meta <= 32'b0;
		pow_sticky <= 1'b0;
		pow_meta <= 1'b0;
	end
	else
	begin
		fpga_ver_reg <= {16'b0,FPGA_MAJOR_VER,FPGA_REV};
		fpga_rev_data_reg <= {FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR};
		fpga_pow_reg <= {30'b0,pow_sticky,pow_meta};
		pow_meta <= pow;
		fpga_buttons_reg <= fpga_buttons_meta;
		fpga_buttons_meta <= {24'b0,fpga_buttons[7:0]};
		fpga_drape_sw_state_reg <= fpga_drape_sw_state_meta;
		fpga_drape_sw_state_meta <= {30'b0,drape_sw_state[1:0]};
		fpga_drape_em_state_reg <= fpga_drape_em_state_meta;
		fpga_drape_em_state_meta <= {30'b0,drape_em_state[1:0]};
		fpga_wheel_driver_do_reg <= fpga_wheel_driver_do_meta;
		fpga_wheel_driver_do_meta <= {28'b0,wheel_driver_do};
		fpga_drape_sensor_reg <= fpga_drape_sensor_meta;
		fpga_drape_sensor_meta <= {18'b0,drape_sensor[11:6],2'b00,drape_sensor[5:0]};
		fpga_wheel_sensor_reg <= fpga_wheel_sensor_meta;
		fpga_wheel_sensor_meta <= {8'b0, wheel_sensor};

		spare_in_reg <= spare_in_meta;
		spare_in_meta <= {sp2_single_ended_1_0,sp2_diff_pair_1_0,sp1_single_ended_1_0,sp1_diff_pair_1_0};	
		in_4mb_spare_reg <= in_4mb_spare_meta;
		in_4mb_spare_meta <= {right_spare_diff_1,left_spare_diff_1};
		fpga_wheel_rod_sensor_reg <= fpga_wheel_rod_sensor_meta;
		fpga_wheel_rod_sensor_meta <= {28'b0,wheel_rod_sensor};
	end

		
//Read Register MUX
always @*
    case(addr)
		ADDR_FPGA_VER:
			data_miso = fpga_ver_reg;
		ADDR_FPGA_REV_DATA:
			data_miso = fpga_rev_data_reg;
		ADDR_FPGA_POW_DIAG:
			data_miso = fpga_pow_reg;
		ADDR_FPGA_BUTTONS:
			data_miso = fpga_buttons_reg;
		ADDR_FPGA_DRAPE_SENSOR:
			data_miso = fpga_drape_sensor_reg;
		ADDR_FPGA_DRAPE_SW_STATE:
			data_miso = fpga_drape_sw_state_reg;
		ADDR_FPGA_DRAPE_EM_STATE:
			data_miso = fpga_drape_em_state_reg;			
		ADDR_FPGA_DRAPE_SW_APPROVAL:
			data_miso = fpga_electromagnet_reg;
		ADDR_FPGA_WHEEL_DRIVER_OUT:
			data_miso = fpga_wheel_driver_out;
		ADDR_FPGA_WHEEL_DRIVER_IN:
			data_miso = fpga_wheel_driver_do_reg;
		ADDR_FPGA_WHEEL_DRIVER_ABRT:
			data_miso = fpga_wheel_driver_abrt_reg;	
		ADDR_FPGA_WHEEL_SENSOR:
			data_miso = fpga_wheel_sensor_reg;
		ADDR_FPGA_BUTTONS_LED:
			data_miso = fpga_buttons_led_reg;
		ADDR_FPGA_ESTOP_ACTIVATION:
			data_miso = fpga_estop_activation_reg;
		ADDR_FPGA_ESTOP_DIAGNOSTIC:
			data_miso = fpga_estop_diagnostic_reg;
		ADDR_FPGA_ESTOP_OPEN:
			data_miso = fpga_estop_open_reg;
		ADDR_FPGA_DIAGNOSTIC_LEDS:
			data_miso = fpga_diagnostic_led_reg;
		ADDR_FPGA_SPARE_IO:
			data_miso = fpga_spare_io_reg;
		ADDR_FPGA_SPARE_4MB:
			data_miso = fpga_4mb_spare_reg;	
		ADDR_FPGA_WHEEL_ROD:
			data_miso = fpga_wheel_rod_sensor_reg;	
		ADDR_FPGA_FAN1_TACHO:
			data_miso = {8'h00,fpga_fan1_tacho_num,fpga_fan1_tacho};
		ADDR_FPGA_FAN1_PWM:
			data_miso = fpga_fan1_pwm;
		ADDR_FPGA_FAN2_TACHO:
			data_miso = {8'h00,fpga_fan2_tacho_num,fpga_fan2_tacho};
		ADDR_FPGA_FAN2_PWM:
			data_miso = fpga_fan2_pwm;			
		default:
			data_miso = 32'hFFFFFFFF;
	endcase
	
always @(posedge clk_100m, negedge rst_n_syn)
    if(!rst_n_syn)
	begin
		fpga_electromagnet_reg <= 32'b0;
		fpga_buttons_led_reg <= 32'b0;
		fpga_diagnostic_led_reg <= 32'h000000FF;
		fpga_estop_activation_reg <= 32'b0;
		fpga_estop_diagnostic_reg <= 32'b0;
		fpga_estop_open_reg <= 32'b0;
		fpga_wheel_driver_out <= 32'b0;
		fpga_wheel_driver_abrt_reg <= 32'b0;
		sp2_single_ended_2_3 <= 2'b0;
		sp2_analog_switch <= 3'b0;
		sp2_diff_pair_2_3 <= 2'b0;
		sp1_single_ended_2_3 <= 2'b0;
		sp1_analog_switch <= 3'b0;
		sp1_diff_pair_2_3 <= 2'b0;
		right_spare_diff_2 <= 0;
		left_spare_diff_2 <= 0;
		start_activation <= 0;
		fpga_fan1_pwm <= 32'b0;
		fpga_fan2_pwm <= 32'b0;
	end
    else if(data_mosi_rdy)
	begin
		case(addr)
			ADDR_FPGA_BUTTONS_LED:
				fpga_buttons_led_reg <= {17'b0,data_mosi[14:12],1'b0,data_mosi[10:8],
										1'b0,data_mosi[6:4],1'b0,data_mosi[2:0]};
			ADDR_FPGA_WHEEL_DRIVER_OUT:
				fpga_wheel_driver_out <= {12'b0,data_mosi[19:0]};
			ADDR_FPGA_WHEEL_DRIVER_ABRT:
				fpga_wheel_driver_abrt_reg <= {30'b0,data_mosi[1:0]};	
			ADDR_FPGA_DRAPE_SW_APPROVAL:
				fpga_electromagnet_reg <= {23'b0,data_mosi[8],7'b0,data_mosi[0]};
			ADDR_FPGA_ESTOP_ACTIVATION:
			begin
				fpga_estop_activation_reg <= {data_mosi[31],31'b0};//,data_mosi[0]};
				start_activation <= data_mosi[0];
			end
			ADDR_FPGA_ESTOP_DIAGNOSTIC:
				fpga_estop_diagnostic_reg <= {16'b0,data_mosi[15:0]};
			ADDR_FPGA_ESTOP_OPEN:
				fpga_estop_open_reg <= {31'b0,data_mosi[0]};	
			ADDR_FPGA_DIAGNOSTIC_LEDS:
				fpga_diagnostic_led_reg <= {24'b0,data_mosi[7:0]};	
			ADDR_FPGA_SPARE_IO:
			begin
				sp2_single_ended_2_3 <= data_mosi[21:20];
				sp2_analog_switch <= data_mosi[17:15];
				sp2_diff_pair_2_3 <= data_mosi[14:13];
				sp1_single_ended_2_3 <= data_mosi[10:9];
				sp1_analog_switch <= data_mosi[6:4];
				sp1_diff_pair_2_3 <= data_mosi[3:2];
			end
			ADDR_FPGA_SPARE_4MB:
			begin
				right_spare_diff_2 <= data_mosi[3];
				left_spare_diff_2 <= data_mosi[1];
			end
			ADDR_FPGA_FAN1_PWM:
				fpga_fan1_pwm <= data_mosi[7:0];
			ADDR_FPGA_FAN2_PWM:
				fpga_fan2_pwm <= data_mosi[7:0];
			default:
				;
		endcase
	end
	else if(estop_activation_rst_posedge)
		start_activation <= 1'b0;
	
always @(posedge clk_100m, negedge rst_n_syn)
    if(!rst_n_syn)
		estop_activation_reg <= 1'b1;
    else
        estop_activation_reg <= ~estop_activation_rst;

assign estop_activation_rst_posedge = estop_activation_rst & estop_activation_reg;

// Posedge from clk_1m.
always @(posedge clk_100m, negedge rst_n_syn)
    if(!rst_n_syn)
		clk_1m_reg <= 1'b1;
    else
        clk_1m_reg <= ~clk_1m;

assign clk_1m_posedge = clk_1m_reg & clk_1m;




endmodule	

