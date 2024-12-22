li x5,0x10000000
li x9,0x10000000
li x6,0 #i
li x8,100
loop:

sb x6,0(x9)#store value of i
addi x6,x6,1#i + 1
add x9,x5,x6#go to next address

bne x6,x8,loop

exit:
li a0,10
ecall