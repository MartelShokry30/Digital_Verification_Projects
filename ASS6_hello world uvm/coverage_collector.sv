package cov_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_cov extends uvm_component;
    `uvm_component_utils(my_cov)
    my_seq_item seq_item;
    uvm_analysis_export #(my_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(my_seq_item) cov_fifo;
    function new(string  name = "my_cov",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_fifo=new("cov_fifo",this);
        cov_export=new("cov_export",this);    
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        cov_fifo.get(seq_item);
        //sample() functions
    endtask
    //constraints
endclass
endpackage