library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        clock           : in     vl_logic;
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        opcode          : in     vl_logic_vector(3 downto 0);
        ALUout          : out    vl_logic_vector(15 downto 0);
        OverflowDetected: out    vl_logic;
        zero            : out    vl_logic
    );
end ALU;
