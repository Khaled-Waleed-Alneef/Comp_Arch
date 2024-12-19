#store the byte-sized integers of: int Arr[5] = (1,2,3,4,5)
li x6,0x01
li x7,0x02
li x8,0x03
li x9,0x04
li x10,0x05


sb x6,0(sp)
sb x7,1(sp)
sb x8,2(sp)
sb x9,3(sp)
sb x10,4(sp)

#convert to word-sized integers of: int Arr[5] = (1,2,3,4,5)
lb x6,0(sp)
lb x7,1(sp)
lb x8,2(sp)
lb x9,3(sp)
lb x10,4(sp)

sw x6,0(sp)
sw x7,4(sp)
sw x8,8(sp)
sw x9,12(sp)
sw x10,16(sp)
