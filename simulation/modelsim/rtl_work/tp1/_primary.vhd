library verilog;
use verilog.vl_types.all;
entity tp1 is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(19 downto 0);
        HEX0            : out    vl_logic_vector(6 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        HEX2            : out    vl_logic_vector(6 downto 0);
        HEX3            : out    vl_logic_vector(6 downto 0);
        HEX4            : out    vl_logic_vector(6 downto 0);
        HEX5            : out    vl_logic_vector(6 downto 0);
        LCD_DATA        : out    vl_logic_vector(7 downto 0);
        LCD_RW          : out    vl_logic;
        LCD_EN          : out    vl_logic;
        LCD_RS          : out    vl_logic;
        LCD_ON          : out    vl_logic;
        LCD_BLON        : out    vl_logic
    );
end tp1;
