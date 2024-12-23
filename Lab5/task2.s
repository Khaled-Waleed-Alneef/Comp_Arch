.data
value: .byte 5
result: .word 0

.text
main:
la a0,value # load value address into a0
jal factorial

mv a1,a0 # print
li a0,1
ecall

li a0, 10 # load a value 10 into a0 register to exit the
ecall

factorial:
addi sp, sp, -16 # Allocate space on the stack
sw ra, 12(sp) # Save return address
sw s0, 8(sp) # Save s0
sw s1, 4(sp) # Save s1
lw s0, 0(a0) # move value to s0
li t0, 1 # Initialize result = 1
li t1, 1 # Initialize i = 1


loop:
bgt t1, s0, end_loop # If i >= size, exit loop
mul t0, t1, t0 # perform mult
addi t1,t1,1 # i++
j loop

end_loop:
add a0,x0,t0 # Load result into a0
lw ra, 12(sp) # Restore return address
lw s0, 8(sp) # Restore s0
lw s1, 4(sp) # Restore s1
addi sp, sp, 16 # Deallocate stack space
jr ra # Return to caller