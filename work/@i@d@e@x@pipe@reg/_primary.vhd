library verilog;
use verilog.vl_types.all;
entity IDEXPipeReg is
    port(
        regdestID       : in     vl_logic;
        jumpID          : in     vl_logic;
        branchID        : in     vl_logic;
        mem_readID      : in     vl_logic;
        memtoregID      : in     vl_logic;
        MemWriteSafe    : in     vl_logic;
        alusrcID        : in     vl_logic;
        RegWriteHazardSafe: in     vl_logic;
        aluopID         : in     vl_logic_vector(1 downto 0);
        regdest         : out    vl_logic;
        jumpEX          : out    vl_logic;
        branchEX        : out    vl_logic;
        mem_readEX      : out    vl_logic;
        memtoregEX      : out    vl_logic;
        MemWriteSafeEX  : out    vl_logic;
        alusrc          : out    vl_logic;
        RegWriteHazardSafeEX: out    vl_logic;
        aluop           : out    vl_logic_vector(1 downto 0);
        readData1ID     : in     vl_logic_vector(31 downto 0);
        readData2ID     : in     vl_logic_vector(31 downto 0);
        readData1EX     : out    vl_logic_vector(31 downto 0);
        readData2EX     : out    vl_logic_vector(31 downto 0);
        extendedID      : in     vl_logic_vector(31 downto 0);
        extendedEX      : out    vl_logic_vector(31 downto 0);
        IDinstrRt2016   : in     vl_logic_vector(4 downto 0);
        IDinstrRs2521   : in     vl_logic_vector(4 downto 0);
        IDinstrRd2015   : in     vl_logic_vector(4 downto 0);
        IDEXinstrRt2016 : out    vl_logic_vector(4 downto 0);
        IDEXinstrRs2521 : out    vl_logic_vector(4 downto 0);
        IDEXinstrRd2015 : out    vl_logic_vector(4 downto 0);
        IFIDinstr       : in     vl_logic_vector(31 downto 0);
        IDEXinstr       : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic
    );
end IDEXPipeReg;
