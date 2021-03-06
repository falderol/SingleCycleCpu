# Makefile automatically generated by ghdl
# Version: GHDL 0.33 (20150921) [Dunoon edition] - llvm code generator
# Command used to generate this makefile:
# ghdl --gen-makefile test_bench_regfile_32x32

GHDL=ghdl
GHDLFLAGS=

# Default target
all: test_bench_regfile_32x32

# Elaboration target
test_bench_regfile_32x32: /usr/lib/ghdl/v93/ieee/std_logic_1164.o /usr/lib/ghdl/v93/ieee/std_logic_1164_body.o word.o register_address.o Clock.o Decoder_4x16.o Decoder_5x32.o dff.o Register_x32.o MUX_4x1_vector.o MUX_2x1_vector.o MUX_32x32x1_vector.o RegisterFile32x32.o test_bench_REGFILE_32x32.o
	$(GHDL) -e $(GHDLFLAGS) $@

# Run target
run: test_bench_regfile_32x32
	$(GHDL) -r test_bench_regfile_32x32 $(GHDLRUNFLAGS)

# Targets to analyze files
/usr/lib/ghdl/v93/ieee/std_logic_1164.o: /usr/lib/ghdl/v93/ieee/../../src/ieee/std_logic_1164.v93
	@echo "This file was not locally built ($<)"
	exit 1
/usr/lib/ghdl/v93/ieee/std_logic_1164_body.o: /usr/lib/ghdl/v93/ieee/../../src/ieee/std_logic_1164_body.v93
	@echo "This file was not locally built ($<)"
	exit 1
word.o: word.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
register_address.o: register_address.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
Clock.o: ./Clock/Clock.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
Decoder_4x16.o: Decoder/Decoder_4x16.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
Decoder_5x32.o: Decoder/Decoder_5x32.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
dff.o: DFF/dff.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
Register_x32.o: Register/Register_x32.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
MUX_4x1_vector.o: MUX/MUX_4x1_vector.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
MUX_2x1_vector.o: MUX/MUX_2x1_vector.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
MUX_32x32x1_vector.o: MUX/MUX_32x32x1_vector.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
RegisterFile32x32.o: RegisterFile/RegisterFile32x32.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
test_bench_REGFILE_32x32.o: RegisterFile/test_bench_REGFILE_32x32.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

# Files dependences
/usr/lib/ghdl/v93/ieee/std_logic_1164.o: 
/usr/lib/ghdl/v93/ieee/std_logic_1164_body.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
word.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
register_address.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
Clock.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
Decoder_4x16.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
Decoder_5x32.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o register_address.o Decoder_4x16.o
dff.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
Register_x32.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o word.o dff.o
MUX_4x1_vector.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
MUX_2x1_vector.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o
MUX_32x32x1_vector.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o word.o MUX_4x1_vector.o MUX_2x1_vector.o
RegisterFile32x32.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o word.o register_address.o Decoder_5x32.o Register_x32.o MUX_32x32x1_vector.o
test_bench_REGFILE_32x32.o:  /usr/lib/ghdl/v93/ieee/std_logic_1164.o /usr/lib/ghdl/v93/ieee/std_logic_1164_body.o word.o register_address.o Clock.o RegisterFile32x32.o
