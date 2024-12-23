.text
li a0, 5
jal fact # jal ra factorial

mv a1, a0
li a0, 1
ecall

li a0, 10 # load a value 10 into a0 register to exit the
ecall







fact:
    li t0, 1
    ble a0, t0, return_one
    else: # return n*fact(n-1)
    # we need to find fact(n-1) first
    addi sp, sp, -8
    sw a0, 0(sp)
    sw ra, 4(sp)
    
    addi a0, a0, -1
    call fact
    # now a0 = fact(n-1)
    lw a1, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    
    mul a0 ,a0 ,a1
    ret
    
return_one:
    li a0, 1
    ret
