package seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class my_seq_item extends uvm_sequence_item;
    `uvm_object_utils(my_seq_item)
    rand logic rst, cin, red_op_A, red_op_B, bypass_A, bypass_B, direction, serial_in;
    rand logic [2:0] opcode;
    rand logic signed [2:0] A, B;
    logic [15:0] leds;
    logic [5:0] out;
    function new(string  name = "my_seq_item");
        super.new(name);
    endfunction
    //constraints
    function string convert2string();
    return  $sformatf("A=%d, B=%d, cin=%b, opcode=%h, serial_in=%b, red_op_A=%b, red_op_B=%b, bypass_A=%b, bypass_B=%b, direction =%b, rst=%b, leds=%b, out=%d", super.convert2string(),
      A, B, cin, opcode, serial_in,
      red_op_A, red_op_B,
      bypass_A, bypass_B ,direction,rst,leds,out);
    endfunction
    function string convert2string_stimulus();
    return  $sformatf("A=%d, B=%d, cin=%b, opcode=%h, serial_in=%b, red_op_A=%b, red_op_B=%b, bypass_A=%b, bypass_B=%b, direction =%b, rst=%b",
    A, B, cin, opcode, serial_in,
    red_op_A, red_op_B,
    bypass_A, bypass_B ,direction,rst); 
    endfunction
endclass
endpackage