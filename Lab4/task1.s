.data
equal: .string "equal"
not_equal: .string "not equal"



.text
li x5,5 #x
li x6,10 #y

bne x5,x6,else

if:
la a1,equal
li a0,4
ecall
beq x0,x0,exit

else:
la a1, not_equal
li a0,4
ecall

exit:
li a0,10
ecall