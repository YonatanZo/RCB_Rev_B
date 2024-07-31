library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RX_Slave is
    Port (
        clk : in std_logic;
        resetn : in std_logic;
		  --TX_Master I/F
        clr_rdy : in std_logic;
        clr_err : in std_logic;
		  --Avalon UART reciver I/F
        avalon_data : in std_logic_vector(7 downto 0);
        avalon_valid : in std_logic;
		avalon_ready    : out  std_logic;
		avalon_error    : in std_logic;
		  -- FIFO I/F
        fifo_write : out std_logic;
        data_in : out std_logic_vector(7 downto 0);
        fifo_full : in std_logic;
		err : out std_logic;
        rdy : out std_logic
    );
end entity RX_Slave;
  

architecture Behavioral of RX_Slave is
		type state_type is (S_IDLE, S_DATA_WAIT, S_FIFO_WRITE);
		signal state : state_type := S_IDLE;
		signal counter : integer range 0 to 12501 := 0;
		signal rx_data : std_logic_vector(7 downto 0);
		signal error_flg : std_logic;
        signal err_reg : std_logic;
begin
    err <= err_reg;
    process(clk, resetn, clr_rdy)
    begin
        if resetn = '0' then
            state <= S_IDLE;
            counter <= 0;
            rx_data <= (others => '0');
            fifo_write <= '0';
            error_flg <= '0';
            rdy <= '0';
            err_reg <= '0';
        elsif rising_edge(clk) then
            case state is
                when S_IDLE =>
                if (err_reg = '0') then
                    fifo_write <= '0';
                    avalon_ready <= '0';
                    counter <= 0;
                    if avalon_valid = '1' then
								avalon_ready <= '1';
                        counter <= 0;
                        --rx_data <= avalon_data;
								data_in <= avalon_data;
								state <= S_FIFO_WRITE;
                    end if;
                end if;
                when S_DATA_WAIT =>
							
							fifo_write <= '0';
							if avalon_error = '1' then
								error_flg <= '1';
							end if;
                     if avalon_valid = '1' then
								counter <= 0;
								if fifo_full = '0' then
									state <= S_FIFO_WRITE;
                        else
                            state <= S_DATA_WAIT;
                        end if;
                        --rx_data <= avalon_data;
								data_in <= avalon_data;
							
                    elsif counter = 800 then --was 8000
								
								if error_flg = '1' then 
									err_reg <= '1';
									error_flg <= '0';
                                    state <= S_IDLE;
								else
									avalon_ready <= '0';
									state <= S_IDLE; -- Transition back to IDLE if no new data received after 50 cycles
									rdy <= '1';
								end if;
                    else
                        counter <= counter + 1;
                    end if;
                when S_FIFO_WRITE =>
                    if fifo_full = '0' then
                        fifo_write <= '1';
                        --data_in <= rx_data;
                        state <= S_DATA_WAIT;
                    end if;

            end case;
        end if;
        
        if clr_rdy = '1' then
            rdy <= '0'; -- Clear rdy when clr_rdy is activated

        end if;
        if clr_err = '1' then
			err_reg <= '0';
        end if;        
    end process;

end architecture Behavioral;