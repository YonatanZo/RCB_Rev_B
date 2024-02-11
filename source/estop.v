////////////////////////////////////////////////////
//	File			: estop.v
//	Author			: Igor Dorman. tracePCB.
//	Date			: 19/10/2022
//	Description		: Test file for emulation in the DE10-Lite.
//	Revision		: 1.0
//	Hierarchy		:  
//	Last Update		: 19/10/2022 
////////////////////////////////////////////////////

module estop(
	//System signals
	clk_1m,
    rst_n,      	// low active synchronous reset

	//FPGA ESTOP Status
	estop_btn1_no,
	estop_btn2_no,
	//Activation(Close) SSR
	estop_activation,
	diag_activation,
	estop_open,
	teensy_activation,
	ssr_enable
);

input	clk_1m;
input	rst_n;     	// low active synchronous reset

//FPGA ESTOP Status
input		estop_btn1_no;
input		estop_btn2_no;
//Activation(Close) SSR
input		estop_activation;
input		diag_activation;
input		estop_open;
input		teensy_activation;
output		ssr_enable;

wire		delay_in;
reg[3:0]	delay_cnt;
reg			open_ssr;
reg			active_ssr;
wire		close_ssr;
wire		ssr_enable;

assign		delay_in = 	estop_btn1_no & estop_btn2_no & estop_open;

reg state_delay;
parameter
	IDLE_DELAY		= 1'b0,
    ACTIVE_DELAY	= 1'b1;

always @(posedge clk_1m, negedge rst_n)
    if(!rst_n)
	begin
		delay_cnt <= 0;
		open_ssr <= 1'b1;
	end
	else
	begin
		case(state_delay)
			IDLE_DELAY:
			begin
				if(!delay_in)
				begin
					open_ssr <= 1'b0;
					state_delay <= ACTIVE_DELAY;
				end
				else
				begin
					open_ssr <= 1'b1;
					delay_cnt	<= 4'h0;
					state_delay <= IDLE_DELAY;
				end					
			end
			ACTIVE_DELAY:
			begin
				if(delay_cnt < 4'hE)
				begin
					open_ssr <= 1'b0;
					delay_cnt <= delay_cnt + 1;
					state_delay <= ACTIVE_DELAY;
				end
				else
				begin
					open_ssr <= 1'b0;
					delay_cnt	<= 4'h0;
					state_delay <= IDLE_DELAY;
				end					
			end
		endcase
	end

assign close_ssr = !(estop_activation & teensy_activation);
	
always @*
begin
	case({open_ssr, close_ssr})
		2'b01:
			active_ssr = 1'b0;
		2'b10:
			active_ssr = 1'b1;
		2'b00:
			active_ssr = 1'b0;
		2'b10:
			active_ssr = active_ssr;
	endcase
end

assign ssr_enable = diag_activation | active_ssr;		


endmodule	

