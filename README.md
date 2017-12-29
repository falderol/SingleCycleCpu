Repository for your VHDL assignments that result in a
simulated MIPS-lite processor.


vhdl is the language the cpu is written in.

ghdl is used to run the code.


To run currently compiled version without warnings use the command 

./cpu 2> /dev/null


To compile a program to run on the cpu you need to be in the asm folder

Use the commands

python assembler.py

"filename.asm"

mv /sram64x8.dat /..

then return to the top level directory using

cd ..

To compile the cpu use the commands

ghdl -i *.vhdl

ghdl -m --ieee=synopsys cpu


Currently supported commands are

addi

add

sub

xor

sll

slt

srl

addiu

addu

ori

slt

beq

lw

sw

j

beq

halt