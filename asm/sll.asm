ori $1, $0, 0xFFFC
# puts the output memory loc in register s0

ori $2, $0, 0x0001
ori $3, $0, 0x0020

sll $4, $3, 0x0001

sw $4, $1, 0
# print out @

ori $4, $0, 0x000A
sw $4, $1, 0

halt

