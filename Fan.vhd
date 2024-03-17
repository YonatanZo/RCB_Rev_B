library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
entity FAN is
    port (
		  RST_N : In STD_LOGIC;
		  CLK : In STD_LOGIC;
		  TACHO_IN : In STD_LOGIC;
		  PWM_OUT : out STD_LOGIC;
		  FAN_TACHO_REG : out STD_LOGIC_VECTOR(15 DOWNTO 0) ;
		  FAN_PWM_REG : In STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
end entity FAN;

architecture Behavioral of FAN is



type state_type is (IDLE_PWM, PWM_PULSE);
signal pwm_state : state_type := IDLE_PWM;

signal counter : integer range 0 to 5001;
signal counter_1k : integer range 0 to 51;
signal clk_1khz : std_logic := '0';




constant FAN_TACHO_MES_PERIOD : natural := 200; 

-- Signals:
signal fan_pwm : std_logic;                      -- Add appropriate type
signal clk_1m_posedge : std_logic; 
signal pwm_cnt : natural range 0 to 2048;         -- Specify the range???????????????????????????????????????????????
signal pwm_value : std_logic_vector(15 downto 0);-- Add appropriate size
signal fpga_fan_pwm : std_logic_vector(7 downto 0); -- Add appropriate size
signal fpga_fan_tacho : std_logic_vector(7 downto 0); -- Add appropriate size
signal fpga_fan_tacho_num : std_logic_vector(7 downto 0); -- Add appropriate size
signal fan_tacho_inv : std_logic;                -- Add appropriate type
signal fan_tacho_meta : std_logic;               -- Add appropriate type
signal fan_tacho_sync : std_logic;               -- Add appropriate type
signal fan_tacho_posedge : std_logic;            -- Add appropriate type
signal fan_tacho : std_logic;            -- Add appropriate type
signal fan_tacho_mes_pulse : std_logic;
signal fan_tacho_cnt  : natural range 0 to 2048;
signal fan_tacho_cnt_1  : natural range 0 to 2048;
signal fan_pwm_f : std_logic;
begin

fpga_fan_pwm <= FAN_PWM_REG;
PWM_OUT <= fan_pwm; 
fan_tacho_posedge <= fan_tacho_inv AND fan_tacho_sync;
FAN_TACHO_REG <= fpga_fan_tacho_num & fpga_fan_tacho;
fan_tacho <= TACHO_IN;

    process(CLK, RST_N)
    begin
        if RST_N = '0' then
            counter_1k <= 0;
            clk_1khz <= '0';
        elsif rising_edge(CLK) then
            if counter_1k = 5000 then -- Counter value for 1 kHz at 100 MHz clock (maybe 5000??)
                counter_1k <= 0;
                clk_1khz <= not clk_1khz;
            else
                counter_1k <= counter_1k + 1;
            end if;
        end if;
    end process;

	process(CLK, RST_N)
    begin
        if RST_N = '0' then
            counter <= 0;
            clk_1khz <= '0';
        elsif rising_edge(CLK) then
            if counter = 50 then -- Counter value for 1 kHz at 100 MHz clock (maybe 50??)
                counter <= 0;
                clk_1m_posedge <= not clk_1m_posedge;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

--pwm logic------
process(clk_1khz, RST_N)
begin
   if RST_N = '0' then
		fan_pwm <= '0';
		pwm_cnt <= 0;
		pwm_state <= IDLE_PWM;
		pwm_value <= (others => '0');

   elsif rising_edge(clk_1khz) then

			if pwm_cnt = 1024 then
				pwm_cnt <=0;
			else    
				pwm_cnt <= (pwm_cnt) + 1;
			end if;
			
			case pwm_state is
				when IDLE_PWM =>
					if ((pwm_cnt /= 0) or (fpga_fan_pwm(7 downto 0)= "00000000")) then
						pwm_state <= IDLE_PWM;
						fan_pwm_f <= '0';
						pwm_value <= fpga_fan_pwm(7 downto 0) & "00000000";
					else
						pwm_state <= PWM_PULSE;
						fan_pwm_f <= '1';
					end if;
					
				when PWM_PULSE =>
					if (pwm_cnt < unsigned(pwm_value) or fpga_fan_pwm = "11111111") then
						pwm_state <= PWM_PULSE;
						fan_pwm_f <= '1';
					else
						pwm_state <= IDLE_PWM;
						fan_pwm_f <= '0';
					end if;
			end case;
	end if;
end process;
		
process(CLK, RST_N)
begin
   if RST_N = '0' then
		fan_tacho_inv <= '1';
		fan_tacho_meta <= '0';
		fan_tacho_sync <= '0';

   elsif rising_edge(CLK) then
      fan_tacho_inv <= not fan_tacho_sync;
		fan_tacho_sync <= fan_tacho_meta;
		fan_tacho_meta <= fan_tacho;
	end if;
end process;

---FAN Tacho Measured pulses VHDL-ed. 
process(CLK, RST_N)
begin
    -- Reset condition: when reset is active low
    if RST_N = '0' then
        -- Reset fan tachometer counter and measurement pulse
        fan_tacho_cnt <= 0;   -- Reset fan tachometer counter
        fan_tacho_mes_pulse <= '0';        -- Reset fan tachometer measurement pulse
    -- Clock edge condition: on rising edge of the 100 MHz clock
    elsif rising_edge(CLK) then
        -- Reset measurement pulse for a new measurement cycle
        fan_tacho_mes_pulse <= '0';
        
        -- Check if the fan tachometer counter has reached the measurement period
        if(fan_tacho_cnt < FAN_TACHO_MES_PERIOD) then
            -- Increment fan tachometer counter
            fan_tacho_cnt <= fan_tacho_cnt + 1; -- Increment fan tachometer counter by 1
        else
            -- Reset fan tachometer counter and set measurement pulse
            fan_tacho_cnt <= 0;   -- Reset fan tachometer counter
            fan_tacho_mes_pulse <= '1';         -- Set measurement pulse to indicate a new measurement period
        end if;
    end if;
end process;

process(fan_tacho_mes_pulse, clk_1m_posedge, RST_N)
begin
    -- Reset condition: when reset is active low
    if RST_N = '0' then
        -- Reset FPGA fan 1 tachometer registers and counters
        fpga_fan_tacho <= (others =>'0');    -- Reset FPGA fan 1 tachometer register
        fpga_fan_tacho_num <=  (others =>'0'); -- Reset FPGA fan 1 tachometer number register
        fan_tacho_cnt_1 <=  0;     -- Reset fan 1 tachometer counter
    -- Clock and pulse condition: when fan tachometer measurement pulse is high and there is a positive edge on the 1 MHz clock
    elsif((fan_tacho_mes_pulse and clk_1m_posedge) = '1') then
        -- Transfer fan 1 tachometer count to FPGA register and increment tachometer number
        fan_tacho_cnt_1 <= fan_tacho_cnt_1;          -- Transfer fan 1 tachometer count to FPGA register
        (fpga_fan_tacho_num) <= std_logic_vector(unsigned(fpga_fan_tacho_num )+ 1); -- Increment FPGA fan 1 tachometer number
        fan_tacho_cnt_1 <= 0;           -- Reset fan 1 tachometer counter for the next measurement
    else
        -- If there's no measurement pulse and it's not a clock edge, check for positive edge on fan 1 tachometer
        if(fan_tacho_posedge = '1') then
            -- Increment fan 1 tachometer counter
            fan_tacho_cnt_1 <= fan_tacho_cnt_1 +1;  -- Increment fan 1 tachometer counter by 1
        end if;
    end if;
end process;

end Behavioral;
