transcript on
if ![file isdirectory TFT_Oscillo_iputf_libs] {
	file mkdir TFT_Oscillo_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/PLL/pll_sim/pll.vo"

vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/TFT {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/TFT/TFT_image.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/TFT {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/TFT/TFT_driver.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/ADC {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/ADC/ad7928.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/simulation {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/simulation/adc7928_tb.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/TFT_Oscillo.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RAM {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RAM/ram.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/RTL/data_process.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/simulation {F:/FPGA/Code/DE1-SoC/Peripheral/TFT/TFT_Oscillo/simulation/data_process_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  data_process_tb

add wave *
view structure
view signals
run -all
