//////////////////////////////////////////////////////////////////////////
//	File			: rcb_tasks.v
//	Author			: Igor Dorman Trace PCB.
//	Date			: 26/09/2022
//	Description		: RCB Tasks File.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb <- tester_rcb <- rcb_test_model <- rcb_tests <- rcb_tasks
//	Last Update		: 18/10/2022 
/////////////////////////////////////////////////////////////////////////

task Register_Reset_Task;
integer i;
begin
	for(i=0;i<NUM_REG;i=i+1)
	begin
		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = i;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
/*		
		if(miso_data != {16'h0000,FPGA_MAJOR_VER,FPGA_REV})
			errors_test = errors_test + 1;
*/
	end
end
endtask


task Version_Register_Task;
reg temp;
begin
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_VER;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	temp = 1'bz;
	
	$fdisplay(broadcast,"\n miso data = %0h  ",miso_data);
	$fdisplay(broadcast,"\n data send = %0h ",FPGA_MAJOR_VER,FPGA_REV);
	
	if(miso_data != {16'h0000,FPGA_MAJOR_VER,FPGA_REV})
		errors_test = errors_test + 1;
		
	$fdisplay(broadcast,"\n errors = %0h ",errors_test);
end
endtask

task Revision_Data_Register_Task;
begin
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_REV_DATA;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	$fdisplay(broadcast,"\n miso data = %0h  ",miso_data);
	$fdisplay(broadcast,"\n data send = %0h ",{FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR});
	
	if(miso_data != {FPGA_REV_YEAR,FPGA_REV_MONTH,FPGA_REV_DAY,FPGA_REV_HOUR})
		errors_test = errors_test + 1;
		
	$fdisplay(broadcast,"\n errors = %0h ",errors_test);
end
endtask


task POW_Register_Task;
begin
	pow <= 1;
	#100;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_POW_DIAG;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000001)
		errors_test = errors_test + 1;
	
	pow <= 0;
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_POW_DIAG;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;
end
endtask

task FPGA_Buttons_Task;
	reg[7:0]	buttons;
	reg[7:0]	drape_buttons_reg;
	integer		i;
begin
	//all buttons high
	buttons = 8'hFF;
	{right_plunger_nc,right_plunger_no,left_plunger_nc,left_plunger_no,right_tool_ex_nc,
	right_tool_ex_no,left_tool_ex_nc,left_tool_ex_no} <= buttons;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h000000FF)
		errors_test = errors_test + 1;
		
	//all buttons low
	buttons = 8'h00;
	{right_plunger_nc,right_plunger_no,left_plunger_nc,left_plunger_no,right_tool_ex_nc,
	right_tool_ex_no,left_tool_ex_nc,left_tool_ex_no} <= buttons;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;

	//buttons step
	buttons = 8'h01;	
	for(i=0;i<8;i=i+1)
	begin
		{right_plunger_nc,right_plunger_no,left_plunger_nc,left_plunger_no,right_tool_ex_nc,
		right_tool_ex_no,left_tool_ex_nc,left_tool_ex_no} <= buttons;

		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_BUTTONS;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		drape_buttons_reg = {miso_data[7:0]};
		
		if(buttons != drape_buttons_reg)
			errors_test = errors_test + 1;
		
		buttons[7:0] = {buttons[6:0],1'b0};
	end
	
	//all buttons low
	buttons = 8'h00;
	{right_plunger_nc,right_plunger_no,left_plunger_nc,left_plunger_no,right_tool_ex_nc,
	right_tool_ex_no,left_tool_ex_nc,left_tool_ex_no} <= buttons;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;
		
end
endtask

task Drape_SW_Task;
	reg[1:0]	state;
	reg[1:0]	drape_sw_reg;
	integer		i;
begin
	//all state high
	state = 2'b11;
	{right_drape_sw_state,left_drape_sw_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h00000003)
		errors_test = errors_test + 1;
		
	//all state low
	state = 2'b00;
	{right_drape_sw_state,left_drape_sw_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;

	//state step
	state = 2'b01;	
	for(i=0;i<2;i=i+1)
	begin
		{right_drape_sw_state,left_drape_sw_state} <= state;

		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_STATE;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		drape_sw_reg = {miso_data[1:0]};
		
		if(drape_sw_reg != state)
			errors_test = errors_test + 1;
		
		state[1:0] = {state[0],1'b0};
	end
	
	//all state low
	state = 2'b00;
	{right_drape_sw_state,left_drape_sw_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;
		
end
endtask

task Drape_EM_Task;
	reg[1:0]	state;
	reg[1:0]	drape_em_reg;
	integer		i;
begin
	//all state high
	state = 2'b11;
	{right_drape_em_state,left_drape_em_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_EM_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h00000003)
		errors_test = errors_test + 1;
		
	//all state low
	state = 2'b00;
	{right_drape_em_state,left_drape_em_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_EM_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;

	//state step
	state = 2'b01;	
	for(i=0;i<2;i=i+1)
	begin
		{right_drape_em_state,left_drape_em_state} <= state;

		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_DRAPE_EM_STATE;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		drape_em_reg = {miso_data[1:0]};
		
		if(drape_em_reg != state)
			errors_test = errors_test + 1;
		
		state[1:0] = {state[0],1'b0};
	end
	
	//all state low
	state = 2'b00;
	{right_drape_em_state,left_drape_em_state} <= state;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_EM_STATE;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;
		
end
endtask

task Drape_SW_Approval_Task;
	reg[1:0] em;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'h00000101;//All Electomagnet Open
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	em = {right_drape_em_open,left_drape_em_open};
	
	$fdisplay(broadcast,"\n em = %0h  ",em);
	$fdisplay(broadcast,"\n drape em  = %0h ",2'b11);
	
	if(em != 2'b11)
		errors_test = errors_test + 1;
		
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	$fdisplay(broadcast,"\n miso data = %0h  ",miso_data);
	
	/*if(miso_data != 32'h00003F3F)
		errors_test = errors_test + 1;*/
/*	
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'h00000000;//All Electomagnet Close
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	em = {right_drape_em_open,left_drape_em_open};
	if(em != 2'b00)
		errors_test = errors_test + 1;
		
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'h00000001;//Left Electomagnet Open, Right - Close
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	em = {right_drape_em_open,left_drape_em_open};
	if(em != 2'b01)
		errors_test = errors_test + 1;
		
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'h00000100;//Left Electomagnet Close, Right - Open
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	em = {right_drape_em_open,left_drape_em_open};
	if(em != 2'b10)
		errors_test = errors_test + 1;
		
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SW_APPROVAL;
	mosi_data[31:0] = 32'h00000000;//All Electomagnet Close
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	em = {right_drape_em_open,left_drape_em_open};
	if(em != 2'b00)
		errors_test = errors_test + 1;
*/
end
endtask

task Drape_Sensor_Task;
	reg[11:0]	sensor;
	reg[11:0]	drape_sensor_reg;
	integer		i;
begin
	//all sensor high
	sensor = 12'hFFF;
	{right_drape_close2_nc,right_drape_close2_no,right_drape_close1_nc,right_drape_close1_no,
	right_drape_open_nc,right_drape_open_no,left_drape_close2_nc,left_drape_close2_no,
	left_drape_close1_nc,left_drape_close1_no,left_drape_open_nc,left_drape_open_no} <= sensor;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(miso_data != 32'h00003F3F)
		errors_test = errors_test + 1;
		
	//all sensor low
	sensor = 12'h000;
	{right_drape_close2_nc,right_drape_close2_no,right_drape_close1_nc,right_drape_close1_no,
	right_drape_open_nc,right_drape_open_no,left_drape_close2_nc,left_drape_close2_no,
	left_drape_close1_nc,left_drape_close1_no,left_drape_open_nc,left_drape_open_no} <= sensor;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;

	//sensor step
	sensor = 12'h001;	
	for(i=0;i<12;i=i+1)
	begin
		{right_drape_close2_nc,right_drape_close2_no,right_drape_close1_nc,right_drape_close1_no,
		right_drape_open_nc,right_drape_open_no,left_drape_close2_nc,left_drape_close2_no,
		left_drape_close1_nc,left_drape_close1_no,left_drape_open_nc,left_drape_open_no} <= sensor;

		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_DRAPE_SENSOR;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		drape_sensor_reg = {miso_data[13:8],miso_data[5:0]};
		
		if(drape_sensor_reg != sensor)
			errors_test = errors_test + 1;
		
		sensor[11:0] = {sensor[10:0],1'b0};
	end
	
	//all sensor low
	sensor = 12'h000;
	{right_drape_close2_nc,right_drape_close2_no,right_drape_close1_nc,right_drape_close1_no,
	right_drape_open_nc,right_drape_open_no,left_drape_close2_nc,left_drape_close2_no,
	left_drape_close1_nc,left_drape_close1_no,left_drape_open_nc,left_drape_open_no} <= sensor;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_DRAPE_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;
		
end
endtask
/*
task ESTOP_Button1_Task;
begin
	estop_btn1_no <= 0;
	#100;
	estop_btn1_nc <= 1;
	#1000;
	estop_btn1_no <= 1;
	#100;
	estop_btn1_nc <= 0;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_STATUS;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000001D)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_STATUS;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000011)
		errors_test = errors_test + 1;
end
endtask

task ESTOP_Button2_Task;
begin
	estop_btn2_no <= 0;
	#100;
	estop_btn2_nc <= 1;
	#1000;
	estop_btn2_no <= 1;
	#100;
	estop_btn2_nc <= 0;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_STATUS;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h000000D1)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_STATUS;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00000011)
		errors_test = errors_test + 1;
end
endtask
*/
task Buttons_Led_Task;
	integer 	i,j;
	reg[11:0]	leds;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS_LED;
	mosi_data[31:0] = 32'hFFFFFFFF;//All leds on	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	leds = {right_tool_ex_led3,right_tool_ex_led2,right_tool_ex_led1,left_tool_ex_led3,
		left_tool_ex_led2,left_tool_ex_led1,right_plunger_led3,right_plunger_led2,
		right_plunger_led1,left_plunger_led3,left_plunger_led2,left_plunger_led1};
	if(leds != 12'hFFF)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS_LED;
	mosi_data[31:0] = 32'h00000000;	//All leds off
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	leds = {right_tool_ex_led3,right_tool_ex_led2,right_tool_ex_led1,left_tool_ex_led3,
		left_tool_ex_led2,left_tool_ex_led1,right_plunger_led3,right_plunger_led2,
		right_plunger_led1,left_plunger_led3,left_plunger_led2,left_plunger_led1};
	if(leds != 12'h000)
		errors_test = errors_test + 1;
	
	mosi_data[31:0] <= 32'b1;
	j=0;
	for(i=0;i<15;i=i+1)
	begin
	#500;
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_BUTTONS_LED;
		if(i==3 || i==7 || i==11)
			;
		else
		begin
			spi_run = 1;
			wait(spi_done);
			spi_run = 0;
			wait(!spi_done);
			leds = {right_tool_ex_led3,right_tool_ex_led2,right_tool_ex_led1,left_tool_ex_led3,
			left_tool_ex_led2,left_tool_ex_led1,right_plunger_led3,right_plunger_led2,
			right_plunger_led1,left_plunger_led3,left_plunger_led2,left_plunger_led1};
			if(leds != (1'b1<<j))
				errors_test = errors_test + 1;
			j=j+1;
		end
		mosi_data[31:0] = {mosi_data[30:0],1'b0};
	end//for
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_BUTTONS_LED;
	mosi_data[31:0] = 32'h00000000;	//All leds off
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	leds = {right_tool_ex_led3,right_tool_ex_led2,right_tool_ex_led1,left_tool_ex_led3,
		left_tool_ex_led2,left_tool_ex_led1,right_plunger_led3,right_plunger_led2,
		right_plunger_led1,left_plunger_led3,left_plunger_led2,left_plunger_led1};
	if(leds != 12'h000)
		errors_test = errors_test + 1;
end
endtask

task Wheel_Driver_Out_Task;
	reg[19:0]	wheel_drv_out;
	integer		i;//,j;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_OUT;
	mosi_data[31:0] = 32'h000FFFFF;//All wheel out 1	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_out = {wheel_home_sw,wheel_reverse_sw,wheel_forward_sw,wheel_driver_di};
	
	if(wheel_drv_out != 20'hFFFFF)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_OUT;
	mosi_data[31:0] = 32'h00000000;	//All wheel out 0
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_out = {wheel_home_sw,wheel_reverse_sw,wheel_forward_sw,wheel_driver_di};
	
	if(wheel_drv_out != 20'h00000)
		errors_test = errors_test + 1;
	
	mosi_data[31:0] <= 32'b1;
	for(i=0;i<20;i=i+1)
	begin
	#500;
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_OUT;
		mosi_data[31:0] = mosi_data;
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);

		wheel_drv_out = {wheel_home_sw,wheel_reverse_sw,wheel_forward_sw,wheel_driver_di};
		
		if(wheel_drv_out != (1'b1<<i))
			errors_test = errors_test + 1;

		mosi_data[31:0] = {mosi_data[30:0],1'b0};
	end//for
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_OUT;
	mosi_data[31:0] = 32'h00000000;	//All wheel out 0
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_out = {wheel_home_sw,wheel_reverse_sw,wheel_forward_sw,wheel_driver_di};
	
	if(wheel_drv_out != 20'h00000)
		errors_test = errors_test + 1;
end
endtask
/*
task Wheel_Driver_ELO_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ELO;
	mosi_data[31:0] = 32'h00000001;//All wheel out 1	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(wheel_driver_elo != 1'b1)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ELO;
	mosi_data[31:0] = 32'h00000000;	//All wheel out 0
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	if(wheel_driver_elo != 1'b0)
		errors_test = errors_test + 1;

end
endtask
*/
task Wheel_Driver_ABRT_Task;
	reg[1:0]	wheel_drv_abrt;
	integer		i;//,j;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ABRT;
	mosi_data[31:0] = 32'h00000003;//All wheel out 1	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_abrt = {wheel_driver_rst,wheel_driver_abrt};
	
	if(wheel_drv_abrt != 2'b11)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ABRT;
	mosi_data[31:0] = 32'h00000000;	//All wheel out 0
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_abrt = {wheel_driver_rst,wheel_driver_abrt};
	
	if(wheel_drv_abrt != 2'b00)
		errors_test = errors_test + 1;
	
	mosi_data[31:0] <= 32'b1;
	for(i=0;i<2;i=i+1)
	begin
	#500;
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ABRT;
		mosi_data[31:0] = mosi_data;
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);

		wheel_drv_abrt = {wheel_driver_rst,wheel_driver_abrt};
		
		if(wheel_drv_abrt != (1'b1<<i))
			errors_test = errors_test + 1;

		mosi_data[31:0] = {mosi_data[30:0],1'b0};
	end//for
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_ABRT;
	mosi_data[31:0] = 32'h00000000;	//All wheel out 0
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	wheel_drv_abrt = {wheel_driver_rst,wheel_driver_abrt};
	
	if(wheel_drv_abrt != 2'b00)
		errors_test = errors_test + 1;
end
endtask

task Wheel_Driver_In_Task;
	reg[3:0]	wheel_do;
	integer		i;
begin
	//all high
	wheel_do = 4'hF;
	wheel_driver_do <= wheel_do;
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_IN;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000F)
		errors_test = errors_test + 1;
		
	//all low	
	wheel_do = 4'b0;
	wheel_driver_do <= wheel_do;
	
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_IN;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
		
	//wheel sensor step	
	wheel_do = 4'h1;
	for(i=0;i<4;i=i+1)
	begin
		wheel_driver_do <= wheel_do;
		#500;
		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_IN;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		if(miso_data != 1'b1<<i)
			errors_test = errors_test + 1;
			
		wheel_do[3:0] = {wheel_do[2:0],1'b0};
	end
	
	//all low	
	wheel_do = 4'b0;
	wheel_driver_do <= wheel_do;
	
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_DRIVER_IN;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
end
endtask

task Wheel_Sensor_Task;
	reg[23:0]	wheel;
	integer		i;
begin
	//all wheel sensor  high
	wheel = 24'hFFFFFF;
	{wheel_d_sens3_in2,wheel_d_sens3_in1,wheel_d_sens2_in2,
	wheel_d_sens2_in1,wheel_d_sens1_in2,wheel_d_sens1_in1,	
	wheel_c_sens3_in2,wheel_c_sens3_in1,wheel_c_sens2_in2,
	wheel_c_sens2_in1,wheel_c_sens1_in2,wheel_c_sens1_in1,
	wheel_b_sens3_in2,wheel_b_sens3_in1,wheel_b_sens2_in2,
	wheel_b_sens2_in1,wheel_b_sens1_in2,wheel_b_sens1_in1,	
	wheel_a_sens3_in2,wheel_a_sens3_in1,wheel_a_sens2_in2,	
	wheel_a_sens2_in1,wheel_a_sens1_in2,wheel_a_sens1_in1} <= wheel;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h00FFFFFF)
		errors_test = errors_test + 1;
		
	//all wheel sensor low	
	wheel = 24'b0;
	{wheel_d_sens3_in2,wheel_d_sens3_in1,wheel_d_sens2_in2,
	wheel_d_sens2_in1,wheel_d_sens1_in2,wheel_d_sens1_in1,	
	wheel_c_sens3_in2,wheel_c_sens3_in1,wheel_c_sens2_in2,
	wheel_c_sens2_in1,wheel_c_sens1_in2,wheel_c_sens1_in1,
	wheel_b_sens3_in2,wheel_b_sens3_in1,wheel_b_sens2_in2,
	wheel_b_sens2_in1,wheel_b_sens1_in2,wheel_b_sens1_in1,	
	wheel_a_sens3_in2,wheel_a_sens3_in1,wheel_a_sens2_in2,	
	wheel_a_sens2_in1,wheel_a_sens1_in2,wheel_a_sens1_in1} <= wheel;
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
		
	//wheel sensor step	
	wheel = 24'h000001;
	for(i=0;i<24;i=i+1)
	begin
		{wheel_d_sens3_in2,wheel_d_sens3_in1,wheel_d_sens2_in2,
		wheel_d_sens2_in1,wheel_d_sens1_in2,wheel_d_sens1_in1,	
		wheel_c_sens3_in2,wheel_c_sens3_in1,wheel_c_sens2_in2,
		wheel_c_sens2_in1,wheel_c_sens1_in2,wheel_c_sens1_in1,
		wheel_b_sens3_in2,wheel_b_sens3_in1,wheel_b_sens2_in2,
		wheel_b_sens2_in1,wheel_b_sens1_in2,wheel_b_sens1_in1,	
		wheel_a_sens3_in2,wheel_a_sens3_in1,wheel_a_sens2_in2,	
		wheel_a_sens2_in1,wheel_a_sens1_in2,wheel_a_sens1_in1} <= wheel;
		#500;
		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_WHEEL_SENSOR;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		if(miso_data != 1'b1<<i)
			errors_test = errors_test + 1;
			
		wheel[23:0] = {wheel[22:0],1'b0};
	end
	
	//all wheel sensor low	
	wheel = 24'b0;
	{wheel_d_sens3_in2,wheel_d_sens3_in1,wheel_d_sens2_in2,
	wheel_d_sens2_in1,wheel_d_sens1_in2,wheel_d_sens1_in1,	
	wheel_c_sens3_in2,wheel_c_sens3_in1,wheel_c_sens2_in2,
	wheel_c_sens2_in1,wheel_c_sens1_in2,wheel_c_sens1_in1,
	wheel_b_sens3_in2,wheel_b_sens3_in1,wheel_b_sens2_in2,
	wheel_b_sens2_in1,wheel_b_sens1_in2,wheel_b_sens1_in1,	
	wheel_a_sens3_in2,wheel_a_sens3_in1,wheel_a_sens2_in2,	
	wheel_a_sens2_in1,wheel_a_sens1_in2,wheel_a_sens1_in1} <= wheel;
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_SENSOR;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
end
endtask

task Diagnoctic_Leds_Task;
	integer 	i;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DIAGNOSTIC_LEDS;
	mosi_data[31:0] = 32'hFFFFFFFF;//All leds on	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(diagnostic_led != 8'hFF)
		errors_test = errors_test + 1;
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DIAGNOSTIC_LEDS;
	mosi_data[31:0] = 32'h00000000;	//All leds off
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(diagnostic_led != 8'h00)
		errors_test = errors_test + 1;
	
	mosi_data[31:0] <= 32'b1;

	for(i=0;i<7;i=i+1)
	begin
	#500;
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_DIAGNOSTIC_LEDS;
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);

		if(diagnostic_led != (1'b1<<i))
			errors_test = errors_test + 1;

		mosi_data[31:0] = {mosi_data[30:0],1'b0};
	end//for
	
	#500;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_DIAGNOSTIC_LEDS;
	mosi_data[31:0] = 32'h00000000;	//All leds off
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(diagnostic_led != 8'h00)
		errors_test = errors_test + 1;
end
endtask

task Wheel_Rod_Sensor_Task;
	reg[3:0]	wheel;
	integer		i;
begin
	//all wheel sensor  high
	wheel = 4'hF;
	{wheel_rod2_out1,wheel_rod2_out2,wheel_rod1_out1,wheel_rod1_out2} <= wheel;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_ROD;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000F)
		errors_test = errors_test + 1;
		
	//all wheel sensor low	
	wheel = 4'h0;
	{wheel_rod2_out1,wheel_rod2_out2,wheel_rod1_out1,wheel_rod1_out2} <= wheel;
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_ROD;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
		
	//wheel sensor step	
	wheel = 4'h1;
	for(i=0;i<4;i=i+1)
	begin
		{wheel_rod2_out1,wheel_rod2_out2,wheel_rod1_out1,wheel_rod1_out2} <= wheel;
		#500;
		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_WHEEL_ROD;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		if(miso_data != 1'b1<<i)
			errors_test = errors_test + 1;
			
		wheel[3:0] = {wheel[2:0],1'b0};
	end
	
	//all wheel sensor low	
	wheel = 4'h0;
	{wheel_rod2_out1,wheel_rod2_out2,wheel_rod1_out1,wheel_rod1_out2} <= wheel;
	#500;
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_WHEEL_ROD;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	if(miso_data != 32'h0000000)
		errors_test = errors_test + 1;
end
endtask

/*
task ESTOP_Activation_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_ACTIVATION;
	mosi_data[31:0] = 32'h00000001;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	wait(estop_activation);

	wait(!estop_activation);
	
	#1000;
	//if(estop_activation != 1'b0)
		//errors_test = errors_test + 1;
end
endtask
*/

task ESTOP_Diag_Activation_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_ACTIVATION;
	mosi_data[31:0] = 32'h80000000;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_DIAGNOSTIC;
	mosi_data[31:0] = ESTOP_DIAG_ACTIV;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	#500
	if(diag_activation == 1'b0)
		errors_test = errors_test + 1;
	
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_ACTIVATION;
	mosi_data[31:0] = 32'h00000000;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	#500
	if(diag_activation == 1'b1)
		errors_test = errors_test + 1;
		
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_DIAGNOSTIC;
	mosi_data[31:0] = 32'h00000000;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	#500
	if(diag_activation == 1'b1)
		errors_test = errors_test + 1;

end
endtask

task Spare_IO_Task;
reg[13:0] spare_in_reg;
reg[13:0] spare_out_reg;
integer i;
begin
	//All bits "1"
	{sp2_single_ended_1_0,sp2_diff_pair_1_0,sp1_single_ended_1_0,sp1_diff_pair_1_0} <= 8'hFF;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'hFFFFFFFF;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(miso_data != 32'h003FFFFF)//22'b1100111110011001111100)
		errors_test = errors_test + 1;
		
	//All bits "0"
	{sp2_single_ended_1_0,sp2_diff_pair_1_0,sp1_single_ended_1_0,sp1_diff_pair_1_0} <= 8'h00;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'h00000000;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;

	
	spare_in_reg = 14'b0;
	spare_out_reg = 14'b1;
	for(i=0;i<8;i=i+1)
	begin
		{sp2_single_ended_1_0,sp2_diff_pair_1_0,sp1_single_ended_1_0,sp1_diff_pair_1_0} = spare_out_reg;
		#500
		spi_com[7:0] = READ_COM;
		spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
		mosi_data[31:0] = 32'hFFFFFFFF;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		#500
		spare_in_reg = {miso_data[19:18],miso_data[12:11],miso_data[8:7],miso_data[1:0]};
		
		if(spare_in_reg != spare_out_reg)//1'b1<<i)
			errors_test = errors_test + 1;
		
		#300
		spare_out_reg[13:0] = {spare_out_reg[12:0],1'b0};
	end		

	spare_in_reg = 14'b0;
	spare_out_reg = 14'b1;
	for(i=0;i<14;i=i+1)
	begin
		mosi_data = {spare_out_reg[13:12],2'b0,spare_out_reg[11:7],2'b0,
					spare_out_reg[6:5],2'b0,spare_out_reg[4:0],2'b0};	
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
		//mosi_data[31:0] = 32'h00000000;
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
		
		#500
		spare_in_reg = {sp2_single_ended_2_3,sp2_analog_switch,sp2_diff_pair_2_3,
						sp1_single_ended_2_3,sp1_analog_switch,sp1_diff_pair_2_3};
		
		if(spare_in_reg != spare_out_reg)//1'b1<<i)
			errors_test = errors_test + 1;
		
		#300
		spare_out_reg[13:0] = {spare_out_reg[12:0],1'b0};
	end

	//All bits "0"
	{sp2_single_ended_1_0,sp2_diff_pair_1_0,sp1_single_ended_1_0,sp1_diff_pair_1_0} <= 8'h00;
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'h00000000;
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_SPARE_IO;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);

	if(miso_data != 32'h00000000)
		errors_test = errors_test + 1;

end
endtask

/*
task ESTOP_Circuit_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_ESTOP_ACTIVATION;
	mosi_data[31:0] = 32'h00000001;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	wait(!estop_activation);

	wait(estop_activation);
	if(estop_activation != 1'b0)
		errors_test = errors_test + 1;
end
endtask
*/


task FAN1_PWM_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_FAN1_PWM;
	mosi_data[31:0] = 32'h00000010;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	wait(fan1_pwm);
	wait(!fan1_pwm);
	wait(fan1_pwm);
	wait(!fan1_pwm);
	/*if(estop_activation != 1'b0)
		errors_test = errors_test + 1;*/
end
endtask

task FAN2_PWM_Task;
begin
	spi_com[7:0] = WRITE_COM;
	spi_addr[15:0] = ADDR_FPGA_FAN2_PWM;
	mosi_data[31:0] = 32'h00000080;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	wait(fan2_pwm);
	wait(!fan2_pwm);
	wait(fan2_pwm);
	wait(!fan2_pwm);
	/*if(estop_activation != 1'b0)
		errors_test = errors_test + 1;*/
end
endtask


task FAN1_Tacho_Task;
integer i;
begin
	for(i=0;i<25;i=i+1)
	begin	
		wait(fan1_tacho);
		wait(!fan1_tacho);
	end
		
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_FAN1_TACHO;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	$fdisplay(broadcast,"\n miso = %0h",miso_data);
	
	if((miso_data != 32'h00010015) && (miso_data != 32'h00010014))
		errors_test = errors_test + 1;
end
endtask

task FAN2_Tacho_Task;
integer i;
begin
	for(i=0;i<25;i=i+1)
	begin	
		wait(fan2_tacho);
		wait(!fan2_tacho);
	end
		
	spi_com[7:0] = READ_COM;
	spi_addr[15:0] = ADDR_FPGA_FAN1_TACHO;
	mosi_data[31:0] = 32'hFFFFFFFF;	
	spi_run = 1;
	wait(spi_done);
	spi_run = 0;
	wait(!spi_done);
	
	$fdisplay(broadcast,"\n miso = %0h",miso_data);
	
	if((miso_data != 32'h00010015) && (miso_data != 32'h00010014))
		errors_test = errors_test + 1;
end
endtask
/*
`ifdef ESTOP_CIRCUIT
  `ifdef ESTOP_TEST
	task Estop_Task;
		//ESTOP Activation
		if(ssr_enable != 1'b0)	//Check SSR Enable = 0
			errors_test = errors_test + 1;
		
		teensy_activation <= 1'b1;
		spi_com[7:0] = WRITE_COM;
		spi_addr[15:0] = ADDR_FPGA_ESTOP_ACTIVATION;
		mosi_data[31:0] = 32'h00000001;	
		spi_run = 1;
		wait(spi_done);
		spi_run = 0;
		wait(!spi_done);
	
		wait(estop_activation);
		
		#1000
		if(ssr_enable != 1'b1)//Check SSR Enable = 1
			errors_test = errors_test + 1;
		
		wait(!estop_activation);
	
	#100
	if(ssr_enable != 1'b1)//Check SSR Enable = 1
		errors_test = errors_test + 1;

	endtask
  `endif
 `endif
*/
task Check_Errors;
begin
	if(errors_test)
		$fdisplay(broadcast,"\n!!!!!!!!!!!!!!!!! %0s Test is FAULTY at %.0f ns, Quantity of Errors = %0d !!!!!!!!!!!!!!!",tests,$time,errors_test);
	else 
		$fdisplay(broadcast,"########## %0s Test is passed O.K. at %.0f ns ",tests,$time);
end
endtask //check_errors

task Finish_Tests;
begin
	$fdisplay(broadcast,"\n****************************************************");
	
	if(errors_counter) 
	begin
		$fdisplay(broadcast,"******  TEST !!!FAULTY!!! AT %.0f ns, Quantity of Errors = %0d",$time,errors_counter);
		//$fdisplay(broadcast,"****** Quantity errors of Duplex Test =  %0d",errors_duplex);
	end
	else   
	begin
		$fdisplay(broadcast,"****** FULL TEST WAS PASSED O.K. AT %.0f ns ******",$time);
	end
	
	$fdisplay(broadcast,"****************************************************");
	
	$fclose (broadcast);
end
endtask //Finish_Test
