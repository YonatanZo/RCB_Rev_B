
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_TOP is
	port (
		CLK			: in  std_logic := '0';
		RST_N			: in  std_logic := '0';
		RXD_4MB		: in  std_logic := '0';
		RXD_M5B		: in  std_logic := '0';
		RXD_EFF		: in  std_logic := '0';
		TXD_TEENSY	: out std_logic
	);
end entity UART_TOP;

architecture rtl of UART_TOP is
constant RX_RATE : Integer:= 10_000_000 ;	
constant UART_CLK : Integer:= 200_000_000 ;
constant TX_RATE : Integer:= 20_000_000 ;		
	COMPONENT UART
	GENERIC ( CLK_FREQ : INTEGER := 100000000; BAUD_RATE : INTEGER := 10000000; PARITY_BIT : STRING := "none"; USE_DEBOUNCER : boolean := true );
	PORT
	(
		CLK		:	 IN STD_LOGIC;
		RST		:	 IN STD_LOGIC;
		UART_TXD		:	 OUT STD_LOGIC;
		UART_RXD		:	 IN STD_LOGIC;
		DIN		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		DIN_VLD		:	 IN STD_LOGIC;
		DIN_RDY		:	 OUT STD_LOGIC;
		DOUT		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		DOUT_VLD		:	 OUT STD_LOGIC;
		FRAME_ERROR		:	 OUT STD_LOGIC;
		PARITY_ERROR		:	 OUT STD_LOGIC
	);
END COMPONENT;
    component RX_Slave is
        Port (
            clk           : in std_logic;
            resetn        : in std_logic;
            clr_rdy       : in std_logic; -- TX_Master I/F
		    clr_err		  : in std_logic;
            avalon_data   : in std_logic_vector(7 downto 0); -- Avalon UART receiver I/F
            avalon_valid  : in std_logic;
            avalon_ready  : out std_logic;
            avalon_error  : in std_logic;
            fifo_write    : out std_logic; -- FIFO I/F
            data_in       : out std_logic_vector(7 downto 0);
            fifo_full     : in std_logic;
            err           : out std_logic;
            rdy           : out std_logic
        );
    end component RX_Slave;


component TX_Master is
    Port (
        clk : in std_logic;
        resetn : in std_logic;
		  --RX_SLAVE0_I/F 
		  tx_rdy0 : in std_logic;
		  tx_err0 : in std_logic;
		  data_0 : in std_logic_vector(7 downto 0);
		  clr_rdy_0 : out std_logic;
		  clr_err0  : out std_logic;
		  --RX_SLAVE1_I/F 
		  tx_rdy1 : in std_logic;
		  tx_err1 : in std_logic;
		  data_1 : in std_logic_vector(7 downto 0);
		  clr_rdy_1 : out std_logic;
		  clr_err1  : out std_logic;
		  --RX_SLAVE2_I/F 
		  tx_rdy2 : in std_logic;
		  tx_err2 : in std_logic;
		  data_2 : in std_logic_vector(7 downto 0);
		  clr_rdy_2 : out std_logic;
		  clr_err2  : out std_logic;
		  --RX_FIFO0_I/F 
		  clr_FIFO_0 : out std_logic;
		  rd_FIFO_0 : out std_logic;
		  FIFO_usedw0 : in std_logic_vector(8 downto 0);
		  --RX_FIFO1_I/F 
		  clr_FIFO_1 : out std_logic;
		  rd_FIFO_1 : out std_logic;
		  FIFO_usedw1 : in std_logic_vector(8 downto 0);
		  --RX_FIFO2_I/F 
		  clr_FIFO_2 : out std_logic;
		  rd_FIFO_2 : out std_logic;
		  FIFO_usedw2 : in std_logic_vector(8 downto 0);
		  --TX_UART_I/F                       
		  rs232_0_to_uart_data    : out  std_logic_vector(7 downto 0); 
		  rs232_0_to_uart_error   : out  std_logic;
		  rs232_0_to_uart_valid   : out  std_logic;
		  rs232_0_to_uart_ready   : in std_logic
    );
end component TX_Master;
	 
	component RX_FIFO
		PORT
	(
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		rdreq		: IN STD_LOGIC ;
		sclr		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		empty		: OUT STD_LOGIC ;
		full		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		usedw		: OUT STD_LOGIC_VECTOR (8 DOWNTO 0)
	);
	end component;


    -- Declare signals for RX_UART component
    signal avalon_ready0, avalon_ready1, avalon_ready2 : std_logic;
    signal avalon_data0, avalon_data1, avalon_data2 : std_logic_vector(7 downto 0);
    signal avalon_error0, avalon_error1, avalon_error2 : std_logic;
    signal avalon_valid0, avalon_valid1, avalon_valid2 : std_logic;
    
    -- Declare signals for RX_Slave components
    signal clr_rdy_0, clr_rdy_1, clr_rdy_2 : std_logic;
    signal fifo_write0, fifo_write1, fifo_write2 : std_logic;
    signal data_in0, data_in1, data_in2 : std_logic_vector(7 downto 0);
    signal fifo_full0, fifo_full1, fifo_full2 : std_logic;
    signal tx_err0, tx_err1, tx_err2 : std_logic;
    signal tx_rdy0, tx_rdy1, tx_rdy2 : std_logic;
    signal clr_err0,clr_err1,clr_err2 : std_logic;
    -- Declare signals for RX_FIFO components
    signal clr_FIFO_0, clr_FIFO_1, clr_FIFO_2 : std_logic;
    signal rd_FIFO_0, rd_FIFO_1, rd_FIFO_2 : std_logic;
    signal FIFO_usedw0, FIFO_usedw1, FIFO_usedw2 : std_logic_vector(8 downto 0);
    signal FIFO_q0, FIFO_q1, FIFO_q2 : std_logic_vector(7 downto 0);
    
    -- Declare signals for TX_UART component
    signal TEENSY_UART_DATA : std_logic_vector(7 downto 0);
    signal TEENSY_UART_ERROR : std_logic;
    signal TEENSY_UART_VALID : std_logic;
    signal TEENSY_UART_RDY : std_logic;
    signal RST : std_logic;


begin

		RST <= not RST_N;

      RX_UART0 : component UART
		GENERIC MAP( CLK_FREQ => UART_CLK,
					BAUD_RATE => RX_RATE,
					PARITY_BIT => "none",
					USE_DEBOUNCER => true )
		
		port map (
				CLK                                  => CLK,      -->EVM 50MHz                    
				RST                            => RST,    -->SW[0]                     
				
				UART_TXD                         => open,  -->GPIO[0]                       
				UART_RXD                  => RXD_4MB,  -->RX_Slave0                 
				DIN                   => (others => '0'),   -->RX_Slave0                
				DIN_VLD                  => '0',  -->RX_Slave0               
				DIN_RDY                  => open,  -->RX_Slave0
							
				DOUT              => avalon_data0,  -->GPIO[1]     
				DOUT_VLD    => avalon_valid0,  -->RX_Slave1
				FRAME_ERROR     => avalon_error0,   -->RX_Slave1
				PARITY_ERROR    => open
		);
		
      RX_UART1 : component UART
		GENERIC MAP( CLK_FREQ => UART_CLK,
					BAUD_RATE => RX_RATE,
					PARITY_BIT => "none",
					USE_DEBOUNCER => true )
		port map (
				CLK                                  => CLK,      -->EVM 50MHz                    
				RST                            => RST,    -->SW[0]                     
				
				UART_TXD                         => open,  -->GPIO[0]                       
				UART_RXD                  => RXD_M5B,  -->RX_Slave0                 
				DIN                   => (others => '0'),   -->RX_Slave0                
				DIN_VLD                  => '0',  -->RX_Slave0               
				DIN_RDY                  => open,  -->RX_Slave0
							
				DOUT              => avalon_data1,  -->GPIO[1]     
				DOUT_VLD    => avalon_valid1,  -->RX_Slave1
				FRAME_ERROR     => avalon_error1,   -->RX_Slave1
				PARITY_ERROR    => open
		);
		
      RX_UART2 : component UART
		GENERIC MAP( CLK_FREQ => UART_CLK,
					BAUD_RATE => RX_RATE,
					PARITY_BIT => "none",
					USE_DEBOUNCER => true )
		port map (
				CLK                                  => CLK,      -->EVM 50MHz                    
				RST                            => RST,    -->SW[0]                     
				
				UART_TXD                         => open,  -->GPIO[0]                       
				UART_RXD                  => RXD_EFF,  -->RX_Slave0                 
				DIN                   => (others => '0'),   -->RX_Slave0                
				DIN_VLD                  => '0',  -->RX_Slave0               
				DIN_RDY                  => open,  -->RX_Slave0
							
				DOUT              => avalon_data2,  -->GPIO[1]     
				DOUT_VLD    => avalon_valid2,  -->RX_Slave1
				FRAME_ERROR     => avalon_error2,   -->RX_Slave1
				PARITY_ERROR    => open
		);
		
		
	 RX_Slave0: RX_Slave
        port map (
            clk           => CLK, 				-->200MHz
            resetn         => RST_N, 			-->SW[0]
            clr_rdy       => clr_rdy_0, 		-->TX_Master
			clr_err		  => clr_err0,
            --avalon_data   => avalon_data0, 	-->RX_UARTS
            avalon_data   => "00000000", 	-->
				avalon_valid  => avalon_valid0, 	-->RX_UARTS
            avalon_ready  => avalon_ready0, 	-->RX_UARTS
            avalon_error  => avalon_error0, 	-->RX_UARTS
            fifo_write    => fifo_write0, 	-->RX_FIFO_inst0[wrreq]
            data_in       => data_in0, 		-->RX_FIFO_inst0[data]
            fifo_full     => fifo_full0, 		-->RX_FIFO_inst0
            err           => tx_err0, 			-->TX_Master
            rdy           => tx_rdy0 			-->TX_Master
        );
		  
  	 
	 RX_Slave1: RX_Slave
        port map (
            clk           => CLK, -->200MHz
            resetn         => RST_N, -->SW[0]
            clr_rdy       => clr_rdy_1,-->TX_Master
			clr_err		  => clr_err1,
            --avalon_data   => avalon_data1,-->RX_UARTS
				avalon_data   => "00000000",-->
            avalon_valid  => avalon_valid1,-->RX_UARTS
            avalon_ready  => avalon_ready1,-->RX_UARTS
            avalon_error  => avalon_error1,-->RX_UARTS
            fifo_write    => fifo_write1,	-->RX_FIFO_inst1[wrreq]
            data_in       => data_in1,		-->RX_FIFO_inst1[data]
            fifo_full     => fifo_full1,	-->RX_FIFO_inst1
            err           => tx_err1, 			-->TX_Master
            rdy           => tx_rdy1 			-->TX_Master
        );
		  

  	 RX_Slave2: RX_Slave
        port map (
				clk           => CLK, 		-->200MHz
				resetn         => RST_N, 	-->SW[0]
				clr_rdy       => clr_rdy_2,-->TX_Master
				clr_err		  => clr_err2,
				--avalon_data   => avalon_data2,-->RX_UARTS
				avalon_data   => "00000000",-->
				avalon_valid  => avalon_valid2,-->RX_UARTS
				avalon_ready  => avalon_ready2,-->RX_UARTS
				avalon_error  => avalon_error2,-->RX_UARTS
				fifo_write    => fifo_write2,	-->RX_FIFO_inst2[wrreq]
				data_in       => data_in2,		-->RX_FIFO_inst2[data]
				fifo_full     => fifo_full2,	-->RX_FIFO_inst2
				err           => tx_err2,-->TX_Master
				rdy           => tx_rdy2-->TX_Master
			);
		  
		  
		TX_Master_inst : TX_Master
        port map (
				--EVM
				clk                     => CLK,-->200MHz
				resetn                   => RST_N,-->SW[0]
				--RX_Slave0
				tx_rdy0                 => tx_rdy0,
				tx_err0                 => tx_err0,
				data_0                  => FIFO_q0,
				clr_rdy_0               => clr_rdy_0,
				clr_err0  				=> clr_err0,
				--RX_Slave1
				tx_rdy1                 => tx_rdy1,
				tx_err1                 => tx_err1,
				data_1                  => FIFO_q1,
				clr_rdy_1               => clr_rdy_1,
				clr_err1  				=> clr_err1,
				--RX_Slave2
				tx_rdy2                 => tx_rdy2,
				tx_err2                 => tx_err2,
				data_2                  => FIFO_q2,
				clr_rdy_2               => clr_rdy_2,
				clr_err2  				=> clr_err2,
				--RX_FIFO_inst0
				clr_FIFO_0              => clr_FIFO_0,
				rd_FIFO_0               => rd_FIFO_0,
				FIFO_usedw0             => FIFO_usedw0,
				--RX_FIFO_inst1
				clr_FIFO_1              => clr_FIFO_1,
				rd_FIFO_1               => rd_FIFO_1,
				FIFO_usedw1             => FIFO_usedw1,
				--RX_FIFO_inst2
				clr_FIFO_2              => clr_FIFO_2,
				rd_FIFO_2               => rd_FIFO_2,
				FIFO_usedw2             => FIFO_usedw2,
				--TX_UART
				rs232_0_to_uart_data  => TEENSY_UART_DATA,  
				rs232_0_to_uart_error => TEENSY_UART_ERROR, 
				rs232_0_to_uart_valid => TEENSY_UART_VALID, 
				rs232_0_to_uart_ready => TEENSY_UART_RDY
		 );
		 
		 
		RX_FIFO_inst0 : RX_FIFO
			port map (
				 clock   => CLK,    --> 
				 --data    => data_in0,           	 -->RX_Slave0
				 data    => avalon_data0,           	 -->RX_UARTS
				 rdreq   => rd_FIFO_0,            -->TX_Master
				 sclr    => clr_FIFO_0,           -->TX_Master 
				 wrreq   => fifo_write0,          -->RX_Slave0 
				 empty   => open,          		  
				 full    => fifo_full0,           -->RX_Slave0 
				 q       => FIFO_q0,              -->TX_Master
				 usedw   => FIFO_usedw0           -->TX_Master 
			);


		RX_FIFO_inst1 : RX_FIFO
			port map (
				 clock   => CLK,    -->EVM 50MHz
				 --data    => data_in1,           	 -->RX_Slave1
				 data    => avalon_data1,           	 -->RX_UARTS
				 rdreq   => rd_FIFO_1,          	 -->TX_Master
				 sclr    => clr_FIFO_1,           -->TX_Master
				 wrreq   => fifo_write1,          -->RX_Slave1
				 empty   => open,          
				 full    => fifo_full1,           -->RX_Slave1
				 q       => FIFO_q1,              -->TX_Master
				 usedw   => FIFO_usedw1           -->TX_Master
			);


		RX_FIFO_inst2 : RX_FIFO
			port map (
				 clock   => CLK,    --> EVM 50MHz
				 --data    => data_in2,           		--> RX_Slave2
				 data    => avalon_data2,           	 -->RX_UARTS
				 rdreq   => rd_FIFO_2,          		-->TX_Master 
				 sclr    => clr_FIFO_2,           	-->TX_Master 
				 wrreq   => fifo_write2,          	-->RX_Slave1 
				 empty   => open,         				  
				 full    => FIFO_full2,           -->RX_Slave1 
				 q       => FIFO_q2,              -->TX_Master
				 usedw   => FIFO_usedw2           -->TX_Master
			);
			
		
		
	TEENSY_TX_UART : component UART
		GENERIC MAP( CLK_FREQ => UART_CLK,
					BAUD_RATE => TX_RATE,
					PARITY_BIT => "none",
					USE_DEBOUNCER => true )
		port map (
				CLK                                  => CLK,      -->EVM 50MHz                    
				RST                            => RST,    -->SW[0]                     
				
				UART_TXD                         => TXD_TEENSY,  -->GPIO[0]                       
				UART_RXD                  => '0',  -->RX_Slave0                 
				DIN                   => TEENSY_UART_DATA,   -->RX_Slave0                
				DIN_VLD                  => TEENSY_UART_VALID,  -->RX_Slave0               
				DIN_RDY                  => TEENSY_UART_RDY,  -->RX_Slave0
							
				DOUT              => open,  -->GPIO[1]     
				DOUT_VLD    => open,  -->RX_Slave1
				FRAME_ERROR     => open,   -->RX_Slave1
				PARITY_ERROR    => open
		);	
		

end architecture rtl; -- of UART_TOP
