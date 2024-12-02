package seq_item_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
class my_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(my_sequence_item)
    rand bit rst,load_n,up_down,ce;
    rand bit [3:0] data_load;
    bit [3:0] count_out;
    bit max_count,zero;

    function new(string name = "seq_item");
        super.new(name);
    endfunction
    
    constraint counter_c {
        load_n dist {1:=70, 0:=30};
        rst dist {0:=90, 1:=10}; //deactivated all the time
        ce dist {1:=70,0:=30};
    }

    function string convert2_string_stimulus();
        return $sformatf("rst = 0b%0b, load_n = 0b%0b, up_down = 0b%0b, ce = 0b%0b, data_load = 0b%0b", rst,load_n,up_down,ce,data_load);
    endfunction

    function string convert2string();
        return $sformatf(" %s rst = 0b%0b, load_n = 0b%0b, up_down = 0b%0b, ce = 0b%0b, data_load = 0b%0b, count_out = %b, max_count = 0b%0b and zero = 0b%0b ",super.convert2string(), rst,load_n,up_down,ce,data_load,count_out,max_count,zero);
    endfunction

endclass
endpackage