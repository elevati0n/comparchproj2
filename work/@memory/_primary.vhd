library verilog;
use verilog.vl_types.all;
entity Memory is
    generic(
        MEM_SIZE        : integer := 16384
    );
    port(
        inst_addr       : in     vl_logic_vector(32 downto 1);
        instr           : out    vl_logic_vector(31 downto 0);
        data_addr       : in     vl_logic_vector(32 downto 1);
        data_in         : in     vl_logic_vector(31 downto 0);
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        data_out        : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MEM_SIZE : constant is 1;
end Memory;
