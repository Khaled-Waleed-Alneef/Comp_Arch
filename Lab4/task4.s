.data
a: .string "a = "
b: .string " ,b = "
result: .string " ,result = "

.text
li x5,5#a
li x6,6#b
li x7,0#result
li x8,1#if

loop:
and x9,x8,x6#check the if state
bne x9,x8,if_false#skip the if state (if = false)
add x7,x7,x5#perform addition (if = true)
if_false:
slli x5,x5,1#perform a * 2
srli x6,x6,1#perform b / 2

bgt x6,x0,loop

print:
li a0,4
la a1,a
ecall

li a0,1
mv a1,x5
ecall

li a0,4
la a1,b
ecall

li a0,1
mv a1,x6
ecall

li a0,4
la a1,result
ecall

li a0,1
mv a1,x7
ecall

exit:
li a0,10
ecall