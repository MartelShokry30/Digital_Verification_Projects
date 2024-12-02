vlib work
vlog priority_enc.sv priority_enc_tb.sv  +cover
vsim -voptargs=+acc work.four_to_two_priority_enc_tb -cover
add wave *
coverage save four_to_two_priority_enc_tb.ucdb -onexit
run -all
