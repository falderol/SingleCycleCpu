ori $s0, $zero, 0xFFFC
# puts the output memory loc in register s0

ori $s1, $zero, 0x0001
ori $s2, $zero, 0x004C

srl $s3, $s2, $s1

sw $s0 , 24($s2)
sw $s0 , 16($s2)
sw $s0 , 8($s2)
sw $s0 , 0($s2)
# print out full register s2 &