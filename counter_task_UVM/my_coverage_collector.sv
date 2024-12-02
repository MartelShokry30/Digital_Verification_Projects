package coverage_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
    class my_coverage extends uvm_component;
        `uvm_component_utils(my_coverage)
        my_sequence_item seq_item;
        uvm_tlm_analysis_fifo #(my_sequence_item) cov_fifo;
        uvm_analysis_export #(my_sequence_item) cov_export;


        covergroup g1;
             Data_load_COV:coverpoint seq_item.data_load iff (!seq_item.load_n);
             cnt_out_cov_up:coverpoint seq_item.count_out iff(!seq_item.rst && seq_item.ce && seq_item.up_down);
             cnt_out_cov_trans_max:coverpoint seq_item.count_out {
                 bins max_t_zero = ( {4{1'b1}} => 0 );
             }
             cnt_out_cov_down:coverpoint seq_item.count_out iff(!seq_item.rst && seq_item.ce && !seq_item.up_down);
             cnt_out_cov_trans_min:coverpoint seq_item.count_out {
                 bins max_t_zero = (0 => {4{1'b1}} );
             }
        
        endgroup
        function new(string name = "coverage_col",uvm_component parent = null);
            super.new(name,parent);
            g1 =new();
        endfunction



        function void build_phase(uvm_phase phase);
            
            super.build_phase(phase);
            $display("started build phase in driver");
            cov_fifo = new("cov_fifo",this);
            cov_export = new("cov_export",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase); 
            cov_export.connect(cov_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                seq_item = my_sequence_item::type_id::create("seq_item");
                cov_fifo.get(seq_item);
                g1.sample();
                
            end
        
        endtask


    endclass
endpackage