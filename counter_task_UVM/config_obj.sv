package config_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
    class my_config extends uvm_object;
        `uvm_object_utils(my_config)
        virtual counter_if vif;
        function new(string name = "config_obj");
            super.new(name);
        endfunction

    endclass
endpackage