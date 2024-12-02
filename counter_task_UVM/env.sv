package env_pkg;
`include "uvm_macros.svh"
import uvm_pkg::*;
import drv_pkg::*;
import sqr_pkg::*;
import agt_pkg::*;
import scoreboard_pkg::*;
import coverage_pkg::*;
    class my_env extends uvm_env;
        `uvm_component_utils(my_env)
        my_agent agt;
        my_coverage cov;
        my_sb sb;
        function new(string name = "my_env",uvm_component parent = null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            $display("started build phase in env");
            super.build_phase(phase);
            agt = my_agent::type_id::create("agt",this);
            sb = my_sb::type_id::create("sb",this);
            cov = my_coverage::type_id::create("cov",this);

        endfunction

        function void connect_phase(uvm_phase phase);
            $display("started connect phase in env");
            super.connect_phase(phase);
            agt.agt_ap.connect(sb.sb_export);
            agt.agt_ap.connect(cov.cov_export);

        endfunction

    endclass
endpackage