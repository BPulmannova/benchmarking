.globl f
f:
        sub     sp, sp, #320
        mov     w1, 25856 ;# 50 mil
        movk    w1, 0x1dcd, lsl 16
        str     w1, [sp, 64]
        mov     w9, 0
        mov     w10, 0

        fmov    s0, 1.5
        fmov    s1, 2.5
        add     x11, sp, 16
        add     x12, sp, 20

.L2:
        nop
        nop
        nop
        ldr     w9, [x11]
        nop
        nop
        nop
        add     x11, sp, 16
        nop
        nop
        nop
        fmov    s0, 1.5
        nop
        nop
        nop
        ldr     w10, [x12]
        nop
        nop
        nop
        add     x12, sp, 20
        nop
        nop
        nop
        fmov    s1, 2.5
        nop
        nop
        nop

        ldr     w13, [x11]
        nop
        nop
        nop
        ldr     w14, [x12]
        nop
        nop
        nop
        fmov    s3, 1.5
        nop
        nop
        nop

        fmov    s4, 2.5
        nop
        nop
        nop
        add     w15, w15, 1
        nop
        nop
        nop
        subs    w1, w1, 1
        nop
        nop
        nop
        bne     .L2


.L3:
        nop
        nop
        nop
        mov     w0, w9
        add     sp, sp, 320
        ret
