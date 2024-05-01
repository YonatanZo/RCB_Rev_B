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
DATE "05/01/2024 11:07:56";
PROGRAM "Quartus Prime";



INPUT CLK_100M;
INPUT R_M5B_SER_IN_SE;
INPUT R_EEF_SER_IN_SE;
INPUT R_4MB_SER_IN_SE;
INPUT L_4MB_SER_IN_SE;
INPUT L_EEF_SER_IN_SE;
INPUT L_M5B_SER_IN_SE;
INPUT SCK0;
INPUT CS0;
INPUT MOSI0;
INOUT SCL_ADC;
INPUT R_WHEEL_SENS_SPARE_OUT2_BUFF;
INPUT L_NO_switch_TOOL_EX_FPGA;
INPUT L_WHEEL_SENS_SPARE_OUT2_BUFF;
INPUT L_NC_switch_TOOL_EX_FPGA;
INPUT R_WHEEL_SENS_SPARE_OUT1_BUFF;
INPUT L_WHEEL_SENS_SPARE_OUT1_BUFF;
INPUT R_WHEEL_SENS_A2_OUT2_BUFF;
INPUT R_NO_switch_TOOL_EX_FPGA;
INPUT L_WHEEL_SENS_A2_OUT2_BUFF;
INPUT R_WHEEL_SENS_A2_OUT1_BUFF;
INPUT R_NC_switch_TOOL_EX_FPGA;
INPUT L_WHEEL_SENS_A2_OUT1_BUFF;
INPUT L_WHEEL_SENS_A1_OUT2_BUFF;
INPUT R_WHEEL_SENS_A1_OUT2_BUFF;
INPUT L_WHEEL_SENS_A1_OUT1_BUFF;
INPUT R_WHEEL_SENS_A1_OUT1_BUFF;
INPUT R_POS_SENS_OUT2_BUFF;
INPUT L_POS_SENS_OUT2_BUFF;
INPUT L_POS_SENS_OUT1_BUFF;
INPUT R_POS_SENS_OUT1_BUFF;
INPUT R_POS_SENS_1_OUT2_BUFF;
INPUT L_POS_SENS_1_OUT2_BUFF;
INPUT L_POS_SENS_1_OUT1_BUFF;
INPUT R_POS_SENS_1_OUT1_BUFF;
INPUT L_POS_SENS_0_OUT2_BUFF;
INPUT R_POS_SENS_0_OUT2_BUFF;
INPUT R_POS_SENS_0_OUT1_BUFF;
INPUT L_POS_SENS_0_OUT1_BUFF;
INOUT SDA_ADC;
INPUT TEENSY_LEDS_STRIP_DO;
INPUT altera_reserved_tdi;
INPUT altera_reserved_tck;
INPUT altera_reserved_tms;
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
OUTPUT altera_reserved_tdo;

/*Arc definitions start here*/
pos_altera_reserved_tdi__altera_reserved_tck__setup:		SETUP (POSEDGE) altera_reserved_tdi altera_reserved_tck ;
pos_altera_reserved_tms__altera_reserved_tck__setup:		SETUP (POSEDGE) altera_reserved_tms altera_reserved_tck ;
pos_altera_reserved_tdi__altera_reserved_tck__hold:		HOLD (POSEDGE) altera_reserved_tdi altera_reserved_tck ;
pos_altera_reserved_tms__altera_reserved_tck__hold:		HOLD (POSEDGE) altera_reserved_tms altera_reserved_tck ;
pos_altera_reserved_tck__altera_reserved_tdo__delay:		DELAY (POSEDGE) altera_reserved_tck altera_reserved_tdo ;

ENDMODEL
