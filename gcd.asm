.data
inp:     .asciiz "Please input the integer: "
inp2:    .asciiz "Please input the second integer: "
str1:    .asciiz "gcd("
str2:    .asciiz ", "
str3:    .asciiz ") = "
calls:   .asciiz "\nNumber of recursive calls: "
invalid: .asciiz "!!!Invalid, please enter a non-negative integer \n"

.text
.globl main

main:
    li   $v0, 4
    la   $a0, inp
    syscall

    li   $v0, 5
    syscall

    # Check for negative number
    blt  $v0, 0, retry

    # Save first input
    move $a1, $v0

    jal secondTry


retry:
    li   $v0, 4
    la   $a0, invalid
    syscall

    j main


retry2:
    li   $v0, 4
    la   $a0, invalid
    syscall

    j secondTry


secondTry:
    li   $v0, 4
    la   $a0, inp2
    syscall

    li   $v0, 5
    syscall

    # Check for negative number
    blt  $v0, 0, retry2

    # Save second input
    move $a2, $v0

    # Save original inputs
    move $s0, $a1
    move $s1, $a2

    # Initialize recursive-call counter
    li   $t1, 0

    # Call GCD
    jal gcd


gcd:
    # If numbers are equal, GCD has been found
    beq $a1, $a2, gcdEquals

    # If first number is zero
    beq $a1, 0, gcdFirstZero

    # If second number is zero
    beq $a2, 0, gcdSecondZero

    # If first number is greater
    bgt $a1, $a2, gcdFirstGreater

    # If second number is greater
    bgt $a2, $a1, gcdSecondGreater

    j exit


gcdEquals:
    # GCD is either number
    add $t0, $a1, $zero

    # Print "gcd("
    li $v0, 4
    la $a0, str1
    syscall

    # Print original first input
    li $v0, 1
    move $a0, $s0
    syscall

    # Print ", "
    li $v0, 4
    la $a0, str2
    syscall

    # Print original second input
    li $v0, 1
    move $a0, $s1
    syscall

    # Print ") = "
    li $v0, 4
    la $a0, str3
    syscall

    # Print GCD
    li $v0, 1
    move $a0, $t0
    syscall

    j printCalls


gcdFirstZero:
    # GCD(0, y) = y
    add $t0, $a2, $zero

    # Print "gcd("
    li $v0, 4
    la $a0, str1
    syscall

    # Print original first input
    li $v0, 1
    move $a0, $s0
    syscall

    # Print ", "
    li $v0, 4
    la $a0, str2
    syscall

    # Print original second input
    li $v0, 1
    move $a0, $s1
    syscall

    # Print ") = "
    li $v0, 4
    la $a0, str3
    syscall

    # Print GCD
    li $v0, 1
    move $a0, $t0
    syscall

    j printCalls


gcdSecondZero:
    # GCD(x, 0) = x
    add $t0, $a1, $zero

    # Print "gcd("
    li $v0, 4
    la $a0, str1
    syscall

    # Print original first input
    li $v0, 1
    move $a0, $s0
    syscall

    # Print ", "
    li $v0, 4
    la $a0, str2
    syscall

    # Print original second input
    li $v0, 1
    move $a0, $s1
    syscall

    # Print ") = "
    li $v0, 4
    la $a0, str3
    syscall

    # Print GCD
    li $v0, 1
    move $a0, $t0
    syscall

    j printCalls


gcdFirstGreater:
    # Count recursive call
    addi $t1, $t1, 1

    # gcd(x,y) = gcd(x-y,y)
    sub $a1, $a1, $a2

    jal gcd


gcdSecondGreater:
    # Count recursive call
    addi $t1, $t1, 1

    # gcd(x,y) = gcd(x,y-x)
    sub $a2, $a2, $a1

    jal gcd


printCalls:
    # Print newline and message
    li $v0, 4
    la $a0, calls
    syscall

    # Print number of recursive calls
    li $v0, 1
    move $a0, $t1
    syscall

    j exit


exit:
    li $v0, 10
    syscall