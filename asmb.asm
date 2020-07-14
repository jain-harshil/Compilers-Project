.data

.text
li $t8,268500992
li $t0, 10
sw $t0,0($t8)

li $t0, 15
sw $t0,4($t8)

li $t0, 0
sw $t0,8($t8)

li $t0, 0
sw $t0,12($t8)

LabStartFor0:lw $t0, 12($t8)
lw $t1, 0($t8)

bge $t0, $t1, NextPartFor0
lw $t3, 0($t8)
lw $t4, 4($t8)

bge $t3, $t4, NextPartFor0
lw $t0, 8($t8)
li $t1, 1
add $t0, $t0, $t1
sw $t0,8($t8)

lw $t0, 12($t8)
li $t1, 1
add $t0, $t0, $t1
sw $t0,12($t8)

j LabStartFor0
NextPartFor0:
lw $t0, 8($t8)
sw $t0,8($t8)


li $v0,1
move $a0,$t0
syscall
