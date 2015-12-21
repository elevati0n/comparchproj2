library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        aluresult       : out    vl_logic_vector(31 downto 0);
        zero            : out    vl_logic;
        operation       : in     vl_logic_vector(3 downto 0);
        data_a          : in     vl_logic_vector(31 downto 0);
        data_b          : in     vl_logic_vector(31 downto 0)
    );
end alu;
