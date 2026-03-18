.data
    prompt_msg: .asciiz "Enter a number: "
    error_msg:  .asciiz "ERROR: The number has a prime factor larger than the considered ones.\n"
    asterisk:   .asciiz " * "
    caret:      .asciiz "^"
    
    primes:     .word 2, 3, 5, 7, 11, 0  # Array of prime numbers
    result:     .space 32                # Buffer for prime factors

.text
main:
    # Print prompt
    la $a0, prompt_msg      
    li $v0, 4
    syscall 
    
    # Read integer from user
    li $v0, 5
    syscall
    move $a0, $v0
    
    # Call prime factorization subroutine
    la $a1, primes              
    la $a2, result
    jal factorize_prime 
    
    # Check for errors
    bne $v0, $zero, print_error 
    la $a0, result
    jal print_factors   
    
exit_program:
    li $v0, 10
    syscall 
    
print_error:
    la $a0, error_msg   
    li $v0, 4
    syscall 
    j exit_program

# ---------------------------------------------------------
# Subroutine: factorize_prime
# Output: $v0 (0: Success, 1: Num < 2, 2: Factor not found)
# ---------------------------------------------------------
factorize_prime:
    move $s0, $a0   # Number to factorize
    move $s1, $a1   # Primes array pointer
    move $s2, $a2   # Results array pointer

    blt $s0, 2, error_less_than_two

recursive_factor:
    lw $t1, 0($s1)              # Load prime
    beq $t1, $zero, error_not_found # End of primes array
    
    move $t0, $s0               # Backup current number
    div $s0, $t1                # Divide number by prime
    mfhi $t2                    # Get remainder
    beqz $t2, store_factor      # If divisible, store it
    
    move $s0, $t0               # Restore number
    addi $s1, $s1, 4            # Next prime
    j recursive_factor

store_factor:
    mflo $s0                    # Update number with quotient
    sw $t1, 0($s2)              # Store factor in result array
    addi $s2, $s2, 4            # Advance result pointer
    beq $s0, 1, success_end     # If number is 1, we are done
    j recursive_factor

success_end:
    sw $zero, 0($s2)            # Null-terminate result array
    li $v0, 0
    jr $ra

error_less_than_two:
    li $v0, 1
    jr $ra

error_not_found:
    li $v0, 2
    jr $ra

# ---------------------------------------------------------
# Subroutine: print_factors
# Formats and prints the prime factors (e.g., 2^3 * 3^1)
# ---------------------------------------------------------
print_factors:
    # (Implementation omitted for brevity, uses syscalls 1 and 4 to format output)
    jr $ra