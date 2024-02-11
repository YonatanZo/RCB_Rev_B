/////////////////////////////////////////////////////////
//	File			: spi_interface.v
//	Author			: Igor Dorman Trace PCB.
//	Date			: 30/08/2022
//	Description		: SPI Interface.
//	Revision		: 1.0
//	Hierarchy		: tb_rcb <- tester_rcb <- spi_test_model <-spi_interface
//	Last Update		: 26/09/2022
//////////////////////////////////////////////////////////
`timescale 1ns/10ps

module spi_interface(
	rst_n,
	sclk,
	cs_n,
	mosi,
	miso,
	spi_com,
	spi_addr,
	mosi_data,
	miso_data,
	spi_done,
	spi_run
);
input 			rst_n;
output			sclk;
output			cs_n;
output			mosi;
input 			miso;
input[7:0]		spi_com;
input[15:0]		spi_addr;
input[31:0]		mosi_data;
output[31:0]	miso_data;
output			spi_done;
input			spi_run;


`include "rcb_parameters.v"
`include "tb_parameters.v"

reg			mclk;
wire		sclk;
reg			cs_n;
reg			mosi;
wire		miso;
reg[3:0] 	state;
reg[5:0]	spi_packet_cnt;
reg[55:0]	spi_mosi;
reg			spi_done;
reg[31:0]	miso_data;
reg			receive_miso;
wire[7:0]	spi_com;
wire[15:0]	spi_addr;
wire[31:0]	mosi_data;

parameter
	IDLE			= 4'h0,
	COM_SEND		= 4'h1,
	ADDR_SEND		= 4'h2,
	DATA_SEND		= 4'h3,
	DATA_RECEIVE 	= 4'h4;
	
	
initial
begin
	//test_file = $fopen("../result/spi_report.txt"); 
	//broadcast = 1 | test_file; //send the report text to file and to display.
	mosi <= 1;
	spi_mosi <= 56'b0;
	spi_done <= 0;
	
	state = IDLE;
	
end
	
assign sclk = ~cs_n & mclk;

// ------- SPI clock generator ---------------//
initial  
begin:SPI_CLOCK
	mclk	<= 1'b0;
	#(4);
	forever #(SPI_PERIOD/2) mclk <= ~mclk;
end 

//----------- SPI Interface FSM ----------------//
always @(negedge mclk)
begin
	#(10);
	case(state)
		IDLE:
		begin
			spi_packet_cnt <= 0;
			spi_done <= 0;
			cs_n <= 1;
			spi_mosi <= 56'b0;
			mosi <= 1'b1;
			receive_miso <= 1'b0;
			if(spi_run)
			begin
				//spi_done <= 0;
				cs_n <= 0;
				{mosi,spi_mosi[55:0]} <= {spi_com[7:0],spi_addr[15:0],mosi_data[31:0],1'b1};
				spi_packet_cnt <= 0;
				state <= COM_SEND;
			end
			else
			begin
				state <= IDLE;
			end
		end
		COM_SEND:
		begin
			if(spi_packet_cnt < SPI_COM_LEN)
			begin
				{mosi,spi_mosi[55:0]} <= {spi_mosi[55:0],1'b1};
				state <= COM_SEND;
			end
			else
			begin
				{mosi,spi_mosi[55:0]} <= {spi_mosi[55:0],1'b1};
				state <= ADDR_SEND;
			end	
			spi_packet_cnt <= spi_packet_cnt + 1;
		end
		ADDR_SEND:
		begin
			if(spi_packet_cnt < SPI_ADDR_LEN)
			begin
				{mosi,spi_mosi[55:0]} <= {spi_mosi[55:0],1'b1};
				state <= ADDR_SEND;
				if((spi_packet_cnt == SPI_ADDR_LEN - 1) && (spi_com == 8'h0F))
					receive_miso <= 1'b1;
			end
			else if(spi_com == 8'h0F)
			begin
				mosi <= 1'b1;
				state <= DATA_RECEIVE;
			end
			else
			begin
				{mosi,spi_mosi[55:0]} <= {spi_mosi[55:0],1'b1};
				state <= DATA_SEND;
			end
			spi_packet_cnt <= spi_packet_cnt + 1;
		end
		DATA_SEND:
		begin
			if(spi_packet_cnt < SPI_DATA_LEN)
			begin
				{mosi,spi_mosi[55:0]} <= {spi_mosi[55:0],1'b1};
				state <= DATA_SEND;
				case(spi_packet_cnt)
					(SPI_DATA_LEN - 2):
						spi_done <= 1;
					(SPI_DATA_LEN - 1):
					begin
						spi_done <= 0;
						cs_n <= 1;
						mosi <= 1;
						state <= IDLE;
					end
				endcase
			end
			spi_packet_cnt <= spi_packet_cnt + 1;
		end
		DATA_RECEIVE:
		begin
			if(spi_packet_cnt < SPI_DATA_LEN)
			begin
				//miso_data[31:0] <= {miso_data[30:0],miso};
				state <= DATA_RECEIVE;
				case(spi_packet_cnt)
					(SPI_DATA_LEN - 2):
						spi_done <= 1;
					(SPI_DATA_LEN - 1):
					begin
						spi_done <= 0;
						cs_n <= 1;
						receive_miso <= 1'b0;
						//spi_done <= 1;
						state <= IDLE;
					end
				endcase
			end
			spi_packet_cnt <= spi_packet_cnt + 1;
		end
	endcase
end	

always @(posedge mclk)//, negedge rst_n)
	if(!rst_n)
		miso_data[31:0] <= 0;
	else
	begin
		if(receive_miso)
		begin
			miso_data[31:0] <= {miso_data[30:0],miso};
		end
	end	

endmodule

