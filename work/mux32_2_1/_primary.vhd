library verilog;
use verilog.vl_types.all;
entity mux32_2_1 is
    port(
        s               : in     vl_logic;
        in0             : in     vl_logic_vector(31 downto 0);
        in1             : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end mux32_2_1;
