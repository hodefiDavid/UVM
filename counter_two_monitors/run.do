# clean the previous compiled files and quit previous simulation
.main clear
# recompile the files
vlog counter.sv my_pkg.svh interface.sv top.sv

# start the simulation
vopt +acc top -o opt_test

# optimize the simulation
vsim opt_test

# add interface variables to the wave
add wave -position insertpoint sim:/top/i_inf/*

# run the simulation
# run 0