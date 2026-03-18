.data
    # Array definitions
    array_A: .word 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 
    array_Even: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    array_Odd:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    array_Rev:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
    
.text
main:
    la $s0, array_A         # Base address of source array
    li $s2, 36              # Max offset (9 elements * 4 bytes = 36)
    la $s4, array_Even      # Base address of Evens array
    la $s5, array_Odd       # Base address of Odds array
    la $s6, array_Rev       # Base address of Reversed array

process_array:
    add $t0, $s2, $s0       # Calculate memory address: Base + Offset
    lw $t0, 0($t0)          # Load element from array A
    
    # Store in reversed array
    sw $t0, 0($s6)          
    addi $s6, $s6, 4        
    
    add $s1, $s1, $t0       # Accumulate sum for average calculation
    
    # Check if Even or Odd using division remainder
    li $t7, 2
    div $t0, $t7            
    mfhi $t7                # Get remainder
    bne $t7, $zero, is_odd  

is_even:      
    sw $t0, 0($s4)          # Store in Even array
    addi $s4, $s4, 4        
    j next_element  

is_odd:
    sw $t0, 0($s5)          # Store in Odd array
    addi $s5, $s5, 4    

next_element:
    slt $t0, $zero, $s2     # Check if offset > 0
    addi $s2, $s2, -4       # Decrement offset by 1 word (4 bytes)
    bne $t0, $zero, process_array # Loop if not finished

calculate_average:
    li $t7, 10              # Total elements
    div $s1, $t7            # Divide total sum by 10
    mflo $s3                # $s3 stores the arithmetic mean

exit:
    li $v0, 10
    syscall