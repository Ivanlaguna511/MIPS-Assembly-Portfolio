# ---------------------------------------------------------
# File: main.asm
# Entry point for the Encoder Project.
# Allocates stack memory for configuration and calls the Parser and Encoder.
# ---------------------------------------------------------
.data
    input_msg:      .asciiz "Enter command (e.g., enc 5 my_string): "
    output_msg:     .asciiz "Result: "
    err_parse_msg:  .asciiz "Error: Invalid command or syntax.\n"
    err_enc_msg:    .asciiz "Error: Encryption failed (empty string or illegal chars).\n"
    
    input_buffer:   .space 1024
    output_buffer:  .space 1024

.text
.globl main

main:
    # 1. Print input prompt
    li $v0, 4
    la $a0, input_msg
    syscall

    # 2. Read user input
    li $v0, 8
    la $a0, input_buffer
    li $a1, 1024
    syscall

    # 3. Call Encoder Wrapper
    la $a0, input_buffer
    la $a1, output_buffer
    jal run_encoder

    # Check for errors from wrapper
    bnez $v0, handle_errors

    # 4. Print Success Result
    li $v0, 4
    la $a0, output_msg
    syscall

    li $v0, 4
    la $a0, output_buffer
    syscall
    j exit

handle_errors:
    # Basic error handling based on return codes
    li $v0, 4
    la $a0, err_parse_msg
    syscall

exit:
    li $v0, 10
    syscall

# ---------------------------------------------------------
# Subroutine: run_encoder
# Wrapper that sets up the stack frame for the configuration object
# $a0: Input string pointer
# $a1: Output string pointer
# Returns $v0: Error code (0 = success)
# ---------------------------------------------------------
run_encoder:
    # Stack Frame: Reserve 1020 bytes
    # [1016]: isDecode (4 bytes)
    # [1012]: key (4 bytes)
    # [0-1011]: string buffer (1012 bytes)
    addiu $sp, $sp, -1020       
    sw $ra, 1016($sp)
    sw $s0, 1012($sp)
    sw $s1, 1008($sp)

    move $s0, $a0               # $s0 = Input string
    move $s1, $a1               # $s1 = Output string

    # Call Parser
    move $a0, $s0               # input_cad
    move $a1, $sp               # config pointer (stack base)
    jal parser
    bnez $v0, run_encoder_end   # If parser fails, return error

    # Call Encoder
    move $a0, $sp               # config pointer
    move $a1, $s1               # output string
    jal encoder

run_encoder_end:
    lw $ra, 1016($sp)
    lw $s0, 1012($sp)
    lw $s1, 1008($sp)
    addiu $sp, $sp, 1020
    jr $ra