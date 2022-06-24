.globl f
f:
        sub     sp, sp, #128
        str     w0, [sp, 12]
        ldr     w1, [sp, 12]
        str     wzr, [sp, 16]
.L2:
        nop
        nop
        nop
        ldr     w0, [sp, 16]
        nop
        nop
        nop
        add     w0, w0, 1
        nop
        nop
        nop
        str     w0, [sp, 32]
        nop
        nop
        nop
        ldr     w0, [sp, 32]
        nop
        nop
        nop
        add     w0, w0, 2
        nop
        nop
        nop
        str     w0, [sp, 48]
        nop
        nop
        nop
        ldr     w0, [sp, 48]
        nop
        nop
        nop
        add     w0, w0, 3
        nop
        nop
        nop
        str     w0, [sp, 64]
        nop
        nop
        nop

        ldr     w0, [sp, 64]
        nop
        nop
        nop
        add     w0, w0, 4
        nop
        nop
        nop
        str     w0, [sp, 80]
        nop
        nop
        nop

        ldr     w0, [sp, 80]
        nop
        nop
        nop
        add     w0, w0, 5
        nop
        nop
        nop
        str     w0, [sp, 16]
        nop
        nop
        nop

        subs    w1, w1, #1
        nop
        nop
        nop
        bne     .L2

        add     sp, sp, 128
        ret
