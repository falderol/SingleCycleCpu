#Tests all arithmetic instructions, input from 0xFFF8, output from 0xFFFC
#input is x, y
#output is z#
#z = ((unsigned((x+y) + 2) + unsigned(x)) + unsigned(4)) - y
#at each step the output is printed
#it also will test halt and not subtract by y at the end

lw $1, $0, 0xFFF8 
lw $2, $0, 0xFFF8 

#addi $1, $1, 0xFFD0
#addi $2, $2, 0xFFD0

#addi $1, $1, 0x0030
#sw $1, $0, 0xFFFC
#addi $1, $1, 0xFFD0

#addi $2, $2, 0x0030
#sw $2, $0, 0xFFFC
#addi $2, $2, 0xFFD0

add $3, $1, $2

#addi $3, $3, 0x0030
sw $3, $0, 0xFFFC
#addi $3, $3, 0xFFD0

addi $3, $3, 0x2

#addi $3, $3, 0x0030
sw $3, $0, 0xFFFC
#addi $3, $3, 0xFFD0

addu $3, $3, $1

#addi $3, $3, 0x0030
sw $3, $0, 0xFFFC
#addi $3, $3, 0xFFD0

addiu $3, $3, 0x4

#addi $3, $3, 0x0030
sw $3, $0, 0xFFFC
#addi $3, $3, 0xFFD0

sub $3, $3, $2

#addi $3, $3, 0x0030
sw $3, $0, 0xFFFC
#addi $3, $3, 0xFFD0

ori $9, $0, 0xA
sw $9, $0, 0xFFFC

halt
sub $3, $3, $2
sw $3, $0, 0xFFFC

ori $9, $0, 0xA
sw $9, $0, 0xFFFC
