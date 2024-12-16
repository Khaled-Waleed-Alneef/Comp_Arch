addi x5,x0,0x123
slli x6, x5, 12
addi x5,x0, 0x456
add x7,x6,x5
slli x8, x7,8
add x9, x0, x8
addi x6,x0,0x78
add x5,x9,x6

add a1, x0, x5
addi a0, x0, 1
ecall