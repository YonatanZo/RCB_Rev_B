/////////////////////////////////////////////////////////
//  File        : core_parameters.v                        
//  Author      : Igor Dorman. tracePCB                            
//  Date        : 30/08/2022                               
//  Description : Global Parameters of the RCB.           
//  Revision    : 1.0  
//	Last Update	: 07/03/2023                                    
/////////////////////////////////////////////////////////

//`define ESTOP_CIRCUIT;

//REVISION
parameter FPGA_MAJOR_VER	= 8'h03;
parameter FPGA_REV		 	= 8'h01;
parameter FPGA_REV_YEAR		= 8'h17;
parameter FPGA_REV_MONTH	= 8'h03;
parameter FPGA_REV_DAY		= 8'h07;			
parameter FPGA_REV_HOUR		= 8'h08;

// SPI packet Lenght
parameter SPI_COM_LEN = 8;
parameter SPI_ADDR_LEN = SPI_COM_LEN + 16;
parameter SPI_DATA_LEN = SPI_ADDR_LEN + 32;

//SPI COMMANDS
parameter WRITE_COM		= 8'h0A;	// Write Command(0A).
parameter READ_COM		= 8'h0F;	// Read Command(0F).
parameter WRITE_MODE	= 2'b00;	// Write Command(0A).
parameter READ_MODE		= 2'b01;	// Read Command(0F).
parameter UNDEF_MODE	= 2'b11;	// Undefined command. Write Cycle without saving result.

// Addreses of FPGA rgisters
parameter ADDR_FPGA_VER 				= 16'h0000;
parameter ADDR_FPGA_REV_DATA			= 16'h0001;
parameter ADDR_FPGA_POW_DIAG 			= 16'h0002;
parameter ADDR_FPGA_BUTTONS				= 16'h0003;
parameter ADDR_FPGA_DRAPE_SW_STATE		= 16'h0004;
parameter ADDR_FPGA_DRAPE_EM_STATE		= 16'h0005;
parameter ADDR_FPGA_DRAPE_SW_APPROVAL	= 16'h0006;
parameter ADDR_FPGA_DRAPE_SENSOR		= 16'h0007;
parameter ADDR_FPGA_WHEEL_DRIVER_OUT	= 16'h0008;
parameter ADDR_FPGA_WHEEL_DRIVER_ELO	= 16'h0009;
parameter ADDR_FPGA_WHEEL_DRIVER_IN		= 16'h000A;
parameter ADDR_FPGA_WHEEL_DRIVER_ABRT	= 16'h000B;
parameter ADDR_FPGA_WHEEL_SENSOR 		= 16'h000C;
parameter ADDR_FPGA_BUTTONS_LED			= 16'h000D;
parameter ADDR_FPGA_ESTOP_STATUS 		= 16'h000E;
parameter ADDR_FPGA_ESTOP_ACTIVATION 	= 16'h000F;
parameter ADDR_FPGA_ESTOP_DIAGNOSTIC 	= 16'h0010;
parameter ADDR_FPGA_ESTOP_OPEN		 	= 16'h0011;
parameter ADDR_FPGA_DIAGNOSTIC_LEDS	 	= 16'h0012;
parameter ADDR_FPGA_SPARE_IO	 		= 16'h0013;
parameter ADDR_FPGA_SPARE_4MB	 		= 16'h0014;
parameter ADDR_FPGA_WHEEL_ROD	 		= 16'h0015;
parameter ADDR_FPGA_FAN1_TACHO	 		= 16'h0016;
parameter ADDR_FPGA_FAN1_PWM	 		= 16'h0017;
parameter ADDR_FPGA_FAN2_TACHO	 		= 16'h0018;
parameter ADDR_FPGA_FAN2_PWM	 		= 16'h0019;


parameter NUM_REG	= 26;	//Number of RCB Registers see above

//ESTOP
parameter ESTOP_DIAG_ACTIV			= 32'h0000ABCD;	//Set to 0xABCD for Closing Estop in Diagnostic mode ( along with bit 31 in ESTOP Activation register
parameter ESTOP_ACTIVATION_PULSE	= 100000;//4'hA;	//ESTOP activation pulse

parameter FAN_TACHO_MES_PERIOD		= 26'h30D40;//200ms

parameter DEB_DEEP = 3;		//deep of SPI debouncer



	




