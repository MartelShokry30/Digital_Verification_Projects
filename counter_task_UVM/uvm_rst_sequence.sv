package rst_seq_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
    class my_rst_sequence extends uvm_sequence #(my_sequence_item);
        `uvm_object_utils(my_rst_sequence)
        my_sequence_item seq_item;
        function new(string name = "rst_seq");
            super.new(name);
        endfunction

        virtual task body();
            seq_item = my_sequence_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.rst = 1;
            seq_item.load_n = 0;
            seq_item.up_down = 0;
            seq_item.data_load = 0;
            seq_item.ce = 0;
            finish_item(seq_item);
        
        endtask

    endclass
endpackage