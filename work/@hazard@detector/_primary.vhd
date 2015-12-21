library verilog;
use verilog.vl_types.all;
entity HazardDetector is
    port(
        IDEXinstrRt2016 : in     vl_logic_vector(4 downto 0);
        IFIDinstrRs2521 : in     vl_logic_vector(4 downto 0);
        IFIDinstrRt2016 : in     vl_logic_vector(4 downto 0);
        IDEXMemRead     : in     vl_logic;
        stall           : out    vl_logic;
        RegWrite        : in     vl_logic;
        MemWrite        : in     vl_logic;
        RegWriteSafe    : out    vl_logic;
        MemWriteSafe    : out    vl_logic
    );
end HazardDetector;
