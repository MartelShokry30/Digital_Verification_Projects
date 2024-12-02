module counter_sva #( parameter int WIDTH = 4)
(counter_if.Monitor c_if); //used the monitor modport as all signals are input

always_comb begin : my_comb
    if (c_if.count_out == {WIDTH{1'b1}}) begin
        assert (c_if.max_count == 1);
    end
    if (c_if.count_out == {WIDTH{1'b0}}) begin
        assert (c_if.zero == 1);
    end  
    if (c_if.rst) begin
        assert final (c_if.count_out == 0);
    end  
end
property load;
    @(posedge c_if.clk) disable iff (c_if.rst) (!c_if.load_n |-> ##1 c_if.count_out == $past(c_if.data_load));
endproperty

property disable_cnt;
    @(posedge c_if.clk) disable iff (c_if.rst) ((c_if.load_n && !c_if.ce )|-> ##1 c_if.count_out == $past(c_if.count_out));
endproperty

property increment;
    @(posedge c_if.clk) disable iff (c_if.rst || (c_if.count_out == 0)) ((c_if.load_n && c_if.ce && c_if.up_down)|-> ##1 c_if.count_out == $past(c_if.count_out)+1);
endproperty

property decrement;
    @(posedge c_if.clk) disable iff (c_if.rst || (c_if.count_out == {WIDTH{1'b1}})) ((c_if.load_n && c_if.ce && !c_if.up_down)|-> ##1 c_if.count_out == $past(c_if.count_out)-1);
endproperty //here added count out in disable conditions to prevent wrap up or wrap down of counter and causing an error in the asssertion



loading_data: assert property(load) $display ("passed"); else $display ("failed load");
disabling_counter: assert property(disable_cnt) $display ("passed"); else $display ("failed disabling counter");
incrementing: assert property(increment) $display ("passed"); else $display ("failed incrementing");
decrementing: assert property(decrement) $display ("passed"); else $display ("failed decrementing");
Wrapping_up: assert property(decrement) $display ("passed"); else $display ("failed decrementing");
Wrapping_down: assert property(decrement) $display ("passed"); else $display ("failed decrementing");    

endmodule