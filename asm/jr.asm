ori $s0, $zero, 0xFFFC
# puts the output memory loc in register s0

ori $s2, $zero, 0x0030
# puts 0 in $s1

jal Skip

addi $s2, 1($s1)
# adds 1 to register s1

Skip

addi $s2, 1($s1)
# adds 1 to register s1

jr

sw $s0 , 24($s2)
sw $s0 , 16($s2)
sw $s0 , 8($s2)
sw $s0 , 0($s2)
# print out full register s2 00000002