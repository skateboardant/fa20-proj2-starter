.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw ra, 4(sp)

    addi t0, x0, 1
    blt a1, t0, exit
    
    add s0, a0, x0
    add t1, x0, x0
    
loop_start:
    beq t1, a1, loop_end
    slli t2, t1, 2
    add t3, s0, t2
    lw t4, 0(t3)
    blt t4, x0, rectifier

loop_continue:
    addi t1, t1, 1
    j loop_start

loop_end:
    # Epilogue
    lw s0, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
	ret
    
exit:
    li a0, 17
    li a1, 78
    ecall
rectifier:
    sw x0, 0(t3)
    j loop_continue