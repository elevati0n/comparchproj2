library verilog;
use verilog.vl_types.all;
entity pc_counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        next_addr       : in     vl_logic_vector(31 downto 0);
        current         : out    vl_logic_vector(31 downto 0);
        hazardStall     : in     vl_logic
    );
end pc_counter;
