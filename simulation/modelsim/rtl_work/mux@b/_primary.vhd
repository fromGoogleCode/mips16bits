library verilog;
use verilog.vl_types.all;
entity muxB is
    port(
        clock           : in     vl_logic;
        B               : in     vl_logic_vector(15 downto 0);
        Immediate       : in     vl_logic_vector(3 downto 0);
        OrigBALU        : in     vl_logic_vector(1 downto 0);
        Data            : out    vl_logic_vector(15 downto 0);
        opcode          : in     vl_logic_vector(3 downto 0)
    );
end muxB;
