library verilog;
use verilog.vl_types.all;
entity InstructionDecode is
    port(
        IFIDinstr       : in     vl_logic_vector(31 downto 0);
        IFIDinstr_add_4 : in     vl_logic_vector(31 downto 0);
        aluAddresult    : out    vl_logic_vector(31 downto 0);
        writeReg        : in     vl_logic_vector(4 downto 0);
        writeData       : in     vl_logic_vector(31 downto 0);
        regWrite        : in     vl_logic;
        clk             : in     vl_logic;
        readData1       : out    vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        ifflush         : out    vl_logic;
        pcSrc           : out    vl_logic;
        signExtended    : out    vl_logic_vector(31 downto 0);
        jump            : out    vl_logic;
        aluAddB         : out    vl_logic_vector(31 downto 0)
    );
end InstructionDecode;
