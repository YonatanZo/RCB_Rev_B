/////////////////////////////////////////////////////////
//  File        : core_parameters.v                        
//  Author      : Igor Dorman. tracePCB                            
//  Date        : 30/08/2022                               
//  Description : Global Parameters of the RCB.           
//  Revision    : 1.0  
//	Last Update	: 06/09/2022                                    
/////////////////////////////////////////////////////////

//REVISION
parameter FPGA_MAJOR_VER	= 8'h01;
parameter FPGA_REV_DATA 	= 8'h01;
parameter FPGA_REV_YEAR		= 8'h55;//16;
parameter FPGA_REV_MONTH	= 8'h55;//08;
parameter FPGA_REV_DAY		= 8'h55;//1E;			
parameter FPGA_REV_HOUR		= 8'h55;//14;

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
parameter FPGA_VER 					= 16'h0000;
parameter FPGA_REV 					= 16'h0001;
parameter FPGA_POW_DIAG 			= 16'h0002;
parameter FPGA_DRAPE_SWITCH_SENSOR	= 16'h0003;
parameter FPGA_DRAPE_ELECTROMAGNET	= 16'h0004;
parameter FPGA_WHEEL_SENSOR 		= 16'h0005;
parameter FPGA_BUTTONS_LED			= 16'h0006;
parameter FPGA_ESTOP_STATUS 		= 16'h0007;
parameter FPGA_ESTOP_ACTIVATION 	= 16'h0008;
parameter FPGA_ESTOP_DIAGNOSTIC 	= 16'h0009;
parameter FPGA_DIAGNOSTIC_LEDS	 	= 16'h000A;
parameter FPGA_SPARE_IO	 			= 16'h000B;

//ESTOP
parameter ESTOP_DIAG_ACTIV			= 32'h0000ABCD;	//Set to 0xABCD for Closing Estop in Diagnostic mode ( along with bit 31 in ESTOP Activation register
parameter ESTOP_ACTIVATION_PULSE	= 4'hA;	//ESTOP activation pulse 		




