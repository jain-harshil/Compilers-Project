.data

.text
li $t8,268500992
li $t0, 5
sw $t0,0($t8)

li $t0, 5
sw $t0,4($t8)

li $t0, 0
sw $t0,8($t8)

IfStart0:lw $t0, 0($t8)
lw $t1, 4($t8)

bge $t0, $t1, NextPartIfElse0
li $t0, 0
sw $t0,8($t8)

j ElseEnd0
NextPartIfElse0:
IfStart1:lw $t0, 4($t8)
lw $t1, 0($t8)

bge $t0, $t1, NextPartIfElse1
li $t0, 0
sw $t0,8($t8)

j ElseEnd1
NextPartIfElse1:
li $t0, 1
sw $t0,8($t8)

ElseEnd1:
ElseEnd0:
lw $t0, 8($t8)
sw $t0,8($t8)


li $v0,1
move $a0,$t0
syscall
