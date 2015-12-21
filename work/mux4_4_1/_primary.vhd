library verilog;
use verilog.vl_types.all;
entity mux4_4_1 is
    port(
        IDEX            : in     vl_logic_vector(31 downto 0);
        EXMEM           : in     vl_logic_vector(31 downto 0);
        MEMWB           : in     vl_logic_vector(31 downto 0);
        s               : in     vl_logic_vector(1 downto 0);
        aluInput        : out    vl_logic_vector(31 downto 0)
    );
end mux4_4_1;
