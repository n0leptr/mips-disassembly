# Author: Gabriel De Jesus
# Licensed under GPL 3.0
# instructions are stored within base address given in $a0
# number of instructions given in $a1
# Purpose: This will read instructions located in memory and decode them into
# a string representing a proper MIPS instruction
# Note:
#   It is possible to significantly reduce the amount of written instructions
#   but I chose to do it this way for readability.

    .text
    .globl main

main:
    ori     $t0, $0, 0
    li      $a1, 6
    la      $a0, instruction_list
    add     $a2, $0, $a0    # preserve a0
    addi    $s1, $0, 32     # funct for add
    addi    $s2, $0, 34     # funct for sub
    addi    $s3, $0, 8      # opcode for addi
    addi    $s4, $0, 35     # opcose for lw
    addi    $s5, $0, 43     # opcode for sw
loop:
    add     $a0, $0, $a2
    beq     $t0, $a1, exit
    sll     $t1, $t0, 2
    add     $t1, $t1, $a0   # address of instruction
    lw      $t1, 0($t1)
    srl     $t2, $t1, 26
    beq     $t2, $0, add_or_sub     # if opcode is 0, it is add or sub instruction
    beq     $t2, $s3, addi_inst
    beq     $t2, $s4, lw_instr
    beq     $t2, $s5, sw_instr
    j       invalid_instruction  
    # extract op code
add_or_sub:
    # extract funct
    sll     $t3, $t1, 26           # extract funct
    srl     $t3, $t3, 26           # 0 extended function value
    beq     $t3, $s1, add_instr    # if the byte is 32, then it is add, if 34 then sub
    beq     $t3, $s2, sub_instr
add_instr:
    #get rs, rt, rd
    # extract rd
    sll     $t5, $t1, 16
    srl     $t5, $t5, 27        # t5 = rd
    # extract rt
    sll     $t6, $t1, 11
    srl     $t6, $t6, 27        # t6 = rt
    # extract rs
    sll     $t7, $t1, 6
    srl     $t7, $t7, 27        # t7 = rs
    # output to console
    li      $v0, 4
    la      $a0, add_string
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t5
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t7
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t6
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j       loop
sub_instr:
        #get rs, rt, rd
    # extract rd
    sll     $t5, $t1, 16
    srl     $t5, $t5, 27        # t5 = rd
    # extract rt
    sll     $t6, $t1, 11
    srl     $t6, $t6, 27        # t6 = rt
    # extract rs
    sll     $t7, $t1, 6
    srl     $t7, $t7, 27        # t7 = rs
    # output to console
    li      $v0, 4
    la      $a0, sub_string
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t5
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t7
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t6
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j       loop
addi_inst:
    # extract rt
    sll     $t5, $t1, 11
    srl     $t5, $t5, 27
    # extract rs
    sll     $t6, $t1, 6
    srl     $t6, $t6, 27
    # extract immediate
    sll     $t7, $t1, 16
    srl     $t7, $t7, 16
    # out put to console
    li      $v0, 4
    la      $a0, addi_string
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t5
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t6
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 1
    add     $a0, $0, $t7
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j loop
lw_instr:
    # extract rt
    sll     $t5, $t1, 11
    srl     $t5, $t5, 27
    # extract rs
    sll     $t6, $t1, 6
    srl     $t6, $t6, 27
    # extract immediate
    sll     $t7, $t1, 16
    srl     $t7, $t7, 16
    # out put to console
    li      $v0, 4
    la      $a0, lw_string
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t5 
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 1
    add     $a0, $0, $t7
    syscall
    li      $v0, 4
    la      $a0, l_par
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t6
    syscall
    li      $v0, 4
    la      $a0, r_par
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j loop
sw_instr:
    # extract rt
    sll     $t5, $t1, 11
    srl     $t5, $t5, 27
    # extract rs
    sll     $t6, $t1, 6
    srl     $t6, $t6, 27
    # extract immediate
    sll     $t7, $t1, 16
    srl     $t7, $t7, 16
    # out put to console
    li      $v0, 4
    la      $a0, sw_string
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t5 
    syscall
    li      $v0, 4
    la      $a0, comma
    syscall
    li      $v0, 1
    add     $a0, $0, $t7
    syscall
    li      $v0, 4
    la      $a0, l_par
    syscall
    li      $v0, 4
    la      $a0, dollarsign
    syscall
    li      $v0, 1
    add     $a0, $0, $t6
    syscall
    li      $v0, 4
    la      $a0, r_par
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j loop
invalid_instruction:
    li      $v0, 4
    la      $a0, inv_string
    syscall
    li      $v0, 4
    la      $a0, newline
    syscall
    addi    $t0, $t0, 1
    j       loop
exit:
    li	    $v0, 10
	syscall
    jr      $ra
###
    .data
newline:	
	.asciiz "\n"
dollarsign:
    .asciiz "$"
whtspc:
    .asciiz " "
comma:
    .asciiz ","
l_par:
    .asciiz "("
r_par:
    .asciiz ")"
instruction_list:
    # add   $17, $18, $19
    # sub   $17, $18, $19
    # addi  $17, $18, 100
    # lw    $17, 100($18)
    # sw    $17, 100($18)
    # Invalid instruction
    .align 2
    .word 0x02538820, 0x02538822, 0x22510064, 0x8E510064, 0xAE510064, 0x12345678
add_string:
    .asciiz "add "
sub_string:
    .asciiz "sub "    
addi_string:
    .asciiz "addi " 
lw_string:
    .asciiz "lw "
sw_string:
    .asciiz "sw "
inv_string:
    .asciiz "Invalid Instruction!"
