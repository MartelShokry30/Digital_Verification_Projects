package main_seq_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
    class my_main_sequence extends uvm_sequence #(my_sequence_item);
        `uvm_object_utils(my_main_sequence)
        my_sequence_item seq_item;
        function new(string name = "main_seq");
            super.new(name);
        endfunction

        virtual task body();
            repeat (100) begin
                seq_item = my_sequence_item::type_id::create("seq_item");
                start_item(seq_item);
                assert(seq_item.randomize());
                finish_item(seq_item);
            end
        endtask

    endclass
endpackage