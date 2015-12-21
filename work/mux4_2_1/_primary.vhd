library verilog;
use verilog.vl_types.all;
entity mux4_2_1 is
    port(
        in0             : in     vl_logic_vector(4 downto 0);
        in1             : in     vl_logic_vector(4 downto 0);
        s               : in     vl_logic;
        \out\           : out    vl_logic_vector(4 downto 0)
    );
end mux4_2_1;
