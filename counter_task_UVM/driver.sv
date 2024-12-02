package drv_pkg;
`include "uvm_macros.svh"
import config_pkg::*;
import uvm_pkg::*;
import seq_item_pkg::*;
import counter_pkg::*;
    class my_drv extends uvm_driver #(my_sequence_item);
        `uvm_component_utils(my_drv)
        my_sequence_item seq_item;
        virtual counter_if vif;
        int counter;
        function new(string name = "my_drv",uvm_component parent = null);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            $display("started build phase in driver");
            super.build_phase(phase);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase); 
        endfunction
        
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                seq_item=my_sequence_item::type_id::create("seq_item");
                seq_item_port.get_next_item(seq_item);
                vif.rst=seq_item.rst;
                vif.load_n=seq_item.load_n;
                vif.up_down=seq_item.up_down;
                vif.ce=seq_item.ce;
                vif.data_load=seq_item.data_load;
                @(negedge vif.clk);
                seq_item_port.item_done();
                `uvm_info("run_phase", seq_item.convert2_string_stimulus(),UVM_HIGH);

            end
        // $display("started run phase in drv at time %0t", $time);
        // trans = new();
        // counter = 0;
        // @(negedge cfg.vif.clk);
        // forever begin
        //    assert (trans.randomize());
        //    counter=counter+1;
        //    cfg.vif.rst = trans.rst;
        //    cfg.vif.load_n = trans.load_n;
        //    cfg.vif.up_down = trans.up_down;
        //    cfg.vif.ce = trans.ce;
        //    cfg.vif.data_load = trans.data_load;
        //    trans.count_out = cfg.vif.count_out;
           
        //    $display("counter is %d", counter);
        //    @(negedge cfg.vif.clk);
        // end
        endtask
    endclass
endpackage