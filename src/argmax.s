.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
    addi sp, sp, -4
    sw ra, 0(sp)
    
    addi t0, x0, 1
    blt a1, t0, exit
    
    li t1, 0
    lw t2, 0(a0)
    li t3, 1
    
loop_start:
    beq t3, a1, loop_end
    slli t4, t3, 2
    add t5, a0, t4
    lw t6, 0(t5)
    bgt t6, t2, change
    
loop_continue:
    addi t3, t3, 1
    j loop_start

loop_end:
    add a0, t1, x0

    # Epilogue
    lw ra 0(sp)
    addi sp, sp, 4

    ret

change:
    add t2, t6, x0
    add t1, t3, x0
    j loop_continue
    
exit:
    li a1, 77
    jal exit2

