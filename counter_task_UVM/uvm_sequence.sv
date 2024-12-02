package seq_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
    class my_sequence extends uvm_sequence;
        `uvm_object_utils(my_sequence)

        function new(string name = "seq");
            super.new(name);
        endfunction

    endclass
endpackage