library verilog;
use verilog.vl_types.all;
entity processor is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inst_addr       : out    vl_logic_vector(31 downto 0);
        instr           : in     vl_logic_vector(31 downto 0);
        data_addr       : out    vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0)
    );
end processor;
