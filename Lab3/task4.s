#small letters "hello"
li x10,0x10000000
li x5,0x656C6C6F
sb x5,0(x10)
srli x6,x5,8
sb x6,1(x10)
srli x5,x6,8
sb x5,2(x10)
srli x6,x5,8
sb x6,3(x10)
li x5,0x68
sb x5,4(x10)

#convert to capital letters "HELLO"
li x6,0x20
lb x5,0(x10)
sub x5,x5,x6
sb x5,0(x10)

lb x5,1(x10)
sub x5,x5,x6
sb x5,1(x10)

lb x5,2(x10)
sub x5,x5,x6
sb x5,2(x10)

lb x5,3(x10)
sub x5,x5,x6
sb x5,3(x10)

lb x5,4(x10)
sub x5,x5,x6
sb x5,4(x10)