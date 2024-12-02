package seq_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_main_seq extends uvm_sequence # (my_seq_item);
    `uvm_object_utils(my_main_seq)
    function new(string  name = "my_main_seq");
        super.new(name);
    endfunction
    task body();
            my_seq_item item;
            item = my_seq_item::type_id::create("item");
            start_item(item);
            item.rst = 1;
            finish_item(item);
    endtask
    //constraints
endclass
class my_rst_seq extends uvm_sequence # (my_seq_item);
    `uvm_object_utils(my_rst_seq)
    function new(string  name = "my_main_seq");
        super.new(name);
    endfunction
    task body();
        repeat(10000) begin
            my_seq_item item;
            item = my_seq_item::type_id::create("item");
            start_item(item);
            assert(item.randomize());
            finish_item(item);
        end
    endtask
    //constraints
endclass
endpackage