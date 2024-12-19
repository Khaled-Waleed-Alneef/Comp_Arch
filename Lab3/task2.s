li x10,0x10000000
li x5,0x12345678

sw x5,0(x10)

lb x6,0(x10)
slli x7,x6,8
lb x6,1(x10)
add x7,x7,x6
lb x6,2(x10)
slli x7,x7,8
add x7,x7,x6
lb x6,3(x10)
slli x7,x7,8
add x7,x7,x6

sw x7,0(x10)