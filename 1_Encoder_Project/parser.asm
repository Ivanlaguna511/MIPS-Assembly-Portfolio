# ---------------------------------------------------------
# File: parser.asm
# Parses the input string, extracts the key and the target string.
# Input:
#   $a0: Pointer to input string
#   $a1: Pointer to conf_t struct in stack (isDecode, key, string)
# Output:
#   $v0: Error Code (0: OK, 1: Not "enc", 2: Syntax Error)
# ---------------------------------------------------------
.data 
    cmd_enc: .asciiz "enc"

.text 
.globl parser

parser: 
    # Stack setup
    addiu $sp, $sp, -16 
    sw $ra, 12($sp) 
    sw $s0, 8($sp) 
    sw $s1, 4($sp) 
    sw $s2, 0($sp) 

    move $s0, $a0       # $s0 = input string pointer
    move $s1, $a1       # $s1 = config struct pointer

    # 1. Skip leading spaces
    move $a0, $s0
    jal skip_spaces
    move $s0, $v0       # Update pointer after spaces

    # 2. Check for "enc" command
    move $a0, $s0
    la $a1, cmd_enc
    jal check_command
    bnez $v0, parser_err_cmd  # If not 0, command is invalid
    
    # Advance pointer by 3 bytes ("enc")
    addiu $s0, $s0, 3

    # 3. Skip spaces after "enc"
    move $a0, $s0
    jal skip_spaces
    move $s0, $v0

    # 4. Extract integer key using atoi
    move $a0, $s0
    jal atoi
    bnez $v1, parser_err_syntax # If atoi sets $v1 != 0, error
    
    # Store key in config struct (offset 4)
    sw $v0, 4($s1)

    # 5. Skip spaces after key
    # (Assuming atoi advanced the pointer to the end of the number, 
    # we need the new address. Custom atoi should return updated pointer in $a0)
    move $s0, $a0
    jal skip_spaces
    move $s0, $v0

    # 6. Copy remaining string to config struct buffer (offset 8)
    addiu $a1, $s1, 8   # Destination inside config struct
    move $a0, $s0       # Source remaining string
    jal copy_string

    li $v0, 0           # Success
    j parser_end

parser_err_cmd:
    li $v0, 1
    j parser_end

parser_err_syntax:
    li $v0, 2

parser_end:
    lw $ra, 12($sp) 
    lw $s0, 8($sp) 
    lw $s1, 4($sp) 
    lw $s2, 0($sp) 
    addiu $sp, $sp, 16 
    jr $ra

# --- Helper: Skip Spaces ---
skip_spaces:
skip_loop:
    lb $t0, 0($a0)
    bne $t0, 32, skip_done  # 32 = Space
    addiu $a0, $a0, 1
    j skip_loop
skip_done:
    move $v0, $a0
    jr $ra

# --- Helper: Check Command ---
check_command:
    li $t2, 0           # index
check_loop:
    lb $t0, 0($a0)
    lb $t1, 0($a1)
    beqz $t1, check_ok  # Reached end of "enc"
    bne $t0, $t1, check_fail
    addiu $a0, $a0, 1
    addiu $a1, $a1, 1
    j check_loop
check_ok:
    li $v0, 0
    jr $ra
check_fail:
    li $v0, 1
    jr $ra

# --- Helper: Copy String ---
copy_string:
copy_loop:
    lb $t0, 0($a0)
    sb $t0, 0($a1)
    beqz $t0, copy_done
    addiu $a0, $a0, 1
    addiu $a1, $a1, 1
    j copy_loop
copy_done:
    jr $ra