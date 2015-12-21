library verilog;
use verilog.vl_types.all;
entity ForwardingUnit is
    port(
        IDEXinstrRt2016 : in     vl_logic_vector(4 downto 0);
        IDEXinstrRs2521 : in     vl_logic_vector(4 downto 0);
        EXMEMRegWrite   : in     vl_logic;
        EXMEMRegRd1511  : in     vl_logic_vector(4 downto 0);
        MEMWBRegWrite   : in     vl_logic;
        MEMWBRegRd1511  : in     vl_logic_vector(4 downto 0);
        fwdA            : out    vl_logic_vector(1 downto 0);
        fwdB            : out    vl_logic_vector(1 downto 0)
    );
end ForwardingUnit;
