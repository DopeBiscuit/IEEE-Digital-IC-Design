vlib work
vlog RISC-V.v Imem.v controller.v Dmem.v datapath.v reg_file.v
vsim -voptargs=+acc work.tb_risc_v
vsim work.tb_risc_v
add wave -position insertpoint sim:/tb_risc_v/risc_v/imem/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/dmem/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/reg_file/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/srcbmux/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/alu/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/resultmux/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/pc_reg/*
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/dp/pcmux/*
add wave -position insertpoint  \
sim:/tb_risc_v/risc_v/risc/dp/reg_file/registers
add wave -position insertpoint  \
sim:/tb_risc_v/risc_v/dmem/mem
add wave -position insertpoint sim:/tb_risc_v/risc_v/risc/c/*