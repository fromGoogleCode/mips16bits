library verilog;
use verilog.vl_types.all;
entity Memoria is
    port(
        addrMem         : in     vl_logic_vector(5 downto 0);
        readMem         : in     vl_logic;
        dataIR          : out    vl_logic_vector(15 downto 0);
        dataMDR         : out    vl_logic_vector(15 downto 0);
        writeMem        : in     vl_logic;
        data            : in     vl_logic_vector(15 downto 0);
        CHAVE           : in     vl_logic_vector(5 downto 0);
        VALOR           : out    vl_logic_vector(15 downto 0);
        state           : in     vl_logic_vector(3 downto 0)
    );
end Memoria;
