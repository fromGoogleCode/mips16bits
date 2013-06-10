library verilog;
use verilog.vl_types.all;
entity AluControl is
    port(
        clock           : in     vl_logic;
        OpAlu           : in     vl_logic_vector(1 downto 0);
        Opcode          : in     vl_logic_vector(3 downto 0);
        state           : in     vl_logic_vector(3 downto 0);
        newOpcode       : out    vl_logic_vector(3 downto 0)
    );
end AluControl;
