#cd D:
#cd project
#cd simulation
#cd uvm_encjpg
cd D:/project/simulation/uvm_encjpg/

if [file exists work] {
    vdel -all
}

#1. create a new project
vlib work

#2. map work to current dirctory
vmap work work

#3. set up env
set INCPATH D:/project/git_project/asic/dv/uvm_encjpg/
set SRCPATH D:/project/design/
set UVMPATH C:/modeltech64_10.2c/uvm-1.1d/
set UVMSRCPATH C:/modeltech64_10.2c/verilog_src/uvm-1.1d/src
set svn_tree D:/project

#4. compile
vlog +incdir+$UVMPATH  +incdir+$INCPATH/tb \
	 +incdir+$INCPATH/tests/ahb_agent \
	 +incdir+$INCPATH/tests/axi_agent \
	 +incdir+$INCPATH/tests/encjpg \
	 +incdir+$INCPATH/tests/encjpg/src \
	 +acc -incr -sv -svext -f $INCPATH/run/modelsim/encjpg.f 
				
vsim -novopt work.tb_top +UVM_VERBOSITY=UVM_HIGH +UVM_TESTNAME=encjpg
add wave -position insertpoint sim:/tb_top/wdut0/dut/*
run -all
				

