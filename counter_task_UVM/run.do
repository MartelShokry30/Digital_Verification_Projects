vlib work
vlog Sva_module.sv interface.sv env.sv test.sv top.sv counter.sv counter_pkg_for_TLM.sv config_obj.sv driver.sv uvm_main_sequence.sv uvm_rst_sequence.sv sequencer.sv seq_item.sv my_agent.sv my_coverage_collector.sv my_monitor.sv my_scoreboard.sv +cover
vsim -voptargs=+acc work.top -cover
coverage save counter_tb.ucdb -onexit
run -all
//quit -sim
//vcover report counter_tb.ucdb -details -all -annotate -output cvr.txt
//add wave *