import uvm_pkg::*;
import test_pkg::*;
module top();

bit clk;
initial begin
    clk = 0;
    forever begin
        #10 clk = ~clk;    
    end
    
end

counter_if c_if(clk);
counter DUT(c_if);
bind counter counter_sva counter_sva_inst(c_if);


initial begin
    uvm_config_db #(virtual counter_if)::set(null,"*","counter_if",c_if);
    run_test("my_test");
end

endmodule