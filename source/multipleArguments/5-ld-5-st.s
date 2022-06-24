.globl f
f:
        sub     sp, sp, #128
        str     w0, [sp, 12]
        ldr     w1, [sp, 12]
        str     wzr, [sp, 16]
.L2:
        ldr     w0, [sp, 16]
        add     w0, w0, 1
        str     w0, [sp, 32]

        ldr     w0, [sp, 32]
        add     w0, w0, 2
        str     w0, [sp, 48]

        ldr     w0, [sp, 48]
        add     w0, w0, 3
        str     w0, [sp, 64]

        ldr     w0, [sp, 64]
        add     w0, w0, 4
        str     w0, [sp, 80]

        ldr     w0, [sp, 80]
        add     w0, w0, 5
        str     w0, [sp, 16]

        subs    w1, w1, #1
        bne     .L2

        add     sp, sp, 128
        ret
