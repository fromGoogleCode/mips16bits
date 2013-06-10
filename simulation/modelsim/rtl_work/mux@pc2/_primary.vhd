library verilog;
use verilog.vl_types.all;
entity muxPc2 is
    port(
        clock           : in     vl_logic;
        ALUOut          : in     vl_logic_vector(15 downto 0);
        Dest            : in     vl_logic_vector(15 downto 0);
        Jump            : in     vl_logic_vector(15 downto 0);
        OrigPC          : in     vl_logic_vector(1 downto 0);
        newPC           : out    vl_logic_vector(5 downto 0)
    );
end muxPc2;
