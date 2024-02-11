//////////////////////////////////////////////////////////////////////
//	File			: spi_tests.v
//	Author			: Igor Dorman Trace PCB.
//	Date			: 02/09/2022
//	Description		: SPI Test File.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb <- tester_rcb <- rcb_tests <-test_list
//	Last Update		: 18/10/2022 
/////////////////////////////////////////////////////////////////////

//`define   echo_0;  //Show echo from low level access tasks(write_access,read_access etc.)
//`define   echo_1;  //Show echo from high level access tasks
//`define   echo_2;  //Show echo from tests tasks
//`define DE10_Lite;	//Test for DE10-Lite Evaluation Board


//-------- ENABLE/DISABLE CERTAIN SPI TEST ----------//	
//For enable(disable) a certain test, set(clear) a sign of comment "//" before the corresponding "define".
//`define	REGISTER_RESET_TEST;
`define	FPGA_VER_TEST;
`define	FPGA_REV_DATA_TEST;
`define	FPGA_POW_TEST;
`define	FPGA_BUTTONS_TEST;
`define	DRAPE_SW_TEST;
`define	DRAPE_EM_TEST;
`define	DRAPE_SW_APPROVAL_TEST;
`define	DRAPE_SENSOR_TEST;
`define	BUTTONS_LEDS_TEST;
`define	WHEEL_DRIVER_OUT_TEST;
				
`define	WHEEL_DRIVER_ABRT_TEST;
`define	WHEEL_DRIVER_IN_TEST;
`define	WHEEL_SENSOR_TEST;
`define	DIAGNOSTIC_LEDS_TEST;
`define	SPARE_IO_TEST;
`define	WHEEL_ROD_SENSOR_TEST;
`define	ESTOP_DIAG_ACTIVATION_TEST;
//`define	FAN1_PWM_TEST;	//Visual test. Check in the Wave window. Set different PWM values and check visually.
//`define	FAN2_PWM_TEST;	//Visual test. Check in the Wave window. Set different PWM values and check visually.
//`define	FAN1_TACHO_TEST;	//Standalone test. Long test must be run alone(without any else tests)
//`define	FAN2_TACHO_TEST;	//Standalone test. Long test must be run alone(without any else tests)


/*
`ifdef ESTOP_TEST
	ESTOP_TEST;	
`endif
*/
//Not used now
//`define	ESTOP_BUTTON1_TEST;
//`define	ESTOP_BUTTON2_TEST;
//`define	WHEEL_DRIVER_ELO_TEST;
//`define	ESTOP_ACTIVATION_TEST;		//Visual test(Long test).Check in the Wave window. The Estop Activation pulse should be about 100ms

//------------ Run All RCB---------------------//
task Run_RCB_Tests;
begin
`ifdef REGISTER_RESET_TEST
	$fdisplay(broadcast,"\n########## Register Reset Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Register Reset Task ";
	#100;
	Register_Reset_Task;	//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;			//rcb_tasks.v
`endif

`ifdef FPGA_VER_TEST
	$fdisplay(broadcast,"\n########## Version Register Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Version Register ";
	#100;
	Version_Register_Task;		//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef FPGA_REV_DATA_TEST
	$fdisplay(broadcast,"\n########## Revision Data Register Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Revision Data Register ";
	#100;
	Revision_Data_Register_Task;	//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef FPGA_POW_TEST
	$fdisplay(broadcast,"\n########## Power Diagnostic Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "POW Register ";
	#100;
	POW_Register_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef FPGA_BUTTONS_TEST
	$fdisplay(broadcast,"\n########## FPGA Buttons Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "FPGA Buttons ";
	#100;
	FPGA_Buttons_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef DRAPE_SENSOR_TEST
	$fdisplay(broadcast,"\n########## Drape Sensor Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Drape Sensor  ";
	#100;
	Drape_Sensor_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef DRAPE_SW_TEST
	$fdisplay(broadcast,"\n########## Drape Switch Indicator Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Drape Switch Indicator";
	#100;
	Drape_SW_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef DRAPE_EM_TEST
	$fdisplay(broadcast,"\n########## Drape Electormagnet Indicator Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Drape Electormagnet Indicator ";
	#100;
	Drape_EM_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif

`ifdef DRAPE_SW_APPROVAL_TEST
	$fdisplay(broadcast,"\n########## Drape SW Approval Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Drape SW approval ";
	#100;
	Drape_SW_Approval_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;					//rcb_tasks.v
`endif
/*
`ifdef ESTOP_BUTTON1_TEST
	$fdisplay(broadcast,"\n########## ESTOP_Button1 Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "ESTOP Button1 ";
	#100;
	ESTOP_Button1_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif
	
`ifdef ESTOP_BUTTON2_TEST
	$fdisplay(broadcast,"\n########## ESTOP_Button2 Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "ESTOP Button2 ";
	#100;
	ESTOP_Button2_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif
*/
`ifdef BUTTONS_LEDS_TEST
	$fdisplay(broadcast,"\n########## Buttons Leds Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Buttons Leds ";
	#100;
	Buttons_Led_Task;			//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef WHEEL_DRIVER_OUT_TEST
	$fdisplay(broadcast,"\n########## Wheel Driver Out Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Driver Out ";
	#100;
	Wheel_Driver_Out_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif
/*
`ifdef WHEEL_DRIVER_ELO_TEST
	$fdisplay(broadcast,"\n########## Wheel Driver ELO Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Driver ELO ";
	#100;
	Wheel_Driver_ELO_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif
*/
`ifdef WHEEL_DRIVER_ABRT_TEST
	$fdisplay(broadcast,"\n########## Wheel Driver ABRT/RST Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Driver ABRT/RST ";
	#100;
	Wheel_Driver_ABRT_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef WHEEL_DRIVER_IN_TEST
	$fdisplay(broadcast,"\n########## Wheel Driver Input Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Driver Input ";
	#100;
	Wheel_Driver_In_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef WHEEL_SENSOR_TEST
	$fdisplay(broadcast,"\n########## Wheel Sensor Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Sensor ";
	#100;
	Wheel_Sensor_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef DIAGNOSTIC_LEDS_TEST
	$fdisplay(broadcast,"\n########## Diagnostic Leds Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Diagnostic LEDs ";
	#100;
	Diagnoctic_Leds_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif	


`ifdef WHEEL_ROD_SENSOR_TEST
	$fdisplay(broadcast,"\n########## Wheel Rod Sensor Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Wheel Ror Sensor ";
	#100;
	Wheel_Rod_Sensor_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif	
/*
`ifdef ESTOP_ACTIVATION_TEST
	$fdisplay(broadcast,"\n########## ESTOP Activation Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "ESTOP Activation ";
	#100;
	ESTOP_Activation_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif	
*/
`ifdef ESTOP_DIAG_ACTIVATION_TEST
	$fdisplay(broadcast,"\n########## ESTOP Diagnostic Activation Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "ESTOP Diagnostic Activation ";
	#100;
	ESTOP_Diag_Activation_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef SPARE_IO_TEST
	$fdisplay(broadcast,"\n########## Spare_IO Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "Spare IO ";
	#100;
	Spare_IO_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef FAN1_PWM_TEST
	$fdisplay(broadcast,"\n########## FAN1 PWM Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "FAN1 PWM ";
	#100;
	FAN1_PWM_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef FAN2_PWM_TEST
	$fdisplay(broadcast,"\n########## FAN2 PWM Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "FAN2 PWM ";
	#100;
	FAN2_PWM_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef FAN1_TACHO_TEST
	$fdisplay(broadcast,"\n########## FAN1 Tacho Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "FAN1 Tacho ";
	#100;
	FAN1_Tacho_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif

`ifdef FAN2_TACHO_TEST
	$fdisplay(broadcast,"\n########## FAN2 Tacho Test BEGIN at %.0f ns ##########",$time);
	#200;
	errors_test = 0;
	tests = "FAN2 Tacho ";
	#100;
	FAN2_Tacho_Task;					//rcb_tasks.v
	errors_counter = errors_counter + errors_test;
	Check_Errors;				//rcb_tasks.v
`endif
/*
`ifdef ESTOP_CIRCUIT
	`ifdef ESTOP_TEST
		$fdisplay(broadcast,"\n########## ESTOP Test BEGIN at %.0f ns ##########",$time);
		#200;
		errors_test = 0;
		tests = "ESTOP ";
		#100;
		Estop_Task;					//rcb_tasks.v
		errors_counter = errors_counter + errors_test;
		Check_Errors;				//rcb_tasks.v
	`endif
`endif
*/

end
endtask

