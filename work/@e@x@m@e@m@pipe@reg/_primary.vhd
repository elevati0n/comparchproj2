library verilog;
use verilog.vl_types.all;
entity EXMEMPipeReg is
    port(
        writeRegEX      : in     vl_logic_vector(4 downto 0);
        data_addrEX     : in     vl_logic_vector(31 downto 0);
        writeDataEX     : in     vl_logic_vector(31 downto 0);
        jumpEX          : in     vl_logic;
        branchEX        : in     vl_logic;
        mem_readEX      : in     vl_logic;
        memwrite        : in     vl_logic;
        RegWriteEx      : in     vl_logic;
        memtoregEX      : in     vl_logic;
        writeRegMEM     : out    vl_logic_vector(4 downto 0);
        data_addr       : out    vl_logic_vector(31 downto 0);
        writeData       : out    vl_logic_vector(31 downto 0);
        jump            : out    vl_logic;
        branch          : out    vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        RegWriteMem     : out    vl_logic;
        memtoregMEM     : out    vl_logic;
        readData1EX     : in     vl_logic_vector(31 downto 0);
        readData2EX     : in     vl_logic_vector(31 downto 0);
        readData1MEM    : out    vl_logic_vector(31 downto 0);
        readData2MEM    : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end EXMEMPipeReg;
