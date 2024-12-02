package sqr_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
import seq_item_pkg::*;
class my_sequencer extends uvm_sequencer #(my_sequence_item);
    `uvm_component_utils(my_sequencer)

    function new(string name = "sqr",uvm_component parent = null);
        super.new(name,parent);
    endfunction
    

endclass
endpackage