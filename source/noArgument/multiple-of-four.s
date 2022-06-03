.globl f
f:
        sub     sp, sp, 64
        mov     w15, 38527   ;# loop counter (10 million)
        movk    w15, 0x98, lsl 16
        mov     w0, 0
        mov     w9, 9
        mov     w10, 10
        mov     w11, 11
        mov     w12, 12
        nop
        nop
        nop
        nop
        nop

.L2:
        nop
        mov     w0, w0
        mov     w0, w0
        mov     w0, w0

        nop
        mov     w0, w0
        mov     w0, w0
        mov     w0, w0

        nop
        mov     w0, w0
        subs    w15, w15, 1  
        bne     .L2       

        add     sp, sp, 64
        ret
