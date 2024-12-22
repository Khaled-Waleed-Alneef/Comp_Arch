.data
star: .string "*"
space: .string " "
newline: .string "\n"
.text
li x8,0#num of rows
li x2,4#initial num of spaces
li x3,1#initial num of stars
li x9,5#max num of rows

add x4,x0,x2#num of spaces in loop
add x5,x0,x3#num of stars in loop

loop_rows:
    loop_space:
    li a0,4
    la a1,space
    ecall
    addi x4,x4,-1
    bge x4,x0,loop_space
    
    loop_stars:
    li a0,4
    la a1,star
    ecall
    addi x5,x5,-1
    bgt x5,x0,loop_stars
    
    addi x8,x8,1
    
    addi x2,x2,-1
    mv x4,x2
    
    addi x3,x3,2
    mv x5,x3
    
    li a0,4
    la a1,newline
    ecall
blt x8,x9,loop_rows

exit:
li a0,10
ecall