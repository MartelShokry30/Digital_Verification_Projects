package env_pkg;
import drv_pkg::*;
import uvm_pkg::*;
import sqr_pkg::*;
import agt_pkg::*;
import cov_pkg::*;
import sb_pkg::*;
`include "uvm_macros.svh"
class alsu_env extends uvm_env;
    `uvm_component_utils(alsu_env)
    my_agent agt;
    my_sb sb;
    my_cov cov;
    function new(string name = "alsu_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = my_agent::type_id::create("my_agt",this);
        sb = my_sb::type_id::create("my_sb",this);
        cov = my_cov::type_id::create("my_cov",this);
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction

    // function void connect_phase(uvm_phase phase);
    //     //super.connect_phase(phase);
    //     alsu_drv.seq_item_port.connect(alsu_sqr.seq_item_export);
        
    // endfunction
endclass 
endpackage