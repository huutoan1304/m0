onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ahblite_axi_bridge_1_opt

do {wave.do}

view wave
view structure
view signals

do {ahblite_axi_bridge_1.udo}

run -all

quit -force
