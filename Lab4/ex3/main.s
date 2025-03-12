.data

myWord: .byte 'h','e','l','l','o','w','o','r','l','d',0
.text

.globl main

main:

    addi a1,zero,0

    addi sp,sp,-12
    sw a0,4(sp)
    sw ra,8(sp)
    sw a1,12(sp)


    la a0,myWord #primul parametru pentru vectorul de caractere
    jal ra,calcLungime


    mv a0,a1
    addi a0,zero,1
    ecall


    lw a0,4(sp)
    lw ra,8(sp)
    lw a1,12(sp)
    addi sp,sp,8


    ret


calcLungime:
    lw t0,0(a0) #pun in t0 primul element din vector, ca sa verific daca e zero

    #in a1 voi tine nr de caractere
    
    beq t0,zero,fin

    addi sp,sp,-8
    sw a0,4(sp)
    sw ra,8(sp)

    addi a1,a1,1
    addi a0,a0,1

    jal ra, calcLungime


    lw a0,4(sp)
    lw ra,8(sp)
    addi sp,sp,8

    fin:

    jalr zero,0(ra)
