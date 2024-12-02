package drv_pkg;
import uvm_pkg::*;
import config_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class alsu_driver extends uvm_driver #(my_seq_item);
    `uvm_component_utils(alsu_driver)
    virtual alsu_if alsu_vif;
    my_seq_item item;
    function new(string name = "alsu_drv",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = my_seq_item::type_id::create("my_seq_item");
            seq_item_port.get_next_item(item);
            alsu_vif.A = item.A;
            alsu_vif.B = item.B;
            alsu_vif.cin = item.cin;
            alsu_vif.opcode = item.opcode;
            alsu_vif.serial_in = item.serial_in;
            alsu_vif.red_op_A = item.red_op_A;
            alsu_vif.red_op_B = item.red_op_B;
            alsu_vif.bypass_A = item.bypass_A;
            alsu_vif.bypass_B = item.bypass_B;
            alsu_vif.rst = item.rst;
            alsu_vif.direction = item.direction;
            @(negedge alsu_vif.clk) 
            `uvm_info("run_phase",item.convert2string_stimulus(),UVM_HIGH)
            seq_item_port.item_done();
        end
        
    endtask

endclass 
endpackage