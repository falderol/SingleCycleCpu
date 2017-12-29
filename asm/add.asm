ori $1, $0, 0xFFFC
# puts the output memory loc in register 1

ori $2, $0, 0x0030
# puts 0 in $2

ori $3, $0, 0x0035
# puts 5 in $3

add $4, $2, $3
# should put 0x0065 in $4 or e

sw $2, $1, 0
# should print 0
sw $3, $1, 0
# should print 5
sw $4, $1, 0
# should print e

ori $5, $0, 0x000A
sw $5, $1, 0
# print newline

halt
