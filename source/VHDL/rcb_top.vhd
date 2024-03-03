library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rcb_top is
    Port (
        trig_in              : in STD_LOGIC;
        -- System signals
        clk_100m             : in STD_LOGIC;       -- system clock
        clk_1m               : in STD_LOGIC;       -- Internal FPGA from PLL
        rst_n                : in STD_LOGIC;       -- low active synchronous reset
        -- SPI INTERFACE
        sclk                 : in STD_LOGIC;       -- SPI clock
        cs_n                 : in STD_LOGIC;       -- SPI chip select, active low
        mosi                 : in STD_LOGIC;       -- SPI serial data from master to slave
        miso                 : out STD_LOGIC;      -- SPI serial data from slave to master
        -- FPGA Power Diagnostic
        pow                  : in STD_LOGIC;
        -- FPGA Buttons
        right_plunger_nc     : in STD_LOGIC;
        right_plunger_no     : in STD_LOGIC;
        left_plunger_nc      : in STD_LOGIC;
        left_plunger_no      : in STD_LOGIC;
        right_tool_ex_nc     : in STD_LOGIC;
        right_tool_ex_no     : in STD_LOGIC;
        left_tool_ex_nc      : in STD_LOGIC;
        left_tool_ex_no      : in STD_LOGIC;
        -- FPGA DRAPE SW State
        right_drape_sw_state : in STD_LOGIC;
        left_drape_sw_state  : in STD_LOGIC;
        -- FPGA DRAPE EM State
        right_drape_em_state : in STD_LOGIC;
        left_drape_em_state  : in STD_LOGIC;
        -- FPGA DRAPE Electro magnet S.W approval
        right_drape_em_open  : out STD_LOGIC;
        left_drape_em_open   : out STD_LOGIC;
        -- FPGA DRAPE Sensors
        right_drape_close2_nc: in STD_LOGIC;
        right_drape_close2_no: in STD_LOGIC;
        right_drape_close1_nc: in STD_LOGIC;
        right_drape_close1_no: in STD_LOGIC;
        right_drape_open_nc  : in STD_LOGIC;
        right_drape_open_no  : in STD_LOGIC;
        left_drape_close2_nc : in STD_LOGIC;
        left_drape_close2_no : in STD_LOGIC;
        left_drape_close1_nc : in STD_LOGIC;
        left_drape_close1_no : in STD_LOGIC;
        left_drape_open_nc   : in STD_LOGIC;
        left_drape_open_no   : in STD_LOGIC;
        -- FPGA Wheel Driver
        wheel_home_sw        : out STD_LOGIC_VECTOR(3 downto 0);
        wheel_reverse_sw     : out STD_LOGIC_VECTOR(3 downto 0);
        wheel_forward_sw     : out STD_LOGIC_VECTOR(3 downto 0);
        wheel_driver_di      : out STD_LOGIC_VECTOR(7 downto 0);
        -- wheel_driver_elo;
        wheel_driver_do      : in STD_LOGIC_VECTOR(3 downto 0);
        wheel_driver_rst     : out STD_LOGIC;
        wheel_driver_abrt    : out STD_LOGIC;
        -- FPGA Wheel Sensor
        wheel_d_sens3_in2    : in STD_LOGIC;
        wheel_d_sens3_in1    : in STD_LOGIC;
        wheel_d_sens2_in2    : in STD_LOGIC;
        wheel_d_sens2_in1    : in STD_LOGIC;
        wheel_d_sens1_in2    : in STD_LOGIC;
        wheel_d_sens1_in1    : in STD_LOGIC;
        wheel_c_sens3_in2    : in STD_LOGIC;
        wheel_c_sens3_in1    : in STD_LOGIC;
        wheel_c_sens2_in2    : in STD_LOGIC;
        wheel_c_sens2_in1    : in STD_LOGIC;
        wheel_c_sens1_in2    : in STD_LOGIC;
        wheel_c_sens1_in1    : in STD_LOGIC;
        wheel_b_sens3_in2    : in STD_LOGIC;
        wheel_b_sens3_in1    : in STD_LOGIC;
        wheel_b_sens2_in2    : in STD_LOGIC;
        wheel_b_sens2_in1    : in STD_LOGIC;
        wheel_b_sens1_in2    : in STD_LOGIC;
        wheel_b_sens1_in1    : in STD_LOGIC;
        wheel_a_sens3_in2    : in STD_LOGIC;
        wheel_a_sens3_in1    : in STD_LOGIC;
        wheel_a_sens2_in2    : in STD_LOGIC;
        wheel_a_sens2_in1    : in STD_LOGIC;
        wheel_a_sens1_in2    : in STD_LOGIC;
        wheel_a_sens1_in1    : in STD_LOGIC;
        -- FPGA Buttons LED
        right_tool_ex_led3   : out STD_LOGIC;
        right_tool_ex_led2   : out STD_LOGIC;
        right_tool_ex_led1   : out STD_LOGIC;
        left_tool_ex_led3    : out STD_LOGIC;
        left_tool_ex_led2    : out STD_LOGIC;
        left_tool_ex_led1    : out STD_LOGIC;
        right_plunger_led3   : out STD_LOGIC;
        right_plunger_led2   : out STD_LOGIC;
        right_plunger_led1   : out STD_LOGIC;
        left_plunger_led3    : out STD_LOGIC;
        left_plunger_led2    : out STD_LOGIC;
        left_plunger_led1    : out STD_LOGIC;
        -- ESTOP
        -- estop_activation;
        diag_activation       : out STD_LOGIC;
        estop_open            : in STD_LOGIC;
        teensy_estop_open_req: in STD_LOGIC;
        teensy_open_elo_req  : in STD_LOGIC;
        miccb_estop_open_req : out STD_LOGIC;
        FPGA_WHEEL_STOP_ELO  : out STD_LOGIC;
        estop_status         : in STD_LOGIC;
        diagnostic_led       : out STD_LOGIC_VECTOR(7 downto 0);
        -- Spare2 IO
        sp2_single_ended_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
        sp2_single_ended_1_0 : in STD_LOGIC_VECTOR(1 downto 0);
        sp2_analog_switch    : out STD_LOGIC_VECTOR(2 downto 0);
        sp2_diff_pair_2_3    : out STD_LOGIC_VECTOR(1 downto 0);
        sp2_diff_pair_1_0    : in STD_LOGIC_VECTOR(1 downto 0);
        -- Spare1 IO
        sp1_single_ended_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
        sp1_single_ended_1_0 : in STD_LOGIC_VECTOR(1 downto 0);
        sp1_analog_switch    : out STD_LOGIC_VECTOR(2 downto 0);
        sp1_diff_pair_2_3    : out STD_LOGIC_VECTOR(1 downto 0);
        sp1_diff_pair_1_0    : in STD_LOGIC_VECTOR(1 downto 0);
        -- Spare Left/Right 4.m.b.
        right_spare_diff_2   : out STD_LOGIC;
        right_spare_diff_1   : in STD_LOGIC;
        left_spare_diff_2    : out STD_LOGIC;
        left_spare_diff_1    : in STD_LOGIC;
        -- Wheel Rod Sensor
        wheel_rod2_out1      : in STD_LOGIC;
        wheel_rod2_out2      : in STD_LOGIC;
        wheel_rod1_out1      : in STD_LOGIC;
        wheel_rod1_out2      : in STD_LOGIC;
        -- FANs
        fan1_tacho           : in STD_LOGIC;
        fan1_pwm             : out STD_LOGIC;
        fan2_tacho           : in STD_LOGIC;
        fan2_pwm             : out STD_LOGIC;
        -- SYNC
        sync                 : in STD_LOGIC;
        estop_delay          : out STD_LOGIC;
        left_robot_tx        : out STD_LOGIC;
        left_robot_rx        : in STD_LOGIC;
        right_robot_tx       : out STD_LOGIC;
        right_robot_rx       : in STD_LOGIC;
        fpga_spare2          : in STD_LOGIC;
        fpga_spare3          : in STD_LOGIC;
        fpga_spare4          : in STD_LOGIC;
        fpga_spare5          : in STD_LOGIC;
        fpga_spare6          : in STD_LOGIC;
        fpga_spare7          : in STD_LOGIC;
        fpga_spare8          : in STD_LOGIC;
        fpga_spare9          : in STD_LOGIC;
        fpga_spare10         : in STD_LOGIC;
        fpga_spare11         : in STD_LOGIC;
        fpga_spare12         : in STD_LOGIC;
        teensy_fpga4         : in STD_LOGIC;
        teensy_fpga5         : in STD_LOGIC;
        fpga_spare13         : in STD_LOGIC;
        MICCB_SPARE_IO0      : in STD_LOGIC;
        MICCB_SPARE_IO1      : in STD_LOGIC;
        MICCB_SPARE_IO2      : out STD_LOGIC;
        MICCB_SPARE_IO3      : out STD_LOGIC
    );
end  rcb_top;


architecture Behavioral of rcb_top is

    component rcb_spi
        Port (
            clk_100m : in STD_LOGIC;
            rst_n_syn : in STD_LOGIC;
            sclk : in STD_LOGIC;
            cs_n : in STD_LOGIC;
            mosi : in STD_LOGIC;
            miso_t : out STD_LOGIC;
            data_miso : in STD_LOGIC_VECTOR(31 downto 0);
            data_mosi : out STD_LOGIC_VECTOR(31 downto 0);
            data_mosi_rdy : inout STD_LOGIC;
            addr : out STD_LOGIC_VECTOR(15 downto 0);
            addr_rdy : out STD_LOGIC;
            data_miso_rdy : out STD_LOGIC
        );
    end component;
	
	

	component rcb_registers is
		port(
			-- System signals
			clk_100m : in STD_LOGIC;         -- system clock
			rst_n_syn : in STD_LOGIC;        -- low active synchronous reset
			clk_1m : in STD_LOGIC;
			-- Internal signals
			data_miso : out STD_LOGIC_VECTOR(31 downto 0);  -- data for transmission to SPI master
			data_mosi : in STD_LOGIC_VECTOR(31 downto 0);   -- received data from SPI master
			data_mosi_rdy : in STD_LOGIC;                    -- when 1, received data is valid
			addr : in STD_LOGIC_VECTOR(15 downto 0);         -- received data from SPI master
			addr_rdy : in STD_LOGIC;                         -- when 1, received address is valid
			data_miso_rdy : in STD_LOGIC:= '0';
			-- FPGA Power Diagnostic
			pow : in STD_LOGIC:='0';
			-- FPGA BUTTONS
			fpga_buttons : in STD_LOGIC_VECTOR(7 downto 0):= (others => '0');
			-- FPGA DRAPE Switch and Sensors state
			drape_sw_state : in STD_LOGIC_VECTOR(1 downto 0):= (others => '0');
			drape_em_state : in STD_LOGIC_VECTOR(1 downto 0):= (others => '0');
			drape_sensor : in STD_LOGIC_VECTOR(11 downto 0):= (others => '0');
			-- FPGA DRAPE Electro magnet S.W approval
			right_drape_em_open : out STD_LOGIC;
			left_drape_em_open : out STD_LOGIC;
			-- FPGA Wheel Driver
			wheel_home_sw : out STD_LOGIC_VECTOR(3 downto 0);
			wheel_reverse_sw : out STD_LOGIC_VECTOR(3 downto 0);
			wheel_forward_sw : out STD_LOGIC_VECTOR(3 downto 0);
			wheel_driver_di : out STD_LOGIC_VECTOR(7 downto 0);
			-- wheel_driver_elo : out STD_LOGIC;
			wheel_driver_do : in STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
			wheel_driver_rst : out STD_LOGIC;
			wheel_driver_abrt : out STD_LOGIC;
			-- FPGA Wheel Sensor
			wheel_sensor : in STD_LOGIC_VECTOR(23 downto 0):= (others => '0');
			-- FPGA Buttons LED
			fpga_buttons_led_reg : out STD_LOGIC_VECTOR(31 downto 0);
			-- Activation(Close) SSR
			-- estop_activation : out STD_LOGIC;  -- Once set – only active for 0.1Sec.
			diag_activation : out STD_LOGIC;
			estop_open : in STD_LOGIC:= '0';
			estop_status : in STD_LOGIC:= '0';
			diagnostic_led : out STD_LOGIC_VECTOR(7 downto 0);
			-- Spare2 IO
			sp2_single_ended_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
			sp2_single_ended_1_0 : in STD_LOGIC_VECTOR(1 downto 0):= (others => '0');
			sp2_analog_switch : out STD_LOGIC_VECTOR(2 downto 0);
			sp2_diff_pair_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
			sp2_diff_pair_1_0 : in STD_LOGIC_VECTOR(1 downto 0);
			-- Spare1 IO
			sp1_single_ended_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
			sp1_single_ended_1_0 : in STD_LOGIC_VECTOR(1 downto 0);
			sp1_analog_switch : out STD_LOGIC_VECTOR(2 downto 0);
			sp1_diff_pair_2_3 : out STD_LOGIC_VECTOR(1 downto 0);
			sp1_diff_pair_1_0 : in STD_LOGIC_VECTOR(1 downto 0);
			-- Spare Left/Right 4.m.b.
			right_spare_diff_2 : out STD_LOGIC;
			right_spare_diff_1 : in STD_LOGIC;
			left_spare_diff_2 : out STD_LOGIC;
			left_spare_diff_1 : in STD_LOGIC;
			wheel_rod_sensor : in STD_LOGIC_VECTOR(3 downto 0);
			fan1_tacho : in STD_LOGIC;
			fan1_pwm : out STD_LOGIC;
			fan2_tacho : in STD_LOGIC;
			fan2_pwm : out STD_LOGIC;
			trig_in : in STD_LOGIC
		);
	end component;
--signal declaration
	
signal data_miso: STD_LOGIC_VECTOR(31 downto 0);
signal data_mosi: STD_LOGIC_VECTOR(31 downto 0);
signal addr: STD_LOGIC_VECTOR(15 downto 0);
signal drape_sensor: STD_LOGIC_VECTOR(11 downto 0);
signal drape_sw_state: STD_LOGIC_VECTOR(1 downto 0);
signal drape_em_state: STD_LOGIC_VECTOR(1 downto 0);
signal wheel_sensor: STD_LOGIC_VECTOR(23 downto 0);
signal fpga_buttons_led_reg: STD_LOGIC_VECTOR(31 downto 0);
signal fpga_buttons: STD_LOGIC_VECTOR(7 downto 0);
--signal wheel_home_sw: STD_LOGIC_VECTOR(3 downto 0);
--signal wheel_reverse_sw: STD_LOGIC_VECTOR(3 downto 0);
--signal wheel_forward_sw: STD_LOGIC_VECTOR(3 downto 0);
--signal wheel_driver_di: STD_LOGIC_VECTOR(7 downto 0);
--signal wheel_driver_do: STD_LOGIC_VECTOR(3 downto 0);
--signal sp2_single_ended_2_3: STD_LOGIC_VECTOR(1 downto 0);
--signal sp2_single_ended_1_0: STD_LOGIC_VECTOR(1 downto 0);
--signal sp2_analog_switch: STD_LOGIC_VECTOR(2 downto 0);
--signal sp2_diff_pair_2_3: STD_LOGIC_VECTOR(1 downto 0);
--signal sp2_diff_pair_1_0: STD_LOGIC_VECTOR(1 downto 0);
--signal sp1_single_ended_2_3: STD_LOGIC_VECTOR(1 downto 0);
--signal sp1_single_ended_1_0: STD_LOGIC_VECTOR(1 downto 0);
--signal sp1_analog_switch: STD_LOGIC_VECTOR(2 downto 0);
--signal sp1_diff_pair_2_3: STD_LOGIC_VECTOR(1 downto 0);
--signal sp1_diff_pair_1_0: STD_LOGIC_VECTOR(1 downto 0);
signal wheel_rod_sensor: STD_LOGIC_VECTOR(3 downto 0);
signal rst_n_meta: STD_LOGIC_VECTOR(7 downto 0);
--signal clk_100m: STD_LOGIC;
--signal rst_n: STD_LOGIC;
--signal clk_1m: STD_LOGIC;
--signal sclk: STD_LOGIC;
--signal cs_n: STD_LOGIC;
--signal mosi: STD_LOGIC;
--signal miso: STD_LOGIC;
signal data_mosi_rdy_in: STD_LOGIC;
signal data_mosi_rdy_out: STD_LOGIC;
signal data_miso_rdy_in: STD_LOGIC;
signal data_miso_rdy_out: STD_LOGIC;
signal addr_rdy: STD_LOGIC;
--signal pow: STD_LOGIC;
--signal wheel_driver_rst: STD_LOGIC;
--signal wheel_driver_abrt: STD_LOGIC;
--signal sync: STD_LOGIC;
--signal diag_activation: STD_LOGIC;
--signal teensy_estop_open_req: STD_LOGIC;
--signal teensy_open_elo_req: STD_LOGIC;
--signal miccb_estop_open_req: STD_LOGIC;
--signal FPGA_WHEEL_STOP_ELO: STD_LOGIC;
--signal estop_open: STD_LOGIC;
--signal estop_status: STD_LOGIC;

signal send_miso: STD_LOGIC;
--signal right_drape_sw_state: STD_LOGIC;
--signal left_drape_sw_state: STD_LOGIC;
--signal right_drape_em_state: STD_LOGIC;
--signal left_drape_em_state: STD_LOGIC;
--signal right_drape_em_open: STD_LOGIC;
--signal left_drape_em_open: STD_LOGIC;
--signal right_drape_close2_nc: STD_LOGIC;
--signal right_drape_close2_no: STD_LOGIC;
--signal right_drape_close1_nc: STD_LOGIC;
--signal right_drape_close1_no: STD_LOGIC;
--signal right_drape_open_nc: STD_LOGIC;
--signal right_drape_open_no: STD_LOGIC;
--signal left_drape_close2_nc: STD_LOGIC;
--signal left_drape_close2_no: STD_LOGIC;
--signal left_drape_close1_nc: STD_LOGIC;
--signal left_drape_close1_no: STD_LOGIC;
--signal left_drape_open_nc: STD_LOGIC;
--signal left_drape_open_no: STD_LOGIC;
--signal right_spare_diff_2: STD_LOGIC;
--signal right_spare_diff_1: STD_LOGIC;
--signal left_spare_diff_2: STD_LOGIC;
--signal left_spare_diff_1: STD_LOGIC;
--signal left_robot_rx: STD_LOGIC;
--signal right_robot_rx: STD_LOGIC;
signal teensy_spare3: STD_LOGIC;
--signal MICCB_SPARE_IO2: STD_LOGIC;
--signal MICCB_SPARE_IO3: STD_LOGIC;
signal rst_n_syn: STD_LOGIC;
--signal estop_delay: STD_LOGIC;
--signal left_robot_tx: STD_LOGIC;
--signal right_robot_tx: STD_LOGIC;
signal teensy_led1: STD_LOGIC;
signal teensy_led2: STD_LOGIC;
signal teensy_led3: STD_LOGIC;


BEGIN
reset_proc : process (clk_100m)
begin
    if rising_edge(clk_100m) then
        if rst_n_meta /= x"AD" then
            rst_n_meta <= rst_n_meta + '1';
        end if;
        
        if rst_n_meta = x"AA" then
            rst_n_syn <= '0';
        else
            rst_n_syn <= '1';
        end if;

        if not rst_n then
            rst_n_meta <= x"AA";
        end if;
    end if;
end process;

fpga_buttons(7) <= right_plunger_nc;
fpga_buttons(6) <= right_plunger_no;
fpga_buttons(5) <= left_plunger_nc;
fpga_buttons(4) <= left_plunger_no;
fpga_buttons(3) <= right_tool_ex_nc;
fpga_buttons(2) <= right_tool_ex_no;
fpga_buttons(1) <= left_tool_ex_nc;
fpga_buttons(0) <= left_tool_ex_no;

drape_sw_state(1) <= right_drape_sw_state;
drape_sw_state(0) <= left_drape_sw_state;
drape_em_state(1) <= right_drape_em_state;
drape_em_state(0) <= left_drape_em_state;

drape_sensor(11) <= right_drape_close2_nc;
drape_sensor(10) <= right_drape_close2_no;
drape_sensor(9) <= right_drape_close1_nc;
drape_sensor(8) <= right_drape_close1_no;
drape_sensor(7) <= right_drape_open_nc;
drape_sensor(6) <= right_drape_open_no;
drape_sensor(5) <= left_drape_close2_nc;
drape_sensor(4) <= left_drape_close2_no;
drape_sensor(3) <= left_drape_close1_nc;
drape_sensor(2) <= left_drape_close1_no;
drape_sensor(1) <= left_drape_open_nc;
drape_sensor(0) <= left_drape_open_no;

wheel_sensor(23 downto 0) <= wheel_d_sens3_in2&wheel_d_sens3_in1&wheel_d_sens2_in2&
wheel_d_sens2_in1&wheel_d_sens1_in2&wheel_d_sens1_in1&
wheel_c_sens3_in2&wheel_c_sens3_in1&wheel_c_sens2_in2&
wheel_c_sens2_in1&wheel_c_sens1_in2&wheel_c_sens1_in1&
wheel_b_sens3_in2&wheel_b_sens3_in1&wheel_b_sens2_in2&
wheel_b_sens2_in1&wheel_b_sens1_in2&wheel_b_sens1_in1&
wheel_a_sens3_in2&wheel_a_sens3_in1&wheel_a_sens2_in2&
wheel_a_sens2_in1&wheel_a_sens1_in2&wheel_a_sens1_in1;

right_tool_ex_led3 <= fpga_buttons_led_reg(14);
 right_tool_ex_led2 <= fpga_buttons_led_reg(13);
 right_tool_ex_led1 <= fpga_buttons_led_reg(12);
 left_tool_ex_led3 <= fpga_buttons_led_reg(10);
 left_tool_ex_led2 <= fpga_buttons_led_reg(9);
 left_tool_ex_led1 <= fpga_buttons_led_reg(8);
 right_plunger_led3 <= fpga_buttons_led_reg(6);
 right_plunger_led2 <= fpga_buttons_led_reg(5);
 right_plunger_led1 <= fpga_buttons_led_reg(4);
 left_plunger_led3 <= fpga_buttons_led_reg(2);
 left_plunger_led2 <= fpga_buttons_led_reg(1);
 left_plunger_led1 <= fpga_buttons_led_reg(0);
wheel_rod_sensor <= wheel_rod2_out1&wheel_rod2_out2&wheel_rod1_out1&wheel_rod1_out2;
miccb_estop_open_req <= teensy_estop_open_req;
FPGA_WHEEL_STOP_ELO <= teensy_open_elo_req;

MICCB_SPARE_IO2 <= 'Z';
MICCB_SPARE_IO3 <= 'Z';
teensy_spare3 <= 'Z';

process
begin
    estop_delay <= 'Z';
    left_robot_tx <= 'Z';
    right_robot_tx <= 'Z';
    teensy_led1 <= '0';
    teensy_led1 <= '1';
    teensy_led1 <= '0';
end process;

   -- Instantiate the rcb_spi module
    SpiModule : rcb_spi
        port map (
            clk_100m => clk_100m,
            rst_n_syn => rst_n_syn,
            sclk => sclk,
            cs_n => cs_n,
            mosi => mosi,
            miso_t => miso,
            data_miso => data_miso,
            data_mosi => data_mosi,
            data_mosi_rdy => data_mosi_rdy_out,
            addr => addr,
            addr_rdy => addr_rdy,
            data_miso_rdy => data_miso_rdy_out
        );
data_mosi_rdy_in <= data_mosi_rdy_out;
data_miso_rdy_in <= data_miso_rdy_out;
--RCB REGISRES insertion  
    rcb_registers_inst : rcb_registers
port map (
    clk_100m=>clk_100m,       	
    rst_n_syn=>rst_n_syn, 
	clk_1m=>clk_1m,
    data_miso=>data_miso,    
    data_mosi=>data_mosi,     
    data_mosi_rdy=>data_mosi_rdy_in, 
	addr=>addr,
	addr_rdy=>addr_rdy,
	data_miso_rdy=>data_miso_rdy_in,
	pow=>pow,
	fpga_buttons=>fpga_buttons,
	
	drape_sw_state=>drape_sw_state,
	drape_em_state=>drape_em_state,
	right_drape_em_open=>right_drape_em_open,
	left_drape_em_open=>left_drape_em_open,
	drape_sensor=>drape_sensor,

	wheel_home_sw=>wheel_home_sw,
	wheel_reverse_sw=>wheel_reverse_sw,
	wheel_forward_sw=>wheel_forward_sw,
	wheel_driver_di=>wheel_driver_di,
	--wheel_driver_elo=>wheel_driver_elo,
	wheel_driver_do=>wheel_driver_do,
	wheel_driver_rst=>wheel_driver_rst,
	wheel_driver_abrt=>wheel_driver_abrt,
	wheel_sensor=>wheel_sensor,
	fpga_buttons_led_reg=>fpga_buttons_led_reg,
	--estop_activation=>estop_activation,
	diag_activation=>diag_activation,
	estop_open=>estop_open,
	estop_status=>estop_status,
	diagnostic_led=>diagnostic_led,
	sp2_single_ended_2_3=>sp2_single_ended_2_3,
	sp2_single_ended_1_0=>sp2_single_ended_1_0,
	sp2_analog_switch=>sp2_analog_switch,
	sp2_diff_pair_2_3=>sp2_diff_pair_2_3,
	sp2_diff_pair_1_0=>sp2_diff_pair_1_0,
	sp1_single_ended_2_3=>sp1_single_ended_2_3,
	sp1_single_ended_1_0=>sp1_single_ended_1_0,
	sp1_analog_switch=>sp1_analog_switch,
	sp1_diff_pair_2_3=>sp1_diff_pair_2_3,
	sp1_diff_pair_1_0=>sp1_diff_pair_1_0,
	right_spare_diff_2=>right_spare_diff_2,
	right_spare_diff_1=>right_spare_diff_1,
	left_spare_diff_2=>left_spare_diff_2,
	left_spare_diff_1=>left_spare_diff_1,
	wheel_rod_sensor=>wheel_rod_sensor,
	fan1_tacho=>fan1_tacho,
	fan1_pwm=>fan1_pwm,
	fan2_tacho=>fan2_tacho,
	fan2_pwm=>fan2_pwm,
	trig_in=>trig_in
);

end Behavioral;
			
