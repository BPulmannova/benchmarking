.globl f
f:
        sub     sp, sp, #1024
        str     w0, [sp, 12]
        ldr     w1, [sp, 12]
        str     wzr, [sp, 16]
.L2:
        ldr     w0, [sp, 16]
        add     w0, w0, 1
        str     w0, [sp, 80]

        ldr     w0, [sp, 144]
        add     w0, w0, 2
        str     w0, [sp, 208]

        ldr     w0, [sp, 272]
        add     w0, w0, 3
        str     w0, [sp, 336]

        ldr     w0, [sp, 400]
        add     w0, w0, 4
        str     w0, [sp, 464]

        ldr     w0, [sp, 528]
        add     w0, w0, 5
        str     w0, [sp, 592]

        subs    w1, w1, #1
        bne     .L2

        add     sp, sp, 1024
        ret
