library verilog;
use verilog.vl_types.all;
entity muxReg is
    port(
        clock           : in     vl_logic;
        Reg1            : in     vl_logic_vector(3 downto 0);
        Reg2            : in     vl_logic_vector(3 downto 0);
        RegDst          : in     vl_logic;
        Dest            : out    vl_logic_vector(3 downto 0)
    );
end muxReg;
