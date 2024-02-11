


INPUT CLK_100M;
INPUT sclk;
INPUT RST_N;
INPUT cs_n;
INPUT mosi;
INPUT wheel_d_sens2_in1;
INPUT sp2_single_ended_1_0[1];
INPUT wheel_d_sens1_in2;
INPUT sp2_single_ended_1_0[0];
INPUT wheel_d_sens1_in1;
INPUT wheel_c_sens3_in2;
INPUT wheel_c_sens3_in1;
INPUT wheel_a_sens1_in1;
INPUT fan2_tacho;
INPUT left_drape_sw_state;
INPUT sp1_diff_pair_in[0];
INPUT left_drape_em_state;
INPUT left_spare_diff_1;
INPUT wheel_rod1_no;
INPUT fan1_tacho;
INPUT pow;
INPUT wheel_driver_do[0];
INPUT estop_btn1_no;
INPUT left_tool_ex_no;
INPUT left_drape_open_no;
INPUT left_tool_ex_nc;
INPUT left_drape_open_nc;
INPUT wheel_rod1_nc;
INPUT sp1_diff_pair_in[1];
INPUT wheel_driver_do[1];
INPUT wheel_a_sens1_in2;
INPUT estop_btn1_nc;
INPUT right_drape_sw_state;
INPUT right_drape_em_state;
INPUT wheel_a_sens2_in1;
INPUT wheel_driver_do[2];
INPUT right_spare_diff_1;
INPUT wheel_rod2_no;
INPUT right_tool_ex_no;
INPUT left_drape_close1_no;
INPUT wheel_a_sens2_in2;
INPUT wheel_driver_do[3];
INPUT wheel_rod2_nc;
INPUT right_tool_ex_nc;
INPUT left_drape_close1_nc;
INPUT estop_btn2_no;
INPUT left_plunger_no;
INPUT left_drape_close2_no;
INPUT wheel_a_sens3_in1;
INPUT left_plunger_nc;
INPUT left_drape_close2_nc;
INPUT estop_btn2_nc;
INPUT wheel_a_sens3_in2;
INPUT right_plunger_no;
INPUT wheel_b_sens1_in1;
INPUT wheel_b_sens1_in2;
INPUT sp1_single_ended_1_0[0];
INPUT right_plunger_nc;
INPUT right_drape_open_no;
INPUT wheel_b_sens2_in1;
INPUT sp1_single_ended_1_0[1];
INPUT wheel_b_sens2_in2;
INPUT right_drape_open_nc;
INPUT wheel_b_sens3_in1;
INPUT right_drape_close1_no;
INPUT wheel_b_sens3_in2;
INPUT right_drape_close1_nc;
INPUT sp2_diff_pair_1_0[0];
INPUT sp2_diff_pair_1_0[1];
INPUT right_drape_close2_no;
INPUT wheel_c_sens1_in1;
INPUT right_drape_close2_nc;
INPUT wheel_c_sens1_in2;
INPUT wheel_c_sens2_in1;
INPUT wheel_c_sens2_in2;
INPUT wheel_d_sens2_in2;
INPUT wheel_d_sens3_in1;
INPUT wheel_d_sens3_in2;
INPUT sync;
INPUT teensy_activation;
OUTPUT miso;
OUTPUT right_drape_em_open;
OUTPUT left_drape_em_open;
OUTPUT wheel_driver_elo;
OUTPUT wheel_driver_rst;
OUTPUT wheel_driver_abrt;
OUTPUT right_tool_ex_led3;
OUTPUT right_tool_ex_led2;
OUTPUT right_tool_ex_led1;
OUTPUT left_tool_ex_led3;
OUTPUT left_tool_ex_led2;
OUTPUT left_tool_ex_led1;
OUTPUT right_plunger_led3;
OUTPUT right_plunger_led2;
OUTPUT right_plunger_led1;
OUTPUT left_plunger_led3;
OUTPUT left_plunger_led2;
OUTPUT left_plunger_led1;
OUTPUT estop_activation;
OUTPUT diag_activation;
OUTPUT estop_open;
OUTPUT right_spare_diff_2;
OUTPUT left_spare_diff_2;
OUTPUT fan1_pwm;
OUTPUT fan2_pwm;
OUTPUT CLK100M_0UT;
OUTPUT CLK100K_OUT;
OUTPUT led_r8;
OUTPUT led_r9;
OUTPUT ssr_enable;
OUTPUT diagnostic_led[7];
OUTPUT diagnostic_led[6];
OUTPUT diagnostic_led[5];
OUTPUT diagnostic_led[4];
OUTPUT diagnostic_led[3];
OUTPUT diagnostic_led[2];
OUTPUT diagnostic_led[1];
OUTPUT diagnostic_led[0];
OUTPUT sp1_analog_switch[2];
OUTPUT sp1_analog_switch[1];
OUTPUT sp1_analog_switch[0];
OUTPUT sp1_diff_pair_out[1];
OUTPUT sp1_diff_pair_out[0];
OUTPUT sp1_single_ended_2_3[1];
OUTPUT sp1_single_ended_2_3[0];
OUTPUT sp2_analog_switch[2];
OUTPUT sp2_analog_switch[1];
OUTPUT sp2_analog_switch[0];
OUTPUT sp2_diff_pair_2_3[1];
OUTPUT sp2_diff_pair_2_3[0];
OUTPUT sp2_single_ended_2_3[1];
OUTPUT sp2_single_ended_2_3[0];
OUTPUT wheel_driver_di[7];
OUTPUT wheel_driver_di[6];
OUTPUT wheel_driver_di[5];
OUTPUT wheel_driver_di[4];
OUTPUT wheel_driver_di[3];
OUTPUT wheel_driver_di[2];
OUTPUT wheel_driver_di[1];
OUTPUT wheel_driver_di[0];
OUTPUT wheel_forward_sw[3];
OUTPUT wheel_forward_sw[2];
OUTPUT wheel_forward_sw[1];
OUTPUT wheel_forward_sw[0];
OUTPUT wheel_home_sw[3];
OUTPUT wheel_home_sw[2];
OUTPUT wheel_home_sw[1];
OUTPUT wheel_home_sw[0];
OUTPUT wheel_reverse_sw[3];
OUTPUT wheel_reverse_sw[2];
OUTPUT wheel_reverse_sw[1];
OUTPUT wheel_reverse_sw[0];

/*Arc definitions start here*/
pos_RST_N__CLK_100M__setup:		SETUP (POSEDGE) RST_N CLK_100M ;
pos_cs_n__CLK_100M__setup:		SETUP (POSEDGE) cs_n CLK_100M ;
pos_estop_btn1_nc__CLK_100M__setup:		SETUP (POSEDGE) estop_btn1_nc CLK_100M ;
pos_estop_btn1_no__CLK_100M__setup:		SETUP (POSEDGE) estop_btn1_no CLK_100M ;
pos_estop_btn2_nc__CLK_100M__setup:		SETUP (POSEDGE) estop_btn2_nc CLK_100M ;
pos_estop_btn2_no__CLK_100M__setup:		SETUP (POSEDGE) estop_btn2_no CLK_100M ;
pos_fan1_tacho__CLK_100M__setup:		SETUP (POSEDGE) fan1_tacho CLK_100M ;
pos_fan2_tacho__CLK_100M__setup:		SETUP (POSEDGE) fan2_tacho CLK_100M ;
pos_left_drape_close1_nc__CLK_100M__setup:		SETUP (POSEDGE) left_drape_close1_nc CLK_100M ;
pos_left_drape_close1_no__CLK_100M__setup:		SETUP (POSEDGE) left_drape_close1_no CLK_100M ;
pos_left_drape_close2_nc__CLK_100M__setup:		SETUP (POSEDGE) left_drape_close2_nc CLK_100M ;
pos_left_drape_close2_no__CLK_100M__setup:		SETUP (POSEDGE) left_drape_close2_no CLK_100M ;
pos_left_drape_em_state__CLK_100M__setup:		SETUP (POSEDGE) left_drape_em_state CLK_100M ;
pos_left_drape_open_nc__CLK_100M__setup:		SETUP (POSEDGE) left_drape_open_nc CLK_100M ;
pos_left_drape_open_no__CLK_100M__setup:		SETUP (POSEDGE) left_drape_open_no CLK_100M ;
pos_left_drape_sw_state__CLK_100M__setup:		SETUP (POSEDGE) left_drape_sw_state CLK_100M ;
pos_left_plunger_nc__CLK_100M__setup:		SETUP (POSEDGE) left_plunger_nc CLK_100M ;
pos_left_plunger_no__CLK_100M__setup:		SETUP (POSEDGE) left_plunger_no CLK_100M ;
pos_left_spare_diff_1__CLK_100M__setup:		SETUP (POSEDGE) left_spare_diff_1 CLK_100M ;
pos_left_tool_ex_nc__CLK_100M__setup:		SETUP (POSEDGE) left_tool_ex_nc CLK_100M ;
pos_left_tool_ex_no__CLK_100M__setup:		SETUP (POSEDGE) left_tool_ex_no CLK_100M ;
pos_mosi__CLK_100M__setup:		SETUP (POSEDGE) mosi CLK_100M ;
pos_pow__CLK_100M__setup:		SETUP (POSEDGE) pow CLK_100M ;
pos_right_drape_close1_nc__CLK_100M__setup:		SETUP (POSEDGE) right_drape_close1_nc CLK_100M ;
pos_right_drape_close1_no__CLK_100M__setup:		SETUP (POSEDGE) right_drape_close1_no CLK_100M ;
pos_right_drape_close2_nc__CLK_100M__setup:		SETUP (POSEDGE) right_drape_close2_nc CLK_100M ;
pos_right_drape_close2_no__CLK_100M__setup:		SETUP (POSEDGE) right_drape_close2_no CLK_100M ;
pos_right_drape_em_state__CLK_100M__setup:		SETUP (POSEDGE) right_drape_em_state CLK_100M ;
pos_right_drape_open_nc__CLK_100M__setup:		SETUP (POSEDGE) right_drape_open_nc CLK_100M ;
pos_right_drape_open_no__CLK_100M__setup:		SETUP (POSEDGE) right_drape_open_no CLK_100M ;
pos_right_drape_sw_state__CLK_100M__setup:		SETUP (POSEDGE) right_drape_sw_state CLK_100M ;
pos_right_plunger_nc__CLK_100M__setup:		SETUP (POSEDGE) right_plunger_nc CLK_100M ;
pos_right_plunger_no__CLK_100M__setup:		SETUP (POSEDGE) right_plunger_no CLK_100M ;
pos_right_spare_diff_1__CLK_100M__setup:		SETUP (POSEDGE) right_spare_diff_1 CLK_100M ;
pos_right_tool_ex_nc__CLK_100M__setup:		SETUP (POSEDGE) right_tool_ex_nc CLK_100M ;
pos_right_tool_ex_no__CLK_100M__setup:		SETUP (POSEDGE) right_tool_ex_no CLK_100M ;
pos_sclk__CLK_100M__setup:		SETUP (POSEDGE) sclk CLK_100M ;
pos_sp1_diff_pair_in[0]__CLK_100M__setup:		SETUP (POSEDGE) sp1_diff_pair_in[0] CLK_100M ;
pos_sp1_diff_pair_in[1]__CLK_100M__setup:		SETUP (POSEDGE) sp1_diff_pair_in[1] CLK_100M ;
pos_sp1_single_ended_1_0[0]__CLK_100M__setup:		SETUP (POSEDGE) sp1_single_ended_1_0[0] CLK_100M ;
pos_sp1_single_ended_1_0[1]__CLK_100M__setup:		SETUP (POSEDGE) sp1_single_ended_1_0[1] CLK_100M ;
pos_sp2_diff_pair_1_0[0]__CLK_100M__setup:		SETUP (POSEDGE) sp2_diff_pair_1_0[0] CLK_100M ;
pos_sp2_diff_pair_1_0[1]__CLK_100M__setup:		SETUP (POSEDGE) sp2_diff_pair_1_0[1] CLK_100M ;
pos_sp2_single_ended_1_0[0]__CLK_100M__setup:		SETUP (POSEDGE) sp2_single_ended_1_0[0] CLK_100M ;
pos_sp2_single_ended_1_0[1]__CLK_100M__setup:		SETUP (POSEDGE) sp2_single_ended_1_0[1] CLK_100M ;
pos_wheel_a_sens1_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens1_in1 CLK_100M ;
pos_wheel_a_sens1_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens1_in2 CLK_100M ;
pos_wheel_a_sens2_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens2_in1 CLK_100M ;
pos_wheel_a_sens2_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens2_in2 CLK_100M ;
pos_wheel_a_sens3_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens3_in1 CLK_100M ;
pos_wheel_a_sens3_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_a_sens3_in2 CLK_100M ;
pos_wheel_b_sens1_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens1_in1 CLK_100M ;
pos_wheel_b_sens1_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens1_in2 CLK_100M ;
pos_wheel_b_sens2_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens2_in1 CLK_100M ;
pos_wheel_b_sens2_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens2_in2 CLK_100M ;
pos_wheel_b_sens3_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens3_in1 CLK_100M ;
pos_wheel_b_sens3_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_b_sens3_in2 CLK_100M ;
pos_wheel_c_sens1_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens1_in1 CLK_100M ;
pos_wheel_c_sens1_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens1_in2 CLK_100M ;
pos_wheel_c_sens2_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens2_in1 CLK_100M ;
pos_wheel_c_sens2_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens2_in2 CLK_100M ;
pos_wheel_c_sens3_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens3_in1 CLK_100M ;
pos_wheel_c_sens3_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_c_sens3_in2 CLK_100M ;
pos_wheel_d_sens1_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens1_in1 CLK_100M ;
pos_wheel_d_sens1_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens1_in2 CLK_100M ;
pos_wheel_d_sens2_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens2_in1 CLK_100M ;
pos_wheel_d_sens2_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens2_in2 CLK_100M ;
pos_wheel_d_sens3_in1__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens3_in1 CLK_100M ;
pos_wheel_d_sens3_in2__CLK_100M__setup:		SETUP (POSEDGE) wheel_d_sens3_in2 CLK_100M ;
pos_wheel_driver_do[0]__CLK_100M__setup:		SETUP (POSEDGE) wheel_driver_do[0] CLK_100M ;
pos_wheel_driver_do[1]__CLK_100M__setup:		SETUP (POSEDGE) wheel_driver_do[1] CLK_100M ;
pos_wheel_driver_do[2]__CLK_100M__setup:		SETUP (POSEDGE) wheel_driver_do[2] CLK_100M ;
pos_wheel_driver_do[3]__CLK_100M__setup:		SETUP (POSEDGE) wheel_driver_do[3] CLK_100M ;
pos_wheel_rod1_nc__CLK_100M__setup:		SETUP (POSEDGE) wheel_rod1_nc CLK_100M ;
pos_wheel_rod1_no__CLK_100M__setup:		SETUP (POSEDGE) wheel_rod1_no CLK_100M ;
pos_wheel_rod2_nc__CLK_100M__setup:		SETUP (POSEDGE) wheel_rod2_nc CLK_100M ;
pos_wheel_rod2_no__CLK_100M__setup:		SETUP (POSEDGE) wheel_rod2_no CLK_100M ;
pos_RST_N__CLK_100M__hold:		HOLD (POSEDGE) RST_N CLK_100M ;
pos_cs_n__CLK_100M__hold:		HOLD (POSEDGE) cs_n CLK_100M ;
pos_estop_btn1_nc__CLK_100M__hold:		HOLD (POSEDGE) estop_btn1_nc CLK_100M ;
pos_estop_btn1_no__CLK_100M__hold:		HOLD (POSEDGE) estop_btn1_no CLK_100M ;
pos_estop_btn2_nc__CLK_100M__hold:		HOLD (POSEDGE) estop_btn2_nc CLK_100M ;
pos_estop_btn2_no__CLK_100M__hold:		HOLD (POSEDGE) estop_btn2_no CLK_100M ;
pos_fan1_tacho__CLK_100M__hold:		HOLD (POSEDGE) fan1_tacho CLK_100M ;
pos_fan2_tacho__CLK_100M__hold:		HOLD (POSEDGE) fan2_tacho CLK_100M ;
pos_left_drape_close1_nc__CLK_100M__hold:		HOLD (POSEDGE) left_drape_close1_nc CLK_100M ;
pos_left_drape_close1_no__CLK_100M__hold:		HOLD (POSEDGE) left_drape_close1_no CLK_100M ;
pos_left_drape_close2_nc__CLK_100M__hold:		HOLD (POSEDGE) left_drape_close2_nc CLK_100M ;
pos_left_drape_close2_no__CLK_100M__hold:		HOLD (POSEDGE) left_drape_close2_no CLK_100M ;
pos_left_drape_em_state__CLK_100M__hold:		HOLD (POSEDGE) left_drape_em_state CLK_100M ;
pos_left_drape_open_nc__CLK_100M__hold:		HOLD (POSEDGE) left_drape_open_nc CLK_100M ;
pos_left_drape_open_no__CLK_100M__hold:		HOLD (POSEDGE) left_drape_open_no CLK_100M ;
pos_left_drape_sw_state__CLK_100M__hold:		HOLD (POSEDGE) left_drape_sw_state CLK_100M ;
pos_left_plunger_nc__CLK_100M__hold:		HOLD (POSEDGE) left_plunger_nc CLK_100M ;
pos_left_plunger_no__CLK_100M__hold:		HOLD (POSEDGE) left_plunger_no CLK_100M ;
pos_left_spare_diff_1__CLK_100M__hold:		HOLD (POSEDGE) left_spare_diff_1 CLK_100M ;
pos_left_tool_ex_nc__CLK_100M__hold:		HOLD (POSEDGE) left_tool_ex_nc CLK_100M ;
pos_left_tool_ex_no__CLK_100M__hold:		HOLD (POSEDGE) left_tool_ex_no CLK_100M ;
pos_mosi__CLK_100M__hold:		HOLD (POSEDGE) mosi CLK_100M ;
pos_pow__CLK_100M__hold:		HOLD (POSEDGE) pow CLK_100M ;
pos_right_drape_close1_nc__CLK_100M__hold:		HOLD (POSEDGE) right_drape_close1_nc CLK_100M ;
pos_right_drape_close1_no__CLK_100M__hold:		HOLD (POSEDGE) right_drape_close1_no CLK_100M ;
pos_right_drape_close2_nc__CLK_100M__hold:		HOLD (POSEDGE) right_drape_close2_nc CLK_100M ;
pos_right_drape_close2_no__CLK_100M__hold:		HOLD (POSEDGE) right_drape_close2_no CLK_100M ;
pos_right_drape_em_state__CLK_100M__hold:		HOLD (POSEDGE) right_drape_em_state CLK_100M ;
pos_right_drape_open_nc__CLK_100M__hold:		HOLD (POSEDGE) right_drape_open_nc CLK_100M ;
pos_right_drape_open_no__CLK_100M__hold:		HOLD (POSEDGE) right_drape_open_no CLK_100M ;
pos_right_drape_sw_state__CLK_100M__hold:		HOLD (POSEDGE) right_drape_sw_state CLK_100M ;
pos_right_plunger_nc__CLK_100M__hold:		HOLD (POSEDGE) right_plunger_nc CLK_100M ;
pos_right_plunger_no__CLK_100M__hold:		HOLD (POSEDGE) right_plunger_no CLK_100M ;
pos_right_spare_diff_1__CLK_100M__hold:		HOLD (POSEDGE) right_spare_diff_1 CLK_100M ;
pos_right_tool_ex_nc__CLK_100M__hold:		HOLD (POSEDGE) right_tool_ex_nc CLK_100M ;
pos_right_tool_ex_no__CLK_100M__hold:		HOLD (POSEDGE) right_tool_ex_no CLK_100M ;
pos_sclk__CLK_100M__hold:		HOLD (POSEDGE) sclk CLK_100M ;
pos_sp1_diff_pair_in[0]__CLK_100M__hold:		HOLD (POSEDGE) sp1_diff_pair_in[0] CLK_100M ;
pos_sp1_diff_pair_in[1]__CLK_100M__hold:		HOLD (POSEDGE) sp1_diff_pair_in[1] CLK_100M ;
pos_sp1_single_ended_1_0[0]__CLK_100M__hold:		HOLD (POSEDGE) sp1_single_ended_1_0[0] CLK_100M ;
pos_sp1_single_ended_1_0[1]__CLK_100M__hold:		HOLD (POSEDGE) sp1_single_ended_1_0[1] CLK_100M ;
pos_sp2_diff_pair_1_0[0]__CLK_100M__hold:		HOLD (POSEDGE) sp2_diff_pair_1_0[0] CLK_100M ;
pos_sp2_diff_pair_1_0[1]__CLK_100M__hold:		HOLD (POSEDGE) sp2_diff_pair_1_0[1] CLK_100M ;
pos_sp2_single_ended_1_0[0]__CLK_100M__hold:		HOLD (POSEDGE) sp2_single_ended_1_0[0] CLK_100M ;
pos_sp2_single_ended_1_0[1]__CLK_100M__hold:		HOLD (POSEDGE) sp2_single_ended_1_0[1] CLK_100M ;
pos_wheel_a_sens1_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens1_in1 CLK_100M ;
pos_wheel_a_sens1_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens1_in2 CLK_100M ;
pos_wheel_a_sens2_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens2_in1 CLK_100M ;
pos_wheel_a_sens2_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens2_in2 CLK_100M ;
pos_wheel_a_sens3_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens3_in1 CLK_100M ;
pos_wheel_a_sens3_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_a_sens3_in2 CLK_100M ;
pos_wheel_b_sens1_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens1_in1 CLK_100M ;
pos_wheel_b_sens1_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens1_in2 CLK_100M ;
pos_wheel_b_sens2_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens2_in1 CLK_100M ;
pos_wheel_b_sens2_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens2_in2 CLK_100M ;
pos_wheel_b_sens3_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens3_in1 CLK_100M ;
pos_wheel_b_sens3_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_b_sens3_in2 CLK_100M ;
pos_wheel_c_sens1_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens1_in1 CLK_100M ;
pos_wheel_c_sens1_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens1_in2 CLK_100M ;
pos_wheel_c_sens2_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens2_in1 CLK_100M ;
pos_wheel_c_sens2_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens2_in2 CLK_100M ;
pos_wheel_c_sens3_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens3_in1 CLK_100M ;
pos_wheel_c_sens3_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_c_sens3_in2 CLK_100M ;
pos_wheel_d_sens1_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens1_in1 CLK_100M ;
pos_wheel_d_sens1_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens1_in2 CLK_100M ;
pos_wheel_d_sens2_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens2_in1 CLK_100M ;
pos_wheel_d_sens2_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens2_in2 CLK_100M ;
pos_wheel_d_sens3_in1__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens3_in1 CLK_100M ;
pos_wheel_d_sens3_in2__CLK_100M__hold:		HOLD (POSEDGE) wheel_d_sens3_in2 CLK_100M ;
pos_wheel_driver_do[0]__CLK_100M__hold:		HOLD (POSEDGE) wheel_driver_do[0] CLK_100M ;
pos_wheel_driver_do[1]__CLK_100M__hold:		HOLD (POSEDGE) wheel_driver_do[1] CLK_100M ;
pos_wheel_driver_do[2]__CLK_100M__hold:		HOLD (POSEDGE) wheel_driver_do[2] CLK_100M ;
pos_wheel_driver_do[3]__CLK_100M__hold:		HOLD (POSEDGE) wheel_driver_do[3] CLK_100M ;
pos_wheel_rod1_nc__CLK_100M__hold:		HOLD (POSEDGE) wheel_rod1_nc CLK_100M ;
pos_wheel_rod1_no__CLK_100M__hold:		HOLD (POSEDGE) wheel_rod1_no CLK_100M ;
pos_wheel_rod2_nc__CLK_100M__hold:		HOLD (POSEDGE) wheel_rod2_nc CLK_100M ;
pos_wheel_rod2_no__CLK_100M__hold:		HOLD (POSEDGE) wheel_rod2_no CLK_100M ;
pos_CLK_100M__CLK100M_0UT__delay:		DELAY (POSEDGE) CLK_100M CLK100M_0UT ;
pos_CLK_100M__CLK100M_0UT__delay:		DELAY (POSEDGE) CLK_100M CLK100M_0UT ;
pos_CLK_100M__diag_activation__delay:		DELAY (POSEDGE) CLK_100M diag_activation ;
pos_CLK_100M__diagnostic_led[0]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[0] ;
pos_CLK_100M__diagnostic_led[1]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[1] ;
pos_CLK_100M__diagnostic_led[2]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[2] ;
pos_CLK_100M__diagnostic_led[3]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[3] ;
pos_CLK_100M__diagnostic_led[4]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[4] ;
pos_CLK_100M__diagnostic_led[5]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[5] ;
pos_CLK_100M__diagnostic_led[6]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[6] ;
pos_CLK_100M__diagnostic_led[7]__delay:		DELAY (POSEDGE) CLK_100M diagnostic_led[7] ;
pos_CLK_100M__estop_activation__delay:		DELAY (POSEDGE) CLK_100M estop_activation ;
pos_CLK_100M__estop_open__delay:		DELAY (POSEDGE) CLK_100M estop_open ;
pos_CLK_100M__fan1_pwm__delay:		DELAY (POSEDGE) CLK_100M fan1_pwm ;
pos_CLK_100M__fan2_pwm__delay:		DELAY (POSEDGE) CLK_100M fan2_pwm ;
pos_CLK_100M__led_r8__delay:		DELAY (POSEDGE) CLK_100M led_r8 ;
pos_CLK_100M__left_drape_em_open__delay:		DELAY (POSEDGE) CLK_100M left_drape_em_open ;
pos_CLK_100M__left_plunger_led1__delay:		DELAY (POSEDGE) CLK_100M left_plunger_led1 ;
pos_CLK_100M__left_plunger_led2__delay:		DELAY (POSEDGE) CLK_100M left_plunger_led2 ;
pos_CLK_100M__left_plunger_led3__delay:		DELAY (POSEDGE) CLK_100M left_plunger_led3 ;
pos_CLK_100M__left_spare_diff_2__delay:		DELAY (POSEDGE) CLK_100M left_spare_diff_2 ;
pos_CLK_100M__left_tool_ex_led1__delay:		DELAY (POSEDGE) CLK_100M left_tool_ex_led1 ;
pos_CLK_100M__left_tool_ex_led2__delay:		DELAY (POSEDGE) CLK_100M left_tool_ex_led2 ;
pos_CLK_100M__left_tool_ex_led3__delay:		DELAY (POSEDGE) CLK_100M left_tool_ex_led3 ;
pos_CLK_100M__miso__delay:		DELAY (POSEDGE) CLK_100M miso ;
pos_CLK_100M__right_drape_em_open__delay:		DELAY (POSEDGE) CLK_100M right_drape_em_open ;
pos_CLK_100M__right_plunger_led1__delay:		DELAY (POSEDGE) CLK_100M right_plunger_led1 ;
pos_CLK_100M__right_plunger_led2__delay:		DELAY (POSEDGE) CLK_100M right_plunger_led2 ;
pos_CLK_100M__right_plunger_led3__delay:		DELAY (POSEDGE) CLK_100M right_plunger_led3 ;
pos_CLK_100M__right_spare_diff_2__delay:		DELAY (POSEDGE) CLK_100M right_spare_diff_2 ;
pos_CLK_100M__right_tool_ex_led1__delay:		DELAY (POSEDGE) CLK_100M right_tool_ex_led1 ;
pos_CLK_100M__right_tool_ex_led2__delay:		DELAY (POSEDGE) CLK_100M right_tool_ex_led2 ;
pos_CLK_100M__right_tool_ex_led3__delay:		DELAY (POSEDGE) CLK_100M right_tool_ex_led3 ;
pos_CLK_100M__sp1_analog_switch[0]__delay:		DELAY (POSEDGE) CLK_100M sp1_analog_switch[0] ;
pos_CLK_100M__sp1_analog_switch[1]__delay:		DELAY (POSEDGE) CLK_100M sp1_analog_switch[1] ;
pos_CLK_100M__sp1_analog_switch[2]__delay:		DELAY (POSEDGE) CLK_100M sp1_analog_switch[2] ;
pos_CLK_100M__sp1_diff_pair_out[0]__delay:		DELAY (POSEDGE) CLK_100M sp1_diff_pair_out[0] ;
pos_CLK_100M__sp1_diff_pair_out[1]__delay:		DELAY (POSEDGE) CLK_100M sp1_diff_pair_out[1] ;
pos_CLK_100M__sp1_single_ended_2_3[0]__delay:		DELAY (POSEDGE) CLK_100M sp1_single_ended_2_3[0] ;
pos_CLK_100M__sp1_single_ended_2_3[1]__delay:		DELAY (POSEDGE) CLK_100M sp1_single_ended_2_3[1] ;
pos_CLK_100M__sp2_analog_switch[0]__delay:		DELAY (POSEDGE) CLK_100M sp2_analog_switch[0] ;
pos_CLK_100M__sp2_analog_switch[1]__delay:		DELAY (POSEDGE) CLK_100M sp2_analog_switch[1] ;
pos_CLK_100M__sp2_analog_switch[2]__delay:		DELAY (POSEDGE) CLK_100M sp2_analog_switch[2] ;
pos_CLK_100M__sp2_diff_pair_2_3[0]__delay:		DELAY (POSEDGE) CLK_100M sp2_diff_pair_2_3[0] ;
pos_CLK_100M__sp2_diff_pair_2_3[1]__delay:		DELAY (POSEDGE) CLK_100M sp2_diff_pair_2_3[1] ;
pos_CLK_100M__sp2_single_ended_2_3[0]__delay:		DELAY (POSEDGE) CLK_100M sp2_single_ended_2_3[0] ;
pos_CLK_100M__sp2_single_ended_2_3[1]__delay:		DELAY (POSEDGE) CLK_100M sp2_single_ended_2_3[1] ;
pos_CLK_100M__ssr_enable__delay:		DELAY (POSEDGE) CLK_100M ssr_enable ;
pos_CLK_100M__wheel_driver_abrt__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_abrt ;
pos_CLK_100M__wheel_driver_di[0]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[0] ;
pos_CLK_100M__wheel_driver_di[1]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[1] ;
pos_CLK_100M__wheel_driver_di[2]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[2] ;
pos_CLK_100M__wheel_driver_di[3]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[3] ;
pos_CLK_100M__wheel_driver_di[4]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[4] ;
pos_CLK_100M__wheel_driver_di[5]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[5] ;
pos_CLK_100M__wheel_driver_di[6]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[6] ;
pos_CLK_100M__wheel_driver_di[7]__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_di[7] ;
pos_CLK_100M__wheel_driver_elo__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_elo ;
pos_CLK_100M__wheel_driver_rst__delay:		DELAY (POSEDGE) CLK_100M wheel_driver_rst ;
pos_CLK_100M__wheel_forward_sw[0]__delay:		DELAY (POSEDGE) CLK_100M wheel_forward_sw[0] ;
pos_CLK_100M__wheel_forward_sw[1]__delay:		DELAY (POSEDGE) CLK_100M wheel_forward_sw[1] ;
pos_CLK_100M__wheel_forward_sw[2]__delay:		DELAY (POSEDGE) CLK_100M wheel_forward_sw[2] ;
pos_CLK_100M__wheel_forward_sw[3]__delay:		DELAY (POSEDGE) CLK_100M wheel_forward_sw[3] ;
pos_CLK_100M__wheel_home_sw[0]__delay:		DELAY (POSEDGE) CLK_100M wheel_home_sw[0] ;
pos_CLK_100M__wheel_home_sw[1]__delay:		DELAY (POSEDGE) CLK_100M wheel_home_sw[1] ;
pos_CLK_100M__wheel_home_sw[2]__delay:		DELAY (POSEDGE) CLK_100M wheel_home_sw[2] ;
pos_CLK_100M__wheel_home_sw[3]__delay:		DELAY (POSEDGE) CLK_100M wheel_home_sw[3] ;
pos_CLK_100M__wheel_reverse_sw[0]__delay:		DELAY (POSEDGE) CLK_100M wheel_reverse_sw[0] ;
pos_CLK_100M__wheel_reverse_sw[1]__delay:		DELAY (POSEDGE) CLK_100M wheel_reverse_sw[1] ;
pos_CLK_100M__wheel_reverse_sw[2]__delay:		DELAY (POSEDGE) CLK_100M wheel_reverse_sw[2] ;
pos_CLK_100M__wheel_reverse_sw[3]__delay:		DELAY (POSEDGE) CLK_100M wheel_reverse_sw[3] ;
pos_CLK_100M__CLK100K_OUT__delay:		DELAY (POSEDGE) CLK_100M CLK100K_OUT ;
pos_CLK_100M__CLK100K_OUT__delay:		DELAY (POSEDGE) CLK_100M CLK100K_OUT ;
pos_CLK_100M__led_r9__delay:		DELAY (POSEDGE) CLK_100M led_r9 ;

ENDMODEL
