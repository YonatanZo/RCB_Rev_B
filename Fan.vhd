library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RCB_TOP is
    port (
        RST_WD: In STD_LOGIC;
        A_24V_L_EN: Out STD_LOGIC;
        B_24V_L_EN: Out STD_LOGIC;
        A_24V_R_EN: Out STD_LOGIC;
        B_24V_R_EN: Out STD_LOGIC;
        A_35V_L_EN: Out STD_LOGIC;
        B_35V_L_EN: Out STD_LOGIC;
        A_35V_R_EN: Out STD_LOGIC;
        B_35V_R_EN: Out STD_LOGIC;
        BIT_SSR_SW: Out STD_LOGIC;
        CLK_100M: In STD_LOGIC;
        CONFIG_SEL: In STD_LOGIC;
        CPU_RESETn: In STD_LOGIC;
        CS0: In STD_LOGIC;
        ESTOP_DELAY: Out STD_LOGIC;
        ESTOP_OPEN_REQUEST: In STD_LOGIC;
        ESTOP_STATUS: In STD_LOGIC;
        ESTOP_STATUS_FAIL: In STD_LOGIC;
        FAN1_PWM: Out STD_LOGIC;
        FAN1_TACHO_BUFF: In STD_LOGIC;
        FAN2_PWM: Out STD_LOGIC;
        FAN2_TACHO_BUFF: In STD_LOGIC;
        FLA_PWR_DIS: In STD_LOGIC;
        FPGA4V_DIS: Out STD_LOGIC;
        FPGA_DIAG_ACT: Out STD_LOGIC;
        FPGA_ESTOP_REQ: Out STD_LOGIC;
        FPGA_FAULT: Out STD_LOGIC;
        FPGA_INT: Out STD_LOGIC;
        FPGA_L_ROBOT_RX: In STD_LOGIC;
        FPGA_L_ROBOT_TX: Out STD_LOGIC;
        FPGA_L_SP_TX: Out STD_LOGIC;
        FPGA_R_ROBOT_RX: In STD_LOGIC;
        FPGA_R_ROBOT_TX: Out STD_LOGIC;
        FPGA_R_SP_TX: Out STD_LOGIC;
        FPGA_WHEEL_STOP_ELO: Out STD_LOGIC;
        FPGA1: Out STD_LOGIC;
        FPGA10: Out STD_LOGIC;
        FPGA11: Out STD_LOGIC;
        FPGA12: Out STD_LOGIC;
        FPGA13: Out STD_LOGIC;
        FPGA2: Out STD_LOGIC;
        FPGA3: Out STD_LOGIC;
        FPGA4: Out STD_LOGIC;
        FPGA5: Out STD_LOGIC;
        FPGA6: Out STD_LOGIC;
        FPGA7: Out STD_LOGIC;
        FPGA8: Out STD_LOGIC;
        FPGA9: Out STD_LOGIC;
        L_TOOL_EX_LED_DIN: Out STD_LOGIC;
        L_4MB_SER_IN_ER: In STD_LOGIC;
        L_4MB_SER_IN_SE: In STD_LOGIC;
        L_EEF_SER_IN_ER: In STD_LOGIC;
        L_EEF_SER_IN_SE: In STD_LOGIC;
        L_LED_DIN: Out STD_LOGIC;
        L_M5B_SER_IN_ER: In STD_LOGIC;
        L_M5B_SER_IN_SE: In STD_LOGIC;
        L_NC_switch_TOOL_EX_FPGA: In STD_LOGIC;
        L_NO_switch_TOOL_EX_FPGA: In STD_LOGIC;
        L_POS_SENS_0_OUT1_BUFF: In STD_LOGIC;
        L_POS_SENS_0_OUT2_BUFF: In STD_LOGIC;
        L_POS_SENS_1_OUT1_BUFF: In STD_LOGIC;
        L_POS_SENS_1_OUT2_BUFF: In STD_LOGIC;
        L_POS_SENS_OUT1_BUFF: In STD_LOGIC;
        L_POS_SENS_OUT2_BUFF: In STD_LOGIC;
        L_ROBOT_DIFF_SP2: In STD_LOGIC;
        L_SCU_INVALIDn: In STD_LOGIC;
        L_SER_RX_ER: In STD_LOGIC;
        L_WHEEL_SENS_A1_OUT1_BUFF: In STD_LOGIC;
        L_WHEEL_SENS_A1_OUT2_BUFF: In STD_LOGIC;
        L_WHEEL_SENS_A2_OUT1_BUFF: In STD_LOGIC;
        L_WHEEL_SENS_A2_OUT2_BUFF: In STD_LOGIC;
        L_WHEEL_SENS_SPARE_OUT1_BUFF: In STD_LOGIC;
        L_WHEEL_SENS_SPARE_OUT2_BUFF: In STD_LOGIC;
        LED_1: Out STD_LOGIC;
        LED_2: Out STD_LOGIC;
        LED_3: Out STD_LOGIC;
        LED_4: Out STD_LOGIC;
        LED_5: Out STD_LOGIC;
        LED_6: Out STD_LOGIC;
        LED_7: Out STD_LOGIC;
        LED_8: Out STD_LOGIC;
        MICCB_SP_IN_A_F: In STD_LOGIC;
        MICCB_SP_IN_B_F: In STD_LOGIC;
        MicCB_ESTOP_OPEN_REQUEST: In STD_LOGIC;
        MICCB_GEN_SYNC_FAIL: In STD_LOGIC;
        MICCB_GEN_SYNC_FPGA: In STD_LOGIC;
        MICCB_SPARE_IO0: In STD_LOGIC;
        MICCB_SPARE_IO1: In STD_LOGIC;
        MICCB_SPARE_IO2: In STD_LOGIC;
        MICCB_SPARE_IO3: In STD_LOGIC;
        MISO0: Out STD_LOGIC;
        MOSI0: In STD_LOGIC;
        SCL_ADC: Out STD_LOGIC;
        SDA_ADC: Out STD_LOGIC;
        TEENSY_FPGA_R_RX: Out STD_LOGIC;
        TEENSY_FPGA_R_TX: In STD_LOGIC;
		  TEENSY_FPGA_L_RX: Out STD_LOGIC;
        TEENSY_FPGA_L_TX: In STD_LOGIC;
        OPEN_ELO_REQUEST: Out STD_LOGIC;
        PS_PG_FPGA: In STD_LOGIC;
        R_TOOL_EX_LED_DIN: Out STD_LOGIC;
        R_4MB_SER_IN_ER: In STD_LOGIC;
        R_4MB_SER_IN_SE: In STD_LOGIC;
        R_EEF_SER_IN_ER: In STD_LOGIC;
        R_EEF_SER_IN_SE: In STD_LOGIC;
        R_LED_DIN: Out STD_LOGIC;
        R_M5B_SER_IN_ER: In STD_LOGIC;
        R_M5B_SER_IN_SE: In STD_LOGIC;
        R_NC_switch_TOOL_EX_FPGA: In STD_LOGIC;
        R_NO_switch_TOOL_EX_FPGA: In STD_LOGIC;
        R_POS_SENS_0_OUT1_BUFF: In STD_LOGIC;
        R_POS_SENS_0_OUT2_BUFF: In STD_LOGIC;
        R_POS_SENS_1_OUT1_BUFF: In STD_LOGIC;
        R_POS_SENS_1_OUT2_BUFF: In STD_LOGIC;
        R_POS_SENS_OUT1_BUFF: In STD_LOGIC;
        R_POS_SENS_OUT2_BUFF: In STD_LOGIC;
        R_ROBOT_DIFF_SP1: In STD_LOGIC;
        R_ROBOT_DIFF_SP2: In STD_LOGIC;
        R_SCU_Invalid_n: In STD_LOGIC;
        R_SER_RX_ER: In STD_LOGIC;
        R_WHEEL_SENS_A1_OUT1_BUFF: In STD_LOGIC;
        R_WHEEL_SENS_A1_OUT2_BUFF: In STD_LOGIC;
        R_WHEEL_SENS_A2_OUT1_BUFF: In STD_LOGIC;
        R_WHEEL_SENS_A2_OUT2_BUFF: In STD_LOGIC;
        R_WHEEL_SENS_SPARE_OUT1_BUFF: In STD_LOGIC;
        R_WHEEL_SENS_SPARE_OUT2_BUFF: In STD_LOGIC;
        ROBOT_ESTOP_LED_DIN: Out STD_LOGIC;
        S_LED_DIN: Out STD_LOGIC;
        SCK0: In STD_LOGIC;
        SPARE1_ANALOG_SW_0_SEL_FPGA: In STD_LOGIC;
        SPARE1_ANALOG_SW_1_SEL_FPGA: In STD_LOGIC;
        SPARE1_ANALOG_SW_SEL_FPGA: In STD_LOGIC;
        SPARE1_DIFF0: In STD_LOGIC;
        SPARE1_DIFF1: In STD_LOGIC;
        SPARE1_DIFF2: In STD_LOGIC;
        SPARE1_DIFF3: In STD_LOGIC;
        SPARE1_IO0_FPGA: In STD_LOGIC;
        SPARE1_IO1_FPGA: In STD_LOGIC;
        SPARE1_IO2_FPGA: In STD_LOGIC;
        SPARE1_IO3_FPGA: In STD_LOGIC;
        SPARE2_ANALOG_SW_0_SEL_FPGA: In STD_LOGIC;
        SPARE2_ANALOG_SW_1_SEL_FPGA: In STD_LOGIC;
        SPARE2_ANALOG_SW_SEL_FPGA: In STD_LOGIC;
        SPARE2_DIFF0: In STD_LOGIC;
        SPARE2_DIFF1: In STD_LOGIC;
        SPARE2_DIFF2: In STD_LOGIC;
        SPARE2_DIFF3: In STD_LOGIC;
        SPARE2_IO0_FPGA: In STD_LOGIC;
        SPARE2_IO1_FPGA: In STD_LOGIC;
        SPARE2_IO2_FPGA: In STD_LOGIC;
        SPARE2_IO3_FPGA: In STD_LOGIC;
        SSR_ON_FPGA: In STD_LOGIC;
        Teensy_FPGA_SP0: In STD_LOGIC;
        Teensy_FPGA_SP1: In STD_LOGIC;
        Teensy_FPGA_SP2: In STD_LOGIC;
        TEENSY_LEDS_STRIP_DO: In STD_LOGIC
    );
end entity RCB_TOP;

architecture Behavioral of RCB_TOP is


COMPONENT rcb_registers
	GENERIC ( FPGA_MAJOR_VER : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"03";
FPGA_REV : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"01";
FPGA_REV_YEAR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"17";
FPGA_REV_MONTH : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"03";
FPGA_REV_DAY : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"07";
FPGA_REV_HOUR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08";
SPI_COM_LEN : INTEGER := 8;
SPI_ADDR_LEN : INTEGER;
SPI_DATA_LEN : INTEGER;
WRITE_COM : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"0A";
READ_COM : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"0F";
WRITE_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
READ_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
UNDEF_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
ADDR_FPGA_VER : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
ADDR_FPGA_REV_DATA : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0001";
ADDR_FPGA_POW_DIAG : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0002";
ADDR_FPGA_BUTTONS : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0003";
ADDR_FPGA_DRAPE_SW_STATE : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0004";
ADDR_FPGA_DRAPE_EM_STATE : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0005";
ADDR_FPGA_DRAPE_SW_APPROVAL : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0006";
ADDR_FPGA_DRAPE_SENSOR : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0007";
ADDR_FPGA_WHEEL_DRIVER_OUT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0008";
ADDR_FPGA_WHEEL_DRIVER_ELO : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0009";
ADDR_FPGA_WHEEL_DRIVER_IN : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000A";
ADDR_FPGA_WHEEL_DRIVER_ABRT : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000B";
ADDR_FPGA_WHEEL_SENSOR : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000C";
ADDR_FPGA_BUTTONS_LED : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000D";
ADDR_FPGA_ESTOP_STATUS : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000E";
ADDR_FPGA_ESTOP_ACTIVATION : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000F";
ADDR_FPGA_ESTOP_DIAGNOSTIC : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0010";
ADDR_FPGA_ESTOP_OPEN : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0011";
ADDR_FPGA_DIAGNOSTIC_LEDS : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0012";
ADDR_FPGA_SPARE_IO : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0013";
ADDR_FPGA_SPARE_4MB : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0014";
ADDR_FPGA_WHEEL_ROD : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0015";
ADDR_FPGA_FAN1_TACHO : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0016";
ADDR_FPGA_FAN1_PWM : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0017";
ADDR_FPGA_FAN2_TACHO : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0018";
ADDR_FPGA_FAN2_PWM : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0019";
NUM_REG : INTEGER := 26;
ESTOP_DIAG_ACTIV : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00002AFD";
ESTOP_ACTIVATION_PULSE : INTEGER := 100000;
FAN_TACHO_MES_PERIOD : STD_LOGIC_VECTOR(25 DOWNTO 0) := x"0019A850";
DEB_DEEP : INTEGER := 3;
MOSI_DATA : INTEGER := 3;
MISO_DATA : INTEGER := 4);
	PORT
	(
		clk_100m		:	 IN STD_LOGIC;
		rst_n_syn		:	 IN STD_LOGIC;
		clk_1m		:	 IN STD_LOGIC;
		data_miso		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_mosi		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_mosi_rdy		:	 IN STD_LOGIC;
		addr		:	 IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		addr_rdy		:	 IN STD_LOGIC;
		data_miso_rdy		:	 IN STD_LOGIC;
		pow		:	 IN STD_LOGIC;
		fpga_buttons		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		drape_sw_state		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		drape_em_state		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		drape_sensor		:	 IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		right_drape_em_open		:	 OUT STD_LOGIC;
		left_drape_em_open		:	 OUT STD_LOGIC;
		wheel_home_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_reverse_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_forward_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_driver_di		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		wheel_driver_do		:	 IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_driver_rst		:	 OUT STD_LOGIC;
		wheel_driver_abrt		:	 OUT STD_LOGIC;
		wheel_sensor		:	 IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		fpga_buttons_led_reg		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		diag_activation		:	 OUT STD_LOGIC;
		estop_open		:	 OUT STD_LOGIC;
		estop_status		:	 IN STD_LOGIC;
		diagnostic_led		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		sp2_single_ended_2_3		:	 OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp2_single_ended_1_0		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp2_analog_switch		:	 OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		sp2_diff_pair_2_3		:	 OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp2_diff_pair_1_0		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp1_single_ended_2_3		:	 OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp1_single_ended_1_0		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp1_analog_switch		:	 OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		sp1_diff_pair_2_3		:	 OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		sp1_diff_pair_1_0		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		right_spare_diff_2		:	 OUT STD_LOGIC;
		right_spare_diff_1		:	 IN STD_LOGIC;
		left_spare_diff_2		:	 OUT STD_LOGIC;
		left_spare_diff_1		:	 IN STD_LOGIC;
		wheel_rod_sensor		:	 IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		fan1_tacho		:	 IN STD_LOGIC;
		fan1_pwm		:	 OUT STD_LOGIC;
		fan2_tacho		:	 IN STD_LOGIC;
		fan2_pwm		:	 OUT STD_LOGIC
	);
END COMPONENT;


COMPONENT rcb_spi
	GENERIC (SPI_COM_LEN : INTEGER := 8;
	WRITE_COM : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"0A";
	READ_COM : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"0F";
	WRITE_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	READ_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "01";
	UNDEF_MODE : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
	NUM_REG : INTEGER := 26;
	DEB_DEEP : INTEGER := 3;
	MOSI_DATA : INTEGER := 3;
	MISO_DATA : INTEGER := 4);
	PORT
	(
		clk_100m		:	 IN STD_LOGIC;
		rst_n_syn		:	 IN STD_LOGIC;
		sclk		:	 IN STD_LOGIC;
		cs_n		:	 IN STD_LOGIC;
		mosi		:	 IN STD_LOGIC;
		miso_t		:	 OUT STD_LOGIC;
		data_miso		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_mosi		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_mosi_rdy		:	 OUT STD_LOGIC;
		addr		:	 OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		addr_rdy		:	 OUT STD_LOGIC;
		data_miso_rdy		:	 OUT STD_LOGIC
	);
END COMPONENT;

signal rst_n_syn            :   STD_LOGIC := '1';
signal counter : integer range 0 to 99 := 0;
signal clk_1m_internal : STD_LOGIC := '0';
signal data_miso       :   STD_LOGIC_VECTOR(31 DOWNTO 0);
signal data_mosi       :   STD_LOGIC_VECTOR(31 DOWNTO 0);
signal data_mosi_rdy   :   STD_LOGIC;
signal addr            :   STD_LOGIC_VECTOR(15 DOWNTO 0);
signal addr_rdy        :   STD_LOGIC;
signal data_miso_rdy   :   STD_LOGIC;

begin

	rcb_spi_inst : rcb_spi
    PORT MAP (
	 
        clk_100m => CLK_100M,
        rst_n_syn => rst_n_syn,
        sclk => SCK0,
        cs_n => CS0,
        mosi => MOSI0,
        miso_t => MISO0,
		  
        data_miso => data_miso,
        data_mosi => data_mosi,
        data_mosi_rdy => data_mosi_rdy,
        addr => addr,
        addr_rdy => addr_rdy,
        data_miso_rdy => data_miso_rdy
    );
	 
	rcb_registers_inst : rcb_registers
    PORT MAP (
	 
		clk_100m		  => CLK_100M,
		rst_n_syn	  => rst_n_syn,
		clk_1m		  => clk_1m_internal,
		data_miso	  => data_miso,
		data_mosi	  => data_mosi,
		data_mosi_rdy => data_mosi_rdy,
		addr		     => addr,
		addr_rdy		  => addr_rdy,
		data_miso_rdy => data_miso_rdy,
		
		pow		:	 IN STD_LOGIC;
		
		fpga_buttons		:	 IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		
		drape_sw_state		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		
		drape_em_state		:	 IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		
		drape_sensor		:	 IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		
		right_drape_em_open		:	 OUT STD_LOGIC;
		
		left_drape_em_open		:	 OUT STD_LOGIC;
		
		wheel_home_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_reverse_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_forward_sw		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_driver_di		:	 OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		wheel_driver_do		:	 IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		wheel_driver_rst		:	 OUT STD_LOGIC;
		wheel_driver_abrt		:	 OUT STD_LOGIC;
		wheel_sensor		:	 IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		
		fpga_buttons_led_reg		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		diag_activation		:	 OUT STD_LOGIC;
		estop_open		:	 OUT STD_LOGIC;
		estop_status		:	 IN STD_LOGIC;
		diagnostic_led		=> LED_8 & LED_7 & LED_6 & LED_5 & LED_4 & LED_3 &	LED_2 & LED_1,
		sp2_single_ended_2_3		=> open,
		sp2_single_ended_1_0	=> "00",
		sp2_analog_switch		=> open,
		sp2_diff_pair_2_3		=> open,
		sp2_diff_pair_1_0		=> "00",
		sp1_single_ended_2_3		=> open,
		sp1_single_ended_1_0	=> "00",
		sp1_analog_switch		=> open,
		sp1_diff_pair_2_3		=> open,
		sp1_diff_pair_1_0		=> "00",
		right_spare_diff_2	=> open,
		right_spare_diff_1	=> '0',	
		left_spare_diff_2		=> open,
		left_spare_diff_1		=> '0',
		
		wheel_rod_sensor		:	 IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		fan1_tacho		=> FAN1_TACHO_BUFF,
		fan1_pwm		=> FAN1_PWM,
		fan2_tacho	=> FAN2_TACHO_BUFF,
		fan2_pwm		=> FAN2_PWM
    );

    -- Clock division process
    process(CLK_100M, rst_n_syn)
    begin
        if rst_n_syn = '0' then
            counter <= 0;
            clk_1m_internal <= '0';
        elsif rising_edge(CLK_100M) then
            if counter = 99 then
                counter <= 0;
                clk_1m_internal <= not clk_1m_internal;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
	 
	 
	ESTOP_DELAY <= 'Z';
	LED_1 <= '1';
	LED_2 <= '1';
	LED_3 <= '1';
end Behavioral;
