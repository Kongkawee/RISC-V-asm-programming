.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
newline: .string "The dot product is: "
.text
main:
    addi x5, x0, 5   # let x5 be 5 for loop limit.
    addi x6, x0, 0   # let x6 be sop and set it to 0.
    
    addi x8, x0, 0  # let x5 be i and set it to 0.
    la x9, a # loading the address of a to x9
    la x7, b # loading the address of b to 7
loop:
    bge x8 , x5, exit
    
    slli x18,x8, 2   # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address off a and put it to x19
    add x20, x18, x7 # add i*4 to the base address off b and put it to x20
    lw x22, 0(x19)
    lw x23, 0(x20)
    mul x21, x22, x23 # sop sum
    add x6, x6, x21
    
    addi x8, x8, 1 # i++
    j loop
    
exit:   
    # print a newline character; print_string
    addi a0, x0, 4
    la a1, newline
    ecall
    # print int sop
    addi a0, x0, 1
    add a1, x0, x6
    ecall 
    # exit cleanly
    addi a0, x0, 10
    ecall