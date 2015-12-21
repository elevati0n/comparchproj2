library verilog;
use verilog.vl_types.all;
entity comparator is
    port(
        readData1       : in     vl_logic_vector(31 downto 0);
        readData2       : in     vl_logic_vector(31 downto 0);
        IFFlush         : out    vl_logic;
        IFIDinstr       : in     vl_logic_vector(5 downto 0);
        PCSrc           : out    vl_logic;
        jump            : out    vl_logic;
        zero            : out    vl_logic
    );
end comparator;
