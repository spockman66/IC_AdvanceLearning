# This is a Makefile
##########################  Parameters  #############################
# Object Verilog Files' catalog
ObjVFile = spi.f

# VCD File's name(.vcd)
VcdFile  = *

# elf File's name(.out)
ElfFile  = run
#####################################################################

# read Verilog Files' catalog
FileBuf := $(shell cat $(ObjVFile))

# make all
all:
	iverilog -o $(ElfFile).out $(FileBuf)
	vvp -n $(ElfFile).out
	gtkwave $(VcdFile).vcd

# only make compile
compile:
	iverilog -o $(ElfFile).out $(FileBuf)

# only make visual ( make .elf file to the .vcd file )
visual:
	vvp -n $(ElfFile).out

# only open the wave
sim: 
	gtkwave $(VcdFile).vcd

# clear middle files
clean:
	rm -rf *vcd *.out


