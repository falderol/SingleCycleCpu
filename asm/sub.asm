ori $1, $0, 0xFFFC
# puts the output memory loc in register s0

ori $2, $0, 0x0001
ori $3, $0, 0x0031

sub $4, $3, $2

sw $4, $1, 0

#print out 0 , now newline and halt

ori $4, $0, 0x000A
sw $4, $1, 0

halt


