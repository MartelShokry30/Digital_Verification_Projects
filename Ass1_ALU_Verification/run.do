vlib work
vlog ALU.sv ALU_tb.sv  +cover
vsim -voptargs=+acc work.ALU_tb -cover
add wave *
coverage save ALU_tb.ucdb -onexit
run -all
