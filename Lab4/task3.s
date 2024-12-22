.data 
vector1: .byte 1,2,3,4,5,6,7,8
vector2: .byte 9,10,11,12,13,14,15,16 
result: .byte 1,0,0,0,0,0,0,0

.text

la x5, vector1#start address of Vecrtor1
la x6,vector2#start address of Vecrtor2
la x7,result#start address of Result
li x8,0#i
li x12,8
loop:
add x1,x5,x8#go to next address (Vector 1)
add x2,x6,x8#go to next address (Vector 2)
add x3,x7,x8#go to next address (Result)

lb x9,0(x1)#load Vector1[i]
lb x10,0(x2)#load Vector2[i]

add x11,x9,x10#perform addition

sb x11,0(x3)#store the value of the addition in result
addi x8,x8,1

bne x8,x12,loop


exit:
li a0,10
ecall
