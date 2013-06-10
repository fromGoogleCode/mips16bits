library verilog;
use verilog.vl_types.all;
entity Display is
    port(
        \out\           : out    vl_logic_vector(6 downto 0);
        \in\            : in     vl_logic_vector(3 downto 0)
    );
end Display;
