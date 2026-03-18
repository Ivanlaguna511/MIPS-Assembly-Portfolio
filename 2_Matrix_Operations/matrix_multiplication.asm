.data   
    # Matrix A (9x6)
    matA: .word 36, 9, 3, 29, 34, 15, 41, 17, 25, -44, 4, 30, 23, 47, 1, -22, -33, 15, -48, 36, 19, 12, 21, 34, -48, 39, 0, 48, -40, 27, 29, -24, 25, 34, 25, 2, -2, 9, 36, -26, -8, 41, -21, 9, 2, 0, 1, 6, -56, 5, 21, 5, 6, 12
    # Matrix B (6x9)
    matB: .word 17, 37, -2, 40, -46, -1, 30, 42, -24, 37, 28, 5, -18, -46, -40, 7, 39, 98, -41, -32, 47, 33, -50, 0, -28, 36, -11, -15, 23, 56, 30, -12, -36, -4, -4, -25, -19, -12, 17, -43, -47, 78, -21, -13, 30, -16, 41, 5, 32, 5, 30, 10, -39, 12
    # Result Matrix C (9x9) -> 9 * 9 * 4 bytes = 324 bytes
    matC: .space 324
    
    # Dimensions: N (Rows A), K (Cols A / Rows B), M (Cols B)
    dimensions: .word 9, 6, 9

.text
main:
    la $a0, matA
    la $a1, matB
    la $a2, matC
    la $a3, dimensions
    jal matrix_multiply

    # Exit program
    li $v0, 10
    syscall

# ---------------------------------------------------------
# Subroutine: matrix_multiply
# Multiplies an NxK matrix by a KxM matrix (O(N^3) complexity)
# ---------------------------------------------------------
matrix_multiply:
    lw $t7, 0($a3)      # $t7 = N (Rows of A)
    lw $t8, 4($a3)      # $t8 = K (Cols of A / Rows of B)
    lw $t9, 8($a3)      # $t9 = M (Cols of B)
    
    li $t0, 0           # i = 0
loop_i: 
    li $t1, 0           # j = 0
loop_j: 
    li $t3, 0           # C[i][j] accumulator
    li $t2, 0           # k = 0
loop_k: 
    # Calculate address of A[i][k] -> A + (i*K + k) * 4
    mul $t4, $t0, $t8       
    add $t4, $t4, $t2   
    sll $t4, $t4, 2     
    add $t4, $t4, $a0   
    lw $t4, 0($t4)      # Load A[i][k]
    
    # Calculate address of B[k][j] -> B + (k*M + j) * 4
    mul $t5, $t2, $t9       
    add $t5, $t5, $t1   
    sll $t5, $t5, 2     
    add $t5, $t5, $a1   
    lw $t5, 0($t5)      # Load B[k][j]
    
    # Multiply and accumulate: C[i][j] += A[i][k] * B[k][j]
    mul $t4, $t4, $t5   
    add $t3, $t3, $t4   
    
    addi $t2, $t2, 1    # k++
    blt $t2, $t8, loop_k

    # Calculate address of C[i][j] -> C + (i*M + j) * 4
    mul $t6, $t0, $t9   
    add $t6, $t6, $t1   
    sll $t6, $t6, 2     
    add $t6, $t6, $a2   
    sw $t3, 0($t6)      # Store result in C[i][j]

    addi $t1, $t1, 1    # j++
    blt $t1, $t9, loop_j

    addi $t0, $t0, 1    # i++
    blt $t0, $t7, loop_i

    jr $ra