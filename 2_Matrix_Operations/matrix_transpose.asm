.text
                
# ---------------------------------------------------------
# Subroutine: CountUppercase
# Counts the number of uppercase letters in a null-terminated string
# Input:  $a0 -> Pointer to string
# Output: $v0 -> Number of uppercase letters                                      
# ---------------------------------------------------------
CountUppercase: 	
	li $v0, 0               # Initialize counter
	lb $t0, 0($a0)          # Load first byte
count_loop:
	beq $t0, '\0', count_end    # Exit on null terminator	
	blt $t0, 'A', next_char     # Skip if below 'A'
	bgt $t0, 'Z', next_char     # Skip if above 'Z'
	addi $v0, $v0, 1            # Increment counter if 'A' <= char <= 'Z'
next_char: 
	addi $a0, $a0, 1            # Move to next byte
	lb $t0, 0($a0)
	j count_loop			
count_end:
 	jr $ra
		

# ---------------------------------------------------------
# Subroutine: MatrixTranspose
# Transposes an NxM matrix into an MxN matrix
# Input:
#   $a0 -> Pointer to source matrix NxM (A)
#   $a1 -> Pointer to destination matrix MxN (B)
#   $a2 -> N (Rows)
#   $a3 -> M (Columns)
# ---------------------------------------------------------
MatrixTranspose:
	li $t0, 0   	        # $t0 = i (Row index)
loop_i: 
    li $t1, 0	            # $t1 = j (Column index)
loop_j: 
    # Calculate address of A[i][j] -> BaseA + (i * M + j) * 4
	mul $t2, $t0, $a3      	
	add $t2, $t2, $t1	    
	sll $t2, $t2, 2		    
	add $t3, $t2, $a0	    
    
    # Calculate address of B[j][i] -> BaseB + (j * N + i) * 4
	mul $t4, $t1, $a2      	
	add $t4, $t4, $t0	    
	sll $t4, $t4, 2		    
	add $t5, $t4, $a1	    

    # Transfer data from A[i][j] to B[j][i]
	lw $t6, 0($t3)		    
	sw $t6, 0($t5)		    

	addi $t1, $t1, 1	    # j++
	blt $t1, $a3, loop_j	# loop if j < M
	addi $t0, $t0, 1	    # i++
	blt $t0, $a2, loop_i	# loop if i < N

	jr $ra