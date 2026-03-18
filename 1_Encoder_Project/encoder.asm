# ---------------------------------------------------------
# File: encoder.asm
# Encrypts the string using the parsed configuration.
# Input:
#   $a0: Pointer to config object in stack
#   $a1: Pointer to output string
# Output:
#   $v0: Error code (0: OK, 1: Empty string, 2: Illegal chars)
# ---------------------------------------------------------
.text
.globl encoder

encoder:
    addiu $sp, $sp, -24
    sw $ra, 20($sp) 
    sw $s0, 16($sp) 
    sw $s1, 12($sp) 
    sw $s2, 8($sp) 
    sw $s3, 4($sp) 

    move $s0, $a0               # $s0 = Config object pointer
    move $s1, $a1               # $s1 = Output string pointer
    
    lw $s2, 4($s0)              # Load key from config
    addiu $s3, $s0, 8           # $s3 = Pointer to string inside config

    # Check for empty string
    lb $t0, 0($s3)
    beq $t0, 10, error_empty    # 10 = \n
    beqz $t0, error_empty       # 0 = \0

encode_loop:
    lb $t0, 0($s3)              # Load char
    beqz $t0, encode_end        # End of string
    beq $t0, 10, encode_end     # Ignore \n at the end

    # Validate printable ASCII (32 to 126)
    blt $t0, 32, error_illegal
    bgt $t0, 126, error_illegal

    # Apply Cipher (Character + Key)
    add $t0, $t0, $s2           

    # Handle ASCII wrap-around
wrap_check:
    bgt $t0, 126, wrap_upper
    blt $t0, 32, wrap_lower
    j store_char

wrap_upper:
    addi $t0, $t0, -95          # 126 - 32 + 1
    j wrap_check

wrap_lower:
    addi $t0, $t0, 95
    j wrap_check

store_char:
    sb $t0, 0($s1)              # Store in output
    addiu $s3, $s3, 1           # Next input char
    addiu $s1, $s1, 1           # Next output char
    j encode_loop

encode_end:
    sb $zero, 0($s1)            # Null terminate
    li $v0, 0                   # Success
    j encoder_exit

error_empty:
    li $v0, 1
    j encoder_exit

error_illegal:
    li $v0, 2

encoder_exit:
    lw $ra, 20($sp) 
    lw $s0, 16($sp) 
    lw $s1, 12($sp) 
    lw $s2, 8($sp) 
    lw $s3, 4($sp) 
    addiu $sp, $sp, 24
    jr $ra