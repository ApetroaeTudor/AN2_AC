.data
    a: .word 3
    b: .word 1
    c: .word 6
    d: .word 2
    e: .word 7

.text

.global main

.equ LEDS,      0x40010000
.equ BTNS,      0x40000000


find_max:
    #a0=a
    #a1=b
    #a2=c 

    bge a0,a1,continue
        mv a0,a1
    continue:

    bge a0,a2, continuee
        mv a0,a2
    continuee:

    bge a0,a3, continueee
        mv a0,a3
    continueee:

    bge a0,a4, continueeee
        mv a0,a4
    continueeee:


    jalr zero, 0(ra)

main:
    la      t0, a
    lw      a0, 0(t0)  
    
    la      t0, b
    lw      a1, 0(t0)

    la      t0, c
    lw      a2,0(t0)

    la      t0, d
    lw      a3, 0(t0)

    la      t0, e
    lw      a4, 0(t0)

    jal ra, find_max  # apel funcțuie
   
    li      t0, LEDS    # afisare valoare returnata pe leduri
    sw      a0, 0(t0)   #in a0 voi avea maximul


    nop                 # fun! Q: Care este instructiunea nativa ?


    ret                 # revenire din main (i.e., exit)
