interface counter_if #( parameter int WIDTH = 4)
    (input logic clk);

    logic rst,load_n,up_down,ce;
    logic [WIDTH-1:0] data_load, count_out;
    logic max_count, zero;
    
    modport TEST (input clk,max_count,zero, count_out,
                output rst,load_n,up_down,ce, data_load);
    modport DUT (input clk,rst,load_n,up_down,ce, data_load,
                output max_count,zero, count_out);
    modport Monitor (input clk,max_count,zero, count_out,
                    rst,load_n,up_down,ce, data_load);
endinterface
              


