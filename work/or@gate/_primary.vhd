library verilog;
use verilog.vl_types.all;
entity orGate is
    port(
        in0             : in     vl_logic;
        in1             : in     vl_logic;
        \out\           : out    vl_logic
    );
end orGate;
