ori $1, $0, 0xFFFC
# puts the output memory loc in register s0

ori $2, $0, 0xDEDEDEDE
ori $3, $0, 0xFFFFFFFF

xor $4, $3, $2

sw $4, $1, 0

# Should print !

ori $4, $0, 0x000A
sw $4, $1, 0

halt


