LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
ENTITY ADC_Master IS
  GENERIC(
    input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
	bus_clk   : INTEGER := 400_000); 
  PORT(
    clk       : IN     STD_LOGIC;                    --system clock
    reset_n   : IN     STD_LOGIC;                    --active low reset
	AIN0   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN1   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN2   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN3   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN4   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN5   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN6   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);
	AIN7   : OUT     STD_LOGIC_VECTOR(15 DOWNTO 0);	
	clk_1MHz : OUT     STD_LOGIC;	
    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
END ADC_Master;

ARCHITECTURE logic OF ADC_Master IS

  COMPONENT i2c_master
    GENERIC(
      input_clk : INTEGER := 50000000; --input clock speed from user logic in Hz
      bus_clk   : INTEGER := 400000);   --speed the i2c bus (scl) will run at in Hz
    PORT(
      clk       : IN     STD_LOGIC;                    --system clock
      reset_n   : IN     STD_LOGIC;                    --active low reset
      ena       : IN     STD_LOGIC;                    --latch in command
      addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
	  rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
      data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
      busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
      data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
      ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
      sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
      scl       : INOUT  STD_LOGIC                    --serial clock output of i2c bus
      );
  END COMPONENT;
  CONSTANT SEQUENCE_CFG_ADDR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";
  CONSTANT OPMODE_CFG_ADDR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"04";
  CONSTANT PIN_CFG_ADDR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"05";
  CONSTANT AUTO_SEQ_CH_SEL_ADDR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"12";
  CONSTANT OP_SIN_REG_RD : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";  --Single register read
  CONSTANT OP_SIN_REG_WR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08"; --Single register write
  CONSTANT OP_CON_REG_RD : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"30";  --Reading a continuous block of registers
  CONSTANT OP_CON_REG_WR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"28";  --Writing a continuous block of registers
  CONSTANT DEV_ID : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010000";  --Writing a continuous block of registers
  TYPE machine IS (
  S_IDLE,
  S_CONFIG_ADC,
  S_DATA_REQ,
  S_WAIT_WR_DONE,
  S_GET_DATA,
  S_UPDATE_DATA,
  S_PUSH_DATA
	);
  SIGNAL state         : machine;                        --state machine
  SIGNAL data_clk      : STD_LOGIC;                      --data clock for sda
  SIGNAL data_clk_prev : STD_LOGIC;                      --data clock during previous system clock
  SIGNAL scl_ena       : STD_LOGIC := '0';               --enables internal scl to output
  SIGNAL sda_int       : STD_LOGIC := '1';               --internal sda
  SIGNAL sda_ena_n     : STD_LOGIC;                      --enables internal sda to output
  SIGNAL addr_rw       : STD_LOGIC_VECTOR(7 DOWNTO 0);   --latched in address and read/write
  SIGNAL data_tx       : STD_LOGIC_VECTOR(7 DOWNTO 0);   --latched in data to write to slave
  SIGNAL data_rx       : STD_LOGIC_VECTOR(7 DOWNTO 0);   --data received from slave
  SIGNAL bit_cnt       : INTEGER RANGE 0 TO 7 := 7;      --tracks bit number in transaction
  SIGNAL stretch       : STD_LOGIC := '0';               --identifies if slave is stretching scl
  SIGNAL DATA_BUFFER       : STD_LOGIC_VECTOR(127 DOWNTO 0);   
  SIGNAL i2c_ena      : STD_LOGIC;
  SIGNAL i2c_addr     : STD_LOGIC_VECTOR(6 DOWNTO 0); -- Assuming the address is 7 bits
  SIGNAL i2c_data_wr  : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL i2c_rw       : STD_LOGIC;
  SIGNAL data_pointer : INTEGER RANGE 0 TO 8; -- Define the upper range according to your design needs
  SIGNAL busy_cnt : INTEGER RANGE 0 TO 32; -- Define the upper range according to your design needs
  SIGNAL reg_cnt  : INTEGER RANGE 0 TO 16; -- Define the upper range according to your design needs
  SIGNAL ena_signal        : STD_LOGIC;
  SIGNAL busy_prev         : STD_LOGIC := '0';
  SIGNAL addr_signal       : STD_LOGIC_VECTOR(6 DOWNTO 0);
  SIGNAL rw_signal         : STD_LOGIC;
  SIGNAL data_wr_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL i2c_busy          : STD_LOGIC;
  SIGNAL data_rd_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL ack_error_signal  : STD_LOGIC;
  SIGNAL data_req          : INTEGER RANGE 0 TO 2; -- Assuming it's a binary signal
  SIGNAL reg_addr          : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL reg_data          : STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal counter : unsigned(5 downto 0) := (others => '0');
  signal clk_1MHz_reg : STD_LOGIC;
BEGIN

  i2c_comm: i2c_master
    GENERIC MAP (
      input_clk => 50000000, -- Input clock speed in Hz
      bus_clk   => 400000     -- I2C bus clock speed in Hz
    )
    PORT MAP (
      clk       => clk,    -- System clock
      reset_n   => reset_n,-- Active low reset
      ena       => i2c_ena,    -- Latch in command
      addr      => i2c_addr,   -- Address of target slave
	   rw        => i2c_rw,     -- '0' is write, '1' is read
      data_wr   => i2c_data_wr,-- Data to write to slave
      busy      => i2c_busy,   -- Indicates transaction in progress
      data_rd   => data_rd_signal,-- Data read from slave
      ack_error => ack_error_signal, -- Flag if improper acknowledge from slave
      sda       => sda,    -- Serial data output of I2C bus
      scl       => scl     -- Serial clock output of I2C bus
    );
  
AIN0 <= DATA_BUFFER(15 downto 0);
AIN1 <= DATA_BUFFER(31 downto 16);
AIN2 <= DATA_BUFFER(47 downto 32);
AIN3 <= DATA_BUFFER(63 downto 48);
AIN4 <= DATA_BUFFER(79 downto 64);
AIN5 <= DATA_BUFFER(95 downto 80);
AIN6 <= DATA_BUFFER(111 downto 96);
AIN7 <= DATA_BUFFER(127 downto 112);

  PROCESS(clk, reset_n,busy_prev,i2c_busy,data_rd_signal,data_req)
  BEGIN
	IF(reset_n = '0') THEN                 --reset asserted
	state <= S_IDLE;                      --return to initial state

	ELSIF rising_edge(clk) THEN
		busy_prev <= i2c_busy;
		
		IF(busy_prev = '0' AND i2c_busy = '1') THEN 
			busy_cnt <= busy_cnt + 1; 
		END IF;
		
		CASE state IS
		
			WHEN S_IDLE =>
				reg_cnt <= 0;
				busy_cnt <= 0;
				state <= S_CONFIG_ADC;
			WHEN S_CONFIG_ADC =>                               --state for conducting this transaction
											--capture the value of the previous i2c busy signal
			  IF(busy_prev = '0' AND i2c_busy = '1') THEN 
				busy_cnt <= busy_cnt + 1;                   
			  END IF;
			  
			  IF busy_cnt mod 3 = 0 THEN
				reg_cnt <= reg_cnt + 1;              
			  END IF;
			  
				  CASE busy_cnt mod 3 IS                            
					WHEN 0 =>                                
					  i2c_ena <= '1';                           
					  i2c_addr <= DEV_ID;                    
					  i2c_data_wr <= OP_SIN_REG_WR;
					  i2c_rw <= '0';                             
					WHEN 1 =>                               
					  i2c_ena <= '1';                           
					  i2c_addr <= DEV_ID;                   
					  i2c_rw <= '0';                        
					  i2c_data_wr <= reg_addr;             
					WHEN 2 =>                                  
					  i2c_ena <= '1';                            
					  i2c_addr <= DEV_ID;                    
					  i2c_rw <= '0';                            
					  i2c_data_wr <= reg_data; 
					WHEN others =>
						null;
				  END CASE;
				  
				  CASE reg_cnt IS                            
					WHEN 0 =>                                  
					  reg_addr <= SEQUENCE_CFG_ADDR;
					  reg_data <= (others => '0');
					WHEN 1 =>                                  
					  reg_addr <= OPMODE_CFG_ADDR;
					  reg_data <= (others => '0');
					WHEN 2 =>                                
					  reg_addr <=PIN_CFG_ADDR;
					  reg_data <= (others => '0');
					WHEN 3 =>                                
					  reg_addr <=AUTO_SEQ_CH_SEL_ADDR;
					  reg_data <= x"ff";
					WHEN 4 =>                                
					  reg_addr <=SEQUENCE_CFG_ADDR;
					  reg_data <= x"01";
					WHEN 5 =>                                
					  reg_addr <=SEQUENCE_CFG_ADDR;
					  reg_data <= x"11";
					WHEN 6 =>     
					  i2c_ena <= '0';
					  state <= S_DATA_REQ;
					  busy_cnt <= 0;
					  data_req <= 0;
					WHEN others =>
						null;
				  END CASE;
				  
			WHEN S_DATA_REQ => 
				data_pointer <= 0;
				
				CASE data_req IS
					WHEN 0 =>
					  i2c_ena <= '1';                           
					  i2c_addr <= DEV_ID;                   
					  i2c_rw <= '0';                        
					  i2c_data_wr <= OP_CON_REG_RD;        
					  state <= S_WAIT_WR_DONE ;
					WHEN 1 =>
					  i2c_ena <= '1';                           
					  i2c_addr <= DEV_ID;                   
					  i2c_rw <= '0';                        
					  i2c_data_wr <= x"A0";   
					state <= S_WAIT_WR_DONE  ;     
					WHEN others =>
						state <=S_GET_DATA ;
				END CASE;
				
			WHEN S_WAIT_WR_DONE => 
			
				IF i2c_busy = '1' THEN
					state <= S_WAIT_WR_DONE ;   
				ELSE
					state <= S_DATA_REQ ;
					data_req <= data_req + 1;
				END IF;
				
			WHEN S_GET_DATA =>  
				  i2c_ena <= '1';                         
				  i2c_addr <= DEV_ID;
				  i2c_rw <= '1';                           
				  state <= S_UPDATE_DATA;  
			WHEN S_UPDATE_DATA =>    
			
				IF i2c_busy = '1' THEN
					state <= S_UPDATE_DATA;  
				ELSE
					state <= S_PUSH_DATA;
				END IF;
				
			WHEN S_PUSH_DATA => 
			
				IF i2c_busy = '1' THEN
					data_pointer <= data_pointer +1;
					state <= S_UPDATE_DATA;
				ELSIF data_pointer = 7 THEN
					data_pointer <= 0;
					state <= S_DATA_REQ;
				ELSE
					DATA_BUFFER(8*data_pointer+7 downto data_pointer*8) <= data_rd_signal;
				END IF;
			WHEN others =>
						null;	
			END CASE;
		END IF;
	END PROCESS;
	
	
	clk_1MHz <= clk_1MHz_reg;
 process (clk, reset_n)
    begin
        if reset_n = '0' then
            counter <= (others => '0');
            clk_1MHz_reg <= '0';
        elsif rising_edge(clk) then
            if counter = 49 then -- Divide 50MHz by 50
                counter <= (others => '0');
                clk_1MHz_reg <= not clk_1MHz_reg; -- Toggle every 50 cycles
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
END logic;