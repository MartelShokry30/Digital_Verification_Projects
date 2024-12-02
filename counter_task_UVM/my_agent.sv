package agt_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
import drv_pkg::*;
import sqr_pkg::*;
import config_pkg::*;
import monitor_pkg::*;
import seq_item_pkg::*;
class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)
    my_drv driver;
    my_sequencer sqr;
    my_monitor monitor;
    my_config cfg;
    uvm_analysis_port #(my_sequence_item) agt_ap;
    function new(string name = "my_agt",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        $display("started build phase in env");
        super.build_phase(phase);
        if (!uvm_config_db #(my_config)::get(this,"","cfg",cfg))
            `uvm_fatal("build_phase","unable to retrieve the config object");
        driver = my_drv::type_id::create("drv",this);
        sqr = my_sequencer::type_id::create("sqr",this);
        monitor = my_monitor::type_id::create("monitor",this);
        agt_ap = new("agt_ap",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.vif=cfg.vif;
        monitor.vif=cfg.vif;
        driver.seq_item_port.connect(sqr.seq_item_export);
        monitor.mon_ap.connect(agt_ap);
    endfunction

endclass
endpackage