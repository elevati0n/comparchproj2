library verilog;
use verilog.vl_types.all;
entity combineSLPC4 is
    port(
        aluPlus4        : in     vl_logic_vector(3 downto 0);
        instr           : in     vl_logic_vector(25 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end combineSLPC4;
