package sb_pkg;
import uvm_pkg::*;
import seq_item_pkg::*;
`include "uvm_macros.svh"
class my_sb extends uvm_scoreboard ;
    `uvm_component_utils(my_sb)
    my_seq_item seq_item;
    uvm_analysis_export #(my_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(my_seq_item) sb_fifo;
    logic [5:0] Alsu_out;
    int error_count=0;
    int correct_count=0;
    function new(string  name = "my_sb",uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sb_fifo=new("sb_fifo",this);
        sb_export=new("sb_export",this);    
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        sb_fifo.get(seq_item);
        ref_model(seq_item);
        if (seq_item.out != Alsu_out) begin
            error_count++;
            `uvm_error("run phase", $sformatf("comparison failed, transaction received by DUT is %s while referemce out is 0b%0b",seq_item.convert2string(),Alsu_out));
        end
        else begin
            correct_count++;
            `uvm_info("run phase", $sformatf("comparison sunccesful, correct alu_out %s",seq_item.convert2string()),UVM_HIGH);
        end
    endtask
    task ref_model(my_seq_item seq_item_checker);
    //try to model the alsu as it is

    endtask
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report phase", $sformatf("total successful transcations %0d",correct_count),UVM_HIGH);
        `uvm_info("report phase", $sformatf("total error transcations %0d",error_count),UVM_HIGH);
    endfunction
    //constraints
endclass
endpackage