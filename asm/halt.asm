ori $s0, $zero, 0xFFFC
# puts the output memory loc in register s0

ori $s1, $zero, 0x0048
sw $s0 , 0($s1)
# should print H

ori $s1, $zero, 0x0065
sw $s0 , 0($s1)
# should print e

ori $s1, $zero, 0x006C
sw $s0 , 0($s1)
# should print l

ori $s1, $zero, 0x006C
sw $s0 , 0($s1)
# should print l

ori $s1, $zero, 0x006F
sw $s0 , 0($s1)
# should print o

ori $s1, $zero, 0x0020
sw $s0 , 0($s1)
# should print a space

halt

ori $s1, $zero, 0x0057
sw $s0 , 0($s1)
# should print W

ori $s1, $zero, 0x006F
sw $s0 , 0($s1)
# should print o

ori $s1, $zero, 0x0072
sw $s0 , 0($s1)
# should print r

ori $s1, $zero, 0x006C
sw $s0 , 0($s1)
# should print l

ori $s1, $zero, 0x0064
sw $s0 , 0($s1)
# should print d

ori $s1, $zero, 0x0021
sw $s0 , 0($s1)
# should print !