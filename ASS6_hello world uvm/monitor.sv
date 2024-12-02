package monitor_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)
    virtual alsu_if alsu_vif;
    my_seq_item seq_item;
    uvm_analysis_port #(my_seq_item) mon_ap;
    function new(string  name = "my_monitor",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_ap=new("mon_ap",this);
    endfunction   
    task run_phase(uvm_phase phase);
        forever begin
            seq_item=my_seq_item::type_id::create("my_seq_item",this);
            @(negedge alsu_vif.clk);
            seq_item.A = alsu_vif.A;
            seq_item.B = alsu_vif.B;
            seq_item.cin = alsu_vif.cin;
            seq_item.opcode = alsu_vif.opcode;
            seq_item.serial_in = alsu_vif.serial_in;
            seq_item.red_op_A = alsu_vif.red_op_A;
            seq_item.red_op_B = alsu_vif.red_op_B;
            seq_item.bypass_A = alsu_vif.bypass_A;
            seq_item.bypass_B = alsu_vif.bypass_B; 
            seq_item.rst=alsu_vif.rst; 
            seq_item.direction = alsu_vif.direction;
            mon_ap.write(seq_item);
            `uvm_info("run_phase",seq_item.convert2string(),UVM_HIGH);

        end
    endtask
    //constraints
endclass
endpackage