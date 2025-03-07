.data
    value: .word 0x80000008 # pentru aceasta valoare, rezultatul trebuie sa fie 2
    arr: .word 0x00000001, 0x00000002, 0x00000003

.text


.global main


.equ LEDS,      0x40010000
.equ BTNS,      0x40000000
.equ ARRLEN,    3


count_ones_array:

    add sp,sp,-24

    add     t1,zero,zero
    
    addi    t0, zero, ARRLEN #in t0 am nr elem
    add     t2, a0, zero #am vect in t2

    #voi pune in a0 elem ce trb verificat


    start: 

    beq     t0,zero,fin
    lw      t4,0(t2)
    add     t0,t0,-1 #decr nr de elem ramase

    la      t0, t2
    lw      a0, 0(t0)   # Se initializeaza valoarea de verificat în a0.
    
    sw ra,0(sp)
    sw t0,4(sp)
    sw t1,8(sp)
    sw t2,12(sp)
    
    jal ra, count_ones  # apel funcțuie
    #in a0 am nr de biti din elem curent
    #in t1 voi tine nr total
    add t1,t1,a0

    lw ra,0(sp)

    add     t2,t2,4 #trec la urm elem din vector

    bne t0,zero,start

    

    fin:

    add a0,t0,zero
    add sp,sp,4


jalr    zero, 0(ra)


count_ones:
    addi    t0, zero, 32    # Se setează contorul de biți (t0 = 32)
                            #   care indică numărul de verificări necesare,
                            #   deoarece un cuvânt are 32 de biți    
    addi    t1, zero, 1     # Se inițializează masca de verificare
                            #   t1 = 0x00000001, care va fi deplasată spre
                            #   stânga pentru a verifica fiecare bit individual
    add     t3, a0, zero    # Muta a0 în t3. Mai departe se va opera cu t3
                            # Q: Oare nu se poate inventa o
                            #   pseudo-instructiune echivalenta?
    add     a0, zero, zero  # Se inițializează contorul de biți de 1, a0 = 0
   
repeat:
    and     t2, t3, t1      # Se efectueaza un AND logic între valoarea t3
                            #   si masca t1 iar rezultatul se pune in t2    
    beq     t2, zero, bit_is_zero   # Dacă rezultatul este egau cu 0,
                                    #   înseamnă că bitul curent este 0
                                    #   deci NUUUUU se incrementează contorul a0
                                    #   (se sare peste incermentare)


    addi    a0, a0, 1       # Se incrementează contorul a0


bit_is_zero:
    slli    t1, t1, 1       # Se deplaseaza masca spre stanga (t1 <<= 1)
                            #   pentru a verifica următorul bit
    addi    t0, t0, -1      # Se decrementează contorul de biți t0
    bne     t0, zero, repeat    # Se repetA pana cand
                                #   toți cei 32 de biti sunt verificati.
                            # Rezultatul final (numarul de biti de 1)
                            #   este stocat în a0
    jalr    zero, 0(ra)     # revenire din funcție


main:


    la      a0, arr # in a1 am adresa vectorului

   
    jal ra, count_ones_array  # apel funcțuie
   
    li      t0, LEDS    # afisare valoare returnata pe leduri
    sw      a0, 0(t0)


    nop                 # fun! Q: Care este instructiunea nativa ?


    ret                 # revenire din main (i.e., exit)
