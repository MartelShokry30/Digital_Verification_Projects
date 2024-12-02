import uvm_pkg::*;
import alsu_test_pkg::*;
`include "uvm_macros.svh"
module top();
    bit clk;
    initial begin
        
        forever begin
            #1 clk = ~clk; 
        end
    end
    alsu_if alsuif(clk);
    ALSU DUT(alsuif.A, alsuif.B, alsuif.cin, alsuif.serial_in, alsuif.red_op_A, alsuif.red_op_B, alsuif.opcode, alsuif.bypass_A, 
    alsuif.bypass_B, clk, alsuif.rst, alsuif.direction, alsuif.leds, alsuif.out);
    initial begin
        uvm_config_db #(virtual alsu_if)::set(null,"*","ALSU_IF",alsuif);
        run_test("alsu_test");
        
    end 
endmodule