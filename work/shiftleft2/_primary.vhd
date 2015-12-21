library verilog;
use verilog.vl_types.all;
entity shiftleft2 is
    port(
        shiftMe         : in     vl_logic_vector(29 downto 0);
        shifted         : out    vl_logic_vector(31 downto 0)
    );
end shiftleft2;
