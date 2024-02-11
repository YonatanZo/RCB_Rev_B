/////////////////////////////////////////////////////////
//	File			: rcb_spi
//	Author			: Igor Dorman. tracePCB.
//	Date			: 26/08/2022
//	Description		: SPI slave interface.
//	Revision		: 1.0
//	Hierarchy		: rcb_top <- rcb_spi
//////////////////////////////////////////////////////////

//THE SPI SLAVE MODULE SUPPORT ONLY SPI MODE 0 (CPOL=0, CPHA=0)!!!
module rcb_spi(
        clk_100m,       	// system clock
        rst_n,      // low active synchronous reset
        // SPI INTERFACE
        sclk,      	// SPI clock
        cs_n,     	// SPI chip select, active in low
        mosi,     	// SPI serial data from master to slave
        miso,     	// SPI serial data from slave to master
        // INTERNAL INTERFACE
        data_miso,     // data for transmission to SPI master
        data_mosi,     // received data from SPI master
        data_mosi_rdy, // when 1, received data are valid
		addr,
		addr_rdy
		//r_w
    );

`include  "rcb_parameters.v"		
	
input 			clk_100m; 
input 			rst_n;  
input 			sclk; 
input 			cs_n;
input 			mosi; 
output 			miso;
input[31:0]		data_miso;
output[31:0] 	data_mosi;
output 			data_mosi_rdy;
output[15:0] 	addr;
output 			addr_rdy;
//output 			r_w;


reg 		miso;
//reg[31:0] data_mosi;
reg 		data_mosi_rdy;
reg 		addr_rdy;
reg 		com_rdy;
reg 		sclk_reg;
reg 		sclk_meta;
reg 		spi_clk_reg;
wire 		sclk_negedge_en;
wire 		sclk_posedge_en;
wire[31:0]	data_mosi;
reg[15:0] 	addr;
reg[5:0] 	data_cnt;
//reg 		data_miso_rdy;
reg[55:0] 	shift_reg;
reg[31:0]	miso_shift;
reg			send_miso;
//reg 		cs_n_meta;
//reg 		cs_n_reg;
//reg 		mosi_meta;
//reg 		mosi_reg;
reg[1:0]	spi_mode;	//00-Write(0A), 01-Read(0F), else- undefined command, do write cycle without saving result.

//assign addr = shift_reg[15:0];
assign data_mosi = shift_reg[31:0];

always @(posedge clk_100m)
    if(!rst_n)
	begin
		sclk_reg  <= 1'b0;
		sclk_meta <= 1'b0;
	end
    else
	begin
		sclk_meta <= sclk;
		sclk_reg  <= sclk_meta;
		//cs_n_meta <= cs_n;
		//cs_n_reg  <= cs_n_meta;
		//mosi_meta <= mosi;
		//mosi_reg  <= mosi_meta;
	end


// -------------------------------------------------------------------------
//  SPI CLOCK REGISTER
// -------------------------------------------------------------------------
// The SPI clock register is necessary for clock edge detection.
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
		spi_clk_reg <= 1'b1;
    else
        spi_clk_reg <= ~sclk_reg;


// -------------------------------------------------------------------------
//  SPI CLOCK EDGES FLAGS
// -------------------------------------------------------------------------
// Falling edge is detect when sclk_reg=0 and spi_clk_reg=1.
assign sclk_negedge_en = ~sclk_reg & ~spi_clk_reg;
//-- Rising edge is detect when sclk_reg=1 and spi_clk_reg=0.
assign sclk_posedge_en = sclk_reg & spi_clk_reg;

reg[2:0] state,next_state;
parameter
	IDLE		= 0,
    CMD			= 1,
    ADDR		= 2,
	MOSI_DATA	= 3,
    MISO_DATA	= 4;
	//END_PACKET 	= 5;

//------------------- SPI FSM --------------------------	
always @(posedge clk_100m, negedge rst_n)
	if (!rst_n)
		state <= IDLE;
	else
	begin
		if(sclk_posedge_en)
			state <= next_state;
	end

always @*
	case(state)
		IDLE:
		begin
			if(cs_n)
				next_state = IDLE;
			else
				next_state = CMD;
		end	
		CMD:
			if(cs_n)
				next_state = IDLE;
			else if(com_rdy)
				next_state = ADDR;
			else
				next_state = CMD;
		ADDR:
			if(cs_n)
				next_state <= IDLE;
			else if(addr_rdy) 
				case(spi_mode)
					WRITE_MODE:
						next_state <= MOSI_DATA;
					READ_MODE:
						next_state <= MISO_DATA;
					default:	//UNDEF_MODE:
						next_state <= MOSI_DATA;//Undefined command. Write Cycle without saving result.
				endcase
			else
				next_state <= ADDR;
		MOSI_DATA:
			if(cs_n)
				next_state <= IDLE;
			else if(data_cnt == SPI_DATA_LEN - 1'b1)//(data_mosi_rdy)
				next_state <= IDLE;//END_PACKET;
			else
				next_state <= MOSI_DATA;			
		MISO_DATA:
			if(cs_n) 
				next_state <= IDLE;
			else if(data_cnt == (SPI_DATA_LEN - 1'b1))//(!send_miso)//data_miso_rdy)
				next_state <= IDLE;//END_PACKET;
			else
				next_state <= MISO_DATA;
/*		END_PACKET:
			if(cs_n)
				next_state <= IDLE;
			else
				next_state <= END_PACKET;*/
	endcase
 
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
	begin
		data_cnt 		<= 6'b0;
		addr_rdy 		<= 1'b0;
		com_rdy 		<= 1'b0;
		//data_mosi_rdy	<= 1'b0;
		//data_miso_rdy	<= 1'b0;
		miso 			<= 1'b1;
		shift_reg 		<= 56'b0;
		send_miso		<= 1'b0;
	end
	else
	begin
		if(sclk_posedge_en)
		begin
			shift_reg[55:0] <= {shift_reg[54:0], mosi};
			com_rdy 		<= 1'b0;
			addr_rdy 		<= 1'b0;
			//data_mosi_rdy	<= 1'b0;
			case(next_state)
				IDLE:
				begin
					data_cnt 		<= 6'b0;
					miso 			<= 1'b1;
					addr_rdy 		<= 1'b0;
					com_rdy 		<= 1'b0;
					//data_mosi_rdy 	<= 1'b0;
					//data_miso_rdy 	<= 1'b0;
					send_miso		<= 1'b0;
				end
				CMD:
				begin
					if(data_cnt == (SPI_COM_LEN - 1'b1))
					begin
						com_rdy <= 1'b1;
					end
					data_cnt <= data_cnt + 1'b1;
				end
				ADDR:
				begin
					if(data_cnt == SPI_ADDR_LEN - 1'b1)
					begin
						addr_rdy <= 1'b1;
						if(spi_mode == READ_MODE)
							send_miso <= 1'b1;
					end
					data_cnt <= data_cnt + 1'b1;
				end
				MOSI_DATA:
				begin
					if(data_cnt == SPI_DATA_LEN - 1'b1)
					begin
						data_cnt <= 6'b0;//data_cnt + 1'b1;
						if(spi_mode == WRITE_MODE)
						begin
							//data_mosi_rdy <= 1'b1;
							data_cnt <= 6'b0;
						end
					end
					else
						data_cnt <= data_cnt + 1'b1;
				end
				MISO_DATA:
				begin
					//{miso, shift_reg[31:1]} <= shift_reg[31:0];
					data_cnt <= data_cnt + 1'b1;
					if(data_cnt == (SPI_DATA_LEN - 1'b1))
					begin
						//data_miso_rdy <= 1'b1;
						send_miso <= 1'b0;
						miso <= 1'b1;
						data_cnt <= 6'b0;//data_cnt + 1'b1;
					end
					
				end
/*				END_PACKET:
				begin
					miso <= 1;
					data_cnt <= 6'b0;
				end*/
			endcase
		end
		else if(sclk_negedge_en && send_miso)
		begin
			if(addr_rdy)// && spi_mode == READ_MODE)
				{miso,miso_shift[31:0]} <= {data_miso,1'b0};
			else
				{miso,miso_shift[31:1]} <= miso_shift[31:0];
/*				
			if(data_cnt == (SPI_DATA_LEN - 1'b1))
				data_miso_rdy <= 1'b1;
			else
				data_miso_rdy <= 1'b0;*/
		end
	end
	
	
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
	begin	
		spi_mode <= UNDEF_MODE;
	end
	else
	begin
		if(com_rdy)// && sclk_negedge_en)
			case(shift_reg[7:0])
				WRITE_COM:
				begin
					spi_mode <= WRITE_MODE;
				end
				READ_COM:
				begin
					spi_mode <= READ_MODE;
				end
				default:
				begin
					spi_mode <= UNDEF_MODE;
				end
			endcase	
	end
	
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
		addr <= 16'hFFFF;
	else
		if(addr_rdy)// && sclk_negedge_en)
			addr <= shift_reg[15:0];
			
always @(posedge clk_100m, negedge rst_n)
    if(!rst_n)
		data_mosi_rdy <= 1'b0;
	else
	begin
		if((data_cnt == (SPI_DATA_LEN - 1'b1)) && (spi_mode == WRITE_MODE) && sclk_posedge_en)
			data_mosi_rdy <= 1'b1;
		else
			data_mosi_rdy <= 1'b0;
	end

	
endmodule	
			
