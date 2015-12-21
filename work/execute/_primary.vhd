library verilog;
use verilog.vl_types.all;
entity execute is
    port(
        alu_op          : in     vl_logic_vector(1 downto 0);
        data_addrEXMEM  : out    vl_logic_vector(31 downto 0);
        IDEXreadData1   : in     vl_logic_vector(31 downto 0);
        IDEXreadData2   : in     vl_logic_vector(31 downto 0);
        EXMEMreadData1  : in     vl_logic_vector(31 downto 0);
        EXMEMreadData2  : in     vl_logic_vector(31 downto 0);
        MEMWBreadData1  : in     vl_logic_vector(31 downto 0);
        MEMWBreadData2  : in     vl_logic_vector(31 downto 0);
        IDEXsignExtended: in     vl_logic_vector(31 downto 0);
        IDEXinstr       : in     vl_logic_vector(31 downto 0);
        alu_src         : in     vl_logic;
        fwdA            : in     vl_logic_vector(1 downto 0);
        fwdB            : in     vl_logic_vector(1 downto 0);
        regdest         : in     vl_logic;
        writeReg        : out    vl_logic_vector(4 downto 0);
        fwdBMux         : out    vl_logic_vector(31 downto 0)
    );
end execute;
