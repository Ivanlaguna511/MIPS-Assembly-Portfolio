.data
    fib_array: .space 80    # Reserve 80 bytes (20 elements * 4 bytes)

.text
main:
    la $s0, fib_array       # Base address of Fibonacci array
    
    # Initialize F[0] = 0 and F[1] = 1
    li $t1, 0               
    li $t2, 1
    sw $t1, 0($s0)          # Store F[0]
    sw $t2, 4($s0)          # Store F[1]
    
    li $t0, 2               # Loop counter (i = 2)
    li $s4, 0               # Total sum accumulator
            
generate_loop:
    sll $t3, $t0, 2         # Offset for i (i * 4)
    add $t1, $s0, $t3       # Address of F[i]
    
    addi $t3, $t3, -4       # Offset for i-1
    add $t2, $s0, $t3       # Address of F[i-1]
    lw $t2, 0($t2)          # Load F[i-1]
    
    addi $t3, $t3, -4       # Offset for i-2
    add $t3, $s0, $t3       # Address of F[i-2]
    lw $t3, 0($t3)          # Load F[i-2]
    
    # F[i] = F[i-1] + F[i-2]
    add $t2, $t2, $t3       
    sw $t2, 0($t1)          # Store result in F[i]
    
    add $s4, $s4, $t2       # Accumulate total sum
    
    addi $t0, $t0, 1        # i++
    blt $t0, 20, generate_loop  # Generate 20 numbers

exit_program:
    li $v0, 10
    syscall