#1
#li x5,0x87654321
#li x10,0x10000004

#li x6,0x12345678
#li x9,0x10000000

#sw x5,0(x10)
#sw x6,0(x9)

#2
li x1,0x100
li x2,0x100

li x10,0x10000000
li x9,0x10000100

sw x1,0(x10)
sw x2,0(x9)

lw x5,0(x10)
lw x6,0(x9)
#3
add x8,x5,x6

li x7,0x10000008
sw x8,0(x7)