vlib work
vlog decoder.v decoder_tb.v
vsim -voptargs=+acc work.decoder_tb
add wave *
run -all
# quit -sim