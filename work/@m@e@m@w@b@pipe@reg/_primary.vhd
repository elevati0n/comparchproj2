library verilog;
use verilog.vl_types.all;
entity MEMWBPipeReg is
    port(
        read_data       : in     vl_logic_vector(31 downto 0);
        data_addr       : in     vl_logic_vector(31 downto 0);
        writeRegMem     : in     vl_logic_vector(4 downto 0);
        regWriteMem     : in     vl_logic;
        memtoregMem     : in     vl_logic;
        read_dataIF     : out    vl_logic_vector(31 downto 0);
        data_addrIF     : out    vl_logic_vector(31 downto 0);
        writeRegMemIF   : out    vl_logic_vector(4 downto 0);
        regWrite        : out    vl_logic;
        memtoreg        : out    vl_logic;
        readData1MEM    : in     vl_logic_vector(31 downto 0);
        readData2MEM    : in     vl_logic_vector(31 downto 0);
        readData1WB     : out    vl_logic_vector(31 downto 0);
        readData2WB     : out    vl_logic_vector(31 downto 0);
        holdRegWrite    : out    vl_logic;
        clk             : in     vl_logic
    );
end MEMWBPipeReg;
