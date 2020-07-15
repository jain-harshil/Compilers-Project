.data

.text
li $t8,268500992
li $t0, 0
sw $t0,0($t8)

li $t0, 5
sw $t0,4($t8)

li $t0, 0
sw $t0,8($t8)

li $t0, 10
sw $t0,12($t8)

LabStartWhile0:lw $t0, 0($t8)
lw $t1, 4($t8)

bge $t0, $t1, NextPartWhile0
li $t0, 0
sw $t0,16($t8)

LabStartWhile1:lw $t0, 16($t8)
lw $t1, 12($t8)

bge $t0, $t1, NextPartWhile1
lw $t0, 8($t8)
li $t1, 1
add $t0, $t0, $t1
sw $t0,8($t8)

lw $t0, 16($t8)
li $t1, 1
add $t0, $t0, $t1
sw $t0,16($t8)

j LabStartWhile1
NextPartWhile1:
lw $t0, 0($t8)
li $t1, 1
add $t0, $t0, $t1
sw $t0,0($t8)

j LabStartWhile0
NextPartWhile0:
lw $t0, 8($t8)
li $t1, 0
add $t0, $t0, $t1
sw $t0,8($t8)


li $v0,1
move $a0,$t0
syscall
