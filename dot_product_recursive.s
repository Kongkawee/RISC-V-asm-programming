.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
string: .string "The dot product is: "
.text
main:
    # pass the first arguent to a0
    # pass the second argument to a1
    la a0, a
    la a1, b
    addi a2, x0, 5  # third argument (size)
    addi s1, x0, 0  # result of dot product
    
    jal dot
    
    mv s1, a0
    
    # print a string character; print_string
    addi a0, x0, 4
    la a1, string
    ecall

    # print_int
    addi a0, x0, 1
    add a1, x0, s1
    ecall
    
    # exit cleanly
    addi a0, x0, 10
    ecall
    
dot:    
    # base case
    # compare a1 with 1, if two are equal you exit the mult function
    addi t0, x0, 1
    beq a2, t0, exit_base_case
    
    # recursive case
    addi sp, sp, -4
    sw ra, 0(sp) # storing the ra value on to the stack

    # save arguments a0 and a1 on to the stack;
    addi sp, sp, -8
    sw a0, 0(sp)
    sw a1, 4(sp)
    
    # dot_product_recursive(a+1, b+1, size-1)
    addi a0, a0, 4  # a+1
    addi a1, a1, 4  # b+1
    addi a2, a2, -1 # size-1
    jal dot
    
    # save value of a0 into t1
    mv t1, a0
    
    # restore the original a value before the call to dot
    lw a0, 0(sp)
    lw a1, 4(sp)
    addi sp, sp, 8
    
    lw a3, 0(a0)
    lw a4, 0(a1)
    mul t2, a3, a4  # t2 = a[0]*b[0]
    add a0, t2, t1  # a0 = a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1)
    
    lw ra, 0(sp)
    addi sp, sp, 4
    
    jr ra  
    
exit_base_case:
    # return a[0]*b[0]
    lw a3, 0(a0)
    lw a4, 0(a1)
    mul a0, a3, a4
    
    jr ra