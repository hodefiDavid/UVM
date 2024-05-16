# clean the previous compiled files and quit previous simulation
vdel -all
quit -sim

# recompile the files
vlog header.svh adder.sv top.sv interface.sv

# start the simulation
vopt +acc top -o opt_test

# optimize the simulation
vsim opt_test

# add interface variables to the wave
add wave -position insertpoint sim:/top/i_inf/*

# run the simulation
run -all