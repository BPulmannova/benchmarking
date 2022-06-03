.globl f
f:
        sub     sp, sp, 64
        mov     w15, 38527   ;# loop counter (10 million)
        movk    w15, 0x98, lsl 16
        mov     w0, 0
        nop

.L2:
        ldr     w9, [sp, 12] ;# 40c
        add     w0, w0, w9
        ldr     w10, [sp, 16] ;# 410
        add     w0, w0, w10
        str     w0, [sp, 24] ;# 418
        ldr     w0, [sp, 28] ;# 41c
        add     w10, w0, w9
        ldr     w0, [sp, 24] ;# 418

        subs    w15, w15, 1
        bne     .L2

        add     sp, sp, 64
        ret

