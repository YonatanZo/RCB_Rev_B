LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY i2c_top IS
  generic (
    DEV_ID : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010000"
  );
  PORT (
    clk      : IN  STD_LOGIC;
    reset_n  : IN  STD_LOGIC;
    start    : IN  STD_LOGIC;
    scl      : INOUT  STD_LOGIC;
    sda      : INOUT  STD_LOGIC;
    data_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- Data read from device
    done     : OUT STD_LOGIC                     -- Indicate completion
  );
END i2c_top;

ARCHITECTURE behavior OF i2c_top IS
  constant OP_SIN_REG_RD : std_logic_vector(7 downto 0) := x"10";                                                                                                     
  constant OP_SIN_REG_WR : std_logic_vector(7 downto 0) := x"08";                                                                                                    
  constant OP_CON_REG_RD : std_logic_vector(7 downto 0) := x"30";                              
  constant OP_CON_REG_WR : std_logic_vector(7 downto 0) := x"28";   
  CONSTANT OSR_CFG : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"03"; 
  CONSTANT OSR_CFG_DATA : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"07"; 
  CONSTANT CHANNEL_SEL : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"11";
  SIGNAL ena         : STD_LOGIC := '0';
  SIGNAL rw          : STD_LOGIC := '0';
  SIGNAL addr        : STD_LOGIC_VECTOR(6 DOWNTO 0) := DEV_ID;
  SIGNAL data_wr     : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL data_rd     : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL busy        : STD_LOGIC;
  TYPE machine IS (
  S_IDLE,
  S_SET_REQ,
  S_CONFIG_ADC,
  S_DATA_REQ,
  S_DATA_READ_DLY,
  S_DATA_READ,
  S_BUSY,
  S_STOP
	);
  SIGNAL read_delay_cnt : INTEGER range 0 to 10000 := 0 ;
  SIGNAL state         : machine;                        --state machine
  SIGNAL next_state         : machine;
  SIGNAL read_buffer : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
  SIGNAL byte_cnt : INTEGER range 0 to 15 := 0 ;
  SIGNAL reg_cnt : INTEGER range 0 to 9 := 0 ;
  SIGNAL sleep_cnt : INTEGER range 0 to 400 := 0 ;
  SIGNAL busy_f : std_LOGIC := '0';
  SIGNAL cnt_busy_flg : std_LOGIC := '0';
  SIGNAL data_wr_dly : STD_LOGIC_VECTOR(7 DOWNTO 0) :=x"08"; 
  COMPONENT i2c_master
    GENERIC (
      input_clk : INTEGER := 50_000_000;
      bus_clk   : INTEGER := 400_000
    );
    PORT (
      clk       : IN     STD_LOGIC;
      reset_n   : IN     STD_LOGIC;
      ena       : IN     STD_LOGIC;
      rw        : IN     STD_LOGIC;
      addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0);
      data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0);
      data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0);
      busy      : OUT    STD_LOGIC;
      ack_error : OUT    STD_LOGIC;
      scl       : INOUT  STD_LOGIC;
      sda       : INOUT  STD_LOGIC
    );
  END COMPONENT;

BEGIN
  i2c_inst : i2c_master
    generic map (
      input_clk => 100_000_000,
      bus_clk => 100_000
    )
    PORT MAP (
      clk       => clk,
      reset_n   => reset_n,
      ena       => ena,
      rw        => rw,
      addr      => DEV_ID,
      data_wr   => data_wr_dly,
      data_rd   => data_rd,
      busy      => busy,
      ack_error => OPEN,
      scl       => scl,
      sda       => sda
    );

  PROCESS (clk, reset_n)
  BEGIN
    IF reset_n = '0' THEN
      ena <= '0';
      rw <= '0';
      state <= S_IDLE;
      next_state <=  S_IDLE;
      byte_cnt <= 0;
      read_delay_cnt <= 0;
      reg_cnt <= 0;
    ELSIF rising_edge(clk) THEN                            
		CASE state IS
      WHEN S_IDLE =>

        ena <= '0';
        rw <= '0';
        state <= S_SET_REQ;
        next_state <=  S_IDLE;
        byte_cnt <= 0;
        reg_cnt <= 0;
        WHEN S_SET_REQ =>
        ena <= '1';
        rw <= '0';
        next_state <= S_SET_REQ;
        case byte_cnt is
          when 0 =>
            next_state <= S_SET_REQ;
          when 1 =>
            next_state <= S_SET_REQ;
          when 2 =>
            ena <= '0';
            next_state <= S_CONFIG_ADC;
          when others =>
            null;
        end case;
        if busy = '1' then
          reg_cnt <= reg_cnt +1;
          state <= S_BUSY;
        end if;      
      WHEN S_CONFIG_ADC =>
        ena <= '1';
        rw <= '0';
        case byte_cnt is
          when 3 =>
            next_state <= S_CONFIG_ADC;
          when 4 =>
            next_state <= S_CONFIG_ADC;
          when 5 =>
            next_state <= S_DATA_REQ;
            ena <= '0';
          when others =>
            null;
        end case;
        if busy = '1' then
          reg_cnt <= reg_cnt +1;
          state <= S_BUSY;
        end if;
      WHEN S_DATA_REQ =>
        ena <= '1';
        rw <= '0';
        next_state <= S_DATA_REQ;
        case byte_cnt is
          when 6 =>
            next_state <= S_DATA_REQ;
          when 7 =>
            next_state <= S_DATA_REQ;
          when 8 =>
            ena <= '0';
            next_state <= S_DATA_READ_DLY;
          when others =>
            null;
        end case;
        if busy = '1' then
          reg_cnt <= reg_cnt +1;
          state <= S_BUSY;
        end if;
      WHEN S_DATA_READ_DLY =>
          if read_delay_cnt = 9999 then
            read_delay_cnt <= 0;
            state <= S_DATA_READ;
          else
            read_delay_cnt <= read_delay_cnt +1;
          end if;
      WHEN S_DATA_READ =>
        ena <= '1';
        rw <= '1';
        if busy = '1' then
          reg_cnt <= reg_cnt +1;
          state <= S_BUSY;
        end if;
        if byte_cnt = 10 then
          ena <= '0';
          next_state <= S_STOP;
        end if;
      WHEN S_BUSY =>
        if busy = '1' then
          state <= S_BUSY;
        elsif busy = '0' then
            byte_cnt <= byte_cnt +1;
            state <= next_state; 
        end if;
      WHEN S_STOP =>
        state <= S_STOP;  
      WHEN others =>
        null;  
      END CASE;
    END IF;
  END PROCESS;    

  PROCESS (clk, reset_n)
  BEGIN
  IF reset_n = '0' THEN
    sleep_cnt <= 0;
    cnt_busy_flg <= '0';   
    data_wr_dly  <= x"08"; 
  ELSIF rising_edge(clk) THEN 
  busy_f <= busy;  
      if (busy and not busy_f) = '1' and cnt_busy_flg = '0' then
          cnt_busy_flg <= '1';
          sleep_cnt <= 0;
      end if;   
      if cnt_busy_flg = '1' then
        if sleep_cnt /= 399 then
          sleep_cnt <= sleep_cnt +1;
        else 
          sleep_cnt <= 0;
          data_wr_dly <= data_wr;
        end if;
    end if;  
      
    END IF;
  END PROCESS;    

  PROCESS (clk)
  BEGIN
  IF rising_edge(clk) THEN 
  case reg_cnt is
    when 0 =>
    data_wr <= OP_SIN_REG_WR;
    when 1 =>
      data_wr <= CHANNEL_SEL;
    when 2 =>
      data_wr <= x"02";
    when 3 =>
      data_wr <= OP_SIN_REG_WR;
    when 4 =>
      data_wr <= OSR_CFG;
    when 5 =>
      data_wr <= OSR_CFG_DATA;
    when 6 =>
      data_wr <= OP_SIN_REG_WR;
    when 7 =>
      data_wr <= CHANNEL_SEL;
    when 8 =>
      data_wr <= (others => '0');
    when others =>
      null;
  end case;
  END IF;
  END PROCESS;
END behavior;