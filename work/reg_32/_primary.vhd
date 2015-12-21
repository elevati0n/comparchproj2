library verilog;
use verilog.vl_types.all;
entity reg_32 is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        en              : in     vl_logic;
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end reg_32;
