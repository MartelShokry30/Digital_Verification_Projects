package agt_pkg;
import uvm_pkg::*;
import sqr_pkg::*;
import drv_pkg::*;
import monitor_pkg::*;
import config_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)
    //virtual alsu_if alsu_vif;
    alsu_config alsu_cfg;
    my_monitor alsu_monitor;
    alsu_driver drv;
    my_sqr sqr;
    uvm_analysis_port #(my_seq_item) agt_ap;
    function new(string  name = "my_agt",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(alsu_config)::get(this,"","ALSU_cfg",alsu_cfg)) begin
            `uvm_fatal("build phase","test - unable to get alsu_cfg of alsu from config db - agent ")
        end
        alsu_monitor=my_monitor::type_id::create("my_monitor",this);
        sqr=my_sqr::type_id::create("my_sqr",this);
        drv=alsu_driver::type_id::create("my_driver",this);
        agt_ap=new("agent_ap",this);

    endfunction

    function void connect_phase(uvm_phase phase);
        drv.alsu_vif=alsu_cfg.alsu_vif;
        alsu_monitor.alsu_vif=alsu_cfg.alsu_vif;
        drv.seq_item_port.connect(sqr.seq_item_export);
        alsu_monitor.mon_ap.connect(this.agt_ap);
    endfunction

    //constraints
endclass
endpackage