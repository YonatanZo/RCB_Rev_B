library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rcb_registers is
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
		MUX_Control	 : out STD_LOGIC_VECTOR(2 downto 0);
		--Mic.C.B
		MICCB_GEN_SYNC_FAIL         : in  STD_LOGIC                    ;
		MICCB_SP_IN_A_F             : in  STD_LOGIC                    ;
		MICCB_SP_IN_B_F             : in  STD_LOGIC                    ;
		MICCB_SPARE_IO0             : in  STD_LOGIC                    ;
		MICCB_SPARE_IO1             : in  STD_LOGIC                    ;
		MICCB_SPARE_IO2             : in  STD_LOGIC                    ;
		MICCB_SPARE_IO3             : in  STD_LOGIC                    ;
		--FPGA Spare out
		FPGA1                       : in STD_LOGIC                    ;
		FPGA2                       : in STD_LOGIC                    ;
		FPGA3                       : in STD_LOGIC                    ;
		FPGA4                       : in STD_LOGIC                    ;
		FPGA5                       : out STD_LOGIC                    ;
		FPGA6                       : out STD_LOGIC                    ;
		FPGA7                       : out STD_LOGIC                    ;
		FPGA8                       : out STD_LOGIC                    ;
		FPGA9                       : out STD_LOGIC                    ;
		FPGA10                      : out STD_LOGIC                    ;
		FPGA11                      : out STD_LOGIC                    ;
		FPGA12                      : out STD_LOGIC                    ;
		FPGA13                      : out STD_LOGIC                    ;
		Teensy_FPGA_SP0             : in STD_LOGIC                    ;
		Teensy_FPGA_SP1             : in STD_LOGIC                    ;
		Teensy_FPGA_SP2             : in STD_LOGIC                    ;
		-- --ADC Voltage 0
		-- P35V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
		-- Spare                       : in  STD_LOGIC_VECTOR(15 downto 0);
		-- --ADC Voltage 1
		-- P12V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
		-- P3_3V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);	
		-- --ADC Voltage 2
		-- P5V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
		-- P2_5V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
		-- --ADC Voltage 3
		-- P24V_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
		-- P12V_PS_Monitor : in STD_LOGIC_VECTOR(15 downto 0);
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
end rcb_registers;
architecture Behavioral of rcb_registers is
--FPGA Version/date
constant FPGA_MAJOR_VER : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"04";
constant FPGA_REV : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"08";
constant FPGA_REV_YEAR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"18";
constant FPGA_REV_MONTH : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"07";
constant FPGA_REV_DAY : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"01";
constant FPGA_REV_HOUR : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"12";
--Regiasters address declaretion 
constant ADDR_FPGA_Version: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
constant ADDR_FPGA_Date: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0001";
constant ADDR_Power_Diagnostic: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0002";
constant ADDR_FPGA_buttons: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0003";
constant ADDR_L_Wheels_sensors: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0004";
constant ADDR_R_Wheels_sensors: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0005";
constant ADDR_Diagnostic_packed_counter: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0006";
constant ADDR_Diagnostic_error_counter: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0007";
constant ADDR_Right_Recivers_Error: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0008";
constant ADDR_Left_Recivers_Error: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0009";
constant ADDR_SSRs_Left: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000A";
constant ADDR_SSRs_Right: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000B";
constant ADDR_FPGA_LEDs: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000C";
constant ADDR_LEDs_strip_Mux: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000D";
constant ADDR_Mic_C_B: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000E";
constant ADDR_FPGA_Spare_out: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"000F";
constant ADDR_ADC_Voltage_0: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0010";
constant ADDR_ADC_Voltage_1: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0011";
constant ADDR_ADC_Voltage_2: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0012";
constant ADDR_ADC_Voltage_3: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0013";
constant ADDR_FPGA_Spare: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0014";
constant ADDR_FLA_PS: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0015";
constant ADDR_FPGA_FAN_1_Tacho: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0016";
constant ADDR_FPGA_FAN_1_PWM: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0017";
constant ADDR_FPGA_FAN_2_Tacho: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0018";
constant ADDR_FPGA_FAN_2_PWM: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0019";
constant ADDR_FPGA_SYNC_DELAY_TIME: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"001A";
constant ADDR_FPGA_SYNC_TIME: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"001B";
constant ADDR_Fault_Registers: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"001C";
constant ADDR_Sync_Timer: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"001D";
constant ADDR_Diagnostic_Header: STD_LOGIC_VECTOR(15 DOWNTO 0) := x"001E";
-- new registers declaretion 
signal FPGA_Version_reg : STD_LOGIC_VECTOR(31 downto 0) := FPGA_REV & FPGA_MAJOR_VER & x"0000";--x"0000"
signal FPGA_Date_reg : STD_LOGIC_VECTOR(31 downto 0) := FPGA_REV_HOUR & FPGA_REV_DAY & FPGA_REV_MONTH & FPGA_REV_YEAR;--x"0001"
signal Power_Diagnostic_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0002"
signal FPGA_buttons_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0003"
signal L_Wheels_sensors_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0004"
signal R_Wheels_sensors_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0005"
signal Diagnostic_packed_counter_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0006"
signal Diagnostic_error_counter_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0007"
signal Right_Recivers_Error_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0008"
signal Left_Recivers_Error_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0009"
signal SSRs_Left_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"000A"
signal SSRs_Right_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"000B"
signal FPGA_LEDs_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"000C"
signal LEDs_strip_Mux_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"000D"
signal Mic_C_B_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"000E"
signal FPGA_Spare_out_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"000F"
signal ADC_Voltage_0_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0010"
signal ADC_Voltage_1_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0011"
signal ADC_Voltage_2_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"0012"
signal ADC_Voltage_3_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"0013"
signal FPGA_Spare_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0014"
signal FLA_PS_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0015"
signal FPGA_FAN_1_Tacho_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"0016"
signal FPGA_FAN_1_PWM_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"0017"
signal FPGA_FAN_2_Tacho_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"0018"
signal FPGA_FAN_2_PWM_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"0019"
signal FPGA_SYNC_DELAY_TIME_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"001A"
signal FPGA_SYNC_TIME_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"001B"
signal Fault_Registers_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); --x"001C"
signal Sync_Timer_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"001D"
signal Diagnostic_Header_reg : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');--x"001E"
	
begin
FPGA_LEDs_OUT <= FPGA_LEDs_reg(7 downto 0);

input_routing: process (clk_100m, rst_n_syn)
begin
    if rst_n_syn = '0' then
        
        FPGA_Version_reg  <= FPGA_REV & FPGA_MAJOR_VER & x"0000";
        FPGA_Date_reg  <= FPGA_REV_HOUR & FPGA_REV_DAY & FPGA_REV_MONTH & FPGA_REV_YEAR;
    elsif rising_edge(clk_100m) then
        FPGA_Version_reg  <= FPGA_REV & FPGA_MAJOR_VER & x"0000";
        FPGA_Date_reg  <= FPGA_REV_HOUR & FPGA_REV_DAY & FPGA_REV_MONTH & FPGA_REV_YEAR;
	    --Data to fan 1 moudle 
	    --FAN_TACHO_REG_OUT_1  <= FPGA_FAN_1_Tacho_reg(15 DOWNTO 0) ;TODO:fix this other deriction 
		FAN_PWM_REG_OUT_1  <= FPGA_FAN_1_PWM_reg(7 DOWNTO 0) ;
		--Data to fan 2 moudle 
	    --FAN_TACHO_REG_OUT_2 <= FPGA_FAN_2_Tacho_reg(15 DOWNTO 0) ;TODO:fix this other deriction 
		FAN_PWM_REG_OUT_2 <= FPGA_FAN_2_PWM_reg(7 DOWNTO 0) ;
		--SSRs_Left
		A_24V_L_EN <= SSRs_Left_reg(0);
		B_24V_L_EN <= SSRs_Left_reg(1);
		A_35V_L_EN <= SSRs_Left_reg(2);
		B_35V_L_EN <= SSRs_Left_reg(3);
		--SSRs_Right
		A_24V_R_EN <= SSRs_Right_reg(0);
		B_24V_R_EN <= SSRs_Right_reg(1);
		A_35V_R_EN <= SSRs_Right_reg(2);
		B_35V_R_EN <= SSRs_Right_reg(3);
		BIT_SSR_SW <= SSRs_Right_reg(4);
		--FPGA Buttons
		FPGA_buttons_reg(0)  <= L_NO_switch_TOOL_EX_FPGA;
		FPGA_buttons_reg(1)  <= L_NC_switch_TOOL_EX_FPGA;
		FPGA_buttons_reg(2)  <= R_NO_switch_TOOL_EX_FPGA;
		FPGA_buttons_reg(3)  <= R_NC_switch_TOOL_EX_FPGA;
		--L Wheels sensors
		L_Wheels_sensors_reg(11 downto 0)  <=L_POS_SENS_0_OUT1 & L_POS_SENS_0_OUT2 & L_POS_SENS_1_OUT1 & L_POS_SENS_1_OUT2 & 
		L_POS_SENS_OUT1 & L_POS_SENS_OUT2 & L_WHEEL_SENS_A1_OUT1 & L_WHEEL_SENS_A1_OUT2 & L_WHEEL_SENS_A2_OUT1 & 
		L_WHEEL_SENS_A2_OUT2 & L_WHEEL_SENS_SPARE_OUT1 & L_WHEEL_SENS_SPARE_OUT2;
		--R Wheels sensors
		R_Wheels_sensors_reg(11 downto 0)  <= R_POS_SENS_0_OUT1 & R_POS_SENS_0_OUT2 & R_POS_SENS_1_OUT1 & R_POS_SENS_1_OUT2 & 
		R_POS_SENS_OUT1 & R_POS_SENS_OUT2 & R_WHEEL_SENS_A1_OUT1 & R_WHEEL_SENS_A1_OUT2 & R_WHEEL_SENS_A2_OUT1 & 
		R_WHEEL_SENS_A2_OUT2 & R_WHEEL_SENS_SPARE_OUT1 & R_WHEEL_SENS_SPARE_OUT2;
		--LED MUX CONTROL 
		MUX_Control <= LEDs_strip_Mux_reg(2 downto 0);
		--Diagnostic Header
		FPGA5 <= Diagnostic_Header_reg(7);
		FPGA6 <= Diagnostic_Header_reg(8);
		FPGA7 <= Diagnostic_Header_reg(9);
		FPGA8 <= Diagnostic_Header_reg(10);
		FPGA9 <= Diagnostic_Header_reg(11);
		FPGA10 <= Diagnostic_Header_reg(12);
		FPGA11 <= Diagnostic_Header_reg(13);
		FPGA12 <= Diagnostic_Header_reg(14);
		FPGA13 <= Diagnostic_Header_reg(15);
		Diagnostic_Header_reg(0) <= FPGA1;
		Diagnostic_Header_reg(1) <= FPGA2;
		Diagnostic_Header_reg(2) <= FPGA3;
		Diagnostic_Header_reg(3) <= FPGA4;
		Diagnostic_Header_reg(4) <= Teensy_FPGA_SP0;
		Diagnostic_Header_reg(5) <= Teensy_FPGA_SP1;
		Diagnostic_Header_reg(6) <= Teensy_FPGA_SP2;
		end if;
end process;
ADC_Voltage_0_reg <=AIN0 & AIN1;
ADC_Voltage_1_reg <=AIN2 & AIN3;
ADC_Voltage_2_reg <=AIN4 & AIN5;
ADC_Voltage_3_reg <=AIN6 & AIN7;	

p_mux : process(addr)
begin
    case addr is
        when ADDR_FPGA_Version =>
            data_miso <= FPGA_Version_reg;
        when ADDR_FPGA_Date =>
            data_miso <= FPGA_Date_reg;
        when ADDR_Power_Diagnostic =>
            data_miso <= Power_Diagnostic_reg;
        when ADDR_FPGA_buttons =>
            data_miso <= FPGA_buttons_reg;
        when ADDR_L_Wheels_sensors =>
            data_miso <= L_Wheels_sensors_reg;
        when ADDR_R_Wheels_sensors =>
            data_miso <= R_Wheels_sensors_reg;
        when ADDR_Diagnostic_packed_counter =>
            data_miso <= Diagnostic_packed_counter_reg;
        when ADDR_Diagnostic_error_counter =>
            data_miso <= Diagnostic_error_counter_reg;
        when ADDR_Right_Recivers_Error =>
            data_miso <= Right_Recivers_Error_reg;
        when ADDR_Left_Recivers_Error =>
            data_miso <= Left_Recivers_Error_reg;
        when ADDR_SSRs_Left =>
            data_miso <= SSRs_Left_reg;
        when ADDR_SSRs_Right =>
            data_miso <= SSRs_Right_reg;
        when ADDR_FPGA_LEDs =>
            data_miso <= FPGA_LEDs_reg;
        when ADDR_LEDs_strip_Mux =>
            data_miso <= LEDs_strip_Mux_reg;
        when ADDR_Mic_C_B =>
            data_miso <= Mic_C_B_reg;
        when ADDR_FPGA_Spare_out =>
            data_miso <= FPGA_Spare_out_reg;
        when ADDR_ADC_Voltage_0 =>
            data_miso <= ADC_Voltage_0_reg;
        when ADDR_ADC_Voltage_1 =>
            data_miso <= ADC_Voltage_1_reg;
        when ADDR_ADC_Voltage_2 =>
            data_miso <= ADC_Voltage_2_reg;
        when ADDR_ADC_Voltage_3 =>
            data_miso <= ADC_Voltage_3_reg;
        when ADDR_FPGA_Spare =>
            data_miso <= FPGA_Spare_reg;
        when ADDR_FLA_PS =>
            data_miso <= FLA_PS_reg;
        when ADDR_FPGA_FAN_1_Tacho =>
            data_miso <= FPGA_FAN_1_Tacho_reg;
        when ADDR_FPGA_FAN_1_PWM =>
            data_miso <= FPGA_FAN_1_PWM_reg;
        when ADDR_FPGA_FAN_2_Tacho =>
            data_miso <= FPGA_FAN_2_Tacho_reg;
        when ADDR_FPGA_FAN_2_PWM =>
            data_miso <= FPGA_FAN_2_PWM_reg;
        when ADDR_FPGA_SYNC_DELAY_TIME =>
            data_miso <= FPGA_SYNC_DELAY_TIME_reg;
        when ADDR_FPGA_SYNC_TIME =>
            data_miso <= FPGA_SYNC_TIME_reg;
        when ADDR_Fault_Registers =>
            data_miso <= Fault_Registers_reg;
        when ADDR_Sync_Timer =>
            data_miso <= Sync_Timer_reg;
		when ADDR_Diagnostic_Header =>
            data_miso <= Diagnostic_Header_reg;
        when others =>
            data_miso <= (others => '1');
	end case;
	
end process;
Sync_Timer_reg <= MicCB_SYNC_CNT;
process (clk_100m, rst_n_syn, data_mosi_rdy, addr, data_mosi)
begin
    if rst_n_syn = '0' then
    	SSRs_Left_reg   <= (others => '0');
    	SSRs_Right_reg  <= (others => '0');
		FPGA_LEDs_reg <= (others => '0');
    elsif rising_edge(clk_100m) then 
		if data_mosi_rdy = '1' then
			case addr is
				when ADDR_FPGA_Version =>
					null;
				when ADDR_FPGA_Date =>
					null;
				when ADDR_Power_Diagnostic =>
					--???<= data_mosi;
					null;
				when ADDR_FPGA_buttons =>
					--???<= data_mosi;
					null;
				when ADDR_L_Wheels_sensors =>
					null;
				when ADDR_R_Wheels_sensors =>
					null;
				when ADDR_Diagnostic_packed_counter =>
					null;
				when ADDR_Diagnostic_error_counter =>
					null;
				when ADDR_Right_Recivers_Error =>
					null;
				when ADDR_Left_Recivers_Error =>
					null;
				when ADDR_SSRs_Left =>
					SSRs_Left_reg  <= data_mosi;
				when ADDR_SSRs_Right =>
					SSRs_Right_reg <= data_mosi;
				when ADDR_FPGA_LEDs =>
					FPGA_LEDs_reg(7 downto 0)<= data_mosi(7 downto 0);
				when ADDR_LEDs_strip_Mux =>
					LEDs_strip_Mux_reg <=data_mosi;
					null;
				when ADDR_Mic_C_B =>
					null;
				when ADDR_FPGA_Spare_out =>
					--???<= data_mosi;
					null;
				when ADDR_ADC_Voltage_0 =>
					null;
				when ADDR_ADC_Voltage_1 =>
					null;
				when ADDR_ADC_Voltage_2 =>
					null;
				when ADDR_ADC_Voltage_3 =>
					null;
				when ADDR_FPGA_Spare =>
					null;
				when ADDR_FLA_PS =>
					--???<= data_mosi;
					null;
				when ADDR_FPGA_FAN_1_Tacho =>
					null;
				when ADDR_FPGA_FAN_1_PWM =>
					--???<= data_mosi;
					null;
				when ADDR_FPGA_FAN_2_Tacho =>
					null;
				when ADDR_FPGA_FAN_2_PWM =>
					--???<= data_mosi;
					null;
				when ADDR_FPGA_SYNC_DELAY_TIME =>
					--???<= data_mosi;
					null;
				when ADDR_FPGA_SYNC_TIME =>
					--???<= data_mosi;
					null;
				when ADDR_Fault_Registers =>
					null;
				when ADDR_Sync_Timer =>
					--???<= data_mosi;
					null;
				when ADDR_Diagnostic_Header =>
					Diagnostic_Header_reg(15 downto 7)<= data_mosi(15 downto 7);
				when others =>
					null;
			end case;
		end if;
    end if;
end process;

end Behavioral;

