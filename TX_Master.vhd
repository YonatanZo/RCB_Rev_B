library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TX_Master is
    Port (
        clk : in std_logic;
        resetn : in std_logic;
		  --RX_SLAVE0_I/F
		  tx_rdy0 : in std_logic;
		  tx_err0 : in std_logic;
		  data_0 : in std_logic_vector(7 downto 0);
		  clr_rdy_0 : out std_logic;
		  clr_err0 : out std_logic;
		  --RX_SLAVE1_I/F 
		  tx_rdy1 : in std_logic;
		  tx_err1 : in std_logic;
		  data_1 : in std_logic_vector(7 downto 0);
		  clr_rdy_1 : out std_logic;
		  clr_err1 : out std_logic;
		  --RX_SLAVE2_I/F 
		  tx_rdy2 : in std_logic;
		  tx_err2 : in std_logic;
		  data_2 : in std_logic_vector(7 downto 0);
		  clr_rdy_2 : out std_logic;
		  clr_err2 : out std_logic;
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
		  TX_COUNTER_OUT    : out  std_logic_vector(15 downto 0); 
		  ERR_COUNTER_OUT    : out  std_logic_vector(15 downto 0);                     
		  rs232_0_to_uart_data    : out  std_logic_vector(7 downto 0); 
		  rs232_0_to_uart_error   : out  std_logic;
		  rs232_0_to_uart_valid   : out  std_logic;
		  rs232_0_to_uart_ready   : in std_logic
    );
end entity TX_Master;

architecture Behavioral of TX_Master is

    type state_type is (S_IDLE, S_TX_DATA, S_ERROR_STATE , S_WRITE_UART,S_CLR_RDY,S_VAL_TX_UART,S_WRITE_UART_D,S_SLEEP);
    signal state : state_type := S_IDLE;
    signal tx_data : std_logic_vector(7 downto 0) := (others => '0');
    signal current_fifo : unsigned(1 downto 0) := (others => '0');
	signal sleep_counter : integer range 0 to 751  := 0;
	 signal data_out : std_logic_vector(23 downto 0);
	 signal FIFO_usedw_reg : std_logic_vector(26 downto 0);
	 signal clr_FIFO_reg : std_logic_vector(2 downto 0):= "000";
	 signal tx_err_reg : std_logic_vector(2 downto 0):= "000";
	 signal pack_cnt : integer range 0 to 65535  := 0;
	 signal data_pointer : integer range 0 to 3  := 0;
	 signal err_cnt : integer range 0 to 65535 := 0;
	 signal tx_cnt : integer range 0 to 1024 := 0;
	 signal clr_rdy_reg : std_logic_vector(2 downto 0):= "000";
	 signal rd_FIFO_reg : std_logic_vector(2 downto 0):= "000";
	 signal clr_err_reg : std_logic_vector(2 downto 0):= "000";
	 signal tx_rdy_reg  : std_logic_vector(2 downto 0):= "000";
begin
TX_COUNTER_OUT <= std_logic_vector(to_unsigned(pack_cnt, TX_COUNTER_OUT'length));
ERR_COUNTER_OUT <= std_logic_vector(to_unsigned(err_cnt, TX_COUNTER_OUT'length));
data_out <= data_2 & data_1 & data_0;
tx_err_reg <= tx_err2 & tx_err1 & tx_err0;

clr_err0 <= clr_err_reg(0);
clr_err1 <= clr_err_reg(1);
clr_err2 <= clr_err_reg(2);

clr_FIFO_0 <= clr_FIFO_reg(0);
clr_FIFO_1 <= clr_FIFO_reg(1);
clr_FIFO_2 <= clr_FIFO_reg(2);

clr_rdy_0 <= clr_rdy_reg(0);
clr_rdy_1 <= clr_rdy_reg(1);
clr_rdy_2 <= clr_rdy_reg(2);

rs232_0_to_uart_error <= '0';

rd_FIFO_0 <= rd_FIFO_reg(0);
rd_FIFO_1 <= rd_FIFO_reg(1);
rd_FIFO_2 <= rd_FIFO_reg(2);
FIFO_usedw_reg <=FIFO_usedw2 & FIFO_usedw1 & FIFO_usedw0;

tx_rdy_reg <= tx_rdy2 & tx_rdy1 & tx_rdy0;

    process(clk, resetn)
    begin
        if resetn = '0' then
            state <= S_IDLE;
            tx_data <= (others => '0');
            current_fifo <= (others => '0');
			clr_rdy_reg <= (others => '0');
			rd_FIFO_reg <= (others => '0');
			clr_FIFO_reg  <= (others => '0');
			clr_err_reg  <= (others => '0');
			tx_cnt <= 0;
			pack_cnt <= 0;
			data_pointer <= 0;
			err_cnt <= 0;
			sleep_counter <= 0;
			
        elsif rising_edge(clk) then
            case state is
                when S_IDLE =>
						  tx_cnt <= 0;
						  sleep_counter <= 0;
						  clr_rdy_reg <= (others => '0');
						  rd_FIFO_reg <= (others => '0');
						  clr_FIFO_reg  <= (others => '0');
						  clr_err_reg  <= (others => '0');
						  if tx_err_reg /= "000" then
						    clr_FIFO_reg <= tx_err_reg;
							clr_err_reg <= tx_err_reg;
							state <= S_ERROR_STATE;
						  else
							  for i in 0 to 2 loop
								  if tx_rdy_reg(i) = '1' then
										
								
										data_pointer <= i;
										state <= S_CLR_RDY;
									else 
										null;
										--state <= S_IDLE;
								  end if;
							  end loop;
						  end if;
					when S_CLR_RDY =>
						clr_rdy_reg(data_pointer) <= '1';
						tx_cnt <= to_integer(unsigned(FIFO_usedw_reg((data_pointer*9+9)-1 downto (data_pointer*9))));
						state <= S_TX_DATA;	  
				    
                when S_TX_DATA =>
						  rs232_0_to_uart_valid <= '0';
						  clr_rdy_reg <= (others => '0');

                    if tx_cnt = 0 then
								pack_cnt <= pack_cnt+1;
								rd_FIFO_reg(data_pointer)  <= '0';
								rs232_0_to_uart_valid <= '0';
								state <= S_SLEEP;
						  else
							  if rs232_0_to_uart_ready = '1' then
								  rd_FIFO_reg(data_pointer) <= '1';
								  tx_cnt <= tx_cnt-1;
								  state <= S_WRITE_UART;
							  else
								  rd_FIFO_reg(data_pointer) <= '0';
								  state <= S_TX_DATA;
							  end if;
                    end if;
				when S_SLEEP =>
					if sleep_counter /= 750 then
						sleep_counter <= sleep_counter + 1 ;
				  	else 
					  	state <= S_IDLE;
						sleep_counter <= 0;
					end if;
                when S_ERROR_STATE =>
						clr_FIFO_reg <= "000";
					    clr_err_reg <= "000";
						err_cnt <= err_cnt+1;
						state <= S_IDLE;
					when S_WRITE_UART =>
						rd_FIFO_reg(data_pointer) <= '0';
						state <= S_WRITE_UART_D;
					when S_WRITE_UART_D =>
						rs232_0_to_uart_data <= data_out((data_pointer*8+7) downto (data_pointer*8));
						state <= S_VAL_TX_UART;
					when S_VAL_TX_UART =>
						rs232_0_to_uart_valid <= '1';
						if rs232_0_to_uart_ready = '0' then
							state <= S_TX_DATA;
						end if;
					when others =>
						null;
            end case;
        end if;
    end process;

end architecture Behavioral;