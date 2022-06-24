.globl f
f:
        sub     sp, sp, #32
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16
        mov     w15, 7
        mov     w14, 9
.L2:

        udiv    w9, w1, w14
        udiv    w10, w1, w15
        madd    w0, w10, w9, w0

        udiv    w9, w9, w14
        udiv    w10, w10, w15
        madd    w0, w10, w9, w0

        udiv    w9, w9, w14
        udiv    w10, w10, w15
        madd    w0, w10, w9, w0

        udiv    w9, w9, w14
        udiv    w10, w10, w15
        madd    w0, w10, w9, w0

        udiv    w9, w9, w14
        udiv    w10, w10, w15
        madd    w0, w10, w9, w0

        subs    w1, w1, 1
        bne     .L2

        add     sp, sp, 32
        ret
