ori $1, $0, 0xFFFC
# puts the output memory loc in register 1

ori $3, $0, 0x0020
# puts maxVal in $2

addiu $4, $3, 0x0010

sw $4, $1, 0

# print out full register 4 00000030
ori $2, $0, 0x000A
sw $2, $1, 0

halt
