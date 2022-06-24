.globl f
f:
        sub     sp, sp, #320
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16
.L2:
        add     w0, w0, 1
        add     w0, w0, 1
        add     w0, w0, 1
        add     w0, w0, 1
        add     w0, w0, 1

        add     w0, w0, 1
        add     w0, w0, 1
        add     w0, w0, 1
        subs    w1, w1, 1
        bne     .L2

        add     sp, sp, 320
        ret
