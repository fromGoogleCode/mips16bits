library verilog;
use verilog.vl_types.all;
entity muxData is
    port(
        clock           : in     vl_logic;
        MDR             : in     vl_logic_vector(15 downto 0);
        AluOut          : in     vl_logic_vector(15 downto 0);
        MemToReg        : in     vl_logic;
        Data            : out    vl_logic_vector(15 downto 0)
    );
end muxData;
