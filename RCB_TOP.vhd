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
        SCL_ADC: InOut STD_LOGIC;
        SDA_ADC: InOut STD_LOGIC;
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
        SPARE1_ANALOG_SW_0_SEL_FPGA: out STD_LOGIC;
        SPARE1_ANALOG_SW_1_SEL_FPGA: out STD_LOGIC;
        SPARE1_ANALOG_SW_SEL_FPGA: out STD_LOGIC;
        SPARE1_DIFF0: In STD_LOGIC;
        SPARE1_DIFF1: In STD_LOGIC;
        SPARE1_DIFF2: out STD_LOGIC;
        SPARE1_DIFF3: out STD_LOGIC;
        SPARE1_IO0_FPGA: In STD_LOGIC;
        SPARE1_IO1_FPGA: In STD_LOGIC;
        SPARE1_IO2_FPGA: out STD_LOGIC;
        SPARE1_IO3_FPGA: out STD_LOGIC;
        SPARE2_ANALOG_SW_0_SEL_FPGA: out STD_LOGIC;
        SPARE2_ANALOG_SW_1_SEL_FPGA: out STD_LOGIC;
        SPARE2_ANALOG_SW_SEL_FPGA: out STD_LOGIC;
        SPARE2_DIFF0: In STD_LOGIC;
        SPARE2_DIFF1: In STD_LOGIC;
        SPARE2_DIFF2: out STD_LOGIC;
        SPARE2_DIFF3: out STD_LOGIC;
        SPARE2_IO0_FPGA: In STD_LOGIC;
        SPARE2_IO1_FPGA: In STD_LOGIC;
        SPARE2_IO2_FPGA: out STD_LOGIC;
        SPARE2_IO3_FPGA: out STD_LOGIC;
        SSR_ON_FPGA: In STD_LOGIC;
        Teensy_FPGA_SP0: out STD_LOGIC;
        Teensy_FPGA_SP1: out STD_LOGIC;
        Teensy_FPGA_SP2: out STD_LOGIC;
        TEENSY_LEDS_STRIP_DO: In STD_LOGIC
    );
end entity RCB_TOP;

architecture Behavioral of RCB_TOP is

  COMPONENT i2c_top
    PORT (
      clk      : IN  STD_LOGIC;
      reset_n  : IN  STD_LOGIC;
      scl      : INOUT  STD_LOGIC;
      sda      : INOUT  STD_LOGIC;
      AIN0 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN1 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN2 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN3 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN4 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN5 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN6 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
      AIN7 : out STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
  END COMPONENT;

  component FAN
port (
    RST_N : in STD_LOGIC;
    CLK : in STD_LOGIC;
    TACHO_IN : in STD_LOGIC;
    PWM_OUT : out STD_LOGIC;
    FAN_TACHO_REG : out STD_LOGIC_VECTOR(15 DOWNTO 0);
    FAN_PWM_REG : in STD_LOGIC_VECTOR(7 DOWNTO 0)
);
end component;
component UART_TOP
  port (
    CLK : in std_logic;
    RST_N : in std_logic;
    RXD_4MB : in std_logic;
    RXD_M5B : in std_logic;
    RXD_EFF : in std_logic;
    TXD_TEENSY : out std_logic
  );
end component;
COMPONENT rcb_registers is
    port (
        --Interfaces 
        -- System signals
        clk_100m                    : in  STD_LOGIC                    ; -- system clock
        rst_n_syn                   : in  STD_LOGIC                    ; -- low active synchronous reset
        clk_1m                      : in  STD_LOGIC                    ;
        -- SPI I/F
        data_miso                   : out STD_LOGIC_VECTOR(31 downto 0); -- data for transmission to SPI master
        data_mosi                   : in  STD_LOGIC_VECTOR(31 downto 0); -- received data from SPI master
        data_mosi_rdy               : in  STD_LOGIC                    ; -- when 1, received data is valid
        addr                        : in  STD_LOGIC_VECTOR(15 downto 0); -- received data from SPI master
        addr_rdy                    : in  STD_LOGIC                    ; -- when 1, received address is valid
        data_miso_rdy               : in  STD_LOGIC                    ;
        --Fan1 I/F
        FAN_TACHO_REG_OUT_1 : in STD_LOGIC_VECTOR(15 DOWNTO 0) ;
        FAN_PWM_REG_OUT_1 : out STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        --Fan1 I/F
        FAN_TACHO_REG_OUT_2 : in STD_LOGIC_VECTOR(15 DOWNTO 0) ;
        FAN_PWM_REG_OUT_2 : out STD_LOGIC_VECTOR(7 DOWNTO 0) ;
        --ADC I/F
        AIN0: in STD_LOGIC_VECTOR(15 downto 0);
        AIN1: in STD_LOGIC_VECTOR(15 downto 0);
        AIN2: in STD_LOGIC_VECTOR(15 downto 0);
        AIN3: in STD_LOGIC_VECTOR(15 downto 0);
        AIN4: in STD_LOGIC_VECTOR(15 downto 0);
        AIN5: in STD_LOGIC_VECTOR(15 downto 0);
        AIN6: in STD_LOGIC_VECTOR(15 downto 0);
        AIN7: in STD_LOGIC_VECTOR(15 downto 0);
        --Debug LEDs 
        FPGA_LEDs_OUT  : out STD_LOGIC_VECTOR(7 downto 0 );
        ----Diagnostic R I/F
        R_DIAG_PACK_CNT : in STD_LOGIC_VECTOR(15 downto 0); --TODO
        R_DIAG_ERR_CNT : in STD_LOGIC_VECTOR(15 downto 0);--TODO
        ----Diagnostic L I/F     
        L_DIAG_PACK_CNT : in STD_LOGIC_VECTOR(15 downto 0);--TODO
        L_DIAG_ERR_CNT : in STD_LOGIC_VECTOR(15 downto 0); --TODO
        --regs IN/OUTs
        --FPGA__buttons_
        L_NO_switch_TOOL_EX_FPGA    : in  STD_LOGIC                    ;
        L_NC_switch_TOOL_EX_FPGA    : in  STD_LOGIC                    ;
        R_NO_switch_TOOL_EX_FPGA    : in  STD_LOGIC                    ;
        R_NC_switch_TOOL_EX_FPGA    : in  STD_LOGIC                    ;
        --L_Wheels_sensors
        L_POS_SENS_0_OUT1           : in  STD_LOGIC                    ;
        L_POS_SENS_0_OUT2           : in  STD_LOGIC                    ;
        L_POS_SENS_1_OUT1           : in  STD_LOGIC                    ;
        L_POS_SENS_1_OUT2           : in  STD_LOGIC                    ;
        L_POS_SENS_OUT1             : in  STD_LOGIC                    ;
        L_POS_SENS_OUT2             : in  STD_LOGIC                    ;
        L_WHEEL_SENS_A1_OUT1        : in  STD_LOGIC                    ;
        L_WHEEL_SENS_A1_OUT2        : in  STD_LOGIC                    ;
        L_WHEEL_SENS_A2_OUT1        : in  STD_LOGIC                    ;
        L_WHEEL_SENS_A2_OUT2        : in  STD_LOGIC                    ;
        L_WHEEL_SENS_SPARE_OUT1     : in  STD_LOGIC                    ;
        L_WHEEL_SENS_SPARE_OUT2     : in  STD_LOGIC                    ;
        --R_Wheels_sensors
        R_POS_SENS_0_OUT1           : in  STD_LOGIC                    ;
        R_POS_SENS_0_OUT2           : in  STD_LOGIC                    ;
        R_POS_SENS_1_OUT1           : in  STD_LOGIC                    ;
        R_POS_SENS_1_OUT2           : in  STD_LOGIC                    ;
        R_POS_SENS_OUT1             : in  STD_LOGIC                    ;
        R_POS_SENS_OUT2             : in  STD_LOGIC                    ;
        R_WHEEL_SENS_A1_OUT1        : in  STD_LOGIC                    ;
        R_WHEEL_SENS_A1_OUT2        : in  STD_LOGIC                    ;
        R_WHEEL_SENS_A2_OUT1        : in  STD_LOGIC                    ;
        R_WHEEL_SENS_A2_OUT2        : in  STD_LOGIC                    ;
        R_WHEEL_SENS_SPARE_OUT1     : in  STD_LOGIC                    ;
        R_WHEEL_SENS_SPARE_OUT2     : in  STD_LOGIC                    ;
        --Right_Recivers_Error
        R_4MB_SER_IN_ER             : in  STD_LOGIC                    ;
        R_EEF_SER_IN_ER             : in  STD_LOGIC                    ;
        R_M5B_SER_IN_ER             : in  STD_LOGIC                    ;
        R_SER_RX_ER                 : in  STD_LOGIC                    ;
        R_SCU_Invalid_n             : in  STD_LOGIC                    ;
        --Left_Recivers_Error
        L_4MB_SER_IN_ER             : in  STD_LOGIC                    ;
        L_EEF_SER_IN_ER             : in  STD_LOGIC                    ;
        L_M5B_SER_IN_ER             : in  STD_LOGIC                    ;
        L_SER_RX_ER                 : in  STD_LOGIC                    ;
        L_SCU_INVALIDn              : in  STD_LOGIC                    ;
        --SSRs_Left
        A_24V_L_EN                  : out STD_LOGIC                    ;
        B_24V_L_EN                  : out STD_LOGIC                    ;
        A_35V_L_EN                  : out STD_LOGIC                    ;
        B_35V_L_EN                  : out STD_LOGIC                    ;
        --SSRs_Right
        A_24V_R_EN                  : out STD_LOGIC                    ;
        B_24V_R_EN                  : out STD_LOGIC                    ;
        A_35V_R_EN                  : out STD_LOGIC                    ;
        B_35V_R_EN                  : out STD_LOGIC                    ;
        BIT_SSR_SW                  : out STD_LOGIC                    ;
        --LEDs_strip_Mux
        MUX_Control  : out STD_LOGIC_VECTOR(2 downto 0);
        --Mic.C.B
        MICCB_GEN_SYNC_FAIL         : in  STD_LOGIC                    ;
        MICCB_SP_IN_A_F             : in  STD_LOGIC                    ;
        MICCB_SP_IN_B_F             : in  STD_LOGIC                    ;
        MICCB_SPARE_IO0             : in  STD_LOGIC                    ;
        MICCB_SPARE_IO1             : in  STD_LOGIC                    ;
        MICCB_SPARE_IO2             : in  STD_LOGIC                    ;
        MICCB_SPARE_IO3             : in  STD_LOGIC                    ;
        --FPGA Spare out
        FPGA1                       : out STD_LOGIC                    ;
        FPGA2                       : out STD_LOGIC                    ;
        FPGA3                       : out STD_LOGIC                    ;
        FPGA4                       : out STD_LOGIC                    ;
        FPGA5                       : out STD_LOGIC                    ;
        FPGA6                       : out STD_LOGIC                    ;
        FPGA7                       : out STD_LOGIC                    ;
        FPGA8                       : out STD_LOGIC                    ;
        FPGA9                       : out STD_LOGIC                    ;
        FPGA10                      : out STD_LOGIC                    ;
        FPGA11                      : out STD_LOGIC                    ;
        FPGA12                      : out STD_LOGIC                    ;
        FPGA13                      : out STD_LOGIC                    ;
        Teensy_FPGA_SP0             : out STD_LOGIC                    ;
        Teensy_FPGA_SP1             : out STD_LOGIC                    ;
        Teensy_FPGA_SP2             : out STD_LOGIC                    ;
        --ADC Voltage 0
        P35V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        Spare                       : in  STD_LOGIC_VECTOR(15 downto 0);
        --ADC Voltage 1
        P12V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        P3_3V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);   
        --ADC Voltage 2
        P5V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        P2_5V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        --ADC Voltage 3
        P24V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        P12V_PS_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
        --FPGA Spare
        SPARE1_DIFF0                : in  STD_LOGIC                    ;
        SPARE1_DIFF1                : in  STD_LOGIC                    ;
        SPARE1_DIFF2                : out STD_LOGIC                    ;
        SPARE1_DIFF3                : out STD_LOGIC                    ;
        SPARE1_ANALOG_SW_0_SEL_FPGA : out STD_LOGIC                    ;
        SPARE1_ANALOG_SW_1_SEL_FPGA : out STD_LOGIC                    ;
        SPARE1_ANALOG_SW_SEL_FPGA   : out STD_LOGIC                    ;
        SPARE1_IO0_FPGA             : in  STD_LOGIC                    ;
        SPARE1_IO1_FPGA             : in  STD_LOGIC                    ;
        SPARE1_IO2_FPGA             : out STD_LOGIC                    ;
        SPARE1_IO3_FPGA             : out STD_LOGIC                    ;
        SPARE2_DIFF0                : in  STD_LOGIC                    ;
        SPARE2_DIFF1                : in  STD_LOGIC                    ;
        SPARE2_DIFF2                : out STD_LOGIC                    ;
        SPARE2_DIFF3                : out STD_LOGIC                    ;
        SPARE2_ANALOG_SW_0_SEL_FPGA : out STD_LOGIC                    ;
        SPARE2_ANALOG_SW_1_SEL_FPGA : out STD_LOGIC                    ;
        SPARE2_ANALOG_SW_SEL_FPGA   : out STD_LOGIC                    ;
        SPARE2_IO0_FPGA             : in  STD_LOGIC                    ;
        SPARE2_IO1_FPGA             : in  STD_LOGIC                    ;
        SPARE2_IO2_FPGA             : out STD_LOGIC                    ;
        SPARE2_IO3_FPGA             : out STD_LOGIC                    ;
        --FLA PS
        FPGA_WHEEL_STOP_ELO         : out STD_LOGIC                    ;
        FPGA24V_DIS                 : out STD_LOGIC                    ;
        FLA_PWR_DIS                 : in STD_LOGIC                    ;
        OPEN_ELO_REQUEST            : out  STD_LOGIC                    ;
        PS_PG_FPGA                  : in  STD_LOGIC                    ;
        --FPGA FAN 1 Tacho
        FAN1_TACHO                  : out STD_LOGIC_VECTOR(15 downto 0);
        FAN_1_READ_NUMBER           : out STD_LOGIC_VECTOR(15 downto 0);
        --FPGA FAN 1 PWM
        FAN_1_PWM                   : in  STD_LOGIC_VECTOR(7 downto 0) ;
        --FPGA FAN 2 Tacho
        FAN_2_TACHO                 : out STD_LOGIC_VECTOR(15 downto 0);
        FAN_2_READ_NUMBER           : out STD_LOGIC_VECTOR(15 downto 0);
        --FPGA FAN 2 PWM  
        FAN_2_PWM                   : in  STD_LOGIC_VECTOR(7 downto 0) ;
        --FPGA SYNC DELAY TIME
        FPGA_SYNC_DELAY_TIME        : out STD_LOGIC_VECTOR(31 downto 0);
        --FPGA SYNC TIME
        FPGA_SYNC_TIME              : out STD_LOGIC_VECTOR(31 downto 0);
        --Fault Registers
        CS_ERROR                    : out STD_LOGIC                    ;
        MicCB_ESTOP_OPEN_REQUEST    : in  STD_LOGIC                    ;
        ESTOP_STATUS_FAIL           : in  STD_LOGIC                    ;
        SSR_ON_FPGA                 : in  STD_LOGIC                    ;
        FPGA_DIAG_ACT               : out STD_LOGIC                    ;
        FPGA_FAULT                  : out STD_LOGIC                    ;
        RST_WD                      : in  STD_LOGIC                    ;
        --Sync Timer
        MicCB_SYNC_CNT              : in STD_LOGIC_VECTOR(31 downto 0)
    );
end COMPONENT;

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

-- component ADC_Master
--   generic (
--     input_clk : INTEGER;
--     bus_clk : INTEGER;
--     dev_id    : STD_LOGIC_VECTOR(6 DOWNTO 0)
--   );
--   port (
--     clk : in STD_LOGIC;
--     reset_n : in STD_LOGIC;
--     AIN0 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN1 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN2 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN3 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN4 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN5 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN6 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     AIN7 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
--     debug : OUT     STD_LOGIC_VECTOR(7 DOWNTO 0);
--     sda : inout STD_LOGIC;
--     scl : inout STD_LOGIC
--   );
-- end component;



component UART_PLL
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
end component;

-- component reset is
--   port (
--     source : out std_logic_vector(0 downto 0)   -- source
--   );
-- end component reset;

constant L_TOOL_EX :std_logic_vector(2 downto 0) := "000";
constant L_LED_Strip :std_logic_vector(2 downto 0) := "001"; 
constant R_Tool_Ex :std_logic_vector(2 downto 0) := "010";
constant R_LED_Stirp :std_logic_vector(2 downto 0) := "011";
constant WS_LED_Strip :std_logic_vector(2 downto 0) := "100";
constant Robot_ESTOP_LED :std_logic_vector(2 downto 0) := "101";


signal rst_n_syn            :   STD_LOGIC := '1';

signal clk_1m_internal : STD_LOGIC := '0';
signal data_miso       :   STD_LOGIC_VECTOR(31 DOWNTO 0);
signal data_mosi       :   STD_LOGIC_VECTOR(31 DOWNTO 0);
signal data_mosi_rdy   :   STD_LOGIC;
signal addr            :   STD_LOGIC_VECTOR(15 DOWNTO 0);
signal addr_rdy        :   STD_LOGIC;
signal data_miso_rdy   :   STD_LOGIC;
signal FAN_TACHO_REG_OUT_1 :   STD_LOGIC_VECTOR(15 DOWNTO 0);
signal FAN_PWM_REG_OUT_1 :   STD_LOGIC_VECTOR(7 DOWNTO 0);
signal FAN_TACHO_REG_OUT_2 :   STD_LOGIC_VECTOR(15 DOWNTO 0);
signal FAN_PWM_REG_OUT_2 :   STD_LOGIC_VECTOR(7 DOWNTO 0);

  signal AIN0     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN1     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN2     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN3     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN4     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN5     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN6     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal AIN7     : STD_LOGIC_VECTOR(15 DOWNTO 0);


  signal FPGA_LEDs_OUT        : STD_LOGIC_VECTOR(7 downto 0 );
  signal R_DIAG_PACK_CNT      : STD_LOGIC_VECTOR(15 downto 0);
  signal R_DIAG_ERR_CNT       : STD_LOGIC_VECTOR(15 downto 0);
  signal L_DIAG_PACK_CNT      : STD_LOGIC_VECTOR(15 downto 0);
  signal L_DIAG_ERR_CNT       : STD_LOGIC_VECTOR(15 downto 0);
  signal MUX_Control          : STD_LOGIC_VECTOR(2 downto 0);
  signal P35V_Monitor         : STD_LOGIC_VECTOR(15 downto 0);
  signal Spare                : STD_LOGIC_VECTOR(15 downto 0);
  signal P12V_Monitor         : STD_LOGIC_VECTOR(15 downto 0);
  signal P3_3V_Monitor        : STD_LOGIC_VECTOR(15 downto 0);
  signal P5V_Monitor          : STD_LOGIC_VECTOR(15 downto 0);
  signal P2_5V_Monitor        : STD_LOGIC_VECTOR(15 downto 0);
  signal P24V_Monitor         : STD_LOGIC_VECTOR(15 downto 0);
  signal P12V_PS_Monitor      : STD_LOGIC_VECTOR(15 downto 0);
  signal FPGA24V_DIS          : STD_LOGIC;
  signal FAN_1_READ_NUMBER    : STD_LOGIC_VECTOR(15 downto 0);
  signal FAN_1_PWM            : STD_LOGIC_VECTOR(7 downto 0);
  signal FAN_2_TACHO          : STD_LOGIC_VECTOR(15 downto 0);
  signal FAN_2_READ_NUMBER    : STD_LOGIC_VECTOR(15 downto 0);
  signal FAN_2_PWM            : STD_LOGIC_VECTOR(7 downto 0);
  signal FPGA_SYNC_DELAY_TIME : STD_LOGIC_VECTOR(31 downto 0);
  signal FPGA_SYNC_TIME       : STD_LOGIC_VECTOR(31 downto 0);
  signal CS_ERROR             : STD_LOGIC;
  signal MicCB_SYNC_CNT       : STD_LOGIC_VECTOR(31 downto 0);
  signal rst_syn             : STD_LOGIC;
  signal UART_CLK             : STD_LOGIC; --200MHz
  signal UART_rstn             : STD_LOGIC;
  signal MICCB_GEN_SYNC_FPGA_F  : STD_LOGIC;
  signal MICCB_GEN_SYNC_FPGA_FF  : STD_LOGIC;
  signal MICCB_GEN_SYNC_FPGA_SYN  : STD_LOGIC;
  ---------------debug only-------------------
  -- signal pc_rst       : STD_LOGIC_VECTOR(0 downto 0);
  -- signal debug_rstn       : STD_LOGIC;
  -- signal counter : integer range 0 to 99_999_999 := 0;
  -- signal SDA_ADC_sig  : STD_LOGIC := '1';
  -- signal SCL_ADC_sig  : STD_LOGIC;
  -- SIGNAL internal_start : STD_LOGIC;
  ---------------debug end--------------------
begin

---------------debug only-------------------
-- reset_u : component reset
-- port map (
--   source => pc_rst  -- sources.source
-- );

-- debug_reset_Counter:process (rst_n_syn,CLK_100M)
-- begin
--   if rst_n_syn = '0' then
--     counter<= 0;
--     debug_rstn <= '0';
--   elsif rising_edge(CLK_100M) then
--     if counter /= 99_999_999 then
--       counter <= counter + 1 ;
--     else 
--       counter <= 0;
--     end if;
--     case counter is
--       when 0 to  99_998_999 =>
--         debug_rstn <= '1';
--       when others =>
--         debug_rstn <= '0';
--     end case;
--   end if;
-- end process;


i2c_top_inst : i2c_top
PORT MAP (
  clk      => CLK_100M,
  reset_n  => rst_syn, --debug_rstn,
  scl      => SCL_ADC,
  sda      => SDA_ADC,
  AIN0 => AIN0,
  AIN1 => AIN1,
  AIN2 => AIN2,
  AIN3 => AIN3,
  AIN4 => AIN4,
  AIN5 => AIN5,
  AIN6 => AIN6,
  AIN7 => AIN7
);

---------------debug end--------------------
  MicCB_SYNC_Counter:process (rst_n_syn,CLK_100M,MICCB_GEN_SYNC_FPGA_SYN)
  begin
    if rst_n_syn = '0' then
      MicCB_SYNC_CNT<= (others => '0');
    elsif rising_edge(CLK_100M) then
      if MICCB_GEN_SYNC_FPGA_SYN = '1' then
        MicCB_SYNC_CNT <= (others => '0');
      elsif MicCB_SYNC_CNT /= x"ffffffff" then
        MicCB_SYNC_CNT <= std_logic_vector( unsigned(MicCB_SYNC_CNT) + 1 );
      else 
        null;
      end if;
    end if;
  end process;

  MICCB_GEN_SYNC_FPGA_SYN <= (MICCB_GEN_SYNC_FPGA_F and (not MICCB_GEN_SYNC_FPGA_FF));
  MICCB_GEN_SYNC_FPGA_SYNC:process (CLK_100M)
  begin
    if rst_n_syn = '0' then
      MICCB_GEN_SYNC_FPGA_F <= '0';
      MICCB_GEN_SYNC_FPGA_FF <= '0';
    elsif rising_edge(CLK_100M) then
      MICCB_GEN_SYNC_FPGA_F <= MICCB_GEN_SYNC_FPGA ;
      MICCB_GEN_SYNC_FPGA_FF <= MICCB_GEN_SYNC_FPGA_F;
    end if;
  end process;
  rst_n_syn <= '1';
  rst_syn <= not rst_n_syn;

  UART_PLL_inst : UART_PLL
  port map (
    areset	=> rst_syn,
		inclk0	=> CLK_100M,
		c0		=> UART_CLK,
		locked	=> UART_rstn
  );


LED_1 <= FPGA_LEDs_OUT(0);
LED_2 <= FPGA_LEDs_OUT(1);
LED_3 <= FPGA_LEDs_OUT(2);
LED_4 <= FPGA_LEDs_OUT(3);
LED_5  <= FPGA_LEDs_OUT(4);
LED_6 <= FPGA_LEDs_OUT(5);
LED_7 <= FPGA_LEDs_OUT(6);
LED_8 <= FPGA_LEDs_OUT(7);

    i_rcb_registers :  rcb_registers
        port map (
            clk_100m                    => clk_100m                   ,
            rst_n_syn                   => rst_n_syn                  ,
            clk_1m                      => clk_1m_internal            ,
            data_miso                   => data_miso                  ,
            data_mosi                   => data_mosi                  ,
            data_mosi_rdy               => data_mosi_rdy              ,
            addr                        => addr                       ,
            addr_rdy                    => addr_rdy                   ,
            data_miso_rdy               => data_miso_rdy              ,
            FAN_TACHO_REG_OUT_1         => FAN_TACHO_REG_OUT_1        ,
            FAN_PWM_REG_OUT_1           => FAN_PWM_REG_OUT_1          ,
            FAN_TACHO_REG_OUT_2         => FAN_TACHO_REG_OUT_2        ,
            FAN_PWM_REG_OUT_2           => FAN_PWM_REG_OUT_2          ,
            AIN0                        => AIN0                       ,
            AIN1                        => AIN1                       ,
            AIN2                        => AIN2                       ,
            AIN3                        => AIN3                       ,
            AIN4                        => AIN4                       ,
            AIN5                        => AIN5                       ,
            AIN6                        => AIN6                       ,
            AIN7                        => AIN7                       ,
            FPGA_LEDs_OUT               => FPGA_LEDs_OUT              ,
            R_DIAG_PACK_CNT             => R_DIAG_PACK_CNT            ,
            R_DIAG_ERR_CNT              => R_DIAG_ERR_CNT             ,
            L_DIAG_PACK_CNT             => L_DIAG_PACK_CNT            ,
            L_DIAG_ERR_CNT              => L_DIAG_ERR_CNT             ,
            L_NO_switch_TOOL_EX_FPGA    => L_NO_switch_TOOL_EX_FPGA   ,
            L_NC_switch_TOOL_EX_FPGA    => L_NC_switch_TOOL_EX_FPGA   ,
            R_NO_switch_TOOL_EX_FPGA    => R_NO_switch_TOOL_EX_FPGA   ,
            R_NC_switch_TOOL_EX_FPGA    => R_NC_switch_TOOL_EX_FPGA   ,
            L_POS_SENS_0_OUT1           => L_POS_SENS_0_OUT1_BUFF     ,
            L_POS_SENS_0_OUT2           => L_POS_SENS_0_OUT2_BUFF     ,
            L_POS_SENS_1_OUT1           => L_POS_SENS_1_OUT1_BUFF     ,
            L_POS_SENS_1_OUT2           => L_POS_SENS_1_OUT2_BUFF     ,
            L_POS_SENS_OUT1             => L_POS_SENS_OUT1_BUFF       ,
            L_POS_SENS_OUT2             => L_POS_SENS_OUT2_BUFF       ,
            L_WHEEL_SENS_A1_OUT1        => L_WHEEL_SENS_A1_OUT1_BUFF  ,
            L_WHEEL_SENS_A1_OUT2        => L_WHEEL_SENS_A1_OUT2_BUFF  ,
            L_WHEEL_SENS_A2_OUT1        => L_WHEEL_SENS_A2_OUT1_BUFF  ,
            L_WHEEL_SENS_A2_OUT2        => L_WHEEL_SENS_A2_OUT2_BUFF  ,
            L_WHEEL_SENS_SPARE_OUT1     => L_WHEEL_SENS_SPARE_OUT1_BUFF,
            L_WHEEL_SENS_SPARE_OUT2     => L_WHEEL_SENS_SPARE_OUT2_BUFF,
            R_POS_SENS_0_OUT1           => R_POS_SENS_0_OUT1_BUFF     ,
            R_POS_SENS_0_OUT2           => R_POS_SENS_0_OUT2_BUFF     ,
            R_POS_SENS_1_OUT1           => R_POS_SENS_1_OUT1_BUFF     ,
            R_POS_SENS_1_OUT2           => R_POS_SENS_1_OUT2_BUFF     ,
            R_POS_SENS_OUT1             => R_POS_SENS_OUT1_BUFF       ,
            R_POS_SENS_OUT2             => R_POS_SENS_OUT2_BUFF       ,
            R_WHEEL_SENS_A1_OUT1        => R_WHEEL_SENS_A1_OUT1_BUFF  ,
            R_WHEEL_SENS_A1_OUT2        => R_WHEEL_SENS_A1_OUT2_BUFF  ,
            R_WHEEL_SENS_A2_OUT1        => R_WHEEL_SENS_A2_OUT1_BUFF  ,
            R_WHEEL_SENS_A2_OUT2        => R_WHEEL_SENS_A2_OUT2_BUFF  ,
            R_WHEEL_SENS_SPARE_OUT1     => R_WHEEL_SENS_SPARE_OUT1_BUFF,
            R_WHEEL_SENS_SPARE_OUT2     => R_WHEEL_SENS_SPARE_OUT2_BUFF,
            R_4MB_SER_IN_ER             => R_4MB_SER_IN_ER            ,
            R_EEF_SER_IN_ER             => R_EEF_SER_IN_ER            ,
            R_M5B_SER_IN_ER             => R_M5B_SER_IN_ER            ,
            R_SER_RX_ER                 => R_SER_RX_ER                ,
            R_SCU_Invalid_n             => R_SCU_Invalid_n            ,
            L_4MB_SER_IN_ER             => L_4MB_SER_IN_ER            ,
            L_EEF_SER_IN_ER             => L_EEF_SER_IN_ER            ,
            L_M5B_SER_IN_ER             => L_M5B_SER_IN_ER            ,
            L_SER_RX_ER                 => L_SER_RX_ER                ,
            L_SCU_INVALIDn              => L_SCU_INVALIDn             ,
            A_24V_L_EN                  => A_24V_L_EN                 ,
            B_24V_L_EN                  => B_24V_L_EN                 ,
            A_35V_L_EN                  => A_35V_L_EN                 ,
            B_35V_L_EN                  => B_35V_L_EN                 ,
            A_24V_R_EN                  => A_24V_R_EN                 ,
            B_24V_R_EN                  => B_24V_R_EN                 ,
            A_35V_R_EN                  => A_35V_R_EN                 ,
            B_35V_R_EN                  => B_35V_R_EN                 ,
            BIT_SSR_SW                  => BIT_SSR_SW                 ,
            MUX_Control                 => MUX_Control                ,
            MICCB_GEN_SYNC_FAIL         => MICCB_GEN_SYNC_FAIL        ,
            MICCB_SP_IN_A_F             => MICCB_SP_IN_A_F            ,
            MICCB_SP_IN_B_F             => MICCB_SP_IN_B_F            ,
            MICCB_SPARE_IO0             => MICCB_SPARE_IO0            ,
            MICCB_SPARE_IO1             => MICCB_SPARE_IO1            ,
            MICCB_SPARE_IO2             => MICCB_SPARE_IO2            ,
            MICCB_SPARE_IO3             => MICCB_SPARE_IO3            ,
            FPGA1                       => FPGA1                      ,
            FPGA2                       => FPGA2                      ,
            FPGA3                       => FPGA3                      ,
            FPGA4                       => FPGA4                      ,
            FPGA5                       => FPGA5                      ,
            FPGA6                       => FPGA6                      ,
            FPGA7                       => FPGA7                      ,
            FPGA8                       => FPGA8                      ,
            FPGA9                       => FPGA9                      ,
            FPGA10                      => FPGA10                     ,
            FPGA11                      => FPGA11                     ,
            FPGA12                      => FPGA12                     ,
            FPGA13                      => FPGA13                     ,
            Teensy_FPGA_SP0             => Teensy_FPGA_SP0            ,
            Teensy_FPGA_SP1             => Teensy_FPGA_SP1            ,
            Teensy_FPGA_SP2             => Teensy_FPGA_SP2            ,
            P35V_Monitor                => P35V_Monitor               ,
            Spare                       => Spare                      ,
            P12V_Monitor                => P12V_Monitor               ,
            P3_3V_Monitor               => P3_3V_Monitor              ,
            P5V_Monitor                 => P5V_Monitor                ,
            P2_5V_Monitor               => P2_5V_Monitor              ,
            P24V_Monitor                => P24V_Monitor               ,
            P12V_PS_Monitor             => P12V_PS_Monitor            ,
            SPARE1_DIFF0                => SPARE1_DIFF0               ,
            SPARE1_DIFF1                => SPARE1_DIFF1               ,
            SPARE1_DIFF2                => SPARE1_DIFF2               ,
            SPARE1_DIFF3                => SPARE1_DIFF3               ,
            SPARE1_ANALOG_SW_0_SEL_FPGA => SPARE1_ANALOG_SW_0_SEL_FPGA,
            SPARE1_ANALOG_SW_1_SEL_FPGA => SPARE1_ANALOG_SW_1_SEL_FPGA,
            SPARE1_ANALOG_SW_SEL_FPGA   => SPARE1_ANALOG_SW_SEL_FPGA  ,
            SPARE1_IO0_FPGA             => SPARE1_IO0_FPGA            ,
            SPARE1_IO1_FPGA             => SPARE1_IO1_FPGA            ,
            SPARE1_IO2_FPGA             => SPARE1_IO2_FPGA            ,
            SPARE1_IO3_FPGA             => SPARE1_IO3_FPGA            ,
            SPARE2_DIFF0                => SPARE2_DIFF0               ,
            SPARE2_DIFF1                => SPARE2_DIFF1               ,
            SPARE2_DIFF2                => SPARE2_DIFF2               ,
            SPARE2_DIFF3                => SPARE2_DIFF3               ,
            SPARE2_ANALOG_SW_0_SEL_FPGA => SPARE2_ANALOG_SW_0_SEL_FPGA,
            SPARE2_ANALOG_SW_1_SEL_FPGA => SPARE2_ANALOG_SW_1_SEL_FPGA,
            SPARE2_ANALOG_SW_SEL_FPGA   => SPARE2_ANALOG_SW_SEL_FPGA  ,
            SPARE2_IO0_FPGA             => SPARE2_IO0_FPGA            ,
            SPARE2_IO1_FPGA             => SPARE2_IO1_FPGA            ,
            SPARE2_IO2_FPGA             => SPARE2_IO2_FPGA            ,
            SPARE2_IO3_FPGA             => SPARE2_IO3_FPGA            ,
            FPGA_WHEEL_STOP_ELO         => FPGA_WHEEL_STOP_ELO        ,
            FPGA24V_DIS                 => FPGA24V_DIS                ,
            FLA_PWR_DIS                 => FLA_PWR_DIS                ,
            OPEN_ELO_REQUEST            => OPEN_ELO_REQUEST           ,
            PS_PG_FPGA                  => PS_PG_FPGA                 ,
            FAN1_TACHO                  => open            ,
            FAN_1_READ_NUMBER           => FAN_1_READ_NUMBER          ,
            FAN_1_PWM                   => FAN_1_PWM                  ,
            FAN_2_TACHO                 => open                ,
            FAN_2_READ_NUMBER           => FAN_2_READ_NUMBER          ,
            FAN_2_PWM                   => FAN_2_PWM                  ,
            FPGA_SYNC_DELAY_TIME        => FPGA_SYNC_DELAY_TIME       ,
            FPGA_SYNC_TIME              => FPGA_SYNC_TIME             ,
            CS_ERROR                    => CS_ERROR                   ,
            MicCB_ESTOP_OPEN_REQUEST    => MicCB_ESTOP_OPEN_REQUEST   ,
            ESTOP_STATUS_FAIL           => ESTOP_STATUS_FAIL          ,
            SSR_ON_FPGA                 => SSR_ON_FPGA                ,
            FPGA_DIAG_ACT               => FPGA_DIAG_ACT              ,
            FPGA_FAULT                  => FPGA_FAULT                 ,
            RST_WD                      => RST_WD                     ,
            MicCB_SYNC_CNT              => MicCB_SYNC_CNT             
        );




        L_UART_TOP_inst :  UART_TOP
        port map (
          CLK => UART_CLK,
          RST_N => UART_rstn,
          RXD_4MB => L_4MB_SER_IN_SE,
          RXD_M5B => L_M5B_SER_IN_SE,
          RXD_EFF => L_EEF_SER_IN_SE,
          TXD_TEENSY => TEENSY_FPGA_L_RX
        );
      
        R_UART_TOP_inst :  UART_TOP
        port map (
          CLK => UART_CLK,
          RST_N => UART_rstn,
          RXD_4MB => R_4MB_SER_IN_SE,
          RXD_M5B => R_M5B_SER_IN_SE,
          RXD_EFF => R_EEF_SER_IN_SE,
          TXD_TEENSY => TEENSY_FPGA_R_RX
        );

        
    FAN1_inst :  FAN
    port map (
      RST_N => rst_n_syn,
      CLK => CLK_100M,
      TACHO_IN => FAN1_TACHO_BUFF,
      PWM_OUT => FAN1_PWM,
      FAN_TACHO_REG => FAN_TACHO_REG_OUT_1,
      FAN_PWM_REG => FAN_PWM_REG_OUT_1
    );
  
    FAN2_inst :  FAN
  port map (
    RST_N => rst_n_syn,
    CLK => CLK_100M,
    TACHO_IN => FAN2_TACHO_BUFF,
    PWM_OUT => FAN2_PWM,
    FAN_TACHO_REG => FAN_TACHO_REG_OUT_2,
    FAN_PWM_REG => FAN_PWM_REG_OUT_2
  );


  process (MUX_Control,TEENSY_LEDS_STRIP_DO)
  begin
    case MUX_Control is
      when L_TOOL_EX =>
        L_TOOL_EX_LED_DIN<= TEENSY_LEDS_STRIP_DO;
      when L_LED_Strip =>
        L_LED_DIN <= TEENSY_LEDS_STRIP_DO;
      when R_Tool_Ex =>
        R_TOOL_EX_LED_DIN<= TEENSY_LEDS_STRIP_DO;
      when R_LED_Stirp =>
        R_LED_DIN <= TEENSY_LEDS_STRIP_DO;
      when WS_LED_Strip =>
        S_LED_DIN <= TEENSY_LEDS_STRIP_DO;
      when Robot_ESTOP_LED =>   
        ROBOT_ESTOP_LED_DIN <= TEENSY_LEDS_STRIP_DO; 
      when others =>
        null;
    end case;
  end process;

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
	 


	 
	ESTOP_DELAY <= 'Z';
	-- LED_1 <= '1';
	-- LED_2 <= '1';
	-- LED_3 <= '1';
end Behavioral;
