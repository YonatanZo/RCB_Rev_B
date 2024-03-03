library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.rcb_parameters.all; -- Import the package

entity rcb_spi is
    Port (
        clk_100m : in STD_LOGIC;      	-- system clock
        rst_n_syn : in STD_LOGIC;      -- low active synchronous reset
        -- SPI INTERFACE
        sclk : in STD_LOGIC; -- SPI clock
        cs_n: in STD_LOGIC;     	-- SPI chip select, active in low
        mosi: in STD_LOGIC;     	-- SPI serial data from master to slave
        miso_t : out STD_LOGIC;     	-- SPI serial data from slave to master
        -- INTERNAL INTERFACE
        data_miso : in STD_LOGIC_VECTOR(31 downto 0);     -- data for transmission to SPI master
        data_mosi : out STD_LOGIC_VECTOR(31 downto 0);      -- received data from SPI master
        data_mosi_rdy : inout STD_LOGIC; -- when 1, received data are valid
		addr: out STD_LOGIC_VECTOR(15 downto 0);
		addr_rdy : out STD_LOGIC;   
		data_miso_rdy : out STD_LOGIC
    );
end rcb_spi;



architecture registers_Behavioral of rcb_registers is
type SPI_FSM is (IDLE, CMD, S_ADDR, MOSI_DATA, MISO_DATA);
signal state : SPI_FSM := IDLE;
signal next_state : SPI_FSM := IDLE;
signal miso: STD_LOGIC;
signal data_mosi_rdy_f: STD_LOGIC;
signal addr_rdy_f: STD_LOGIC;
signal data_miso_rdy_f: STD_LOGIC;
signal com_rdy: STD_LOGIC;
signal spi_clk_reg: STD_LOGIC := '1';
signal send_miso: STD_LOGIC;
signal miso_en: STD_LOGIC;
signal sclk_syn: STD_LOGIC;
signal cs_n_syn: STD_LOGIC;
signal mosi_syn: STD_LOGIC;
signal sclk_meta: STD_LOGIC;
signal cs_n_meta: STD_LOGIC;
signal mosi_meta: STD_LOGIC;
signal sclk_negedge: STD_LOGIC;
signal sclk_posedge: STD_LOGIC;
signal miso_t_f: STD_LOGIC; 
signal data_mosi_f: STD_LOGIC_VECTOR(31 downto 0); 
signal addr_f: STD_LOGIC_VECTOR(15 downto 0); 
signal data_cnt: STD_LOGIC_VECTOR(5 downto 0);
signal shift_reg: STD_LOGIC_VECTOR(55 downto 0);
signal miso_shift: STD_LOGIC_VECTOR(31 downto 0);
signal spi_mode: STD_LOGIC_VECTOR(1 downto 0);
signal sclk_deb_cnt : STD_LOGIC_VECTOR(DEB_DEEP downto 0);
signal cs_deb_cnt : STD_LOGIC_VECTOR(DEB_DEEP downto 0);
signal mosi_deb_cnt : STD_LOGIC_VECTOR(DEB_DEEP downto 0);
constant WRITE_MODE : STD_LOGIC_VECTOR(1 downto 0) := "00";
constant READ_MODE  : STD_LOGIC_VECTOR(1 downto 0) := "01";
BEGIN


data_mosi_rdy <= data_mosi_rdy_f;
addr_rdy <= addr_rdy_f;
data_miso_rdy  <= data_miso_rdy_f ;
addr  <= addr_f ;
data_mosi  <= data_mosi_f ;
miso_t  <= miso_t_f ;

process (shift_reg, miso_en, miso)
begin
    data_mosi_f <= shift_reg(31 downto 0);
    
    if miso_en = '1' then
        miso_t_f <= miso;
    else
        miso_t_f <= 'Z';
    end if;
end process;


process (clk_100m, rst_n_syn)
begin
    
	if rst_n_syn = '0' then
		sclk_syn  <= '0';
		sclk_meta <= '0';
		cs_n_syn  <= '0';
		cs_n_meta <= '0';
		mosi_syn  <= '0';
		mosi_meta <= '0';
	elsif rising_edge(clk_100m) then
		sclk_syn  <= sclk_meta and sclk;
		sclk_meta <= sclk;
		cs_n_syn  <= cs_n_meta and cs_n;
		cs_n_meta <= cs_n;
		mosi_syn  <= mosi_meta and mosi;
		mosi_meta <= mosi;
    end if;
end process;


process (clk_100m, rst_n_syn)
begin
	if rst_n_syn = '0' then
		spi_clk_reg <= '1';
	elsif rising_edge(clk_100m) then
		spi_clk_reg  <= not sclk_syn;
    end if;
end process;



sclk_negedge <= (not sclk_syn) and (not spi_clk_reg);
sclk_posedge <= sclk_syn and spi_clk_reg;


    process (clk_100m, rst_n_syn)
    begin
        if rst_n_syn = '0' then
            state <= IDLE;
        elsif rising_edge(clk_100m) then
            case state is
                when IDLE =>
                    if cs_n_syn = '1' then
                        state <= IDLE;
                    else
                        state <= CMD;
                    end if;
                when CMD =>
                    if cs_n_syn = '1' then
                        state <= IDLE;
                    elsif com_rdy = '1' then
                        state <= S_ADDR;
                    else
                        state <= CMD;
                    end if;
                when S_ADDR =>
                    if cs_n_syn = '1' then
                        state <= IDLE;
                    elsif addr_rdy_f = '1' then
                        case spi_mode is
                            when WRITE_MODE =>
                                state <= MOSI_DATA;
                            when READ_MODE =>
                                state <= MISO_DATA;
                            when others =>
                                state <= IDLE; -- UNDEF_MODE
                        end case;
                    else
                        state <= S_ADDR;
                    end if;
                when MOSI_DATA =>
                    if cs_n_syn = '1' then
                        state <= IDLE;
                    elsif data_cnt = "11111111" then
                        state <= IDLE;
                    else
                        state <= MOSI_DATA;
                    end if;
                when MISO_DATA =>
                    if cs_n_syn = '1' then
                        state <= IDLE;
                    elsif data_cnt = "11111111" then
                        state <= IDLE;
                    else
                        state <= MISO_DATA;
                    end if;
            end case;
        end if;
    end process;

    next_state <= state;  -- Output the current state
process (clk_100m, rst_n_syn)
begin
    if rst_n_syn = '0' then
        data_cnt     <= "000000";
        addr_rdy_f     <= '0';
        com_rdy      <= '0';
        miso         <= '1';
        shift_reg    <= (others => '0');
        send_miso    <= '0';
        miso_shift   <= (others => '0');
        miso_en      <= '0';
    else
        if rising_edge(clk_100m) then
            shift_reg(55 downto 0) <= mosi_syn & shift_reg(54 downto 1);
            com_rdy                 <= '0';
            addr_rdy_f                <= '0';
            miso_en                 <= '0';
            
            case next_state is
                when IDLE =>
                    data_cnt <= "000000";
                    miso     <= '1';
                    com_rdy  <= '0';
                    addr_rdy_f <= '0';
                    send_miso <= '0';
                when CMD =>
                    if data_cnt = SPI_COM_LEN - 1 then
                        com_rdy <= '1';
                    end if;
                    data_cnt <= data_cnt + 1;
                when S_ADDR =>
                    if data_cnt = SPI_ADDR_LEN - 1 then
                        addr_rdy_f <= '1';
                        if spi_mode = READ_MODE then
                            send_miso <= '1';
                            miso_en <= '1';
                        end if;
                    end if;
                    data_cnt <= data_cnt + 1;
                when MOSI_DATA =>
                    if data_cnt = SPI_DATA_LEN - 1 then
                        data_cnt <= "000000";
                        if spi_mode = WRITE_MODE then
                            data_cnt <= "000000";
                        end if;
                    else
                        data_cnt <= data_cnt + 1;
                    end if;
                when MISO_DATA =>
                    data_cnt <= data_cnt + 1;
                    miso_en <= '1';
            end case;
        elsif falling_edge(clk_100m) and send_miso = '1' then
            if addr_rdy_f = '1' then
                miso <= data_miso & "0" & miso_shift(30 downto 0);
            else
                miso <= miso_shift(31) & miso_shift(30 downto 1);
            end if;
        end if;
    end if;
end process;
	
	
process (clk_100m, rst_n_syn)
begin
    if rst_n_syn = '0' then
        spi_mode <= UNDEF_MODE;
    elsif rising_edge(clk_100m) then
        if com_rdy = '1' then
            case shift_reg(7 downto 0) is
                when WRITE_COM =>
                    spi_mode <= WRITE_MODE;
                when READ_COM =>
                    spi_mode <= READ_MODE;
                when others =>
                    spi_mode <= UNDEF_MODE;
            end case;
        end if;
    end if;
end process;
	
addr_init_proc:process (clk_100m, rst_n_syn)
	begin
    if (rst_n_syn = '1') then
		addr_f <= (other => '1');
	elsif rising_edge(clk_100m) then
		if(addr_rdy_f = '1') then
			addr_f <= shift_reg(15 downto 0);
	   end if;
	end if;
end process;		


process (clk_100m, rst_n_syn)
begin
    if (rst_n_syn = '1') then
        data_mosi_rdy_f <= '0';
    elsif rising_edge(clk_100m) then
        if (data_cnt = (SPI_DATA_LEN - '1') and spi_mode = WRITE_MODE and sclk_posedge) then
            data_mosi_rdy_f <= '1';
        else
            data_mosi_rdy_f <= '0';
        end if;
    end if;
end process;

process (clk_100m, rst_n_syn)
begin
    if (rst_n_syn = '1') then
        data_miso_rdy_f <= '0';
    elsif rising_edge(clk_100m) then
        if (data_cnt = (SPI_DATA_LEN - '1') and spi_mode = READ_MODE and sclk_posedge) then
            data_miso_rdy_f <= '1';
        else
            data_miso_rdy_f <= '0';
        end if;
    end if;
end process;

end registers_Behavioral;
	
