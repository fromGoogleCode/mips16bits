library verilog;
use verilog.vl_types.all;
entity Banco is
    port(
        clock           : in     vl_logic;
        state           : in     vl_logic_vector(3 downto 0);
        writeReg        : in     vl_logic;
        addra           : in     vl_logic_vector(3 downto 0);
        addrb           : in     vl_logic_vector(3 downto 0);
        addrc           : in     vl_logic_vector(3 downto 0);
        dataa           : out    vl_logic_vector(15 downto 0);
        datab           : out    vl_logic_vector(15 downto 0);
        datac           : in     vl_logic_vector(15 downto 0);
        store           : out    vl_logic_vector(15 downto 0);
        CHAVE           : in     vl_logic_vector(5 downto 0);
        VALOR           : out    vl_logic_vector(15 downto 0);
        r0              : out    vl_logic_vector(15 downto 0);
        r1              : out    vl_logic_vector(15 downto 0);
        r2              : out    vl_logic_vector(15 downto 0)
    );
end Banco;
