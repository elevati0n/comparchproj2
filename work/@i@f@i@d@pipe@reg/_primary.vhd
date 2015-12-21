library verilog;
use verilog.vl_types.all;
entity IFIDPipeReg is
    port(
        instr_add_4     : in     vl_logic_vector(31 downto 0);
        IFIDinstr_add_4 : out    vl_logic_vector(31 downto 0);
        instr           : in     vl_logic_vector(31 downto 0);
        IFIDinstr       : out    vl_logic_vector(31 downto 0);
        ifFlush         : in     vl_logic;
        stall           : in     vl_logic;
        clk             : in     vl_logic
    );
end IFIDPipeReg;
