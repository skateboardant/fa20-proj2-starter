.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:

    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    
    li t0, 1
    blt a2, t0, exit75
    
    blt a3, t0, exit76
    blt a4, t0, exit76
    
    li s0, 0
    li t1, 0
    li t2, 4
    mul t3, t2, a3
    mul t4, t2, a4

loop_start:
    beq t1, a2, loop_end
    lw t5, 0(a0)
    lw t6, 0(a1)
    mul s1, t5, t6
    add s0, s0, s1
    add a0, a0, t3
    add a1, a1, t4
    addi t1, t1, 1
    j loop_start

loop_end:
    add a0, s0, x0

    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    
    ret

exit75:
    li a0, 17
    li a1, 75
    ecall

exit76:
    li a0, 17
    li a1, 76
    ecall
