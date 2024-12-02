package alsu_test_pkg;
import uvm_pkg::*;
import env_pkg::*;    
import config_pkg::*;
import seq_pkg::*;
`include "uvm_macros.svh"
class alsu_test extends uvm_test;
    `uvm_component_utils(alsu_test)
    alsu_env my_env;
    alsu_config alsu_cfg;
    my_main_seq main_seq;
    my_rst_seq rst_seq;
    function new(string name = "alsu_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_env = alsu_env::type_id::create("my_env",this);
        alsu_cfg = alsu_config::type_id::create("alsu_cfg",this);
        main_seq = my_main_seq::type_id::create("main_seq",this);
        rst_seq = my_rst_seq::type_id::create("reset_seq",this);
        if (!uvm_config_db #(virtual alsu_if)::get(this,"","ALSU_IF",alsu_cfg.alsu_vif)) begin
            `uvm_fatal("build phase","test - unable to get alsu_vif of alsu from config db - test ");
        end
        uvm_config_db #(alsu_config)::set(this,"*","ALSU_cfg",alsu_cfg);
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        //#10;`uvm_info("run phase","welcome to uvm env",UVM_MEDIUM);
        `uvm_info("run phase","reset asserted",UVM_MEDIUM);
        rst_seq.start(my_env.agt.sqr);
        `uvm_info("run phase","reset deasserted",UVM_MEDIUM);

        `uvm_info("run phase","stimulus started",UVM_MEDIUM);
        main_seq.start(my_env.agt.sqr);
        `uvm_info("run phase","stimulus ended",UVM_MEDIUM);
        phase.drop_objection(this);
    endtask
endclass 
endpackage