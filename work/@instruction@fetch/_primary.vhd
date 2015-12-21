library verilog;
use verilog.vl_types.all;
entity InstructionFetch is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inst_addr       : out    vl_logic_vector(31 downto 0);
        aluAddresult    : in     vl_logic_vector(31 downto 0);
        instr_add_4     : out    vl_logic_vector(31 downto 0);
        pcSrc           : in     vl_logic;
        hazardStall     : in     vl_logic;
        jump            : in     vl_logic;
        jumpMux1        : in     vl_logic_vector(31 downto 0)
    );
end InstructionFetch;
