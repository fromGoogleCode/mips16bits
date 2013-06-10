library verilog;
use verilog.vl_types.all;
entity mux_PC is
    port(
        clock           : in     vl_logic;
        PC              : in     vl_logic_vector(5 downto 0);
        aluOut          : in     vl_logic_vector(15 downto 0);
        addr            : out    vl_logic_vector(5 downto 0);
        IouD            : in     vl_logic
    );
end mux_PC;
