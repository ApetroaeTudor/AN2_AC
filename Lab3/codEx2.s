.data
    arr: .word 23,42,56,48,123
.text

.global main

.equ LEDS,      0x40010000
.equ BTNS,      0x40000000
.equ ARRLEN,    5

count_even:
    addi    t0, zero, ARRLEN    # nr de elem din vector
    
    addi    t1, zero, 1     # Se inițializează masca de verificare
                            #   t1 = 0x00000001

    add     t3, a0, zero    # Muta a0 în t3. t3 va fi adresa de inceput a vect

    add     a0, zero, zero  # Se inițializează contorul de nr pare

repeat:

    lw      t4,0(t3)

    and     t2, t4, t1      # Se efectueaza un AND logic între valoarea t3

    bne     t2, zero, bit_is_one   # Dacă rezultatul este egau cu 0,

    addi    a0, a0, 1       # Se incrementează contorul a0


bit_is_one:

    addi    t0, t0, -1      # Se decrementează nr de elemente ramase in vector
    addi    t3,t3,4 #trece la urm elem din vector
    bne     t0, zero, repeat    # Se repetA pana cand
    jalr    zero, 0(ra)     # revenire din funcție


main:
    la      a0, arr

    jal ra, count_even  # apel funcțuie
   
    li      t0, LEDS    # afisare valoare returnata pe leduri
    sw      a0, 0(t0)


    nop                 # fun! Q: Care este instructiunea nativa ?


    ret                 # revenire din main (i.e., exit)
