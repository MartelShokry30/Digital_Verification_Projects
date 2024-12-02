package scoreboard_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
    class my_sb extends uvm_scoreboard;
        `uvm_component_utils(my_sb)
        my_sequence_item seq_item;
        uvm_tlm_analysis_fifo #(my_sequence_item) sb_fifo;
        uvm_analysis_export #(my_sequence_item) sb_export;

        logic[3:0] count_out_ref;
        logic max_count_ref;
        logic zero_ref;
        int error_count = 0;
        int correct_count = 0;
        function new(string name = "my_sb",uvm_component parent = null);
            super.new(name,parent);
        endfunction



        function void build_phase(uvm_phase phase);
            $display("started build phase in driver");
            super.build_phase(phase);
            sb_fifo = new("sb_fifo",this);
            sb_export = new("sb_export",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase); 
            sb_export.connect(sb_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                seq_item = my_sequence_item::type_id::create("seq_item");
                sb_fifo.get(seq_item);
                ref_model(seq_item);
                if ((seq_item.max_count!=max_count_ref)||(seq_item.zero!=zero_ref)) begin
                    `uvm_error("run_phase",$sformatf("comparison failed, transaction received by DUT is %s while the expected max output is 0b%0b and expected zero count is 0b%0b", seq_item.convert2string(), max_count_ref,zero_ref));
                    error_count++;
            
                end
                else begin
                    `uvm_info("run_phase",$sformatf("comparison succeeded, transaction received by DUT is %s while the expected max output is 0b%0b and expected zero count is 0b%0b", seq_item.convert2string(), max_count_ref,zero_ref), UVM_HIGH);
                    correct_count++;

                end
            end
        
        endtask

        function void report_phase(uvm_phase phase);   
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("total passsed transactions are %d", correct_count), UVM_MEDIUM);
            `uvm_info("report_phase",$sformatf("total failed transactions are %d", error_count), UVM_MEDIUM);
        endfunction

        task ref_model(my_sequence_item seq_item);
            if (seq_item.rst) begin
                max_count_ref = 1'b0;
                zero_ref = 1'b1;
            end
            else begin
                if (seq_item.count_out == 4'b1111) begin
                    max_count_ref = 1'b1;
                    zero_ref = 1'b0;
                end
                else if (seq_item.count_out == 4'b0000) begin
                    zero_ref = 1'b1;
                    max_count_ref = 1'b0;
                end
                else begin
                    zero_ref = 1'b0;
                    max_count_ref = 1'b0;
                end

            end


        
        endtask

    endclass
endpackage