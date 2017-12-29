ori $s0, $zero, 0xFFFC
# puts the output memory loc in register s0

ori $s1, $zero, 0x21
ori $s2, $zero, 0xFFFFFFFF

nor $s3, $s2, $s1

sw $s0 , 24($s3)
sw $s0 , 16($s3)
sw $s0 , 8($s3)
sw $s0 , 0($s3)
# print out full register s2 !!!!!!!!