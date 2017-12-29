ori $s0, $zero, 0xFFFC
# puts the output memory loc in register s0

ori $s1, $zero, 0x000A
# puts the output memory loc in register s0

ori $s2, $zero, 0xFFFFFFFF
# puts maxVal in $s1

ori $s3, #zero, 0x0032
## puts 2 in s3

addu $s4, $s2, $s3

sw $s0 , 24($s2)
sw $s0 , 16($s2)
sw $s0 , 8($s2)
sw $s0 , 0($s2)
# print out full register s2 FFFFFFFF

sw $s0, 0($s1)
# should print a newline

sw $s0 , 24($s3)
sw $s0 , 16($s3)
sw $s0 , 8($s3)
sw $s0 , 0($s3)
# print out full register s3 00000032

sw $s0, 0($s1)
# should print a newline

sw $s0 , 24($s4)
sw $s0 , 16($s4)
sw $s0 , 8($s4)
sw $s0 , 0($s4)
# print out full register s3 00000031