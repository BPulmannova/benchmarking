.globl f
f:
        sub     sp, sp, #320
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16
        mov     w0, w0
        mov     w0, w0



.L2:     
        ldr     w0, [sp, 200]
        str     w0, [sp, 50]
        str     w0, [sp, 100]
        str     w0, [sp, 150]

        mov     w0, w0
        mov     w0, w0
        subs    w1, w1, 1
        bne     .L2

        mov     w0, 0
        add     sp, sp, 320
        ret
