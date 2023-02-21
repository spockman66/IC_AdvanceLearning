onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib dds_1MHz_opt

do {wave.do}

view wave
view structure
view signals

do {dds_1MHz.udo}

run -all

quit -force
