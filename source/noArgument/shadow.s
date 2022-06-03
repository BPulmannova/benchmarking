.globl f
f:
        sub     sp, sp, #320
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16


.L2:            

        ldr     w0, [sp, 20]
        ldr     w0, [sp, 24]
        ldr     w0, [sp, 28]
        ldr     w0, [sp, 32]
        ldr     w0, [sp, 36]

        subs    w1, w1, 1
        bne     .L2

        mov     w0, 0
        add     sp, sp, 320
        ret
