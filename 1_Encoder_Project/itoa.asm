# ---------------------------------------------------------
# File: itoa.asm
# Converts a 32-bit integer to an ASCII string.
# Input:  
#   $a0 -> Integer to convert
#   $a1 -> Format type (0 = 32-bit signed, etc.)
#   $a2 -> Pointer to destination string
# ---------------------------------------------------------
.text
.globl itoa

itoa:
    move $t0, $a0       # Number to convert
    move $t7, $a2       # Save original start of string
    li $t2, 10          # Divisor
    li $t9, 0           # Negative flag

    # Check if negative (only if format 0 - 32-bit signed)
    bnez $a1, convert_loop # Skip sign check if not format 0
    bgez $t0, convert_loop
    
    li $t9, 1           # Set negative flag
    xori $t0, $t0, 0xFFFFFFFF
    addi $t0, $t0, 1    # Make positive

convert_loop:
    div $t0, $t2
    mflo $t0            # Quotient
    mfhi $t1            # Remainder
    
    addi $t1, $t1, '0'  # Convert remainder to ASCII
    sb $t1, 0($a2)      # Store char
    addiu $a2, $a2, 1
    
    bnez $t0, convert_loop

    # Add minus sign if negative
    beqz $t9, terminate_string
    li $t1, '-'
    sb $t1, 0($a2)
    addiu $a2, $a2, 1

terminate_string:
    sb $zero, 0($a2)    # Null terminator
    
    # String is currently backwards, need to reverse it
    move $t8, $a2
    addiu $t8, $t8, -1  # $t8 points to last char

reverse_loop:
    bge $t7, $t8, itoa_end # If start >= end, we are done
    
    lb $t3, 0($t7)      # Swap start and end
    lb $t4, 0($t8)
    sb $t4, 0($t7)
    sb $t3, 0($t8)
    
    addiu $t7, $t7, 1
    addiu $t8, $t8, -1
    j reverse_loop

itoa_end:
    jr $ra
