library verilog;
use verilog.vl_types.all;
entity controlunit is
    port(
        regdest         : out    vl_logic;
        jump            : out    vl_logic;
        branch          : out    vl_logic;
        memread         : out    vl_logic;
        memtoreg        : out    vl_logic;
        memwrite        : out    vl_logic;
        alusrc          : out    vl_logic;
        regwrite        : out    vl_logic;
        aluop           : out    vl_logic_vector(1 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0)
    );
end controlunit;
