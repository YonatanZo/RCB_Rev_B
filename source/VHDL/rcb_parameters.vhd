library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package rcb_parameters is
    -- FPGA revision parameters
    constant FPGA_MAJOR_VER     : std_logic_vector(7 downto 0) := "00000011";
    constant FPGA_REV           : std_logic_vector(7 downto 0) := "00000001";
    constant FPGA_REV_YEAR      : std_logic_vector(7 downto 0) := "00010111";
    constant FPGA_REV_MONTH     : std_logic_vector(7 downto 0) := "00000011";
    constant FPGA_REV_DAY       : std_logic_vector(7 downto 0) := "00000111";
    constant FPGA_REV_HOUR      : std_logic_vector(7 downto 0) := "00001000";

    -- SPI packet length parameters
    constant SPI_COM_LEN        : integer := 8;
    constant SPI_ADDR_LEN       : integer := SPI_COM_LEN + 16;
    constant SPI_DATA_LEN       : integer := SPI_ADDR_LEN + 32;

    -- SPI COMMANDS
    constant WRITE_COM          : std_logic_vector(7 downto 0) := "00001010"; -- Write Command (0A).
    constant READ_COM           : std_logic_vector(7 downto 0) := "00001111"; -- Read Command (0F).
    constant WRITE_MODE         : std_logic_vector(1 downto 0) := "00";         -- Write Mode.
    constant READ_MODE          : std_logic_vector(1 downto 0) := "01";         -- Read Mode.
    constant UNDEF_MODE         : std_logic_vector(1 downto 0) := "11";         -- Undefined command. Write Cycle without saving result.

    -- Addresses of FPGA registers
    constant ADDR_FPGA_VER                : std_logic_vector(15 downto 0) := "0000000000000000";
    constant ADDR_FPGA_REV_DATA           : std_logic_vector(15 downto 0) := "0000000000000001";
    constant ADDR_FPGA_POW_DIAG           : std_logic_vector(15 downto 0) := "0000000000000010";
    constant ADDR_FPGA_BUTTONS            : std_logic_vector(15 downto 0) := "0000000000000011";
    constant ADDR_FPGA_DRAPE_SW_STATE     : std_logic_vector(15 downto 0) := "0000000000000100";
    constant ADDR_FPGA_DRAPE_EM_STATE     : std_logic_vector(15 downto 0) := "0000000000000101";
    constant ADDR_FPGA_DRAPE_SW_APPROVAL  : std_logic_vector(15 downto 0) := "0000000000000110";
    constant ADDR_FPGA_DRAPE_SENSOR       : std_logic_vector(15 downto 0) := "0000000000000111";
    constant ADDR_FPGA_WHEEL_DRIVER_OUT   : std_logic_vector(15 downto 0) := "0000000000001000";
    constant ADDR_FPGA_WHEEL_DRIVER_ELO   : std_logic_vector(15 downto 0) := "0000000000001001";
    constant ADDR_FPGA_WHEEL_DRIVER_IN    : std_logic_vector(15 downto 0) := "0000000000001010";
    constant ADDR_FPGA_WHEEL_DRIVER_ABRT  : std_logic_vector(15 downto 0) := "0000000000001011";
    constant ADDR_FPGA_WHEEL_SENSOR       : std_logic_vector(15 downto 0) := "0000000000001100";
    constant ADDR_FPGA_BUTTONS_LED        : std_logic_vector(15 downto 0) := "0000000000001101";
    constant ADDR_FPGA_ESTOP_STATUS       : std_logic_vector(15 downto 0) := "0000000000001110";
    constant ADDR_FPGA_ESTOP_ACTIVATION   : std_logic_vector(15 downto 0) := "0000000000001111";
    constant ADDR_FPGA_ESTOP_DIAGNOSTIC   : std_logic_vector(15 downto 0) := "0000000000010000";
    constant ADDR_FPGA_ESTOP_OPEN         : std_logic_vector(15 downto 0) := "0000000000010001";
    constant ADDR_FPGA_DIAGNOSTIC_LEDS    : std_logic_vector(15 downto 0) := "0000000000010010";
    constant ADDR_FPGA_SPARE_IO           : std_logic_vector(15 downto 0) := "0000000000010011";
    constant ADDR_FPGA_SPARE_4MB          : std_logic_vector(15 downto 0) := "0000000000010100";
    constant ADDR_FPGA_WHEEL_ROD          : std_logic_vector(15 downto 0) := "0000000000010101";
    constant ADDR_FPGA_FAN1_TACHO         : std_logic_vector(15 downto 0) := "0000000000010110";
    constant ADDR_FPGA_FAN1_PWM           : std_logic_vector(15 downto 0) := "0000000000010111";
    constant ADDR_FPGA_FAN2_TACHO         : std_logic_vector(15 downto 0) := "0000000000011000";
    constant ADDR_FPGA_FAN2_PWM           : std_logic_vector(15 downto 0) := "0000000000011001";

    constant NUM_REG            : integer := 26; -- Number of RCB Registers

    -- ESTOP
    constant ESTOP_DIAG_ACTIV   : std_logic_vector(31 downto 0) := x"0000ABCD"; -- Set to 0xABCD for Closing Estop in Diagnostic mode (along with bit 31 in ESTOP Activation register)
    constant ESTOP_ACTIVATION_PULSE : integer := 100000; -- 4'hA; -- ESTOP activation pulse

    constant FAN_TACHO_MES_PERIOD : integer := 200000; -- 26'h30D40; -- 200ms

    constant DEB_DEEP           : integer := 3; -- Depth of SPI debouncer
end package rcb_parameters;