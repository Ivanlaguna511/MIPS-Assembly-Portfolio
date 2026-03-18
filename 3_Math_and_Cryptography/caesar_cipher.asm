.data
    input_string:    .space 21
    ciphered_string: .space 21
    msg_prompt:      .asciiz "Message: "
    key_prompt:      .asciiz "Key: "
    result_prompt:   .asciiz "Ciphered: "
    error_msg:       .asciiz "Invalid key\n"

.text
main:
    # Print Message prompt
    li $v0, 4
    la $a0, msg_prompt
    syscall
    
    # Read input string from user
    li $v0, 8
    la $a0, input_string
    li $a1, 20
    syscall
    
    # Print Key prompt
    li $v0, 4
    la $a0, key_prompt
    syscall
    
    # Read integer key
    li $v0, 5
    syscall
    move $t3, $v0
    
    # Print Ciphered prompt
    li $v0, 4
    la $a0, result_prompt
    syscall
    
    # Call clean_input to remove newline character (\n)
    la $a0, input_string
    li $a1, 20
    jal clean_input

    # Call caesar_encrypt
    # $a0: Source string | $a1: Shift key | $a2: Destination string
    la $a0, input_string
    move $a1, $t3
    la $a2, ciphered_string
    jal caesar_encrypt
    
    # Print the resulting ciphered string
    li $v0, 4
    la $a0, ciphered_string
    syscall

exit_program:
    li $v0, 10
    syscall

# ---------------------------------------------------------
# Subroutine: clean_input
# Removes the Line Feed (LF, ASCII 10) from the string
# ---------------------------------------------------------
clean_input:
    addu $t1, $a0, $a1      # Calculate max address boundary
clean_loop:
    lb $t0, 0($a0)          # Load current byte
    beqz $t0, clean_end     # If null terminator, exit
    li $t2, 10              # ASCII for Line Feed (\n)
    beq $t0, $t2, remove_lf # If LF found, replace it
    addiu $a0, $a0, 1       # Move to next byte
    bne $a0, $t1, clean_loop
    j clean_end

remove_lf:
    sb $zero, 0($a0)        # Replace LF with null terminator (\0)

clean_end:
    jr $ra

# ---------------------------------------------------------
# Subroutine: caesar_encrypt
# Applies a Caesar shift to the string within printable ASCII
# ---------------------------------------------------------
caesar_encrypt:
    bgt $a1, 100, cipher_error  # If key > 100, throw error

encrypt_loop:
    lb $t0, 0($a0)          # Load current byte
    beqz $t0, encrypt_end   # If null terminator, exit
    add $t0, $t0, $a1       # Apply shift key
    
    # Boundary checks for printable ASCII (32 to 127)
    blt $t0, 32, fix_lower_bound
    bgt $t0, 127, fix_upper_bound
    j store_char

fix_lower_bound:
    addi $t0, $t0, 95       # Wrap around if below space
    j store_char

fix_upper_bound:
    addi $t0, $t0, -95      # Wrap around if above DEL
    
store_char:
    sb $t0, 0($a2)          # Store ciphered byte in destination
    addiu $a0, $a0, 1       # Next source byte
    addiu $a2, $a2, 1       # Next destination byte
    j encrypt_loop

encrypt_end:
    sb $zero, 0($a2)        # Null-terminate destination string
    jr $ra

cipher_error:
    li $v0, 4
    la $a0, error_msg
    syscall
    j exit_program