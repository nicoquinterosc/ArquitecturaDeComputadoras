#CODIGO FIBONACCI
FIB:    addi $sp, $sp, -12
        sw $ra, 0($sp)
        sw $s1, 4($sp)
        sw $a0, 8($sp) #comentario
        slti $t0, $a0, 1
        beq $t0, $0, L1
        addi $v0, $a0, 0
        j EXIT
L1:     addi $a0, $a0, -1
        jal FIB
        addi $s1, $v0, 0 #comentario
        addi $a0, $a0, -1
        jal FIB
EXIT:   lw $ra, 0($sp)
        lw $a0, 8($sp)
        lw $s1, 4($sp)
        addi $sp, $sp, 12
        jr $ra
        