ori $2, $0, 0xFFFC
# puts the output memory loc in register s0

ori $1, $0, 0x0048
sw $1, $2, 0
# should print H

ori $1, $0, 0x0065
sw $1, $2, 0
# should print e

ori $1, $0, 0x006C
sw $1, $2, 0
# should print l

ori $1, $0, 0x006C
sw $1, $2, 0
# should print l

ori $1, $0, 0x006F
sw $1, $2, 0
# should print o

ori $1, $0, 0x0020
sw $1, $2, 0
# should print a space

ori $1, $0, 0x0057
sw $1, $2, 0
# should print W

ori $1, $0, 0x006F
sw $1, $2, 0
# should print o

ori $1, $0, 0x0072
sw $1, $2, 0
# should print r

ori $1, $0, 0x006C
sw $1, $2, 0
# should print l

ori $1, $0, 0x0064
sw $1, $2, 0
# should print d

ori $1, $0, 0x0021
sw $1, $2, 0
# should print !

ori $1, $0, 0x000A
sw $1, $2, 0
# should print newline

halt
