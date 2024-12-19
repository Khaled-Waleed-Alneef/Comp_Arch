#the word "hello"
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

#reversing the word "hello" --> "olleh"
lb x7,0(x10)
lb x6,1(x10)
lb x5,2(x10)
lb x4,3(x10)
lb x3,4(x10)

sb x3,0(x10)
sb x4,1(x10)
sb x5,2(x10)
sb x6,3(x10)
sb x7,4(x10)