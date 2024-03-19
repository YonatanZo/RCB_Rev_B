/*
 Copyright (C) 2023  Intel Corporation. All rights reserved.
 Your use of Intel Corporation's design tools, logic functions 
 and other software and tools, and any partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Intel Program License 
 Subscription Agreement, the Intel Quartus Prime License Agreement,
 the Intel FPGA IP License Agreement, or other applicable license
 agreement, including, without limitation, that your use is for
 the sole purpose of programming logic devices manufactured by
 Intel and sold by Intel or its authorized distributors.  Please
 refer to the applicable agreement for further details, at
 https://fpgasoftware.intel.com/eula.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Slow Corner delays for the design using part 10M40DCF256I7G
 with speed grade 7, core voltage 1.2V, and temperature 100 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "RCB_FPGA_3_1";
DATE "03/19/2024 13:54:13";
PROGRAM "Quartus Prime";



INPUT SCK0;
INPUT CLK_100M;
INPUT CS0;
INPUT MOSI0;
INPUT R_M5B_SER_IN_SE;
INPUT R_EEF_SER_IN_SE;
INPUT R_4MB_SER_IN_SE;
INPUT L_M5B_SER_IN_SE;
INPUT L_4MB_SER_IN_SE;
INPUT L_EEF_SER_IN_SE;
INOUT SCL_ADC;
INPUT L_NO_switch_TOOL_EX_FPGA;
INPUT R_WHEEL_SENS_SPARE_OUT2_BUFF;
INPUT L_WHEEL_SENS_SPARE_OUT2_BUFF;
INPUT R_WHEEL_SENS_SPARE_OUT1_BUFF;
INPUT L_NC_switch_TOOL_EX_FPGA;
INPUT L_WHEEL_SENS_SPARE_OUT1_BUFF;
INPUT R_NO_switch_TOOL_EX_FPGA;
INPUT R_WHEEL_SENS_A2_OUT2_BUFF;
INPUT L_WHEEL_SENS_A2_OUT2_BUFF;
INPUT L_WHEEL_SENS_A2_OUT1_BUFF;
INPUT R_NC_switch_TOOL_EX_FPGA;
INPUT R_WHEEL_SENS_A2_OUT1_BUFF;
INPUT L_WHEEL_SENS_A1_OUT2_BUFF;
INPUT R_WHEEL_SENS_A1_OUT2_BUFF;
INPUT L_WHEEL_SENS_A1_OUT1_BUFF;
INPUT R_WHEEL_SENS_A1_OUT1_BUFF;
INPUT L_POS_SENS_OUT2_BUFF;
INPUT R_POS_SENS_OUT2_BUFF;
INPUT L_POS_SENS_OUT1_BUFF;
INPUT R_POS_SENS_OUT1_BUFF;
INPUT R_POS_SENS_1_OUT2_BUFF;
INPUT L_POS_SENS_1_OUT2_BUFF;
INPUT R_POS_SENS_1_OUT1_BUFF;
INPUT L_POS_SENS_1_OUT1_BUFF;
INPUT L_POS_SENS_0_OUT2_BUFF;
INPUT R_POS_SENS_0_OUT2_BUFF;
INPUT R_POS_SENS_0_OUT1_BUFF;
INPUT L_POS_SENS_0_OUT1_BUFF;
INOUT SDA_ADC;
INPUT TEENSY_LEDS_STRIP_DO;
INPUT RST_WD;
INPUT CONFIG_SEL;
INPUT CPU_RESETn;
INPUT ESTOP_OPEN_REQUEST;
INPUT ESTOP_STATUS;
INPUT ESTOP_STATUS_FAIL;
INPUT FAN1_TACHO_BUFF;
INPUT FAN2_TACHO_BUFF;
INPUT FLA_PWR_DIS;
INPUT FPGA_L_ROBOT_RX;
INPUT FPGA_R_ROBOT_RX;
INPUT L_4MB_SER_IN_ER;
INPUT L_EEF_SER_IN_ER;
INPUT L_M5B_SER_IN_ER;
INPUT L_ROBOT_DIFF_SP2;
INPUT L_SCU_INVALIDn;
INPUT L_SER_RX_ER;
INPUT MICCB_SP_IN_A_F;
INPUT MICCB_SP_IN_B_F;
INPUT MicCB_ESTOP_OPEN_REQUEST;
INPUT MICCB_GEN_SYNC_FAIL;
INPUT MICCB_GEN_SYNC_FPGA;
INPUT MICCB_SPARE_IO0;
INPUT MICCB_SPARE_IO1;
INPUT MICCB_SPARE_IO2;
INPUT MICCB_SPARE_IO3;
INPUT TEENSY_FPGA_R_TX;
INPUT TEENSY_FPGA_L_TX;
INPUT PS_PG_FPGA;
INPUT R_4MB_SER_IN_ER;
INPUT R_EEF_SER_IN_ER;
INPUT R_M5B_SER_IN_ER;
INPUT R_ROBOT_DIFF_SP1;
INPUT R_ROBOT_DIFF_SP2;
INPUT R_SCU_Invalid_n;
INPUT R_SER_RX_ER;
INPUT SPARE1_DIFF0;
INPUT SPARE1_DIFF1;
INPUT SPARE1_IO0_FPGA;
INPUT SPARE1_IO1_FPGA;
INPUT SPARE2_DIFF0;
INPUT SPARE2_DIFF1;
INPUT SPARE2_IO0_FPGA;
INPUT SPARE2_IO1_FPGA;
INPUT SSR_ON_FPGA;
OUTPUT ESTOP_DELAY;
OUTPUT MISO0;
OUTPUT A_24V_L_EN;
OUTPUT B_24V_L_EN;
OUTPUT A_24V_R_EN;
OUTPUT B_24V_R_EN;
OUTPUT A_35V_L_EN;
OUTPUT B_35V_L_EN;
OUTPUT A_35V_R_EN;
OUTPUT B_35V_R_EN;
OUTPUT BIT_SSR_SW;
OUTPUT FAN1_PWM;
OUTPUT FAN2_PWM;
OUTPUT FPGA4V_DIS;
OUTPUT FPGA_DIAG_ACT;
OUTPUT FPGA_ESTOP_REQ;
OUTPUT FPGA_FAULT;
OUTPUT FPGA_INT;
OUTPUT FPGA_L_ROBOT_TX;
OUTPUT FPGA_L_SP_TX;
OUTPUT FPGA_R_ROBOT_TX;
OUTPUT FPGA_R_SP_TX;
OUTPUT FPGA_WHEEL_STOP_ELO;
OUTPUT FPGA1;
OUTPUT FPGA10;
OUTPUT FPGA11;
OUTPUT FPGA12;
OUTPUT FPGA13;
OUTPUT FPGA2;
OUTPUT FPGA3;
OUTPUT FPGA4;
OUTPUT FPGA5;
OUTPUT FPGA6;
OUTPUT FPGA7;
OUTPUT FPGA8;
OUTPUT FPGA9;
OUTPUT L_TOOL_EX_LED_DIN;
OUTPUT L_LED_DIN;
OUTPUT LED_1;
OUTPUT LED_2;
OUTPUT LED_3;
OUTPUT LED_4;
OUTPUT LED_5;
OUTPUT LED_6;
OUTPUT LED_7;
OUTPUT LED_8;
OUTPUT TEENSY_FPGA_R_RX;
OUTPUT TEENSY_FPGA_L_RX;
OUTPUT OPEN_ELO_REQUEST;
OUTPUT R_TOOL_EX_LED_DIN;
OUTPUT R_LED_DIN;
OUTPUT ROBOT_ESTOP_LED_DIN;
OUTPUT S_LED_DIN;
OUTPUT SPARE1_ANALOG_SW_0_SEL_FPGA;
OUTPUT SPARE1_ANALOG_SW_1_SEL_FPGA;
OUTPUT SPARE1_ANALOG_SW_SEL_FPGA;
OUTPUT SPARE1_DIFF2;
OUTPUT SPARE1_DIFF3;
OUTPUT SPARE1_IO2_FPGA;
OUTPUT SPARE1_IO3_FPGA;
OUTPUT SPARE2_ANALOG_SW_0_SEL_FPGA;
OUTPUT SPARE2_ANALOG_SW_1_SEL_FPGA;
OUTPUT SPARE2_ANALOG_SW_SEL_FPGA;
OUTPUT SPARE2_DIFF2;
OUTPUT SPARE2_DIFF3;
OUTPUT SPARE2_IO2_FPGA;
OUTPUT SPARE2_IO3_FPGA;
OUTPUT Teensy_FPGA_SP0;
OUTPUT Teensy_FPGA_SP1;
OUTPUT Teensy_FPGA_SP2;

/*Arc definitions start here*/
pos_CS0__CLK_100M__setup:		SETUP (POSEDGE) CS0 CLK_100M ;
pos_L_4MB_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) L_4MB_SER_IN_SE CLK_100M ;
pos_L_EEF_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) L_EEF_SER_IN_SE CLK_100M ;
pos_L_M5B_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) L_M5B_SER_IN_SE CLK_100M ;
pos_L_NC_switch_TOOL_EX_FPGA__CLK_100M__setup:		SETUP (POSEDGE) L_NC_switch_TOOL_EX_FPGA CLK_100M ;
pos_L_NO_switch_TOOL_EX_FPGA__CLK_100M__setup:		SETUP (POSEDGE) L_NO_switch_TOOL_EX_FPGA CLK_100M ;
pos_L_POS_SENS_0_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_0_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_0_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_0_OUT2_BUFF CLK_100M ;
pos_L_POS_SENS_1_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_1_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_1_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_1_OUT2_BUFF CLK_100M ;
pos_L_POS_SENS_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_POS_SENS_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A1_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_A1_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A1_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_A1_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A2_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_A2_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A2_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_A2_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_SPARE_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_SPARE_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_SPARE_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) L_WHEEL_SENS_SPARE_OUT2_BUFF CLK_100M ;
pos_MOSI0__CLK_100M__setup:		SETUP (POSEDGE) MOSI0 CLK_100M ;
pos_R_4MB_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) R_4MB_SER_IN_SE CLK_100M ;
pos_R_EEF_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) R_EEF_SER_IN_SE CLK_100M ;
pos_R_M5B_SER_IN_SE__CLK_100M__setup:		SETUP (POSEDGE) R_M5B_SER_IN_SE CLK_100M ;
pos_R_NC_switch_TOOL_EX_FPGA__CLK_100M__setup:		SETUP (POSEDGE) R_NC_switch_TOOL_EX_FPGA CLK_100M ;
pos_R_NO_switch_TOOL_EX_FPGA__CLK_100M__setup:		SETUP (POSEDGE) R_NO_switch_TOOL_EX_FPGA CLK_100M ;
pos_R_POS_SENS_0_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_0_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_0_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_0_OUT2_BUFF CLK_100M ;
pos_R_POS_SENS_1_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_1_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_1_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_1_OUT2_BUFF CLK_100M ;
pos_R_POS_SENS_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_POS_SENS_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A1_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_A1_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A1_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_A1_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A2_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_A2_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A2_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_A2_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_SPARE_OUT1_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_SPARE_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_SPARE_OUT2_BUFF__CLK_100M__setup:		SETUP (POSEDGE) R_WHEEL_SENS_SPARE_OUT2_BUFF CLK_100M ;
pos_SCK0__CLK_100M__setup:		SETUP (POSEDGE) SCK0 CLK_100M ;
pos_SCL_ADC__CLK_100M__setup:		SETUP (POSEDGE) SCL_ADC CLK_100M ;
pos_TEENSY_LEDS_STRIP_DO__rcb_registers:i_rcb_registers|MUX_Control[0]__setup:		SETUP (POSEDGE) TEENSY_LEDS_STRIP_DO rcb_registers:i_rcb_registers|MUX_Control[0] ;
pos_TEENSY_LEDS_STRIP_DO__rcb_registers:i_rcb_registers|MUX_Control[0]__setup:		SETUP (POSEDGE) TEENSY_LEDS_STRIP_DO rcb_registers:i_rcb_registers|MUX_Control[0] ;
pos_CS0__CLK_100M__hold:		HOLD (POSEDGE) CS0 CLK_100M ;
pos_L_4MB_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) L_4MB_SER_IN_SE CLK_100M ;
pos_L_EEF_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) L_EEF_SER_IN_SE CLK_100M ;
pos_L_M5B_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) L_M5B_SER_IN_SE CLK_100M ;
pos_L_NC_switch_TOOL_EX_FPGA__CLK_100M__hold:		HOLD (POSEDGE) L_NC_switch_TOOL_EX_FPGA CLK_100M ;
pos_L_NO_switch_TOOL_EX_FPGA__CLK_100M__hold:		HOLD (POSEDGE) L_NO_switch_TOOL_EX_FPGA CLK_100M ;
pos_L_POS_SENS_0_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_0_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_0_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_0_OUT2_BUFF CLK_100M ;
pos_L_POS_SENS_1_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_1_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_1_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_1_OUT2_BUFF CLK_100M ;
pos_L_POS_SENS_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_OUT1_BUFF CLK_100M ;
pos_L_POS_SENS_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_POS_SENS_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A1_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_A1_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A1_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_A1_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A2_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_A2_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_A2_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_A2_OUT2_BUFF CLK_100M ;
pos_L_WHEEL_SENS_SPARE_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_SPARE_OUT1_BUFF CLK_100M ;
pos_L_WHEEL_SENS_SPARE_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) L_WHEEL_SENS_SPARE_OUT2_BUFF CLK_100M ;
pos_MOSI0__CLK_100M__hold:		HOLD (POSEDGE) MOSI0 CLK_100M ;
pos_R_4MB_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) R_4MB_SER_IN_SE CLK_100M ;
pos_R_EEF_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) R_EEF_SER_IN_SE CLK_100M ;
pos_R_M5B_SER_IN_SE__CLK_100M__hold:		HOLD (POSEDGE) R_M5B_SER_IN_SE CLK_100M ;
pos_R_NC_switch_TOOL_EX_FPGA__CLK_100M__hold:		HOLD (POSEDGE) R_NC_switch_TOOL_EX_FPGA CLK_100M ;
pos_R_NO_switch_TOOL_EX_FPGA__CLK_100M__hold:		HOLD (POSEDGE) R_NO_switch_TOOL_EX_FPGA CLK_100M ;
pos_R_POS_SENS_0_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_0_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_0_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_0_OUT2_BUFF CLK_100M ;
pos_R_POS_SENS_1_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_1_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_1_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_1_OUT2_BUFF CLK_100M ;
pos_R_POS_SENS_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_OUT1_BUFF CLK_100M ;
pos_R_POS_SENS_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_POS_SENS_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A1_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_A1_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A1_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_A1_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A2_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_A2_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_A2_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_A2_OUT2_BUFF CLK_100M ;
pos_R_WHEEL_SENS_SPARE_OUT1_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_SPARE_OUT1_BUFF CLK_100M ;
pos_R_WHEEL_SENS_SPARE_OUT2_BUFF__CLK_100M__hold:		HOLD (POSEDGE) R_WHEEL_SENS_SPARE_OUT2_BUFF CLK_100M ;
pos_SCK0__CLK_100M__hold:		HOLD (POSEDGE) SCK0 CLK_100M ;
pos_SCL_ADC__CLK_100M__hold:		HOLD (POSEDGE) SCL_ADC CLK_100M ;
pos_TEENSY_LEDS_STRIP_DO__rcb_registers:i_rcb_registers|MUX_Control[0]__hold:		HOLD (POSEDGE) TEENSY_LEDS_STRIP_DO rcb_registers:i_rcb_registers|MUX_Control[0] ;
pos_TEENSY_LEDS_STRIP_DO__rcb_registers:i_rcb_registers|MUX_Control[0]__hold:		HOLD (POSEDGE) TEENSY_LEDS_STRIP_DO rcb_registers:i_rcb_registers|MUX_Control[0] ;
pos_CLK_100M__A_24V_L_EN__delay:		DELAY (POSEDGE) CLK_100M A_24V_L_EN ;
pos_CLK_100M__A_24V_R_EN__delay:		DELAY (POSEDGE) CLK_100M A_24V_R_EN ;
pos_CLK_100M__A_35V_L_EN__delay:		DELAY (POSEDGE) CLK_100M A_35V_L_EN ;
pos_CLK_100M__A_35V_R_EN__delay:		DELAY (POSEDGE) CLK_100M A_35V_R_EN ;
pos_CLK_100M__BIT_SSR_SW__delay:		DELAY (POSEDGE) CLK_100M BIT_SSR_SW ;
pos_CLK_100M__B_24V_L_EN__delay:		DELAY (POSEDGE) CLK_100M B_24V_L_EN ;
pos_CLK_100M__B_24V_R_EN__delay:		DELAY (POSEDGE) CLK_100M B_24V_R_EN ;
pos_CLK_100M__B_35V_L_EN__delay:		DELAY (POSEDGE) CLK_100M B_35V_L_EN ;
pos_CLK_100M__B_35V_R_EN__delay:		DELAY (POSEDGE) CLK_100M B_35V_R_EN ;
pos_CLK_100M__LED_1__delay:		DELAY (POSEDGE) CLK_100M LED_1 ;
pos_CLK_100M__LED_2__delay:		DELAY (POSEDGE) CLK_100M LED_2 ;
pos_CLK_100M__LED_3__delay:		DELAY (POSEDGE) CLK_100M LED_3 ;
pos_CLK_100M__LED_4__delay:		DELAY (POSEDGE) CLK_100M LED_4 ;
pos_CLK_100M__LED_5__delay:		DELAY (POSEDGE) CLK_100M LED_5 ;
pos_CLK_100M__LED_6__delay:		DELAY (POSEDGE) CLK_100M LED_6 ;
pos_CLK_100M__LED_7__delay:		DELAY (POSEDGE) CLK_100M LED_7 ;
pos_CLK_100M__LED_8__delay:		DELAY (POSEDGE) CLK_100M LED_8 ;
pos_CLK_100M__MISO0__delay:		DELAY (POSEDGE) CLK_100M MISO0 ;
pos_CLK_100M__SCL_ADC__delay:		DELAY (POSEDGE) CLK_100M SCL_ADC ;
pos_CLK_100M__SDA_ADC__delay:		DELAY (POSEDGE) CLK_100M SDA_ADC ;
pos_CLK_100M__TEENSY_FPGA_L_RX__delay:		DELAY (POSEDGE) CLK_100M TEENSY_FPGA_L_RX ;
pos_CLK_100M__TEENSY_FPGA_R_RX__delay:		DELAY (POSEDGE) CLK_100M TEENSY_FPGA_R_RX ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__L_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] L_LED_DIN ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__L_TOOL_EX_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] L_TOOL_EX_LED_DIN ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__ROBOT_ESTOP_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] ROBOT_ESTOP_LED_DIN ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__R_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] R_LED_DIN ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__R_TOOL_EX_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] R_TOOL_EX_LED_DIN ;
pos_rcb_registers:i_rcb_registers|MUX_Control[0]__S_LED_DIN__delay:		DELAY (POSEDGE) rcb_registers:i_rcb_registers|MUX_Control[0] S_LED_DIN ;

ENDMODEL
