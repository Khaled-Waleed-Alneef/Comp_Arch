.text
main:
li t0, 5# Load immediate value 5 into register t0
li t1, 10# Load immediate value 10 into register t1
sub a1, t0, t1# a1 <= t0 - t1
# Print the result using a system call
li a0, 1
# System call for printing an integer
ecall
# Exit the program
li a0, 10
# System call for exit
ecall