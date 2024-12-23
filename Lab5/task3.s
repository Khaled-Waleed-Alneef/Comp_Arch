.data
array: .byte 5,6,3,4,2,1
result: .byte 0

.text
main:
    la a0,array
    jal BS
    
    exit:
    li a0,10 
    ecall
    

BS:
addi sp, sp, -16 # Allocate space on the stack
sw ra, 12(sp) # Save return address
sw s0, 8(sp) # Save s0
sw s1, 4(sp) # Save s1
lb s0,0(a0) # move arr to s0

loop_init:
    li t0,0 # i = 0
    li t2,5 # t2 = n - 1
loop:
    bge t0,t2,loop_end # check if i >= n
    inner_loop_init:
    li t1, 0 # j = 0
    sub t6,t2,t0
    inner_loop:
    bge t1,t6,inner_loop_end
    add t3,t1,a0 # address of arr[j]
    addi t4, t3, 1 # address of arr[j+1]
    lb s1,0(t3) # value of arr[j]
    lb s2,0(t4) # value of arr[j+1]
    ble s1,s2,else # check if arr[j] > arr[j+1]
    mv t5, s1 # temp = arr[j]
    mv s1,s2 # arr[j] = arr[j+1]
    mv s2,t5 # arr[j+1] = temp
    sb s1,0(t3) # store arr[j]
    sb s2,0(t4) # store arr[j+1] 
    else:
    addi t1,t1,1 # j++
    j inner_loop
    
    inner_loop_end:
  addi t0,t0, 1 # i++
  j loop
loop_end:
  jr ra 