library verilog;
use verilog.vl_types.all;
entity Controle is
    port(
        opcode          : in     vl_logic_vector(3 downto 0);
        prevState       : in     vl_logic_vector(3 downto 0);
        clock           : in     vl_logic;
        control         : out    vl_logic_vector(15 downto 0);
        nextState       : out    vl_logic_vector(3 downto 0)
    );
end Controle;
