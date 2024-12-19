.data
array: .byte 0x78, 0x56, 0x34, 0x12, 0x21, 0x43, 0x65, 0x87

li x10,0x5
li x9,0x10000000

lb x1,7(x9)
lb x2,6(x9)
lb x3,5(x9)
lb x4,4(x9)
lb x5,3(x9)
lb x6,2(x9)
lb x7,1(x9)
lb x8,0(x9)

add x11,x0,x9
sb x0,7(x11)
sb x0,6(x11)
sb x0,5(x11)
sb x0,4(x11)
sb x0,3(x11)
sb x0,2(x11)
sb x0,1(x11)
sb x0,0(x11)

add x9,x9,x10
sb x1,7(x9)
sb x2,6(x9)
sb x3,5(x9)
sb x4,4(x9)
sb x5,3(x9)
sb x6,2(x9)
sb x7,1(x9)
sb x8,0(x9)