/////////////////////////////////////////////////////////
//	File			: rcb_registers.v
//	Author			: Igor Dorman. tracePCB.
//	Date			: 30/08/2022
//	Description		: RCB Registers.
//	Revision		: 1.0
//	Last Update		: 06/09/2022  
//	Hierarchy		: rcb_top <- rcb_registers
//	Last Update		: 07/09/2022 
//////////////////////////////////////////////////////////

module rcb_registers(
	//System signals
    clk_100m,       		// system clock
    rst_n,      	// low active synchronous reset
	clk_100k, 
	//Internal signls
    data_miso,		// data for transmission to SPI master
    data_mosi,		// received data from SPI master
    data_mosi_rdy,	// when 1, received data is valid
	addr,			// received data from SPI master
	addr_rdy,		// when 1, received address is valid
	//r_w,
	
	//FPGA Power Diagnostic
	pow,
	//FPGA DRAPE Switch and Sensors state
	switch_sensor_wire,
	//FPGA DRAPE Electro magnet S.W approval
	right_drape_em_open,
	left_drape_em_open,
	//FPGA Wheel Sensor status
	wheel_sensor_wire,
	//FPGA Buttons LED
	fpga_buttons_led_reg,
	//FPGA ESTOP Status
	estop_btn1,
	estop_btn2,
	//Activation(Close) SSR
	estop_activation,
	diag_activation,
	estop_open,
	diagnostic_led,
	single_ended_out,
	single_ended_in,
	analog_switch_set

);
	
`include  "rcb_parameters.v"	
	
input 			clk_100m; 
input 			rst_n; 
input			clk_100k; 
output[31:0]	data_miso;
input[31:0]		data_mosi;
input			data_mosi_rdy;
input[15:0]		addr;
input			addr_rdy;
input			pow;
input[19:0]		switch_sensor_wire;
output			right_drape_em_open;
output			left_drape_em_open;
input[7:0]		wheel_sensor_wire;
output[31:0]	fpga_buttons_led_reg;
input			estop_btn1;
input			estop_btn2;
output			estop_activation;		//Once set – only active for 0.1Sec.
output			diag_activation;
output			estop_open;
output[7:0]		diagnostic_led;
output[3:0]		single_ended_out;
input[3:0]		single_ended_in;
output[6:0]		analog_switch_set;

reg[31:0] 		fpga_ver_reg;
reg[31:0] 		fpga_rev_data_reg;
reg[31:0] 		fpga_pow_reg;
reg[31:0] 		fpga_switch_sensor_reg;
reg[31:0] 		fpga_switch_sensor_meta;
reg[31:0] 		fpga_electromagnet_reg;
reg[31:0] 		fpga_wheel_sensor_reg;
reg[31:0] 		fpga_wheel_sensor_meta;
reg[31:0] 		fpga_buttons_led_reg;
reg[31:0]		fpga_estop_status_reg;
reg[31:0]		fpga_estop_status_meta;
reg[31:0]		fpga_estop_activation_reg;
reg[31:0]		fpga_estop_diagnostic_reg;	//Set to 0xABCD for Closing Estop in Diagnostic mode
											//( along with bit 31 in ESTOP Activation register.
reg[31:0]		fpga_diagnostic_led_reg;
reg[27:0]		fpga_spare_io_reg_write;
reg[3:0]		fpga_spare_io_reg_read;										
//reg[12:0]		reg_en;
reg[31:0]		data_miso;
//wire			estop_activation;
wire[7:0]		diagnostic_led;
reg[3:0]		single_ended_out;
wire[3:0]		single_ended_in;
wire[6:0]		analog_switch_set;

reg				estop_activation;
reg[3:0]		estop_activation_cnt;
reg				estop_activation_rst;
wire			estop_activation_rst_posedge;
reg				estop_activation_reg;
wire			clk_100k_posedge;
reg				clk_100k_reg;

//assign estop_activation = fpga_estop_activation_reg[0];
assign diag_activation = fpga_estop_activation_reg[31] & (fpga_estop_diagnostic_reg[15:0] == ESTOP_DIAG_ACTIV);
assign estop_open = 0;	//?????????
assign diagnostic_led = fpga_diagnostic_led_reg[7:0];
assign single_ended_out = fpga_spare_io_reg_write[15:12];
assign analog_switch_set = fpga_spare_io_reg[6:0];

assign right_drape_em_open = fpga_electromagnet_reg[8];
assign left_drape_em_open = fpga_electromagnet_reg[0];

always @(posedge clk_100m, negedge rst_n)
	if(!rst_n)
	begin
		fpga_ver_reg <= {16'b0,FPGA_MAJOR_VER,FPGA_REV};
		fpga_rev_data_reg <= {FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR};
		fpga_pow_reg <= 32'b0;
		fpga_switch_sensor_reg <= 32'b0;
		fpga_switch_sensor_meta <= 32'b0;
		fpga_wheel_sensor_reg <= 32'b0;
		fpga_wheel_sensor_meta <= 32'b0;
		fpga_estop_status_reg <= 32'b0;
		fpga_estop_status_meta <= 32'b0;
		fpga_spare_io_reg_read <= 4'b0;
	end
	else
	begin
		fpga_ver_reg <= {16'b0,FPGA_MAJOR_VER,FPGA_REV};
		fpga_rev_data_reg <= {FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR};
		fpga_pow_reg[0] <= {31'b0,pow};
		fpga_switch_sensor_reg <= fpga_switch_sensor_meta;
		fpga_switch_sensor_meta <= {4'b0,switch_sensor_wire[19:16],4'b0,switch_sensor_wire[15:12],
									2'b0,switch_sensor_wire[11:6],2'b0,switch_sensor_wire[5:0]};
		fpga_wheel_sensor_reg <= fpga_wheel_sensor_meta;
		fpga_wheel_sensor_meta <= {24'b0, wheel_sensor_wire};
		fpga_estop_status_reg <= fpga_estop_status_meta;
		fpga_estop_status_meta <= {30'hb0,estop_btn2,estop_btn1};
		fpga_spare_io_reg_read <= single_ended_in;	
	end
	
//Read Register MUX
always @*
    case(addr)
		FPGA_VER:
			data_miso = fpga_ver_reg;
		FPGA_REV_DATA:
			data_miso = fpga_rev_data_reg;
		FPGA_POW_DIAG:
			data_miso = fpga_pow_reg;
		FPGA_DRAPE_SWITCH_SENSOR:
			data_miso = fpga_switch_sensor_reg;
		FPGA_DRAPE_ELECTROMAGNET:
			data_miso = fpga_electromagnet_reg;
		FPGA_WHEEL_SENSOR:
			data_miso = fpga_wheel_sensor_reg;
		FPGA_BUTTONS_LED:
			data_miso = fpga_buttons_led_reg;
		FPGA_ESTOP_STATUS:
			data_miso = fpga_estop_status_reg;
		FPGA_ESTOP_ACTIVATION:
			data_miso = fpga_estop_activation_reg;
		FPGA_ESTOP_DIAGNOSTIC:
			data_miso = fpga_estop_diagnostic_reg;
		FPGA_DIAGNOSTIC_LEDS:
			data_miso = fpga_diagnostic_led_reg;
		FPGA_SPARE_IO:
			data_miso = {fpga_spare_io_reg_write[31:12],fpga_spare_io_reg_read[3:0],fpga_spare_io_reg_write[7:0]};
		default:
			data_miso = 32'hFFFFFFFF;
	endcase
	
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
	begin
		fpga_electromagnet_reg <= 32'b0;
		fpga_buttons_led_reg <= 32'b0;
		fpga_diagnostic_led_reg <= 32'b0;
		fpga_estop_activation_reg <= 32'b0;
		fpga_estop_diagnostic_reg <= 32'b0;
		fpga_spare_io_reg_write <= 28'b0;
	end
    else if(data_mosi_rdy)
	begin
		case(addr)
			FPGA_BUTTONS_LED:
				fpga_buttons_led_reg <= data_mosi;
			FPGA_DRAPE_ELECTROMAGNET:
				fpga_electromagnet_reg <= data_mosi;
			FPGA_ESTOP_ACTIVATION:
				fpga_estop_activation_reg <= data_mosi;
			FPGA_ESTOP_DIAGNOSTIC:
				fpga_estop_diagnostic_reg <= data_mosi;	
			FPGA_DIAGNOSTIC_LEDS:
				fpga_diagnostic_led_reg <= data_mosi;	
			FPGA_SPARE_IO:
				fpga_spare_io_reg_write[27:0] <= {data_mosi[31:12],data_mosi[7:0]};
			default:
				;
		endcase
	end
	else if(estop_activation_rst_posedge)
		fpga_estop_activation_reg[0] <= {fpga_estop_activation_reg[31:1],1'b0};
	

//ESTOP Activation 0.1ms pulse
reg[2:0] state_active,next_state_active;
parameter
	IDLE_ACTIVE		= 0,
    ACTIVE_PULSE	= 1;
	
always @(posedge clk_100k, negedge rst_n)
	if (!rst_n)
		state_active <= IDLE_ACTIVE;
	else
	begin
		state_active <= next_state_active;
	end

always @*
	case(state_active)
		IDLE_ACTIVE:
		begin
			if(!fpga_estop_activation_reg[0])
				next_state_active = IDLE_ACTIVE;
			else
				next_state_active = ACTIVE_PULSE;
		end
		ACTIVE_PULSE:
		begin
			if(estop_activation_cnt < ESTOP_ACTIVATION_PULSE)//if(estop_activation_rst)
				next_state_active = ACTIVE_PULSE;
			else
				next_state_active = IDLE_ACTIVE;
		end
	endcase

	
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
	begin
		estop_activation <= 1'b1;
		estop_activation_cnt <= 4'b0;
		estop_activation_rst <= 1'b0;
	end
	else if(clk_100k_posedge)
	begin
		case(state_active)
			IDLE_ACTIVE:
			begin
				estop_activation <= 1'b1;
				estop_activation_cnt <= 4'b0;
				estop_activation_rst <= 1'b0;
			end
			ACTIVE_PULSE:
			begin
				//if(fpga_estop_activation_reg[0] == 1'b1)
				begin	
					if(estop_activation_cnt < ESTOP_ACTIVATION_PULSE)
					begin
						estop_activation <= 1'b0;
						estop_activation_cnt <= estop_activation_cnt + 1'b1;
						estop_activation_rst <= 1'b1;
					end
					else
					begin
						estop_activation <= 1'b1;
						estop_activation_cnt <= 4'b0;
						estop_activation_rst <= 1'b0;
					end
				end
			end
		endcase
	end
	
// Posedge from estop_activation_rst to set to zero the ESTOP Activation bit in the ESTOP activation register.
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
		estop_activation_reg <= 1'b1;
    else
        estop_activation_reg <= ~estop_activation_rst;

assign estop_activation_rst_posedge = estop_activation_rst & estop_activation_reg;

// Posedge from estop_activation_rst to set to zero the ESTOP Activation bit in the ESTOP activation register.
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
		clk_100k_reg <= 1'b1;
    else
        clk_100k_reg <= ~clk_100k;

assign clk_100k_posedge = clk_100k_reg & clk_100k;

			

endmodule	
			
