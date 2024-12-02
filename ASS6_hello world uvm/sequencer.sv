package sqr_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_sqr extends uvm_sequencer #(my_seq_item);
    `uvm_component_utils(my_sqr)
    my_seq_item seq_item;
    function new(string  name = "my_sqr",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    //constraints
endclass
endpackage