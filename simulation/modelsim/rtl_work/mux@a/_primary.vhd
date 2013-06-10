library verilog;
use verilog.vl_types.all;
entity muxA is
    port(
        clock           : in     vl_logic;
        A               : in     vl_logic_vector(15 downto 0);
        PC              : in     vl_logic_vector(5 downto 0);
        OrigAALU        : in     vl_logic;
        Data            : out    vl_logic_vector(15 downto 0)
    );
end muxA;
