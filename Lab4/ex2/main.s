
.data
myArray: .word 'a', 'b', 'c','d', 'e', 0

.text

.globl main


main:
    la a0,myArray
    
    jal ra,afisRec

ret

afisRec:
    lw t0,0(a0) #pun elem curent din vector in t0 pt a il comapara cu 0 sa vad daca sunt la final
    beq zero,t0, fin

    addi sp,sp,-8
    sw a0,0(sp)
    sw ra,4(sp)

    addi a0,a0,4

    jal ra,afisRec

    addi a0,a0,-4


    lw a1,0(a0)
    addi a0,zero,11
    ecall

    addi a0,zero,11
    addi a1,zero,10
    ecall

    lw a0,0(sp)
    lw ra,4(sp)
    addi sp,sp,8


    fin:


jalr zero,0(ra)

