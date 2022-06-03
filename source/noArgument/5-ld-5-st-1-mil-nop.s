.globl f
f:
        sub     sp, sp, #32
        str     wzr, [sp, 12]
        mov     w1, 16960
        movk    w1, 0xf, lsl 16
.L2:            
        add     w0, w0, 6
        add     w0, w0, 6
        ldr     w0, [sp, 28]
        add     w0, w0, 1
        str     w0, [sp, 28]
        ldr     w0, [sp, 24]
        add     w0, w0, 2
        str     w0, [sp, 24]
        ldr     w0, [sp, 20]
        add     w0, w0, 3
        str     w0, [sp, 20]
        ldr     w0, [sp, 16]
        add     w0, w0, 4
        str     w0, [sp, 16]
        ldr     w0, [sp, 12]
        add     w0, w0, 5
        str     w0, [sp, 12]
        subs    w1, w1, #1
        bne     .L2
        mov     w0, 0
        add     sp, sp, 32
        ret
