module alu( output reg[31:0] aluresult, output zero,
            input[3:0] operation, input[31:0] data_a, input [31:0] data_b );
  // These codes and outputs are taken from figure 4.12 and the first graph in ch.4.4 P&H.
  assign zero = (aluresult == '0);    
  always @ (operation or data_a or data_b) begin
    case (operation)
      4'b0000: begin // AND
        aluresult = data_a & data_b;
      end
      4'b0001: begin // OR
        aluresult = data_a | data_b;
      end
      4'b0010: begin // add
        aluresult = data_a + data_b;
      end
      4'b0110: begin // subtract
        aluresult = data_a - data_b;
      end
      4'b0111: begin // slt
        //check sign bit for negative 
        if //if a is negative and b is positive a is smaller
          ((data_a[31] == 1) && (data_b [31] == 0))
          begin 
          aluresult = 1;
        end
       else if // b is negative therefore smaller 
          ((data_b[31] == 1) && (data_a [31] == 0))
          begin 
          aluresult = 0;
        end
       else if //both are negative do opposite
          ((data_b[31] == 1) && (data_a [31] == 1))
          begin
          aluresult = data_a > data_b ? 1 : 0;
        end
        else //normal case 
        begin
          aluresult =  data_a < data_b ? 1 : 0;
      end  
      end
      4'b1100: begin // nor
        aluresult = ~( data_a  | data_b );
      end
      default: begin
        aluresult = data_a + data_b;
      end
    endcase
  end
endmodule
