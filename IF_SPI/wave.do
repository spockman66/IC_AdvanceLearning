onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_master_tb/u_spi/clk
add wave -noupdate /spi_master_tb/u_spi/state
add wave -noupdate /spi_master_tb/u_spi/clk_en1
add wave -noupdate /spi_master_tb/u_spi/clk_en2
add wave -noupdate /spi_master_tb/u_spi/spi_load
add wave -noupdate /spi_master_tb/u_spi/tx_en
add wave -noupdate /spi_master_tb/u_spi/tx_data
add wave -noupdate /spi_master_tb/u_spi/tx_cnt
add wave -noupdate /spi_master_tb/u_spi/spi_done
add wave -noupdate /spi_master_tb/spi_mosi
add wave -noupdate /spi_master_tb/u_spi/SCLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110373 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {525 us}
