package test_pkg;
import uvm_pkg::*; 
import env_pkg::*;
import config_pkg::*;
import main_seq_pkg::*;
import rst_seq_pkg::*;
`include "uvm_macros.svh"
class my_test extends uvm_test;
    `uvm_component_utils(my_test)
    my_env env;
    my_config cfg;
    my_main_sequence main_seq;
    my_rst_sequence rst_seq;

    function new(string name = "my_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        $display("started build phase in test");
        super.build_phase(phase);
        env = my_env::type_id::create("my_env",this);
        cfg = my_config::type_id::create("my_config");
        main_seq = my_main_sequence::type_id::create("main_seq");
        rst_seq = my_rst_sequence::type_id::create("rst_seq");

        if(!uvm_config_db #(virtual counter_if)::get(this,"","counter_if",cfg.vif))
            `uvm_fatal("build phase","test - unable to get vif from config db - test ");
        uvm_config_db #(my_config)::set(this,"*","cfg",cfg);
    endfunction

    task run_phase(uvm_phase phase);
        $display("started run phase in test at time %0t", $time);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase","reset_asserted",UVM_LOW);
        rst_seq.start(env.agt.sqr);
        `uvm_info("run_phase","reset_deasserted",UVM_LOW);
        `uvm_info("run_phase","stimulus generation started",UVM_LOW);
        main_seq.start(env.agt.sqr);
        `uvm_info("run_phase","stimulus generation ended",UVM_LOW);        
        phase.drop_objection(this);
    endtask
endclass

endpackage


